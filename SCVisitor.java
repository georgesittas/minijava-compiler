import syntaxtree.*;
import symbol_table.*;
import visitor.GJDepthFirst;

public class SCVisitor extends GJDepthFirst<String, String> {
	private SymbolTable st;

	// Scope is represented as a string of the form "ClassId:MethodId"

	private String getScopeClass(String scope)  {
		String[] tokens = scope.split(":");
		return tokens[0];
	}

	private String getScopeMethod(String scope) {
		String[] tokens = scope.split(":");
		return tokens.length == 2 ? tokens[1] : null;
	}

	private VarInfo searchVar(String target_id, String scope) {
		if (scope == null)
			return null; // We didn't find the var we were looking for

		String class_id = getScopeClass(scope);
		String method_id = getScopeMethod(scope);

		// Assumes that the class contained in 'scope' is declared -- no null checks
		ClassInfo classinfo = st.getClassInfo(class_id);

		if (method_id != null) {
			MethodInfo methodinfo = classinfo.getMethodInfo(method_id);
			VarInfo targetinfo = methodinfo.getInfo(target_id);

			if (targetinfo != null)
				return targetinfo; // Found a matching local var (or arg) inside the method
		}

		// Didn't find the target var in the method's scope, search class fields upwards
		VarInfo targetinfo = classinfo.getFieldInfo(target_id);
		return targetinfo != null ? targetinfo
		                          : searchVar(target_id, st.getSuperClassId(class_id));
	}

	private MethodInfo searchMethod(String target_id, String scope) {
		if (scope == null)
			return null; // We didn't find the method we were looking for

		String class_id = getScopeClass(scope);

		// Assumes that the class contained in 'scope' is defined -- no null checks
		ClassInfo classinfo = st.getClassInfo(class_id);

		MethodInfo targetinfo = classinfo.getMethodInfo(target_id);
		return targetinfo != null ? targetinfo
		                          : searchMethod(target_id, st.getSuperClassId(class_id));
	}

	private boolean isCompatible(String t1, String t2) throws Exception {
		if (t1.equals("int"))     return t2.equals("int");
		if (t1.equals("boolean")) return t2.equals("boolean");
		if (t1.equals("int[]"))   return t2.equals("int[]");

		if (st.getClassInfo(t1) == null || st.getClassInfo(t2) == null)
			throw new Exception("Invalid type (undefined symbol)");

		// t1 is compatible with t2 if (a) they're the same or (b) t1 inherits from t2
		return t1.equals(t2) || st.isDerivedFrom(t1, t2);
	}

