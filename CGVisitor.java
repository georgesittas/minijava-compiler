import vtable.*;
import java.util.*;
import syntaxtree.*;
import symbol_table.*;
import java.io.FileWriter;
import visitor.GJDepthFirst;

public class CGVisitor extends GJDepthFirst<VarInfo, String> {
	private VTable vt;
	private SymbolTable st;

	private FileWriter writer;

	// Auxiliary fields (mostly used to maintain internal state)

	private int temp_id = 0;
	private int label_id = 0;

	private boolean is_field = false; // Used to distinguish between var/arg and field identifiers
	private int field_offset = 0; // Keeps the offset of a field found during last call to searchVar

	// This is used for phi's right bracket (needed for nested and-statements etc that include jumps).
	// Note: it's only needed to update its value in expression nodes, since the statement nodes like
	// if, while and array assignment statements can't appear inside another expression

	String prev_basic_block = null;

	private String newTemp() throws Exception {
		temp_id += 1;
		return "_" + (temp_id - 1);
	}

	private String newLabel() throws Exception {
		label_id += 1;
		return "l" + (label_id - 1);
	}

	private void emit(String code) throws Exception {
		writer.write(code);
	}

	// Scope is represented as a string formatted as <ClassIdentifier> [":" [<MethodIdentifier>]]

	private String getScopeClass(String scope) {
		String[] tokens = scope.split(":");
		return tokens[0];
	}

	private String getScopeMethod(String scope) {
		String[] tokens = scope.split(":");
		return tokens.length == 2 ? tokens[1] : null;
	}

	private VarInfo searchVar(String target_id, String scope) throws Exception {
		String class_id = getScopeClass(scope);
		String method_id = getScopeMethod(scope);

		ClassInfo classinfo = st.getClassInfo(class_id);

		if (method_id != null) {
			MethodInfo methodinfo = classinfo.getMethodInfo(method_id);
			VarInfo targetinfo = methodinfo.getInfo(target_id);

			if (targetinfo != null) {
				is_field = false;
				return targetinfo; // Found a matching local var (or arg) inside the method
			}
		}

		// Didn't find the target var in the method's scope, search class fields upwards
		VarInfo targetinfo = classinfo.getFieldInfo(target_id);

		if (targetinfo != null) {
			is_field = true;
			field_offset = 8 + classinfo.getFieldOffset(target_id); // Add 8 bytes for the vtable
			return targetinfo;
		}

		return searchVar(target_id, st.getSuperClassId(class_id));
	}

	private MethodInfo searchMethod(String target_id, String scope) {
		String class_id = getScopeClass(scope);

		ClassInfo classinfo = st.getClassInfo(class_id);

		MethodInfo targetinfo = classinfo.getMethodInfo(target_id);
		return targetinfo != null ? targetinfo
		                          : searchMethod(target_id, st.getSuperClassId(class_id));
	}

	private int getMethodOffset(String class_id, String method_id) throws Exception {
		ClassInfo classinfo = st.getClassInfo(class_id);
		Integer offset = classinfo.getMethodOffset(method_id);

		return offset == null ? getMethodOffset(st.getSuperClassId(class_id), method_id)
		                      : offset;
	}

	private String typeInLLVMIR(String type) {
		if (type.equals("int"))     return "i32";
		if (type.equals("boolean")) return "i1";
		if (type.equals("int[]"))   return "i32*";

		return "i8*"; // Representation for user-defined classes
	}

	private void emitVTableInfo() throws Exception {

		// Emits the following line for each class in the source program:
		// @.<class_id>_vtable = global [<n_methods> x i8*] [<method_list>]\n

		for (String class_id : st.getClasses()) {
			List<VTInfo> methods = vt.getMethods(class_id);

			int n_methods = methods.size();
			emit("@." + class_id + "_vtable = global [" + n_methods + " x i8*] [");

			for (VTInfo method : methods) {
				String owner = method.getOwner();
				MethodInfo methodinfo = method.getMethodInfo();

				// Make sure to have "this" as the first argument for each method
				emit("i8* bitcast (" + typeInLLVMIR(methodinfo.getType()) + " (i8*");

				for (VarInfo arg : methodinfo.getArgs())
					emit(", " + typeInLLVMIR(arg.getType()));

				n_methods -= 1;
				emit(")* @" + owner + "." + methodinfo.getId() + " to i8*)" + (n_methods == 0 ? "" : ", "));
			}

			emit("]\n");
		}

		emit("\n");
	}

