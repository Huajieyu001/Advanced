package org.example;

public class LoadTest {

    public static void main(String[] args) throws Exception {
        ClassLoader classLoader = App.class.getClassLoader();
        // AppClassLoader
        System.out.println(classLoader);

        Class<?> aClass = classLoader.loadClass("java.lang.String");
        // null,说明不是AppClassLoader加载的，而是启动类加载器加载
        System.out.println(aClass.getClassLoader());

        System.in.read();
    }
}
