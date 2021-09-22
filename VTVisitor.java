import vtable.*;
import syntaxtree.*;
import symbol_table.*;
import visitor.GJDepthFirst;

public class VTVisitor extends GJDepthFirst<String, String> {
	private VTable vt;
	private SymbolTable st;

	public VTVisitor(SymbolTable st, VTable vt) {
		this.vt = vt;
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

		vt.addClass(classname);

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

		vt.addClass(classname);

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
		String supername = n.f3.f0.tokenImage;

		vt.addClass(classname);

		// Since we're extending a class, first copy the superclass' virtual table
		// entries into the first positions of the current class' virtual table.

		for (VTInfo methods : vt.getMethods(supername))
			vt.addMethod(classname, methods.getOwner(), methods.getMethodInfo());

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
		String methodname = n.f2.f0.tokenImage;
		String classname = argu; // Class (scope) we're currently in

		ClassInfo classinfo = st.getClassInfo(classname);
		MethodInfo methodinfo = classinfo.getMethodInfo(methodname);

		vt.addMethod(classname, classname, methodinfo);

		return null;
	}
}