	private void emitBoilerplate() throws Exception {
		emit("declare i8* @calloc(i32, i32)\n"
			 + "declare i32 @printf(i8*, ...)\n"
			 + "declare void @exit(i32)\n\n"
			 + "@_cint = constant [4 x i8] c\"%d\\0a\\00\"\n"
			 + "@_cOOB = constant [15 x i8] c\"Out of bounds\\0a\\00\"\n\n"
			 + "define void @print_int(i32 %i) {\n"
			 + "\t%_str = bitcast [4 x i8]* @_cint to i8*\n"
			 + "\tcall i32 (i8*, ...) @printf(i8* %_str, i32 %i)\n"
			 + "\tret void\n"
			 + "}\n\n"
			 + "define void @throw_oob() {\n"
			 + "\t%_str = bitcast [15 x i8]* @_cOOB to i8*\n"
			 + "\tcall i32 (i8*, ...) @printf(i8* %_str)\n"
			 + "\tcall void @exit(i32 1)\n"
			 + "\tret void\n"
			 + "}\n\n"
			  );
	}

	private int getObjectSize(String class_id) throws Exception {
		// 8 bytes for the vtable pointer + sizeof(fields) (counts superclass fields)
		return 8 + st.getClassInfo(class_id).getFieldOffset();
	}

	public CGVisitor(FileWriter writer, SymbolTable st, VTable vt) {
		this.st = st;
		this.vt = vt;
		this.writer = writer;
	}

	// f0  -> "class"
	// f1  -> Identifier()
	// f2  -> "{"
	// f3  -> "public"
	// f4  -> "static"
	// f5  -> "void"
	// f6  -> "main"
	// f7  -> "("
	// f8  -> "String"
	// f9  -> "["
	// f10 -> "]"
	// f11 -> Identifier()
	// f12 -> ")"
	// f13 -> "{"
	// f14 -> ( VarDeclaration() )*
	// f15 -> ( Statement() )*
	// f16 -> "}"
	// f17 -> "}"
	@Override
	public VarInfo visit(MainClass n, String argu) throws Exception {
		String classname = n.f1.f0.tokenImage;

		emitVTableInfo();  // Global vtable declarations
		emitBoilerplate(); // Boilerplate code (print_int, throw_oob etc)

		emit("define i32 @main() {\n");

		n.f14.accept(this, classname + ":main"); // Generate code for var declarations
		n.f15.accept(this, classname + ":main"); // Generate code for statements

		emit("\n\tret i32 0\n}\n");

		return null;
	}

	// f0 -> "class"
	// f1 -> Identifier()
	// f2 -> "{"
	// f3 -> ( VarDeclaration() )*
	// f4 -> ( MethodDeclaration() )*
	// f5 -> "}"
	@Override
	public VarInfo visit(ClassDeclaration n, String argu) throws Exception {
		String classname = n.f1.f0.tokenImage;

		n.f4.accept(this, classname); // Generate code for method declarations

		return null;
	}

	// f0 -> "class"
	// f1 -> Identifier()
	// f2 -> "extends"
	// f3 -> Identifier()
	// f4 -> "{"
	// f5 -> ( VarDeclaration() )*
	// f6 -> ( MethodDeclaration() )*
	// f7 -> "}"
	@Override
	public VarInfo visit(ClassExtendsDeclaration n, String argu) throws Exception {
		String classname = n.f1.f0.tokenImage;

		n.f6.accept(this, classname); // Generate code for method declarations

		return null;
	}

	// f0 -> Type()
	// f1 -> Identifier()
	// f2 -> ";"
	@Override
	public VarInfo visit(VarDeclaration n, String argu) throws Exception {
		String vartype = n.f0.accept(this, null).getType();
		String varname = n.f1.f0.tokenImage;

		// i1 and i32 will be init'd to 0, while i32* and i8* will be init'd to null
		emit("\t%" + varname + " = alloca " + vartype + "\n"
			 + "\tstore " + vartype + " "
			 + (vartype.equals("i32") || vartype.equals("i1") ? "0" : "null")
			 + ", " + vartype + "* %" + varname + "\n\n"
			  );

		return null;
	}

