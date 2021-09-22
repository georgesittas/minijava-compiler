class Main {
  public static void main(String[] a) {
    System.out.println(new A().foo(1));
    System.out.println(new A().foo(2));
  }
}

class A {
  public int foo(int a) {
    if (a < 2) {
      a = 3;
    } else {
      a = 4;
    }
    return a;
  }
}
