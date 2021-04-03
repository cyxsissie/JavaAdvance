package filter;

import io.netty.handler.codec.http.FullHttpResponse;
import inbound.HttpInboundHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class HeaderHttpResponseFilter implements HttpResponseFilter {
    private static Logger logger = LoggerFactory.getLogger(HttpInboundHandler.class);
    @Override
    public void filter(FullHttpResponse response) {
        logger.info("进入响应过滤器~~~~~~");
        response.headers().set("Cookie", "112233");

    }
}
