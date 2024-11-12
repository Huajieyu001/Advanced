package top.huajieyu001.jvm.base.p31after;

import java.lang.ref.WeakReference;

public class WeakReferenceDemo {

    public static void main(String[] args) throws Exception{
        byte [] bytes = new byte[1024 * 1024 * 100];

        WeakReference<byte[]> wr = new WeakReference<>()(bytes);

    }
}
