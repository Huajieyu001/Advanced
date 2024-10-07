package top.huajieyu001.jvm.base.p1_19.prac;

public class ABCD {


    public static void main(String[] args) {
        System.out.println("A");
        new ABCD();
        new ABCD();
    }

    ABCD(){
        System.out.println("B");
    }

    {
        System.out.println("C");
    }

    static {
        System.out.println("D");
    }
}
