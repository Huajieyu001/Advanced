package top.huajieyu001.jvm.base.p1_19.classloader;

/**
 * 测试测试启动加载器
 */
public class BootStrapClassLoader {

    public static void main(String[] args) throws Exception{
        ClassLoader classLoader = String.class.getClassLoader();
        System.out.println(classLoader);

        System.in.read();
    }
}