	// f0  -> "public"
	// f1  -> Type()
	// f2  -> Identifier()
	// f3  -> "("
	// f4  -> ( FormalParameterList() )?
	// f5  -> ")"
	// f6  -> "{"
	// f7  -> ( VarDeclaration() )*
	// f8  -> ( Statement() )*
	// f9  -> "return"
	// f10 -> Expression()
	// f11 -> ";"
	// f12 -> "}"
	@Override
	public VarInfo visit(MethodDeclaration n, String argu) throws Exception {
		String classname = argu;
		String methodname = n.f2.f0.tokenImage;

		ClassInfo classinfo = st.getClassInfo(classname);
		MethodInfo methodinfo = classinfo.getMethodInfo(methodname);

		String methodtype = typeInLLVMIR(methodinfo.getType());
		emit("\ndefine " + methodtype + " @" + classname + "." + methodname + "(i8* %this");

		// Argument names follow the format %.<arg_name> (eg. %.num)

		for (VarInfo arg : methodinfo.getArgs())
			emit(", " + typeInLLVMIR(arg.getType()) + " %." + arg.getId());

		emit(") {\n");

		// Emit alloca-store statement pairs for each formal argument of the method

		for (VarInfo arg : methodinfo.getArgs()) {
			String argid = arg.getId();
			String argtype = typeInLLVMIR(arg.getType());

			emit("\t%" + argid + " = alloca " + argtype + "\n"
				 + "\tstore " + argtype + " %." + argid + ", " + argtype + "* %" + argid + "\n\n"
				  );
		}

		n.f7.accept(this, classname + ":" + methodname); // Generate code for var declarations
		n.f8.accept(this, classname + ":" + methodname); // Generate code for statements

		VarInfo ret = n.f10.accept(this, classname + ":" + methodname); // Generate code for expression

		emit("\n\tret " + methodtype + " "
			 + (ret.getType().split(":")[0].endsWith("Lit") ? "" : "%")
			 + ret.getId() + "\n}\n"
			  );

		return null;
	}

	@Override
	public VarInfo visit(Type n, String argu) throws Exception {

		// .which = 0 -> ArrayType
		//        = 1 -> BooleanType
		//        = 2 -> IntegerType
		//        = 3 -> Identifier
		//
		// (See minijava-jtb.jj, lines: 421-448)

		return n.f0.which == 3 ? new VarInfo(null, "i8*")
		                       : super.visit(n, argu);
	}

	@Override
	public VarInfo visit(ArrayType n, String argu) {
		return new VarInfo(null, "i32*");
	}

	@Override
	public VarInfo visit(BooleanType n, String argu) {
		return new VarInfo(null, "i1");
	}

	@Override
	public VarInfo visit(IntegerType n, String argu) {
		return new VarInfo(null, "i32");
	}

	@Override
	public VarInfo visit(Identifier n, String argu) throws Exception {

		// The following code corresponds to the case where an identifier is used
		// as an expression (_not_ as an lvalue)

		VarInfo target = searchVar(n.f0.tokenImage, argu);

		String llvmtype = typeInLLVMIR(target.getType());

		if (is_field) {
			String temp_gep = newTemp();
			String temp_cast = newTemp();
			String temp_load = newTemp();

			emit("\t%" + temp_gep + " = getelementptr i8, i8* %this, i32 " + field_offset + "\n"
				 + "\t%" + temp_cast + " = bitcast i8* %" + temp_gep + " to " + llvmtype + "*\n"
				 + "\t%" + temp_load + " = load " + llvmtype + ", " + llvmtype + "* %" + temp_cast + "\n\n"
				  );

			return new VarInfo(temp_load, llvmtype + ":" + target.getType());
		}

		String temp_load = newTemp();

		emit("\t%" + temp_load + " = load " + llvmtype + ", " + llvmtype + "* %" + target.getId() + "\n");

		return new VarInfo(temp_load, llvmtype + ":" + target.getType());
	}

	// f0 -> Identifier()
	// f1 -> "="
	// f2 -> Expression()
	// f3 -> ";"
	@Override
	public VarInfo visit(AssignmentStatement n, String argu) throws Exception {
		VarInfo lvalue_info = searchVar(n.f0.f0.tokenImage, argu);

		// Remember these two in case searchVar is called again (and the state is altered)
		boolean is_lvalue_field = is_field;
		int lvalue_offset = field_offset;

		String llvmtype = typeInLLVMIR(lvalue_info.getType());

		VarInfo temp_expr = n.f2.accept(this, argu); // Generate code for expression

		if (is_lvalue_field) {
			String temp_gep = newTemp();
			String temp_cast = newTemp();

			emit("\t%" + temp_gep + " = getelementptr i8, i8* %this, i32 " + lvalue_offset + "\n"
				 + "\t%" + temp_cast + " = bitcast i8* %" + temp_gep + " to " + llvmtype + "*\n"
				 + "\tstore " + llvmtype + " "
				 + (temp_expr.getType().split(":")[0].endsWith("Lit") ? "" : "%")
				 + temp_expr.getId() + ", " + llvmtype + "* %" + temp_cast + "\n\n"
				  );

			return null;
		}

		emit("\tstore " + llvmtype + " "
			 + (temp_expr.getType().split(":")[0].endsWith("Lit") ? "" : "%")
			 + temp_expr.getId() + ", " + llvmtype + "* %" + lvalue_info.getId() + "\n\n"
			  );

		return null;
	}

