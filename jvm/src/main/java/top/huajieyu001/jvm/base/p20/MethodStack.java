package top.huajieyu001.jvm.base.p20;

public class MethodStack {

    public static void main(String[] args) {
        A();
    }

    private static void A(){
        System.out.println("A");
        B();
    }

    private static void B(){
        System.out.println("B");
        C();
    }

    private static void C(){
        System.out.println("C");
    }
}
