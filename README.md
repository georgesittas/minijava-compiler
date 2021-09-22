# Minijava Compiler

This is a MiniJava-to-LLVM compiler project, written in Java (with the help of JFlex, JavaCUP and JTB), introduced
as an assignment for the [compilers](http://cgi.di.uoa.gr/~compilers) course (NKUA). The compiler checks a MiniJava
program to determine whether it's semantically correct, in which case it compiles it to LLVM IR code. More details
about the assignment can be found [here](http://cgi.di.uoa.gr/~compilers/project.html#hw2) (homework 2 & 3).


## Compilation & Execution

- Type in "make" to generate and compile all necessary files.

- Execute the compiler as: java Main file1 [file2 [file3 ...]].

- Type in "make clean" to clean the directory of all class files (recursively).

- Type in "make clean_all" to clean the directory of all *generated* files.


## Symbol Table

A simple approach has been chosen for the implementation of the symbol table, due to the fact
that MiniJava is a fairly simple language, when it comes to scopes: all declarations precede
statements. This property prevents having declarations in nested compound statements, such as
if-else, while and block statements. Namely, the symbol_table package contains the classes:

- SymbolTable, which keeps track of class declarations & maintains inheritance-related info.

- ClassInfo, which contains class-scope info, such as field and method declarations and their
  offsets.

- MethodInfo, which contains method-scope info, such as formal parameter & local variable
  declarations.

- VarInfo, which is a wrapper for a variable/argument's identifier and type.

Note that some static checking is handled by the symbol table logic itself. One such example
is when someone tries to declare a class A which inherits from a class B, that hasn't been
declared previously. This error will be caught in the addClass method, and an exception will
be thrown. Generally: errors are handled by throwing exceptions whenever needed.


## Virtual Method Table

The vtable package contains the classes:

- VTable : keeps track of a class' methods & their "owners" (eg. A::foo or B::foo), depending on
  the overriding that's happened (which can be determined statically). A list has been used, so
  that the correct method order is attained for emitting the vtable info in LLVM IR later on.

- VTInfo : wrapper around the method binding info (see above).


## Visitors

Four visitors have been created in order to do the static semantic checking & code generation.
These are:

- STVisitor, that's used to fill in the symbol table with symbol declaration info.

- SCVisitor, that's used to do the type checking etc on the input programs.

- VTVisitor, that's used to fill in the virtual table appropriately.

- CGVisitor, that's used to translate the input programs to LLVM IR.

The first two visitors keep the symbol table associated with the input program as a private
field. The argument "argu" in each overriden visit method is used to propagate information
about scope to nodes that are deeper in the visited AST. The scope itself is represented as
a string that follows the format <ClassIdentifier> [":" [<MethodIdentifier>]].

The MainClass symbol and its main method are not handled separately. The main method's
argument is stored in the symbol table with type "String[]", so, if it appears in any
expression in the program, a type error will be triggered.

The last two visitors keep both the symbol and the virtual method tables associated with the
input program as private fields. The VTVisitor argu/return value types play the same role as
in the STVisitor, while the CGVisitor return value type has been changed to VarInfo, in order
to propagate virtual register names & their types (both in LLVM IR & in high level) upwards,
in a more "organized" way (less string hacks), whenever that's needed.

Some key points about the code generation visitor:

- Virtual registers are represented as %_<number> (<number> is incremented by 1 each time).

- Local variables of type i32 and i1 are explicitly initialized to zero upon declaration
  (following the discussion made under the piazza followup post @131_f1).

- For almost all visit methods (except those corresponding to Type()), the idea is that we
  want to return both the LLVM IR type & the corresponding high level type name. The latter
  is needed in cases such as MessageSend, so that we'll be able to use the object's type to
  find method offset info from the symbol table. The former is simply helpful for cases where
  we only want to use the LLVM IR representation of that same type. Both of these types are
  stored in a single string (the .type field in the VarInfo), and are seperated by a colon,
  so calls to split(":") are needed to fetch the correct one each time (a bit hacky, but ok).

