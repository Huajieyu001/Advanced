package org.example;

/**
 * 当3个类加载器都无法加载的时候，会报异常java.lang.ClassNotFoundException
 */
public class LoadEmptyClass {

    public static void main(String[] args) throws Exception{
        Class<?> aClass = Class.forName("asdf.sdfs");

        System.out.println(aClass);
    }
}
