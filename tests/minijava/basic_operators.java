class Main {
  public static void main(String[] args) {
    int i;
    int j;
    i = 10;
    j = 20;
    System.out.println(((((1 + 2) + 3) + i) + j));
    System.out.println(((((1 * 2) * 3) * i) * j));
    System.out.println(((((1 * 2) * 3) - i) + j));
    System.out.println(((((1 * ((new A()).getData())) * 3) - i) + 20));
  }
}
class A {
  public int getData() { return 100; }
}