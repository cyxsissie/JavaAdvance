# 作业1
使 Java 里的动态代理，实现一个简单的 AOP。
```
public class Main {

    public static void main(String[] args) {

        Scanner in=new Scanner(System.in);
        System.out.print("请输入登录名：");
        String username = in.nextLine();

        System.out.print("请输入密码：");
        String password = in.nextLine();

        MetricsCollectorProxy<IUserController> metricsProxy = new MetricsCollectorProxy<>();
        IUserController user = metricsProxy.createProxy(new UserController());
        user.login(username, password);
    }
}

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

public interface IUserController {
    boolean login(String username, String password);
}

public class UserController implements IUserController {
    @Override
    public boolean login(String username, String password) {
        System.out.println("登录成功！登录人是：" + username + ", 密码为："+ password);
        return true;
    }
}
 ```
# 作业2
写代码实现 Spring Bean 的装配，方式越多越好（XML、Annotation 都可以）, 提交到 GitHub。

第一种：通过 XML 配置装配 Bean使用
```
public static void main(String[] args) {
		// 通过 XML 配置装配 Bean
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		SgtPeppers sgtPeppers1 = context.getBean(SgtPeppers.class);
		sgtPeppers1.play();
}

<bean name="sgtPeppers1" class="sissie.example.work.SgtPeppers">
    <constructor-arg name="id" value="1" />
    <constructor-arg name="name" value="学生1"/>
</bean>
 ```

第二种：使用@Compoent 装配 Bean
```
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/context https://www.springframework.org/schema/context/spring-context.xsd">
    <!-- 通过XML文件的配置启用组件扫描 -->
    <context:component-scan base-package="sissie.example.work" />
</beans>

@Component
public class SgtPeppers implements CompactDisc {

     @Value("1")
     int id;
     @Value("sgtPeppers_name_2")
     String name;

    public void play() {
        System.out.println("Playing "+ id + " by " + name);
    }
}
 ```

第三种：@Autowired 的 Bean 进行自动注入
```
public class CDPlayer implements MediaPlayer {

    @Autowired
    private CompactDisc cd = null;
    
    public void play() {
        cd.play();
    }

}

<bean class="org.springframework.beans.factory.annotation.AutowiredAnnotationBeanPostProcessor"/>
 ```

第四种：使用@Resource通过JNDI lookup来解析对象
```
public class CDPlayer implements MediaPlayer {

    @Resource
    private CompactDisc cd;

    public void play() {
        cd.play();
    }

}
 ```

# 作业8

# 作业10 
研究一下 JDBC 接口和数据库连接池，掌握它们的设计和用法：
```
(1) 使用 JDBC 原生接口，实现数据库的增删改查操作

    /**
     * 获取数据库连接对象
     * @return
     */
    private static Connection getConnection() {
        //URL指向要访问的数据库
        String url = "jdbc:mysql://localhost:3306/java-test";
        //MySQL配置用户名和密码
        String user = "root";
        String password = "root";
        Connection con;
        try {
             con = DriverManager.getConnection(url, user, password);
            if(!con.isClosed()) {
                System.out.println("连接成功");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("获取数据库连接异常，请检查配置数据");
        }
        return con;
    }

    /**
     * 关闭JDBC相关资源
     * @param con
     * @param statement
     */
    private static void closeResource(Connection con, Statement statement) {
        try {
            if(con!=null) {
                con.close();
            }
            if(statement!=null) {
                statement.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        //声明Connection对象
        Connection con;
        String sql;
        try {
            //驱动程序名
            String driver = "com.mysql.jdbc.Driver";
            //加载驱动程序
            Class.forName(driver);
            //getConnection()方法，连接MySQL数据库
            con = getConnection();
            //创建statement类对象，用来执行SQL语句
            Statement statement = con.createStatement();
           
            //查询
            sql = "select * from student";
            query(statement, sql);
            //增加
            sql = "insert into student(id,name) values('4','第四个')";
            System.out.println("插入执行结果:"+handle(statement,sql));
            //更新
            sql = "update student set name='第一个' where id = 1";
            System.out.println("更新执行结果:"+handle(statement,sql));
            //删除
            sql = "delete from student where id = 3";
            System.out.println("删除执行结果:"+handle(statement,sql));

            closeResource(con,statement);
        } catch(ClassNotFoundException e) {
            //数据库驱动类异常处理
            System.out.println("Sorry,can`t find the Driver!");
            e.printStackTrace();
        } catch(SQLException e) {
            //数据库连接失败异常处理
            e.printStackTrace();
        }
        finally{
            System.out.println("数据库数据成功获取！！");
        }
    }

    /**
     * 查询
     * @param statement
     * @param sql
     * @throws SQLException
     */
    private static void query(Statement statement,String sql) throws SQLException {
        ResultSet res = statement.executeQuery(sql);

        System.out.println("--------------------------------------");
        System.out.println("查询执行结果如下所示:");
        System.out.println("------------------------");
        System.out.println("id" + "\t" + "姓名");
        System.out.println("--------------------------------------");
        String name;
        String id;
        while(res.next()){
            id = res.getString("id");
            name = res.getString("name");
            //输出结果
            System.out.println(id + "\t" + name);
        }
    }

    /**
     * 增删改
     * @param statement
     * @param sql
     * @return
     * @throws SQLException
     */
    private static int handle(Statement statement,String sql) throws SQLException {
        return statement.executeUpdate(sql);
    }

