import java.util.concurrent.Callable;
import java.util.concurrent.TimeUnit;

public class RandomSleepTask implements Callable<Integer> {

    @Override
    public Integer call() throws Exception {
        TimeUnit.MILLISECONDS.sleep(2000);
        return 2;
    }
}
