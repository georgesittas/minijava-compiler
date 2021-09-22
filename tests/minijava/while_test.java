class Main {
  public static void main(String[] args) {
    int dummy;
    A a;
    a = new A();
    dummy = a.foo();
  }
}

class A {
  public int foo() {
    int a;
    int b;
    a = 3;
    while (a < 4) {
      a = a + 1;
    }
    System.out.println(a);
    b = this.bar(7, true);
    System.out.println(b);
    return 0;
  }

  public int bar(int a, boolean cond) {
    int b;
    b = 0;
    while (cond) {
      b = a;
      if (cond) {
        a = 2;
      } else {
      }
      cond = false;
    }
    return b;
  }
}
