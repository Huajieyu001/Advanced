package top.huajieyu001.jvm.base.p31;

public class ReferenceCounting {

    public static A a2 = null;

    public static void main(String[] args) throws Exception{
        A a = new A();
        B b = new B();
        a.b = b;
        b.a = a;

        a = null;
        b = null;

        a2 = a;
        System.in.read();
    }
}

class A {
    B b;
}

class B {
    A a;
}
