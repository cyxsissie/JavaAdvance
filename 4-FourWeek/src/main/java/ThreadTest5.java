import java.util.concurrent.*;

public class ThreadTest5 {

    // 创建单线程池执行 | 可缓冲线程池执行
    public static void main(String[] args) {
        // ExecutorService threadPool = Executors.newSingleThreadExecutor();
        ExecutorService threadPool = Executors.newCachedThreadPool();
            for (int i = 0; i < 2; i++) {
                final int no = i;
                threadPool.execute(() -> {
                    System.out.println("start:" + no);
                    try {
                        Thread.sleep(2000L);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    System.out.println("end:" + no);
                });
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