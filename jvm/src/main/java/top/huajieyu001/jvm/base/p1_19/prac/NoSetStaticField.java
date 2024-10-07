package top.huajieyu001.jvm.base.p1_19.prac;

/**
 * 有静态字段但是没有设置，也不会生成clinit方法
 */
public class NoSetStaticField {

    public static int j;

    public static void main(String[] args) {

    }
}
