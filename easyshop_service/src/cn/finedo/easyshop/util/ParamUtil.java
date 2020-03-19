package cn.finedo.easyshop.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
@Component
public class ParamUtil {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	/**
	 * 从配置文件中获取相关参数
	 * @author 2018130
	 * @date 2019年4月26日 下午9:20:17
	 * @return
	 * @throws Exception
	 */
	public Properties getParam() throws Exception{
		
		InputStream inputstream = this.getClass().getClassLoader().getResourceAsStream("/corpkey.key");
		Properties pro = new Properties();
		
		try {
			pro.load(inputstream);
		} catch (IOException ioE) {
			logger.error("读取文件异常",ioE);
		} finally {
			inputstream.close();
		}

		return pro;
	}
}
