# 必做作业一
思考有多少种方式，在 main 函数启动一个新线程，运行一个方法，拿到这
个方法的返回值后，退出主线程?

第一种：创建CountDownLatch 对象， 设定需要计数的子线程数目
```
 public class ThreadTest1 {
     private static int count = 2;
 
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
 ```

第二种：Thread的join()等待所有的子线程执行完毕，主线程在执行
```
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
 ```

第三种：CyclicBarrier
```
 public class ThreadTest3 {
     private static int count = 2;
 
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
 ```

第四种：创建固定大小池执行
```
public class ThreadTest4 {
    private static int count = 2;

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
            if (threadPool.isTerminated()) { //所有的子线程都结束了
                System.out.println(Thread.currentThread().getName()+"  执行完毕...");
                break;
            }
        }
        System.out.println("主线程执行完毕....");
    }
}
 ```

第五种：创建单线程池执行 | 可缓冲线程池执行
```
 public class ThreadTest5 {
 
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
             if (threadPool.isTerminated()) { //所有的子线程都结束了
                 System.out.println(Thread.currentThread().getName()+"  执行完毕...");
                 break;
             }
         }
         System.out.println("主线程执行完毕....");
     }
 }
 ```

第六种：创建定时线程池执行
```
 public class ThreadTest6 {
     private static int count = 2;
 
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
             if (threadPool.isTerminated()) { //所有的子线程都结束了
                 System.out.println(Thread.currentThread().getName()+"  执行完毕...");
                 break;
             }
          }
          System.out.println("主线程执行完毕....");
 
     }
 }
 ```

第七种：Thread 异步处理
```
public class ThreadTest7 {

    // Thread 异步处理
    public static void main(String[] args) {
        LockHandler sHandler=new LockHandler();
        Thread sThread=new Thread(new WorkRunnable(sHandler));

        sThread.start();
        sHandler.waitHandle();

        System.out.println("主线程执行完毕....");
    }

    public static class WorkRunnable implements Runnable {
        public LockHandler sHandler;

        public WorkRunnable(LockHandler sHandler) {
            this.sHandler = sHandler;
        }

        public void run() {
            try {
                System.out.println(Thread.currentThread().getName()+"  开始执行");
                Thread.sleep(2000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            System.out.println(Thread.currentThread().getName()+"  执行完毕...");

            sHandler.notifyAllHandle();
        }
    }

    public static class LockHandler {
        public synchronized void waitHandle() {
            try {
                this.wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

        public synchronized void notifyAllHandle() {
            this.notifyAll();
        }
    }

}
 ```

# 必做作业二

详见 Multithreading.jpg 和 Concurrent.jpg

