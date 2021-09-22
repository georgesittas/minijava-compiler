import syntaxtree.*;
import symbol_table.*;
import visitor.GJDepthFirst;

public class STVisitor extends GJDepthFirst<String, String> {
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

	public STVisitor(SymbolTable st) {
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
		String classname = n.f1.accept(this, null);
		st.addClass(classname, null);
                                                        // +- Means "don't add offset info"
		ClassInfo classinfo = st.getClassInfo(classname);   // v 
		classinfo.addMethod(new MethodInfo("main", "void"), false);

		MethodInfo maininfo = classinfo.getMethodInfo("main");
		String argname = n.f11.accept(this, null);
		maininfo.addArg(new VarInfo(argname, "String[]"));

		n.f14.accept(this, classname + ":main");

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
		String classname = n.f1.accept(this, null);
		st.addClass(classname, null);

		n.f3.accept(this, classname);
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
		String classname = n.f1.accept(this, null);
		String supername = n.f3.accept(this, null);
		st.addClass(classname, supername);

		n.f5.accept(this, classname);
		n.f6.accept(this, classname);

		return null;
	}

	// f0 -> Type()
	// f1 -> Identifier()
	// f2 -> ";"
	@Override
	public String visit(VarDeclaration n, String argu) throws Exception {
		String vartype = n.f0.accept(this, null);
		String varname = n.f1.accept(this, null);

		String classname = getScopeClass(argu);
		String methodname = getScopeMethod(argu);

		ClassInfo classinfo = st.getClassInfo(classname);

		if (methodname == null)
			classinfo.addField(new VarInfo(varname, vartype));
		else {
			MethodInfo methodinfo = classinfo.getMethodInfo(methodname);
			methodinfo.addVar(new VarInfo(varname, vartype));
		}

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
		String methodname = n.f2.accept(this, null);

		// Calling n.f4.accept will give us a string like "int-foo,boolean-bar"
		String[] methodargs = n.f4.present() ? n.f4.accept(this, null).split(",")
		                                     : new String[0]; // Ensures .length == 0

		String classname = getScopeClass(argu);
		boolean add_offset = true;

		// Check for overloading errors due to different definitions in superclasses
		for (String curr = classname; true; ) {
			curr = st.getSuperClassId(curr);

			if (curr == null)
				break; // No more superclasses, resume flow of control

			ClassInfo classinfo = st.getClassInfo(curr);
			MethodInfo methodinfo = classinfo.getMethodInfo(methodname);

			if (methodinfo != null) {
				if (methodinfo.getType() != methodtype)
					throw new Exception("Invalid method declaration (overloaded symbol)");

				if (methodargs.length != methodinfo.getNumArgs())
					throw new Exception("Invalid method declaration (overloaded symbol)");

				for (int i = 0; i < methodargs.length; i++) {
					String argtype = (methodargs[i].split("-"))[0]; // eg (["int", "foo"])[0]

					if (!argtype.equals(methodinfo.getArgType(i)))
						throw new Exception("Invalid method declaration (overloaded symbol)");
				}

				add_offset = false; // No need to add offset info for overriden methods
				break; // No need to check further up, resume flow of control
			}
		}

		ClassInfo classinfo = st.getClassInfo(classname);
		classinfo.addMethod(new MethodInfo(methodname, methodtype), add_offset);

		MethodInfo methodinfo = classinfo.getMethodInfo(methodname);

		for (int i = 0; i < methodargs.length; i++) {
			String[] arginfo = methodargs[i].split("-");

			String argtype = arginfo[0];
			String argname = arginfo[1];

			methodinfo.addArg(new VarInfo(argname, argtype));
		}

		n.f7.accept(this, classname + ":" + methodname);
		return null;
	}

	// f0 -> FormalParameter()
	// f1 -> FormalParameterTail()
	@Override
	public String visit(FormalParameterList n, String argu) throws Exception {
		String ret = n.f0.accept(this, null);

		if (n.f1 != null)
			ret += n.f1.accept(this, null);

		return ret;
	}

	// f0 -> Type()
	// f1 -> Identifier()
	@Override
	public String visit(FormalParameter n, String argu) throws Exception {
		String argtype = n.f0.accept(this, null);
		String argname = n.f1.accept(this, null);

		return argtype + "-" + argname;
	}

	// f0 -> ( FormalParameterTerm() )*
	@Override
	public String visit(FormalParameterTail n, String argu) throws Exception {
		String ret = "";

		for (Node node : n.f0.nodes)
			ret += "," + node.accept(this, null);

		return ret;
	}

	// f0 -> ","
	// f1 -> FormalParameter()
	@Override
	public String visit(FormalParameterTerm n, String argu) throws Exception {
		return n.f1.accept(this, null);
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

	@Override
	public String visit(Identifier n, String argu) {
		return n.f0.toString();
	}
}
