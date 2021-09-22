class VarDeclDemo {
	public static void main(String[] args) {
		int x;
		int y;
		boolean z;
		int[] w;
		A a;
		B b;
	}
}

class A {
	public int foo(A a, B b) {
		int x;
		int y;

		return 5;
	}
}

class B extends A {
	public int foo(A a, B b) {
		B k;
		B l;
		int[] x;

		return 6;
	}
}
