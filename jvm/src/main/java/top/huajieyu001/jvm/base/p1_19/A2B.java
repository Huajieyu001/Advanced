package top.huajieyu001.jvm.base.p1_19;
import java.io.File;

public class A2B {
    public static void main(String[] args) {
        // 设置当前目录
        File directory = new File("D:\\baiduDownload\\other\\YQ-K");
        // 设置要更改的原始后缀和目标后缀
        String [] strings = new String[]{".r删a除r", ".r谁a除r", ".自行修改后缀"};

        String targetSuffix = ".rar";

        // 获取当前目录下所有文件和文件夹
        File[] files = directory.listFiles();

        for (String string : strings) {
            updateEndwith(files, string, targetSuffix);
        }
    }

    private static void updateEndwith(File[] files, String originalSuffix, String targetSuffix) {
        if (files != null) {
            for (File file : files) {
                // 检查是否是文件以及是否具有指定的原始后缀
                if (file.isFile() && file.getName().endsWith(originalSuffix)) {
                    // 构建新的文件名
                    String newName = file.getName().replace(originalSuffix, targetSuffix);
                    // 创建新的File对象
                    File newFile = new File(file.getParent(), newName);
                    // 重命名文件
                    boolean success = file.renameTo(newFile);
                    if (success) {
                        System.out.println("Renamed " + file.getName() + " to " + newName);
                    } else {
                        System.out.println("Failed to rename " + file.getName());
                    }
                }
            }
        }
    }
}
