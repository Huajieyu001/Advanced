package top.huajieyu001.jvm.base.p31;

import java.lang.ref.SoftReference;

public class SoftRef {

    public static void main(String[] args) throws Exception{
        byte [] bytes = new byte[1024 * 1024 * 100];
        SoftReference<byte[]> softReference = new SoftReference<>(bytes);
        bytes = null;

        System.out.println(softReference.get());

        byte [] bytes2 = new byte[1024 * 1024 * 100];
        System.out.println(softReference.get());

        byte [] bytes3 = new byte[1024 * 1024 * 100];
        System.out.println(softReference.get());
    }
}
