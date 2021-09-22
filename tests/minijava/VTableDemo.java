class VTableDemo {
  public static void main(String[] args) {}
}

class A {
  public int foo() { return 5; }
  public boolean func(A a) { return true; }
  public boolean bla() { return true; }
}

class B extends A {
  public int foo() { return 6; }
  public int baz() { return 7; }
}

class C extends B {
  public int foo() { return 8; }
  public int bar() { return 9; }
  public boolean bla() { return false; }
}
