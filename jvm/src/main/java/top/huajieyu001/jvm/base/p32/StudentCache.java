package top.huajieyu001.jvm.base.p32;

import java.lang.ref.ReferenceQueue;
import java.lang.ref.SoftReference;
import java.util.HashMap;
import java.util.Map;


public class StudentCache{

    public static void main(String[] args) {
        for (int i = 0; ; i++) {
            StudentCache.getInstance().cacheStudent(new Student(i, String.valueOf(i)));
        }
    }

    private static StudentCache cache = new StudentCache();

    private class StudentRef extends SoftReference<Student>{
        private Integer refKey = null;

        public StudentRef(Student elem, ReferenceQueue<? super Student> q) {
            super(elem, q);
            refKey = elem.getId();
        }
    }

    private Map<Integer, StudentRef> studentRefMap;
    private ReferenceQueue<Student> queue;

    private StudentCache(){
        studentRefMap = new HashMap<>();
        queue = new ReferenceQueue<Student>();
    }

    public static StudentCache getInstance(){
        return cache;
    }

    private void cacheStudent(Student student){
        cleanCache();
        StudentRef ref = new StudentRef(student, queue);
        studentRefMap.put(student.getId(), ref);

        System.out.println(studentRefMap.size());
    }

    public Student getStudent(Integer id){
        Student elem = null;
        if(studentRefMap.containsKey(id)){
            StudentRef ref = studentRefMap.get(id);
            elem = ref.get();
        }
        return elem;
    }

    private void cleanCache(){
        StudentRef ref = null;
        while((ref = (StudentRef) queue.poll()) != null){
            studentRefMap.remove(ref.refKey);
        }
    }


}


class Student{
    private Integer id;
    private String name;

    public Student(Integer id, String name) {
        this.id = id;
        this.name = name;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}