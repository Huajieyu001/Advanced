package top.huajieyu001.jvm.base.p23;

public class StackOverFlowTest {

    public static int i = 0;
    public static void fun(){
        long a, b, c, d, e, f, g,h ,z ,j ,k;
        System.out.println(++i);
        fun();;
    }

    public static void main(String[] args) {
        fun();
    }
}
