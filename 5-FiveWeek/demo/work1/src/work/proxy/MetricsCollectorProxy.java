package work.proxy;

import java.lang.reflect.Proxy;

public class MetricsCollectorProxy<T> {

    // 创建代理类的方法
    public T createProxy(Object proxiedObject) {

        // 获得这个对象所实现的接口
        ClassLoader loader = proxiedObject.getClass().getClassLoader();
        Class<?>[] interfaces = proxiedObject.getClass().getInterfaces();
        DynamicProxyHandler handler = new DynamicProxyHandler(proxiedObject);
        return (T) Proxy.newProxyInstance(loader, interfaces, handler);
    }

}
