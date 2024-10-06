package top.huajieyu001.jvm.prac;

public class InitDemo {
    static {
        System.out.println("InitDemo init");
//        i = 2;
    }
//
//    public static int i = 1;

    public static void main(String[] args) throws Exception {
        int j = Demo2.i;
        System.out.println(j);
        Demo3 demo3 = new Demo3();
        Class.forName("top.huajieyu001.jvm.prac.Demo4");
    }
}

class Demo2{
    static {
        System.out.println("Demo2 init");
    }

    public static final int i = 1;
}

class Demo3{
    static {
        System.out.println("Demo3 init");
    }

    public static int i = 1;
}

class Demo4{
    static {
        System.out.println("Demo4 init");
    }

    public static int i = 1;
}



