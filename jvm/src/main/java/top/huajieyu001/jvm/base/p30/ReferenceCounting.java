package top.huajieyu001.jvm.base.p30;

public class ReferenceCounting {

    public static void main(String[] args) {
        while (true) {
            A a = new A();
            B b = new B();
            a.b = b;
            b.a = a;

            a = null;
            b = null;

            System.gc();
        }
    }
}

class A {
    B b;
}

class B {
    A a;
}
