# Minijava Compiler

This is a MiniJava-to-LLVM-IR compiler project, written in Java (with the help of JFlex, JavaCUP and JTB), introduced
as an assignment for the [compilers](http://cgi.di.uoa.gr/~compilers) course (NKUA). The compiler checks a MiniJava
program to determine whether it's semantically correct, in which case it compiles it to LLVM IR code. More details
about the assignment can be found [here](https://cgi.di.uoa.gr/~compilers/20_21/project.html#hw2) (homework 2 & 3). Many
thanks to [Stefanos Baziotis](https://github.com/baziotis) for his [MiniJava testsuite](https://github.com/baziotis/minijava-testsuite)
contribution!


## Compilation & Execution

- Type in "make" to generate and compile all necessary files.

- Execute the compiler as: java Main file1 [file2 [file3 ...]].

- Type in "make clean" to clean the directory of all class files (recursively).

- Type in "make clean_all" to clean the directory of all *generated* files.


## Symbol Table

The symbol table has been modelled in a simple way, due to the fact that MiniJava is a fairly
simple language when it comes to scopes: all declarations precede statements. This property
prevents declarations from showing up in nested compound statements, such as if-else, while
and block statements. The classes contained in the symbol_table package are:

- SymbolTable: keeps track of class declarations & maintains inheritance-related info.

- ClassInfo: contains class-scope info, such as field and method declarations and their
  offsets.

- MethodInfo: contains method-scope info, such as formal parameter & local variable
  declarations.

- VarInfo: wrapper for a variable/argument's identifier and type.

Note that some semantic checks are incorporated in the symbol table logic. One such example
is when someone tries to declare a class A which inherits from a class B, which hasn't been
declared previously. This error will be caught in the addClass method, and an exception will
be thrown. Generally, errors are handled by throwing exceptions whenever needed.


## Virtual Method Table

The vtable package contains the classes:

- VTable: keeps track of a class' methods & their "owners" (eg. A::foo or B::foo), depending on
  the overriding that's happened (which can be determined statically). A list has been used, in
  order to maintain the method order and later emit the correct vtable info in LLVM IR.

- VTInfo: wrapper around the method binding info (see above).


## Visitors

There are four visitors, that are used to implement the semantic checks and the code generation:

- STVisitor: populates the symbol table.

- SCVisitor: does type checking and other static checks.

- VTVisitor: populates the virtual table.

- CGVisitor: generates the resulting LLVM IR code.

The first two visitors maintain the symbol table associated with the input program as a private
field. The argument "argu" in each overriden visit method is used to propagate information
about scope to nodes that are deeper in the visited AST. The scope itself is represented as
a string that follows the format ClassID [":" [MethodID]].

The MainClass symbol and its main method are not handled separately. The main method's
argument is stored in the symbol table with type "String[]", so, if it appears in any
expression in the program, a type error will be triggered inevitably.

The last two visitors maintain both the symbol and the virtual method tables associated with the
input program as private fields. The VTVisitor argu/return value types play the same role as
in the STVisitor, while the CGVisitor return value type has been changed to VarInfo, in order
to propagate virtual register names & their types (both in LLVM IR & in high level) upwards,
in a more "organized" way (less string hacks), whenever that's needed.

Some key points about the code generation visitor:

- Virtual registers are represented as %\_number (number is incremented by 1 each time).

- Local variables of type i32 and i1 are explicitly initialized to zero upon declaration.

- For almost all visit methods (except those corresponding to Type()), the idea is that we
  want to return both the LLVM IR type & the corresponding high level type name. The latter
  is needed in cases such as MessageSend, so that we'll be able to use the object's type to
  find method offset info from the symbol table. The former is simply helpful for cases where
  we only want to use the LLVM IR representation of that same type. Both of these types are
  stored in a single string (the .type field in the VarInfo), and are seperated by a colon,
  so calls to split(":") are needed to fetch the correct one each time (a bit hacky, but ok).
