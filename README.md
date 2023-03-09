# MiniJava Compiler

This is a [MiniJava](https://cgi.di.uoa.gr/~compilers/20_21/project.html#hw2) compiler that produces
LLVM IR code, written in Java using JFlex, JavaCUP and JTB.

I would like to thank [Stefanos Baziotis](https://github.com/baziotis) for contributing his [MiniJava
testsuite](https://github.com/baziotis/minijava-testsuite)!


## Usage

```bash
# Compile the project
make

# Run the compiler
java Main file1 [file2 [file3 ...]]

# Cleanup
make clean
```

## Implementation

### Scoping & Symbol Table

MiniJava is a simple language when it comes to scoping: all declarations precede statements.
This property prevents declarations from showing up in nested compound statements such as
if-else, while and block statements. Thus, the symbol table need only keep track of class
declarations, class-scoped declarations (i.e. fields and methods) and method-scoped declarations
(i.e. parameter and local variables).

### Compilation Phases

We start by producing an AST for the source program with the help of JFlex, JavaCUP and JTB. Then,
we check its semantics & finally generate the LLVM-IR code with the help of the following visitor
classes:

1. `STVisitor` populates the symbol table

2. `SCVisitor` type checks the program

3. `VTVisitor` populates the virtual method table

4. `CGVisitor` generates the resulting LLVM IR code

### Notes

- The `MainClass` class and its `main` method are not handled as special cases. The method's
argument is stored in the symbol table with type `String[]`, so, if it appears in any
expression in the program, a type error will be triggered by `SCVisitor` inevitably.

- Scopes are implemented by constructing strings of the form `ClassID [":" [MethodID]]` and passing
them as arguments to children nodes as the visitors are walking the AST. 

- LLVM-IR code virtual registers are assigned names of the form `%_number`, where `number` is an
auto-incrementing integer.