	// f0 -> Identifier()
	// f1 -> "["
	// f2 -> Expression()
	// f3 -> "]"
	// f4 -> "="
	// f5 -> Expression()
	// f6 -> ";"
	@Override
	public VarInfo visit(ArrayAssignmentStatement n, String argu) throws Exception {
		VarInfo arr_info = searchVar(n.f0.f0.tokenImage, argu);

		// Remember these two in case searchVar is called again (and the state is altered)
		boolean is_lvalue_field = is_field;
		int lvalue_offset = field_offset;

		VarInfo temp_idx = n.f2.accept(this, argu); // Generate code for expression
		VarInfo temp_expr = n.f5.accept(this, argu); // Generate code for expression

		String then_label = newLabel();
		String else_label = newLabel();

		String temp_load;

		if (is_lvalue_field) {
			String temp_gep = newTemp();
			String temp_cast = newTemp();

			temp_load = newTemp();

			emit("\t%" + temp_gep + " = getelementptr i8, i8* %this, i32 " + lvalue_offset + "\n"
				 + "\t%" + temp_cast + " = bitcast i8* %" + temp_gep + " to i32**\n"
				 + "\t%" + temp_load + " = load i32*, i32** %" + temp_cast + "\n"
				  );
		}
		else {
			temp_load = newTemp();

			emit("\t%" + temp_load + " = load i32*, i32** %" + arr_info.getId() + "\n");
		}

		String temp_size = newTemp();

		emit("\t%" + temp_size + " = load i32, i32* %" + temp_load + "\n\n");

		String temp_gtz = newTemp();
		String temp_lts = newTemp();

		String pre = (temp_idx.getType().split(":")[0].equals("intLit") ? "" : "%");

		emit("\t%" + temp_gtz + " = icmp sge i32 " + pre + temp_idx.getId() + ", 0\n"
			 + "\t%" + temp_lts + " = icmp slt i32 " + pre + temp_idx.getId() + ", %" + temp_size + "\n"
			  );

		String temp_and = newTemp();
		String temp_gep_idx = newTemp();
		String temp_gep_res = newTemp();

		emit("\t%" + temp_and + " = and i1 %" + temp_gtz + ", %" + temp_lts + "\n"
			 + "\tbr i1 %" + temp_and + ", label %" + then_label + ", label %" + else_label + "\n\n"
			 + else_label + ":\n"
			 + "\tcall void @throw_oob()\n"
			 + "\tbr label %" + then_label + "\n\n"
			 + then_label + ":\n"
			 + "\t%" + temp_gep_idx + " = add i32 1, " + pre + temp_idx.getId() + "\n"
			 + "\t%" + temp_gep_res + " = getelementptr i32, i32* %"
			 + temp_load + ", i32 %" + temp_gep_idx + "\n\n"
			 + "\tstore i32 "
			 + (temp_expr.getType().split(":")[0].equals("intLit") ? "" : "%")
			 + temp_expr.getId() + ", i32* %" + temp_gep_res + "\n\n"
			  );

		return null;
	}

	// f0 -> "if"
	// f1 -> "("
	// f2 -> Expression()
	// f3 -> ")"
	// f4 -> Statement()
	// f5 -> "else"
	// f6 -> Statement()
	@Override
	public VarInfo visit(IfStatement n, String argu) throws Exception {
		VarInfo temp_expr = n.f2.accept(this, argu); // Generate code for expression

		String l1 = newLabel();
		String l2 = newLabel();
		String l3 = newLabel();

		emit("\tbr i1 "
			 + (temp_expr.getType().split(":")[0].equals("boolLit") ? "" : "%")
			 + temp_expr.getId() + ", label %" + l1 + ", label %" + l2 + "\n\n"
			  );

		emit(l2 + ":\n");

		n.f6.accept(this, argu); // Generate code for statement

		emit("\tbr label %" + l3 + "\n\n");

		emit(l1 + ":\n");

		n.f4.accept(this, argu); // Generate code for statement

		emit("\tbr label %" + l3 + "\n\n"
			 + l3 + ":\n"
			  );

		return null;
	}

