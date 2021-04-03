
import inbound.HttpInboundServer;
import java.util.Arrays;

public class NettyHttpServer {
    public static void main(String[] args) {
        String proxyPort = System.getProperty("proxyPort","8808");

        String proxyServers = System.getProperty("proxyServers","http://localhost:8801,http://localhost:8802");
        int port = Integer.parseInt(proxyPort);
        HttpInboundServer server = new HttpInboundServer(port, Arrays.asList(proxyServers.split(",")));
        try {
            server.run();
        } catch (Exception ex){
            ex.printStackTrace();
        }
    }
}
