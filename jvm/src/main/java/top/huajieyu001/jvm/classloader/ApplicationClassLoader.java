package top.huajieyu001.jvm.classloader;

import org.springframework.util.StringUtils;

/**
 * 测试应用加载器
 */
public class ApplicationClassLoader {

    public static void main(String[] args) {
        Demo demo = new Demo();
        ClassLoader classLoader = Demo.class.getClassLoader();
        System.out.println(classLoader);

        ClassLoader classLoader1 = StringUtils.class.getClassLoader();
        System.out.println(classLoader1);
    }
}
