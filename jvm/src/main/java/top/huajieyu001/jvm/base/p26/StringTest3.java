package top.huajieyu001.jvm.base.p26;

public class StringTest3 {

    public static void main(String[] args) {
        String s1 = new StringBuilder().append("th").append("sd").toString();

        System.out.println(s1.intern() == s1);

        String s2 = new StringBuilder().append("ja").append("va").toString();

        System.out.println(s2.intern() == s2);
    }
}