	// f0 -> "while"
	// f1 -> "("
	// f2 -> Expression()
	// f3 -> ")"
	// f4 -> Statement()
	@Override
	public VarInfo visit(WhileStatement n, String argu) throws Exception {
		String l1 = newLabel();
		String l2 = newLabel();
		String l3 = newLabel();

		// Entry of loop (l1)
		emit("\tbr label %" + l1 + "\n"
		   + l1 + ":\n"
		    );

		VarInfo temp_expr = n.f2.accept(this, argu); // Generate code for expression

		// If expression is true, jump to loop body (l2)
		emit("\tbr i1 "
			 + (temp_expr.getType().split(":")[0].equals("boolLit") ? "" : "%")
			 + temp_expr.getId() + ", label %" + l2 + ", label %" + l3 + "\n\n"
			  );

		emit(l2 + ":\n"); // Loop body (2)

		n.f4.accept(this, argu); // Generate code for statement

		emit("\tbr label %" + l1 + "\n\n"); // Jump back to loop entry (l1)

		emit(l3 + ":\n"); // Loop exit (l3)

		return null;
	}

	// f0 -> "System.out.println"
	// f1 -> "("
	// f2 -> Expression()
	// f3 -> ")"
	// f4 -> ";"
	@Override
	public VarInfo visit(PrintStatement n, String argu) throws Exception {
		VarInfo temp_arg = n.f2.accept(this, argu); // Generate code for expression

		emit("\tcall void (i32) @print_int(i32 "
			 + (temp_arg.getType().split(":")[0].equals("intLit") ? "" : "%")
			 + temp_arg.getId() + ")\n\n"
			  );

		return null;
	}

	// f0 -> Clause()
	// f1 -> "&&"
	// f2 -> Clause()
	@Override
	public VarInfo visit(AndExpression n, String argu) throws Exception {
		VarInfo temp_l = n.f0.accept(this, argu); // Generate code for clause

		String l1 = newLabel();
		String l2 = newLabel();
		String l3 = newLabel();

		String pre1 = temp_l.getType().split(":")[0].equals("boolLit") ? "" : "%";

		emit("\tbr i1 " + pre1 + temp_l.getId() + ", label %" + l1 + ", label %" + l2 + "\n\n"
			 + l2 + ":\n"
			 + "\tbr label %" + l3 + "\n\n"
			 + l1 + ":\n"
			  );

		prev_basic_block = l1;

		VarInfo temp_r = n.f2.accept(this, argu); // Generate code for clause
		
		String pre2 = temp_r.getType().split(":")[0].equals("boolLit") ? "" : "%";

		String temp_res = newTemp();

		emit("\tbr label %" + l3 + "\n\n"
			 + l3 + ":\n"
			 + "\t%" + temp_res + " = phi i1 [ 0, %" + l2 + " ], [ "
			 + pre2 + temp_r.getId() + ", %" + prev_basic_block + " ]\n\n"
			  );

		prev_basic_block = l3;

		return new VarInfo(temp_res, "i1:boolean");
	}

	// f0 -> PrimaryExpression()
	// f1 -> "<"
	// f2 -> PrimaryExpression()
	@Override
	public VarInfo visit(CompareExpression n, String argu) throws Exception {
		VarInfo temp_l = n.f0.accept(this, argu); // Generate code for primary expression
		VarInfo temp_r = n.f2.accept(this, argu); // Generate code for primary expression

		String temp_res = newTemp();

		String pre1 = temp_l.getType().split(":")[0].equals("intLit") ? "" : "%";
		String pre2 = temp_r.getType().split(":")[0].equals("intLit") ? "" : "%";

		emit("\t%" + temp_res + " = icmp slt i32 "
			 + pre1 + temp_l.getId() + ", "
			 + pre2 + temp_r.getId() + "\n\n"
			  );

		return new VarInfo(temp_res, "i1:boolean");
	}

