package org.example;

public class ExtTest {

    public static void main(String[] args) throws Exception{
        Class<?> clazz = Class.forName("com.example.classloader.A");

        System.out.println(clazz);

        ClassLoader classLoader = clazz.getClassLoader();
        System.out.println(classLoader);

        System.in.read();
    }
}
