package top.huajieyu001.jvm.base.p1_19.method;

public class MethodTest {

    public static int getI1(){
        int i = 0;
        i = i++;
        return i;
    }

    public static int getI2(){
        int i = 0;
        i = ++i;
        return i;
    }

    public static int getIJ(){
        int i = 0;
        int j = i + 1;
        return j;
    }

    public static void main(String[] args) {
        System.out.println(getI1());
        System.out.println(getI2());
        System.out.println(getIJ());
    }
}
