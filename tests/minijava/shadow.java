class Main {
  public static void main(String[] args) {
    A a;
    C c;
    D d;
    E e;
    boolean dummy;
    a = new A();
    dummy = a.set_x();
    System.out.println(a.x());
    System.out.println(a.y());
    a = new B();
    dummy = a.set_x();
    System.out.println(a.x());
    System.out.println(a.y());

    c = new C();
    System.out.println(c.get_method_x());
    System.out.println(c.get_class_x());

    d = new D();
    dummy = d.set_int_x();
    if (d.get_class_x2()) {
      System.out.println(1);
    } else {
      System.out.println(0);
    }

    e = new E();
    dummy = e.set_int_x();
    if (e.get_class_x2()) {
      System.out.println(1);
    } else {
      System.out.println(0);
    }
    dummy = e.set_bool_x();
    if (e.get_bool_x()) {
      System.out.println(1);
    } else {
      System.out.println(0);
    }
  }
}

class A {
  int x;
  // Verify that this is 0 (since it's not set)
  int y;

  public boolean set_x() {
    x = 1;
    return true;
  }

  public int x() { return x; }

  public int y() { return y; }
}

class B extends A {
  int x;

  public boolean set_x() {
    x = 2;
    return true;
  }

  public int x() { return x; }
}

class C {
  int x;

  public int get_class_x() { return x; }

  public int get_method_x() {
    int x;
    x = 3;
    return x;
  }

  public boolean set_int_x() {
    x = 20;
    return true;
  }
}

class D extends C {
  boolean x;

  public boolean get_class_x2() { return x; }
}

class E extends D {
  boolean x;

  public boolean set_bool_x() {
    x = true;
    return true;
  }

  public boolean get_bool_x() { return x; }
}
