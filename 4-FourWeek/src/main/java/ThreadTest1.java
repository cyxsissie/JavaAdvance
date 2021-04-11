import java.util.concurrent.CountDownLatch;

public class ThreadTest1 {
    private static int count = 2;

    // 创建CountDownLatch 对象， 设定需要计数的子线程数目
    public static void main(String[] args) throws InterruptedException {

        final CountDownLatch latch=new CountDownLatch(count);

        for (int i = 0; i < count; i++) {
            new Thread(() -> {
                try {
                    System.out.println(Thread.currentThread().getName()+"  开始执行");
                    Thread.sleep(2000);
                    System.out.println(Thread.currentThread().getName()+"  执行完毕...");

                    latch.countDown();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }).start();
        }
        System.out.println("等待子线程执行完毕...");

        latch.await();
        System.out.println("主线程执行完毕....");
    }




}




