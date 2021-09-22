import vtable.*;
import visitor.*;
import java.io.*;
import java.util.*;
import syntaxtree.*;
import symbol_table.*;

public class Main {

	public static void main(String[] args) throws Exception {
		if (args.length == 0) {
			System.err.println("Usage: java Main file1 [file2 [file3 ...]]");
			System.exit(1);
		}

		Goal root = null;
		VTable vt = null;
		SymbolTable st = null;
		FileWriter writer = null;
		FileInputStream stream = null;

		for (String filename : args) {
			try {
				stream = new FileInputStream(filename);
				root = new MiniJavaParser(stream).Goal();

				System.err.println("Program " + filename + " parsed successfully!");

				vt = new VTable();
				st = new SymbolTable();

				// Assumption: input files follow the format "name.java"
				writer = new FileWriter(filename.substring(0, filename.lastIndexOf('.')) + ".ll");

				root.accept(new STVisitor(st), null); // Populate the symbol table
				root.accept(new SCVisitor(st), null); // Do static semantic checking

				System.err.println("Program " + filename + " is semantically sound!");
				System.err.println("Translating " + filename + " to LLVM IR");

				root.accept(new VTVisitor(st, vt), null); // Configure vtable
				root.accept(new CGVisitor(writer, st, vt), null); // Generate LLVM IR

				System.out.println();
			} catch (Exception e) {
				System.err.println("Error: " + e.getMessage() + "\n");
			} finally {
				try {
					if (stream != null)
						stream.close();

					if (writer != null)
						writer.close();

					root = null; vt = null; st = null; writer = null; stream = null;
				} catch(Exception e) {
					System.err.println("Error: " + e.getMessage() + "\n");
				}
			}
		}
	}
}
