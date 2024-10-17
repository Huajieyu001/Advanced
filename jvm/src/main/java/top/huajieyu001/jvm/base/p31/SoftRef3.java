package top.huajieyu001.jvm.base.p31;

import java.lang.ref.ReferenceQueue;
import java.lang.ref.SoftReference;
import java.util.ArrayList;
import java.util.List;

public class SoftRef3 {

    public static void main(String[] args) throws Exception{
        List<SoftReference> softReferenceList = new ArrayList<>();
        ReferenceQueue<byte[]> queues = new ReferenceQueue<byte[]>();

        for (int i = 0; i < 10; i++) {
            byte[] bytes = new byte[1024 * 1024 * 100];
            SoftReference<byte[]> softReference = new SoftReference<>(bytes, queues);
            softReferenceList.add(softReference);
        }

        SoftReference<byte[]> ref = null;
        int count = 0;
        // 被释放的软引用个数
        while((ref = (SoftReference<byte[]>) queues.poll()) != null){
            count++;
        }
        System.out.println("**********************");
        System.out.println(count);
    }
}
