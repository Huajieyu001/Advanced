package top.huajieyu001.jvm.base.p24;

import java.util.ArrayList;

public class NewObj {

    public static void main(String[] args) throws Exception{
        ArrayList<Object> objects = new ArrayList<>();
        System.in.read();
        while(true){
            objects.add(new byte[1024 * 1024]);
            Thread.sleep(10);
        }
    }
}
