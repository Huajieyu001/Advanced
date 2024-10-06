package top.huajieyu001.jvm.prac;

public class TestArr {

    public static void main(String[] args) {
        TestArr2 [] arr2s = new TestArr2[10];
    }
}

class TestArr2{
    static {
        System.out.println("TestArr2 init");
    }
}
