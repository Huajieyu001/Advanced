package top.huajieyu001.jvm.base.p25;

import net.bytebuddy.jar.asm.ClassWriter;
import net.bytebuddy.jar.asm.Opcodes;

public class ByteBuddyTest extends ClassLoader{

    public static void main(String[] args) throws Exception {
        System.in.read();
        ByteBuddyTest test = new ByteBuddyTest();
        int count = 0;
        while(true){
            String name = "Class" + count;
            ClassWriter writer = new ClassWriter(0);
            writer.visit(Opcodes.V1_8, Opcodes.ACC_PUBLIC, name, null, "java/lang/Object", null);
            byte [] bytes = writer.toByteArray();
            test.defineClass(name, bytes, 0, bytes.length);
            System.out.println(++count);
        }

    }
}
