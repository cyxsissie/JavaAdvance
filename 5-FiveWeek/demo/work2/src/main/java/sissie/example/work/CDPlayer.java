package sissie.example.work;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

@Component("mediaPlayer")
public class CDPlayer implements MediaPlayer {

    @Autowired
    private CompactDisc cd;

    public void play() {
        cd.play();
    }

}
