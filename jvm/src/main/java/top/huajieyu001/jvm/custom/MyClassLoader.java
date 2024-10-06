package top.huajieyu001.jvm.custom;

public class MyClassLoader extends ClassLoader{

    private byte[] loadClassData(String name){
        findClass()
    }

    @Override
    public Class<?> loadClass(String name) throws ClassNotFoundException {
        if (name.startsWith("java")){
            return super.loadClass(name);
        }
        byte [] data = loadClassData();
        return super.loadClass(name);
    }
}