	// f0 -> PrimaryExpression()
	// f1 -> "+"
	// f2 -> PrimaryExpression()
	@Override
	public VarInfo visit(PlusExpression n, String argu) throws Exception {
		VarInfo temp_l = n.f0.accept(this, argu); // Generate code for primary expression
		VarInfo temp_r = n.f2.accept(this, argu); // Generate code for primary expression

		String temp_res = newTemp();

		String pre1 = temp_l.getType().split(":")[0].equals("intLit") ? "" : "%";
		String pre2 = temp_r.getType().split(":")[0].equals("intLit") ? "" : "%";

		emit("\t%" + temp_res + " = add i32 "
			 + pre1 + temp_l.getId() + ", "
			 + pre2 + temp_r.getId() + "\n\n"
			  );

		return new VarInfo(temp_res, "i32:int");
	}

	// f0 -> PrimaryExpression()
	// f1 -> "-"
	// f2 -> PrimaryExpression()
	@Override
	public VarInfo visit(MinusExpression n, String argu) throws Exception {
		VarInfo temp_l = n.f0.accept(this, argu); // Generate code for primary expression
		VarInfo temp_r = n.f2.accept(this, argu); // Generate code for primary expression

		String temp_res = newTemp();

		String pre1 = temp_l.getType().split(":")[0].equals("intLit") ? "" : "%";
		String pre2 = temp_r.getType().split(":")[0].equals("intLit") ? "" : "%";

		emit("\t%" + temp_res + " = sub i32 "
			 + pre1 + temp_l.getId() + ", "
			 + pre2 + temp_r.getId() + "\n\n"
			  );

		return new VarInfo(temp_res, "i32:int");
	}

	// f0 -> PrimaryExpression()
	// f1 -> "*"
	// f2 -> PrimaryExpression()
	@Override
	public VarInfo visit(TimesExpression n, String argu) throws Exception {
		VarInfo temp_l = n.f0.accept(this, argu); // Generate code for primary expression
		VarInfo temp_r = n.f2.accept(this, argu); // Generate code for primary expression

		String temp_res = newTemp();

		String pre1 = temp_l.getType().split(":")[0].equals("intLit") ? "" : "%";
		String pre2 = temp_r.getType().split(":")[0].equals("intLit") ? "" : "%";

		emit("\t%" + temp_res + " = mul i32 "
			 + pre1 + temp_l.getId() + ", "
			 + pre2 + temp_r.getId() + "\n\n"
			  );

		return new VarInfo(temp_res, "i32:int");
	}

	// f0 -> PrimaryExpression()
	// f1 -> "["
	// f2 -> PrimaryExpression()
	// f3 -> "]"
	@Override
	public VarInfo visit(ArrayLookup n, String argu) throws Exception {
		VarInfo temp_arr = n.f0.accept(this, argu); // Generate code for primary expression
		VarInfo temp_idx = n.f2.accept(this, argu); // Generate code for primary expression

		String temp_size = newTemp();

		emit("\t%" + temp_size + " = load i32, i32* %" + temp_arr.getId() + "\n");

		String temp_gtz = newTemp(); // greater than zero
		String temp_lts = newTemp(); // less than size

		String pre = (temp_idx.getType().split(":")[0].equals("intLit") ? "" : "%");

		emit("\t%" + temp_gtz + " = icmp sge i32 " + pre + temp_idx.getId() + ", 0\n"
			 + "\t%" + temp_lts + " = icmp slt i32 " + pre + temp_idx.getId() + ", %" + temp_size + "\n"
			  );

		String temp_and = newTemp();

		emit("\t%" + temp_and + " = and i1 %" + temp_gtz + ", %" + temp_lts + "\n");

		String else_label = newLabel();
		String then_label = newLabel();

		String temp_gep_idx = newTemp();
		String temp_gep_res = newTemp();
		String temp_res = newTemp();

		emit("\tbr i1 %" + temp_and + ", label %" + then_label + ", label %" + else_label + "\n\n"
			 + else_label + ":\n"
			 + "\tcall void @throw_oob()\n"
			 + "\tbr label %" + then_label + "\n\n"
			 + then_label + ":\n"
			 + "\t%" + temp_gep_idx + " = add i32 1, " + pre + temp_idx.getId() + "\n"
			 + "\t%" + temp_gep_res + " = getelementptr i32, i32* %"
			 + temp_arr.getId() + ", i32 %" + temp_gep_idx + "\n"
			 + "\t%" + temp_res + " = load i32, i32* %" + temp_gep_res + "\n\n"
			  );

		prev_basic_block = then_label;
		return new VarInfo(temp_res, "i32:int");
	}

