package sissie.example.work;

import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

@Data
public class Klass {

    @Autowired
    List<Student> students;

    public void dong(){
        System.out.println(students);
    }

}

