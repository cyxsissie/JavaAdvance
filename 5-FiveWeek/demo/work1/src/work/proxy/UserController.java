package work.proxy;

public class UserController implements IUserController {
    @Override
    public boolean login(String username, String password) {
        System.out.println("登录成功！登录人是：" + username + ", 密码为："+ password);
        return true;
    }
}