	// f0 -> PrimaryExpression()
	// f1 -> "."
	// f2 -> "length"
	@Override
	public VarInfo visit(ArrayLength n, String argu) throws Exception {
		VarInfo temp_arr = n.f0.accept(this, argu); // Generate code for primary expression

		String temp_len = newTemp();

		// Get first 4 bytes, beginning from the array base address (that is: its length)
		emit("\t%" + temp_len + " = load i32, i32* %" + temp_arr.getId() + "\n\n");

		return new VarInfo(temp_len, "i32:int");
	}

	// f0 -> PrimaryExpression()
	// f1 -> "."
	// f2 -> Identifier()
	// f3 -> "("
	// f4 -> ( ExpressionList() )?
	// f5 -> ")"
	@Override
	public VarInfo visit(MessageSend n, String argu) throws Exception {
		VarInfo temp_obj = n.f0.accept(this, argu); // Generate code for primary expression

		String methodname = n.f2.f0.tokenImage;

		MethodInfo methodinfo = searchMethod(methodname, temp_obj.getType().split(":")[1]);

		// Generate code (possibly) for the expression list
		VarInfo temp_args = n.f4.present() ? n.f4.accept(this, argu) : new VarInfo("", null);

		// Example for args: ["%_5", "%_6", 23, 1, "%_7"] (see below)
		String[] args = temp_args.getId().equals("") ? new String[0] : temp_args.getId().split(",");

		String temp_cast = newTemp();
		String temp_vtptr = newTemp();
		String temp_mptr = newTemp();
		String temp_actual_mptr = newTemp();

		int offset = getMethodOffset(temp_obj.getType().split(":")[1], methodname);
		int method_idx = offset / 8; // getelementptr only needs the relative method position/index

		emit("\t%" + temp_cast + " = bitcast i8* %" + temp_obj.getId() + " to i8***\n"
       + "\t%" + temp_vtptr + " = load i8**, i8*** %" + temp_cast + "\n"
       + "\t%" + temp_mptr + " = getelementptr i8*, i8** %" + temp_vtptr + ", i32 " + method_idx + "\n\n"
       + "\t%" + temp_actual_mptr + " = load i8*, i8** %" + temp_mptr + "\n"
			  );

		String temp_cast_actual_mptr = newTemp();

		emit("\t%" + temp_cast_actual_mptr + " = bitcast i8* %" + temp_actual_mptr + " to "
			 + typeInLLVMIR(methodinfo.getType()) + " (i8*"
			  );

		for (VarInfo arg : methodinfo.getArgs())
			emit(", " + typeInLLVMIR(arg.getType()));

		emit(")*\n\n");

		String temp_res = newTemp();

		emit("\t%" + temp_res + " = call " + typeInLLVMIR(methodinfo.getType()) + " %"
			 + temp_cast_actual_mptr + "(i8* %" + temp_obj.getId()
			  );

		int idx = 0;
		for (VarInfo arg : methodinfo.getArgs()) {
			emit(", " + typeInLLVMIR(arg.getType()) + " " + args[idx]);
			idx += 1;
		}

		emit(")\n\n");

		return new VarInfo(temp_res, typeInLLVMIR(methodinfo.getType()) + ":" + methodinfo.getType());
	}

	// f0 -> Expression()
	// f1 -> ExpressionTail()
	@Override
	public VarInfo visit(ExpressionList n, String argu) throws Exception {
		VarInfo temp_expr = n.f0.accept(this, argu); // Generate code for expression
		VarInfo temp_expr_tail = null;

		if (n.f1 != null)
			temp_expr_tail = n.f1.accept(this, argu); // Generate code for expression tail

		String pre = temp_expr.getType().split(":")[0].endsWith("Lit") ? "" : "%";

		String res = pre + temp_expr.getId() + (temp_expr_tail == null ? "" : temp_expr_tail.getId());

		return new VarInfo(res, null);
	}

	// f0 -> ( ExpressionTerm() )*
	@Override
	public VarInfo visit(ExpressionTail n, String argu) throws Exception {
		String ret = "";

		for (Node node : n.f0.nodes) {
			VarInfo temp_expr_term = node.accept(this, argu);

			ret += ", "
			     + (temp_expr_term.getType().split(":")[0].endsWith("Lit") ? "" : "%")
			     + temp_expr_term.getId();
		}

		return new VarInfo(ret, null);
	}

