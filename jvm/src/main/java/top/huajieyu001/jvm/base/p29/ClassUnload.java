package top.huajieyu001.jvm.base.p29;

import java.net.URL;
import java.net.URLClassLoader;
import java.util.ArrayList;
import java.util.List;

public class ClassUnload {

    public static void main(String[] args) {
        try{
            List<Class> classList = new ArrayList<>();
            List<URLClassLoader> urlClassLoaderList = new ArrayList<>();
            List<Object> objectList = new ArrayList<>();

            while(true){

                URL [] urls = new URL[]{new URL("file:D://lib")};
                URLClassLoader loader = new URLClassLoader(urls);

                Class clazz = loader.loadClass("top.huajieyu001.jvm.base.p29.A");
                Object o = clazz.newInstance();

                objectList.add(o);

                System.gc();
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }
}
