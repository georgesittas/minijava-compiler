class Main {
  public static void main(String[] a) {
    boolean flag;
    if (true) {
      if (true) {
        if (true) {
          if (true) {
            if (true) {
              System.out.println(1);
            } else {
              System.out.println(0);
            }
            System.out.println(2);
          } else {
            System.out.println(0);
          }
          System.out.println(3);
        } else {
          System.out.println(0);
        }
        System.out.println(4);
      } else {
        System.out.println(0);
      }
      System.out.println(5);
    } else {
      System.out.println(0);
    }
    flag = (((true && true) && ((!(false)) && (!(false)))) &&
            (100 < 1000)); // true
    if (((true && flag) && ((!(false)) && (!(false))))) {
      if (((true && flag) && ((!(false)) && (!(false))))) {
        if (((true && flag) && ((!(false)) && (!(false))))) {
          if (((true && flag) && ((!(false)) && (!(false))))) {
            if (((flag && flag) && ((!(false)) && (!(false))))) {
              System.out.println(1);
            } else {
              System.out.println(0);
            }
            System.out.println(2);
          } else {
            System.out.println(0);
          }
          System.out.println(3);
        } else {
          System.out.println(0);
        }
        System.out.println(4);
      } else {
        System.out.println(0);
      }
      System.out.println(5);
    } else {
      System.out.println(0);
    }
  }
}