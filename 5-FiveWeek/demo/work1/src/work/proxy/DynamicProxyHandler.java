package work.proxy;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

public class DynamicProxyHandler implements InvocationHandler {
    private Object proxiedObject;
    public DynamicProxyHandler(Object proxiedObject) {
        this.proxiedObject = proxiedObject;
    }

    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        // 执行原始类业务之前的附加功能：（逻辑处理 -- 记录执行开始时间）
        long totalMilliSeconds = System.currentTimeMillis();
        before(totalMilliSeconds);
        // 委托
        Object result = method.invoke(proxiedObject, args);
       // 执行原始类业务之后的附加功能：（逻辑处理 -- 记录执行结束时间）
        after(totalMilliSeconds);
        String apiName = proxiedObject.getClass().getName() + ":" + method.getName();
        System.out.println("委托方："+ apiName);
        return result;
    }

    private void before(long totalMilliSeconds) {
        //获得系统的时间，单位为毫秒
        DateFormat dateFormatterChina = DateFormat.getDateTimeInstance(DateFormat.MEDIUM,DateFormat.MEDIUM); //格式化输出
        TimeZone timeZoneChina = TimeZone.getTimeZone("Asia/Shanghai"); //获取时区 这句加上，很关键。
        dateFormatterChina.setTimeZone(timeZoneChina);//设置系统时区
        Date nowTime = new Date(totalMilliSeconds);
        SimpleDateFormat sdFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:dd");
        String retStrFormatNowDate = sdFormatter.format(nowTime);

        System.out.println("登录操作开始时间："+ retStrFormatNowDate);
    }

    private void after(long totalMilliSeconds) {
        long endTimeStamp = System.currentTimeMillis();
        long responseTime = endTimeStamp - totalMilliSeconds;

        System.out.println("登录操作用时："+ responseTime + "毫秒");
    }
}
