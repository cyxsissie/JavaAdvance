package my.work.onework;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.io.IOException;

@SpringBootApplication
public class HttpClient {

	public static void main(String[] args) throws Exception {

		// 请求地址
		String url = "http://localhost:8801";
		// 创建默认的客户端实例
		CloseableHttpClient httpclient = HttpClients.createDefault();
		// 创建get请求实例
		HttpGet httpGet = new HttpGet(url);
		// 执行GET请求 返回响应实体
		HttpResponse response = httpclient.execute(httpGet);
		// 获取响应码
		int statusCode = response.getStatusLine().getStatusCode();
		// 获取响应消息实体
		HttpEntity entity = response.getEntity();

		System.out.println("响应状态码为:" + statusCode);
		if (entity != null) {
			System.out.println("响应的内容："+EntityUtils.toString(entity));
		}
		// 关闭连接
		try {
			httpclient.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
