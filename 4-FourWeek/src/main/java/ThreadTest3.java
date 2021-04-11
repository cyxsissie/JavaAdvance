import java.util.concurrent.BrokenBarrierException;
import java.util.concurrent.CyclicBarrier;

public class ThreadTest3 {
    private static int count = 2;

    // 同步屏障CyclicBarrier
    public static void main(String[] args) throws InterruptedException, BrokenBarrierException {
        final CyclicBarrier barrier = new CyclicBarrier(count);
        for (int i = 0; i< count; i++) {
            Thread childThread = new Thread(() -> {
                try {
                    System.out.println(Thread.currentThread().getName()+"  开始执行");
                    Thread.sleep(2000);
                    System.out.println(Thread.currentThread().getName()+"  执行完毕...");
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                try {
                    barrier.await();
                } catch (BrokenBarrierException | InterruptedException e) {
                    e.printStackTrace();
                }
            });

            childThread.start();
        }
        barrier.await();
        System.out.println("主线程执行完毕....");
    }
}
