package top.huajieyu001.jvm.base.p27;

import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.List;

public class DirectMemory {

    public static final int size = 1024 * 1024 * 100;

    public static List<ByteBuffer> buffers = new ArrayList<>();

    public static int count = 0;

    public static void main(String[] args) throws Exception{


        while(true){
            ByteBuffer buffer = ByteBuffer.allocateDirect(size);
            buffers.add(buffer);
            System.out.println(++ count);

//            Thread.sleep(5000);
        }
    }
}
