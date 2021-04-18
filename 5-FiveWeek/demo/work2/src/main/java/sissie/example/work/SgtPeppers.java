package sissie.example.work;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class SgtPeppers implements CompactDisc {

     @Value("1")
     int id;
     @Value("sgtPeppers_name_3")
     String name;

    public void play() {
        System.out.println("Playing "+ id + " by " + name);
    }
}
