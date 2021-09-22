class ThisTest {
	public static void main(String[] args) {
		System.out.println(new A().foo(new B()));
	}
}

class A {
	public int foo(A a1) {
		a1 = this;
		return this.bar();
	}

	public int bar() {
		return 5;
	}
}

class B extends A {}
