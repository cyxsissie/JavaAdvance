import java.util.concurrent.*;

public class ThreadTest4 {
    private static int count = 2;

    // 创建固定大小池执行
    public static void main(String[] args) {

        ExecutorService threadPool = Executors.newFixedThreadPool(count);
        Callable<Integer> task = new RandomSleepTask();

        try {
            Future<Integer> future = threadPool.submit(task);
            Integer res = future.get();
            System.out.println("task共耗时:" + res + "秒");

        } catch (ExecutionException | InterruptedException ex) {
            System.out.println("catch submit");
            ex.printStackTrace();
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



