package filter;

import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.http.FullHttpRequest;
import inbound.HttpInboundHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class HeaderHttpRequestFilter implements HttpRequestFilter {
    private static Logger logger = LoggerFactory.getLogger(HttpInboundHandler.class);

    @Override
    public void filter(FullHttpRequest fullRequest, ChannelHandlerContext ctx) {
        logger.info("进入请求过滤器~~~~~~");
        fullRequest.headers().set("token", "123456");
    }
}
