package sissie.example.work;

import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;

public class School implements ISchool {

    @Autowired
    Klass class1;

    @Autowired
    Student student;

    @Override
    public void ding(){
        System.out.println("Class1 have " + this.class1.students.toString() + " students and one is " + this.student);
    }
}