	// f0 -> ","
	// f1 -> Expression()
	@Override
	public VarInfo visit(ExpressionTerm n, String argu) throws Exception {
		return n.f1.accept(this, argu);
	}

	@Override
	public VarInfo visit(IntegerLiteral n, String argu) {
		return new VarInfo(n.f0.tokenImage, "intLit:int");
	}

	@Override
	public VarInfo visit(TrueLiteral n, String argu) {
		return new VarInfo("1", "boolLit:boolean");
	}

	@Override
	public VarInfo visit(FalseLiteral n, String argu) {
		return new VarInfo("0", "boolLit:boolean");
	}

	@Override
	public VarInfo visit(ThisExpression n, String argu) {

		return new VarInfo("this", "i8*:" + getScopeClass(argu));
	}

	// f0 -> "new"
	// f1 -> "int"
	// f2 -> "["
	// f3 -> Expression()
	// f4 -> "]"
	@Override
	public VarInfo visit(ArrayAllocationExpression n, String argu) throws Exception {
		VarInfo temp_expr = n.f3.accept(this, argu); // Generate code for expression

		String temp_size = newTemp();

		emit("\t%" + temp_size + " = add i32 1, "
			 + (temp_expr.getType().split(":")[0].equals("intLit") ? "" : "%")
			 + temp_expr.getId() + "\n"
			  );

		String temp_cmp = newTemp();

		// Check that the size of the array is not negative (since we added 1, we
		// only need to check that temp_size >= 1)

		emit("\t%" + temp_cmp + " = icmp sge i32 %" + temp_size + ", 1\n");

		String else_label = newLabel();
		String then_label = newLabel();

		String alloc_temp = newTemp();
		String cast_temp = newTemp();

		emit("\tbr i1 %" + temp_cmp + ", label %" + then_label + ", label %" + else_label + "\n\n"
       + else_label + ":\n"
			 + "\tcall void @throw_oob()\n"
			 + "\tbr label %" + then_label + "\n\n"
			 + then_label + ":\n"
			 + "\t%" + alloc_temp + " = call i8* @calloc(i32 %" + temp_size + ", i32 4)\n"
			 + "\t%" + cast_temp + " = bitcast i8* %" + alloc_temp + " to i32*\n"
			  );

		emit("\tstore i32 " + (temp_expr.getType().split(":")[0].equals("intLit") ? "" : "%")
			 + temp_expr.getId() + ", i32* %" + cast_temp + "\n\n"
			  );

		prev_basic_block = then_label;
		return new VarInfo(cast_temp, "i32*:int[]");
	}

	// f0 -> "new"
	// f1 -> Identifier()
	// f2 -> "("
	// f3 -> ")"
	@Override
	public VarInfo visit(AllocationExpression n, String argu) throws Exception {
		String classname = n.f1.f0.tokenImage;

		int obj_size = getObjectSize(classname);

		String temp_obj_ref = newTemp();

		emit("\t%" + temp_obj_ref + " = call i8* @calloc(i32 1, i32 " + obj_size + ")\n");

		String temp_vt_ref = newTemp();

		emit("\t%" + temp_vt_ref + " = bitcast i8* %" + temp_obj_ref + " to i8***\n");

		String temp_first = newTemp();
		int n_methods = vt.getNumMethods(classname);

		emit("\t%" + temp_first + " = getelementptr [" + n_methods + " x i8*]"
			 + ", [" + n_methods + " x i8*]* @." + classname + "_vtable, i32 0, i32 0\n"
			 + "\tstore i8** %" + temp_first + ", i8*** %" + temp_vt_ref + "\n\n"
			  );

		return new VarInfo(temp_obj_ref, "i8*:" + classname);
	}

	// f0 -> "!"
	// f1 -> Clause()
	@Override
	public VarInfo visit(NotExpression n, String argu) throws Exception {
		VarInfo temp_clause = n.f1.accept(this, argu); // Generate code for clause

		String temp_not = newTemp();

		// !b <=> 1 xor b, if b is a boolean
		emit("\t%" + temp_not + " = xor i1 1, "
			 + (temp_clause.getType().split(":")[0].equals("boolLit") ? "" : "%")
			 + temp_clause.getId() + "\n\n"
			  );

		return new VarInfo(temp_not, "i1:boolean");
	}

	// f0 -> "("
	// f1 -> Expression()
	// f2 -> ")"
	@Override
	public VarInfo visit(BracketExpression n, String argu) throws Exception {
		return n.f1.accept(this, argu); // Generate code for expression
	}
}
