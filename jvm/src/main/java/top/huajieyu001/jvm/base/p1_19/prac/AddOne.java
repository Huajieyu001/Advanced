package top.huajieyu001.jvm.base.p1_19.prac;

public class AddOne {

    public static void get1(){
        int i = 0;
        i++;
        System.out.println(i);
    }

    public static void get2(){
        int i = 0;
        i = i + 1;
        System.out.println(i);
    }

    public static void get3(){
        int i = 0;
        i += 1;
        System.out.println(i);
    }

    public static void main(String[] args) throws Exception{
        get1();
        get2();
        get3();

//        while(true){
//            Thread.sleep(1000L);
//        }
    }
}
