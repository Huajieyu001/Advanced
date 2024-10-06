package org.example;

/**
 * 添加下列虚拟机参数，xxx为目录和jar文件名
 * -Xbootclasspath/a:xxxxxxx/xxx.jar
 */
public class BootTest{

    public static void main(String[] args) throws Exception {
        Class<?> clazz = Class.forName("com.example.classloader.A");

        System.out.println(clazz);

        ClassLoader classLoader = clazz.getClassLoader();
        System.out.println(classLoader);

        System.in.read();
    }

}
