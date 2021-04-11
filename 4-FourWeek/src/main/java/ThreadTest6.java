import java.util.concurrent.*;

public class ThreadTest6 {
    private static int count = 2;

    // 创建定时线程池执行
    public static void main(String[] args) {

         ScheduledExecutorService threadPool = Executors.newScheduledThreadPool(count);
        for (int i = 0; i < count; i++) {
            Runnable runnable = () -> {
                try {
                    System.out.println(Thread.currentThread().getName()+"  开始执行");
                    Thread.sleep(1000L);
                    System.out.println(Thread.currentThread().getName()+"  执行完毕...");
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            };
            // 3s后执行
            threadPool.schedule(runnable, 3, TimeUnit.SECONDS);
        }

         threadPool.shutdown();
         while (true) { //等待所有任务都执行结束
            if (threadPool.isTerminated()) {//所有的子线程都结束了
                System.out.println(Thread.currentThread().getName()+"  执行完毕...");
                break;
            }
         }
         System.out.println("主线程执行完毕....");

    }
}