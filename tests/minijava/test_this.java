class Main {
  public static void main(String[] args) {
    E e;
    F f;
    e = new E();
    f = new F();
    System.out.println(e.InitE());
    System.out.println(e.f5());
    System.out.println(f.InitF(e));
  }
}
class A {
  int dataA;
  public int InitA() {
    dataA = 1024;
    return dataA;
  }
  public int f1() { return 1; }
}
class B extends A {
  int dataB;
  public int InitB() {
    dataB = 2048;
    return (dataB + (this.InitA()));
  }
  public int f2() { return (2 + (this.f1())); }
}
class C extends B {
  int dataC;
  public int InitC() {
    dataC = 4096;
    return (dataC + (this.InitB()));
  }
  public int f3() { return (3 + (this.f2())); }
}
class D extends C {
  int dataD;
  public int InitD() {
    dataD = 8192;
    return (dataD + (this.InitC()));
  }
  public int f4() { return (4 + (this.f3())); }
}
class E extends D {
  int dataE;
  public int InitE() {
    dataE = 16384;
    return (dataE + (this.InitD()));
  }
  public int f5() { return (5 + (this.f4())); }
}
class F {
  E Member_E;
  public int InitF(E e) {
    Member_E = e;
    return (e.f5());
  }
}