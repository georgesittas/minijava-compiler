class Main {
  public static void main(String[] a) {
    int i;
    int j;
    int z;
    int x;
    int sum;
    boolean flag;
    sum = 0;
    i = 0;
    while (i < 6) {
      j = 0;
      while (j < 5) {
        z = 0;
        while (z < 4) {
          x = 0;
          while (x < 4) {
            sum = sum + (((i + j) + z) + x);
            x = x + 1;
          }
          z = z + 1;
        }
        j = j + 1;
      }
      i = i + 1;
    }
    System.out.println(sum);
    sum = 0;
    i = 0;
    flag = true;
    while (i < 6) {
      j = 0;
      if (flag) {
        while (j < 5) {
          z = 0;
          while (z < 4) {
            x = 0;
            while (x < 4) {
              sum = sum + (((i + j) + z) + x);
              x = x + 1;
            }
            z = z + 1;
          }
          j = j + 1;
        }
        flag = false;
      } else {
        while (j < 4) {
          z = 0;
          while (z < 10) {
            x = 0;
            while (x < 4) {
              sum = sum + (((i * j) + z) + x);
              x = x + 1;
            }
            z = z + 1;
          }
          j = j + 1;
        }
        flag = false;
      }
      i = i + 1;
    }
    System.out.println(sum);
  }
}