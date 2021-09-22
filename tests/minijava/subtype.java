class Main {
  public static void main(String[] args) {
    boolean dummy;
    A a;
    B b;
    C c;
    D d;
    int separator;
    int cls_separator;
    separator = 1111111111;
    cls_separator = 333333333;

    dummy = new Receiver().A(new A());
    System.out.println(separator);
    dummy = new Receiver().A(new Receiver().alloc_B_for_A());
    System.out.println(separator);
    dummy = new Receiver().A(new Receiver().alloc_C_for_A());
    System.out.println(separator);
    dummy = new Receiver().A(new Receiver().alloc_D_for_A());

    System.out.println(cls_separator);

    dummy = new Receiver().B(new B());
    System.out.println(separator);
    dummy = new Receiver().B(new Receiver().alloc_D_for_B());

    System.out.println(cls_separator);

    dummy = new Receiver().C(new C());

    System.out.println(cls_separator);

    dummy = new Receiver().D(new D());
  }
}

class Receiver {

  public boolean A(A a) {
    System.out.println(a.foo());
    System.out.println(a.bar());
    System.out.println(a.test());
    return true;
  }

  public boolean B(B b) {
    System.out.println(b.foo());
    System.out.println(b.bar());
    System.out.println(b.test());
    System.out.println(b.not_overriden());
    System.out.println(b.another());
    return true;
  }

  public boolean C(C c) {
    System.out.println(c.foo());
    System.out.println(c.bar());
    System.out.println(c.test());
    return true;
  }

  public boolean D(D d) {
    System.out.println(d.foo());
    System.out.println(d.bar());
    System.out.println(d.test());
    System.out.println(d.not_overriden());
    System.out.println(d.another());
    System.out.println(d.stef());
    return true;
  }

  public A alloc_B_for_A() { return new B(); }

  public A alloc_C_for_A() { return new C(); }

  public A alloc_D_for_A() { return new D(); }

  public B alloc_D_for_B() { return new D(); }
}

class A {
  public int foo() { return 1; }

  public int bar() { return 2; }

  public int test() { return 3; }
}

class B extends A {
  public int bar() { return 12; }

  public int not_overriden() { return 14; }

  public int another() { return 15; }
}

class C extends A {
  public int bar() { return 22; }
}

class D extends B {
  public int bar() { return 32; }

  public int another() { return 35; }

  public int stef() { return 36; }
}
