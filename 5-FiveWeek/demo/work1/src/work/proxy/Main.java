package work.proxy;

import java.util.Scanner;

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


