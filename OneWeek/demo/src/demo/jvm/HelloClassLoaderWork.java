package demo.jvm;

import java.io.*;
import java.lang.reflect.Method;

public class HelloClassLoaderWork extends ClassLoader {

    private String rootDir;

    public HelloClassLoaderWork(String rootDir) {
        this.rootDir = rootDir;
    }

    public static  void main(String[] args) {
        try {
            Class<?> myClass = new HelloClassLoaderWork("e:/JavaLearn/JavaAdvance/Works/OneWeek/").findClass("Hello");
            Method method = myClass.getDeclaredMethod("hello");
            Object obj = myClass.newInstance();
            method.invoke(obj);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected Class<?> findClass(String name) {
        File file = new File(rootDir + name.replaceAll("\\.", "/")+".xlass");
        try {
            FileInputStream inputStream = new FileInputStream(file);
            ByteArrayOutputStream bsArr = new ByteArrayOutputStream();
            int b ;
            while ((b = inputStream.read()) != -1){
                bsArr.write(b);
            }
            bsArr.close();
            inputStream.close();
            byte [] bs = bsArr.toByteArray();

            int[] data = new int[bs.length];
            for(int i=0; i<bs.length; i++) {
                data[i] = 255- ( bs[i] & 0xff);
            }

            byte [] newBs = new byte[bs.length];

            for(int i=0; i<data.length; i++) {
                newBs[i] = (byte) data[i];
            }

                return super.defineClass(name, newBs, 0, newBs.length);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
}
