package top.huajieyu001.jvm.base.p20;

public class Demo1 {

    public static void test1(){
        int i = 0;
        int j = 1;
    }
    public void test2(){
        int i = 0;
        int j = 1;
    }

    public void test3(int k, int m){
        int i = 0;
        int j = 1;
    }

    public void test4(int k, int m){
        {
            int i = 0;
            int j = 1;
        }
    }

}