	public SCVisitor(SymbolTable st) {
		this.st = st;
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
	public String visit(MainClass n, String argu) throws Exception {
		String classname = n.f1.f0.tokenImage;
		n.f15.accept(this, classname + ":main");

		return null;
	}

	// f0 -> "class"
	// f1 -> Identifier()
	// f2 -> "{"
	// f3 -> ( VarDeclaration() )*
	// f4 -> ( MethodDeclaration() )*
	// f5 -> "}"
	@Override
	public String visit(ClassDeclaration n, String argu) throws Exception {
		String classname = n.f1.f0.tokenImage;
		n.f4.accept(this, classname);

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
	public String visit(ClassExtendsDeclaration n, String argu) throws Exception {
		String classname = n.f1.f0.tokenImage;
		n.f6.accept(this, classname);

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
	public String visit(MethodDeclaration n, String argu) throws Exception {
		String methodtype = n.f1.accept(this, null);
		String methodname = n.f2.f0.tokenImage;

		String scope = getScopeClass(argu) + ":" + methodname;

		n.f8.accept(this, scope);

		String returntype = n.f10.accept(this, scope);

		if (!isCompatible(returntype, methodtype))
			throw new Exception("Incompatible return type");

		return null;
	}

	@Override
	public String visit(ArrayType n, String argu) {
		return "int[]";
	}

	@Override
	public String visit(BooleanType n, String argu) {
		return "boolean";
	}

	@Override
	public String visit(IntegerType n, String argu) {
		return "int";
	}

	// f0 -> Identifier()
	// f1 -> "="
	// f2 -> Expression()
	// f3 -> ";"
	@Override
	public String visit(AssignmentStatement n, String argu) throws Exception {
		String lvalue_type = n.f0.accept(this, argu);
		String rvalue_type = n.f2.accept(this, argu);

		if (!isCompatible(rvalue_type, lvalue_type))
			throw new Exception("Incompatible types in assignment");

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
	public String visit(ArrayAssignmentStatement n, String argu) throws Exception {
		String lvalue_type = n.f0.accept(this, argu);

		if (!lvalue_type.equals("int[]"))
			throw new Exception("Invalid lvalue type in array assignment");

		String idx_type = n.f2.accept(this, argu);

		if (!idx_type.equals("int"))
			throw new Exception("Invalid array index type");

		String rvalue_type = n.f5.accept(this, argu);

		if (!rvalue_type.equals("int"))
			throw new Exception("Incompatible types in array assignment");

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
	public String visit(IfStatement n, String argu) throws Exception {
		String condition_type = n.f2.accept(this, argu);

		if (!condition_type.equals("boolean"))
			throw new Exception("Invalid condition expression type");

		n.f4.accept(this, argu);
		n.f6.accept(this, argu);

		return null;
	}

	// f0 -> "while"
	// f1 -> "("
	// f2 -> Expression()
	// f3 -> ")"
	// f4 -> Statement()
	@Override
	public String visit(WhileStatement n, String argu) throws Exception {
		String condition_type = n.f2.accept(this, argu);

		if (!condition_type.equals("boolean"))
			throw new Exception("Invalid condition expression type");

		n.f4.accept(this, argu);

		return null;
	}

	// f0 -> "System.out.println"
	// f1 -> "("
	// f2 -> Expression()
	// f3 -> ")"
	// f4 -> ";"
	@Override
	public String visit(PrintStatement n, String argu) throws Exception {
		String print_arg_type = n.f2.accept(this, argu);

		if (!print_arg_type.equals("int"))
			throw new Exception("Invalid print statement argument type");

		return null;
	}

	// f0 -> Clause()
	// f1 -> "&&"
	// f2 -> Clause()
	@Override
	public String visit(AndExpression n, String argu) throws Exception {
		String clause1_type = n.f0.accept(this, argu);
		String clause2_type = n.f2.accept(this, argu);

		if (!clause1_type.equals("boolean") || !clause2_type.equals("boolean"))
			throw new Exception("Invalid operand type in conjunction");

		return "boolean";
	}

	// f0 -> PrimaryExpression()
	// f1 -> "<"
	// f2 -> PrimaryExpression()
	@Override
	public String visit(CompareExpression n, String argu) throws Exception {
		String expr1_type = n.f0.accept(this, argu);
		String expr2_type = n.f2.accept(this, argu);

		if (!expr1_type.equals("int") || !expr2_type.equals("int"))
			throw new Exception("Invalid operand type in comparison");

		return "boolean";
	}

	// f0 -> PrimaryExpression()
	// f1 -> "+"
	// f2 -> PrimaryExpression()
	@Override
	public String visit(PlusExpression n, String argu) throws Exception {
		String expr1_type = n.f0.accept(this, argu);
		String expr2_type = n.f2.accept(this, argu);

		if (!expr1_type.equals("int") || !expr2_type.equals("int"))
			throw new Exception("Invalid operand type in addition");

		return "int";
	}

	// f0 -> PrimaryExpression()
	// f1 -> "-"
	// f2 -> PrimaryExpression()
	@Override
	public String visit(MinusExpression n, String argu) throws Exception {
		String expr1_type = n.f0.accept(this, argu);
		String expr2_type = n.f2.accept(this, argu);

		if (!expr1_type.equals("int") || !expr2_type.equals("int"))
			throw new Exception("Invalid operand type in subtraction");

		return "int";
	}

	// f0 -> PrimaryExpression()
	// f1 -> "*"
	// f2 -> PrimaryExpression()
	@Override
	public String visit(TimesExpression n, String argu) throws Exception {
		String expr1_type = n.f0.accept(this, argu);
		String expr2_type = n.f2.accept(this, argu);

		if (!expr1_type.equals("int") || !expr2_type.equals("int"))
			throw new Exception("Invalid operand type in multiplication");

		return "int";
	}

	// f0 -> PrimaryExpression()
	// f1 -> "["
	// f2 -> PrimaryExpression()
	// f3 -> "]"
	@Override
	public String visit(ArrayLookup n, String argu) throws Exception {
		String expr_type = n.f0.accept(this, argu);
		String idx_type  = n.f2.accept(this, argu);

		if (!expr_type.equals("int[]"))
			throw new Exception("Non-array type in lookup expression");

		if (!idx_type.equals("int"))
			throw new Exception("Invalid array index type");

		return "int";
	}

	// f0 -> PrimaryExpression()
	// f1 -> "."
	// f2 -> "length"
	@Override
	public String visit(ArrayLength n, String argu) throws Exception {
		String expr_type = n.f0.accept(this, argu);

		if (!expr_type.equals("int[]"))
			throw new Exception("Non-array type in length expression");

		return "int";
	}

	// f0 -> PrimaryExpression()
	// f1 -> "."
	// f2 -> Identifier()
	// f3 -> "("
	// f4 -> ( ExpressionList() )?
	// f5 -> ")"
	@Override
	public String visit(MessageSend n, String argu) throws Exception {
		String expr_type = n.f0.accept(this, argu);

		ClassInfo classinfo = st.getClassInfo(expr_type);

		if (classinfo == null)
			throw new Exception("Method called on object of invalid type");

		String target_method = n.f2.f0.tokenImage;
		MethodInfo methodinfo = searchMethod(target_method, expr_type);

		if (methodinfo == null)
			throw new Exception("Invalid method (undefined symbol)");

		// Calling n.f4.accept will give us a string like "int,boolean,T"
		String[] argtypes = n.f4.present() ? n.f4.accept(this, argu).split(",")
		                                   : new String[0]; // Ensures .length == 0

		if (argtypes.length != methodinfo.getNumArgs())
			throw new Exception("Invalid number of arguments in method call");

		for (int i = 0; i < argtypes.length; i++)
			if (!isCompatible(argtypes[i], methodinfo.getArgType(i)))
				throw new Exception("Incompatible method argument type");

		return methodinfo.getType();
	}

	// f0 -> Expression()
	// f1 -> ExpressionTail()
	@Override
	public String visit(ExpressionList n, String argu) throws Exception {
		String ret = n.f0.accept(this, argu);

		if (n.f1 != null)
			ret += n.f1.accept(this, argu);

		return ret;
	}

	// f0 -> ( ExpressionTerm() )*
	@Override
	public String visit(ExpressionTail n, String argu) throws Exception {
		String ret = "";

		for (Node node : n.f0.nodes)
			ret += "," + node.accept(this, argu);

		return ret;
	}

	// f0 -> ","
	// f1 -> Expression()
	@Override
	public String visit(ExpressionTerm n, String argu) throws Exception {
		return n.f1.accept(this, argu);
	}

	@Override
	public String visit(IntegerLiteral n, String argu) {
		return "int";
	}

	@Override
	public String visit(TrueLiteral n, String argu) {
		return "boolean";
	}

	@Override
	public String visit(FalseLiteral n, String argu) {
		return "boolean";
	}

	@Override
	public String visit(Identifier n, String argu) throws Exception {
		String target_id = n.f0.toString();

		// Try to find the identifier's type in the scope designated by argu
		VarInfo targetinfo = searchVar(target_id, argu);

		if (targetinfo == null)
			throw new Exception("Invalid identifier (undefined symbol)");

		return targetinfo.getType();
	}

	@Override
	public String visit(Type n, String argu) throws Exception {

		// .which = 0 -> ArrayType
		//        = 1 -> BooleanType
		//        = 2 -> IntegerType
		//        = 3 -> Identifier
		//
		// (See minijava-jtb.jj, lines: 421-448)

		return n.f0.which == 3 ? ((Identifier) n.f0.choice).f0.tokenImage
		                       : super.visit(n, argu);
	}

	@Override
	public String visit(ThisExpression n, String argu) {
		return getScopeClass(argu); // Return type is just the surrounding class' id
	}

	// f0 -> "new"
	// f1 -> "int"
	// f2 -> "["
	// f3 -> Expression()
	// f4 -> "]"
	@Override
	public String visit(ArrayAllocationExpression n, String argu) throws Exception {
		String idx_type = n.f3.accept(this, argu);

		if (!idx_type.equals("int"))
			throw new Exception("Invalid array index type");

		return "int[]";
	}

	// f0 -> "new"
	// f1 -> Identifier()
	// f2 -> "("
	// f3 -> ")"
	@Override
	public String visit(AllocationExpression n, String argu) throws Exception {
		String typename = n.f1.f0.tokenImage;

		if (st.getClassInfo(typename) == null)
			throw new Exception("Invalid type (undefined symbol)");

		return typename; // Name of the class corresponding to Identifier()
	}

	// f0 -> "!"
	// f1 -> Clause()
	@Override
	public String visit(NotExpression n, String argu) throws Exception {
		String clause_type = n.f1.accept(this, argu);

		if (!clause_type.equals("boolean"))
			throw new Exception("Invalid operand type in negation");

		return "boolean";
	}

	// f0 -> "("
	// f1 -> Expression()
	// f2 -> ")"
	@Override
	public String visit(BracketExpression n, String argu) throws Exception {
		return n.f1.accept(this, argu);
	}
}
