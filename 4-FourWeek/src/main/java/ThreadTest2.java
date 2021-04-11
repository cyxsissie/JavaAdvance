import java.util.Vector;

public class ThreadTest2 {
    private static int count = 2;

    // Thread的join()等待所有的子线程执行完毕，主线程在执行
    public static void main(String[] args) throws InterruptedException {
        Vector<Thread> threadVector = new Vector<>();
        for (int i = 0; i< count; i++) {
            Thread childThread = new Thread(() -> {
                try {
                    System.out.println(Thread.currentThread().getName()+"  开始执行");
                    Thread.sleep(2000);
                    System.out.println(Thread.currentThread().getName()+"  执行完毕...");
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            });
            threadVector.add(childThread);
            childThread.start();
        }
        for (Thread thread : threadVector) {
            thread.join();
        }
        System.out.println("主线程执行完毕....");
    }
}
