package top.huajieyu001.jvm.base.p1_19.prac;

public class InitValueOf {

    public static void main(String[] args) {
        System.out.println(TestIntegerValueOf.i);
    }
}

class TestIntegerValueOf{
    public static final Integer i = Integer.valueOf(129);
    static{
        System.out.println("TestIntegerValueOf init");
    }
}
