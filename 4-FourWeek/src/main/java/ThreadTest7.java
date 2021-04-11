
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