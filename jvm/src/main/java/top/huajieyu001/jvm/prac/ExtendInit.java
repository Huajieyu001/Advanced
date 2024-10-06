package top.huajieyu001.jvm.prac;

public class ExtendInit {

    public static void main(String[] args) {
        /*
        1.直接访问父类的静态变量，不会触发子类的初始化。
        2.子类的初始化clinit调用之前，会先调用父类的clinit初始化方法。

        也就是说，如果new了B02，输出结果是2，如果没有new，那就是A02初始化后的值，也就是1
         */
        new B02();
        System.out.println(B02.a);
    }
}

class A02{
    static int a = 0;
    static {
        a = 1;
    }
}

class B02 extends A02{
    static {
        a = 2;
    }
}