(2) 使用事务，PrepareStatement 方式，批处理方式，改进上述操作

    public static void main(String[] args) {
        //声明Connection对象
        Connection con;
        String sql;
        PreparedStatement ps;
        try {
            //驱动程序名
            String driver = "com.mysql.jdbc.Driver";
            //加载驱动程序
            Class.forName(driver);
            //getConnection()方法，连接MySQL数据库
            con = getConnection();
            
            //查询
            sql = "select * from student WHERE id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, 1);
            query(ps);

            //增加
            sql = "insert into student(id,name) values(?,?)";
            ps = con.prepareStatement(sql);
            ps.setInt(1, 4);
            ps.setString(2,"第四个");
            System.out.println("插入执行结果:"+handle(ps));

            //批量更新
            con.setAutoCommit(false); //将自动提交关闭
            sql = "update student set name=? where id = ?";
            ps = con.prepareStatement(sql);

            for(int i=0; i<1000; i++){
                ps.setString(1, "修改了第"+i+"次");
                ps.setInt(2, 1);
                ps.addBatch();
                //每500条执行一次
                if(i>0 && i%500==0){
                    ps.executeBatch();
                }

            }
            ps.executeBatch();        //执行最后剩下的
            con.commit();             //执行完后，手动提交事务
            con.setAutoCommit(true);  //再把自动提交打开，避免影响其他需要自动提交的操作

            //删除
            sql = "delete from student where id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, 3);
            System.out.println("删除执行结果:"+handle(ps));

            closeResource(con,ps);
        } catch(ClassNotFoundException e) {
            //数据库驱动类异常处理
            System.out.println("Sorry,can`t find the Driver!");
            e.printStackTrace();
        } catch(SQLException e) {
            //数据库连接失败异常处理
            e.printStackTrace();
        }
    }

    /**
     * 查询
     * @param statement
     * @throws SQLException
     */
    private static void query(PreparedStatement statement) throws SQLException {
        ResultSet res = statement.executeQuery();

        System.out.println("--------------------------------------");
        System.out.println("查询执行结果如下所示:");
        System.out.println("------------------------");
        System.out.println("id" + "\t" + "姓名");
        System.out.println("--------------------------------------");
        String name;
        String id;
        while(res.next()){
            id = res.getString("id");
            name = res.getString("name");
            //输出结果
            System.out.println(id + "\t" + name);
        }
    }

    /**
     * 增删改
     * @param statement
     * @return
     * @throws SQLException
     */
    private static int handle(PreparedStatement statement) throws SQLException {
        return statement.executeUpdate();
    }

(3) 配置 Hikari 连接池

spring.datasource.driver-class-name=com.mysql.jdbc.Driver
spring.datasource.url=jdbc:mysql://localhost:3306/java-test?useUnicode=true&characterEncoding=UTF-8
spring.datasource.username=root 
spring.datasource.password=root

spring.datasource.hikari.minimum-idle=5
spring.datasource.hikari.maximum-pool-size=15  # 连接池最大连接数
spring.datasource.hikari.auto-commit=true
spring.datasource.hikari.idle-timeout=30000         # 空闲连接存活最大时间
spring.datasource.hikari.pool-name=DatebookHikariCP # 连接池名称
spring.datasource.hikari.max-lifetime=1800000       # 此属性控制池中连接的最长生命周期，值0表示无限生命周期
spring.datasource.hikari.connection-timeout=30000   # 数据库连接超时时间,默认30秒
spring.datasource.hikari.connection-test-query=SELECT 1
 ```



