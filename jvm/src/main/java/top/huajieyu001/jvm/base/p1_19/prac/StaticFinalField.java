package top.huajieyu001.jvm.base.p1_19.prac;

/**
 * 有静态字段也设置了，但是用了final修饰，也不会生成clinit方法
 */
public class StaticFinalField {

    public static final int j = 1;

    public static void main(String[] args) {
        
    }
}
