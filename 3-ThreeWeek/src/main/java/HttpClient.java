import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import java.io.IOException;

public class HttpClient {

	public static void main(String[] args) throws Exception {

		// 请求地址
		String url = "http://localhost:8808/admin";

		CloseableHttpClient httpclient = HttpClients.createDefault();

		HttpGet httpGet = new HttpGet(url);
		HttpResponse response = httpclient.execute(httpGet);
		HttpEntity entity = response.getEntity();

		if (entity != null) {
			System.out.println("响应的内容："+EntityUtils.toString(entity));
		}

		try {
			httpclient.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
