class Alsdfjasdjfl {
  public static void main(String[] irrelevant) {
    boolean dummy;
    A a;
    a = new A();
    dummy = a.print(a.foo(false, false, false));
    dummy = a.print(a.foo(false, false, true));
    dummy = a.print(a.foo(false, true, false));
    dummy = a.print(a.foo(false, true, true));
    dummy = a.print(a.foo(true, false, false));
    dummy = a.print(a.foo(true, false, true));
    dummy = a.print(a.foo(true, true, false));
    dummy = a.print(a.foo(true, true, true));

    dummy = a.print(a.bar(true, true));
    dummy = a.print(a.bar(false, true));

    dummy = a.print(new B().foo(1));
    dummy = a.print(new B().foo(2));
    dummy = a.print(new B().t(2, 2, true, true));
  }
}

class A {
  public boolean foo(boolean a, boolean b, boolean c) { return (a && b) && c; }

  public boolean bar(boolean a, boolean b) {
    return (a && (this.foo(a, b, true))) && b;
  }

  public boolean print(boolean res) {
    if (res) {
      System.out.println(1);
    } else {
      System.out.println(0);
    }
    return true;
  }
}

class B {
  public boolean foo(int a) { return !(3 < (a + 2)) && !false; }

  public boolean t(int a, int b, boolean c, boolean d) {
    return (!(a < b)) && (c && d);
  }
}
