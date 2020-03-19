package cn.finedo.easyshop.webapp.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

public class WxChat {

	public static Map<String, String> getOpenid( String code) throws Exception {// 接收用户传过来的code，required=false表明如果这个参数没有传过来也可以。
		ParamUtil paramUtil = new ParamUtil();
		Properties pro = paramUtil.getParam();
		// 接收从客户端获取的code
		// 向微信后台发起请求获取openid的url
		String WX_URL = "https://api.weixin.qq.com/sns/jscode2session?appid=APPID&secret=SECRET&js_code=JSCODE&grant_type=authorization_code";
		// 这三个参数就是之后要填上自己的值。
		// 替换appid，appsecret，和code
		String requestUrl = WX_URL.replace("APPID", pro.getProperty("APPID")).// 填写自己的appid
				replace("SECRET", pro.getProperty("SECRET")).replace("JSCODE", code).// 填写自己的appsecret，
				replace("authorization_code", "authorization_code");

		// 调用get方法发起get请求，并把返回值赋值给returnvalue
		String returnvalue = GET(requestUrl);
//		System.out.println(requestUrl);// 打印发起请求的url
//		System.out.println(returnvalue);// 打印调用GET方法返回值
		// 定义一个json对象。
		JSONObject convertvalue = new JSONObject();

		// 将得到的字符串转换为json
		convertvalue = (JSONObject) JSON.parse(returnvalue);

//		System.out.println("return openid is ：" + (String) convertvalue.get("openid")); // 打印得到的openid
//		System.out.println("return sessionkey is ：" + (String) convertvalue.get("session_key"));// 打印得到的sessionkey，
		// 把openid和sessionkey分别赋值给openid和sessionkey
		String openid = (String) convertvalue.get("openid");
		String sessionkey = (String) convertvalue.get("session_key");// 定义两个变量存储得到的openid和session_key.
		Map<String, String> map = new HashMap<>();
		map.put("openid", openid);
		map.put("sessionkey", sessionkey);
		return map;// 返回openid
	}

	// 发起get请求的方法。
	public static String GET(String url) {
		String result = "";
		BufferedReader in = null;
		InputStream is = null;
		InputStreamReader isr = null;
		try {
			URL realUrl = new URL(url);
			URLConnection conn = realUrl.openConnection();
			conn.connect();
			is = conn.getInputStream();
			isr = new InputStreamReader(is);
			in = new BufferedReader(isr);
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
		} catch (Exception e) {
			// 异常记录
		} finally {
			try {
				if (in != null) {
					in.close();
				}
				if (is != null) {
					is.close();
				}
				if (isr != null) {
					isr.close();
				}
			} catch (Exception e2) {
				// 异常记录
			}
		}
		return result;
	}

	/*
	 * 此方法没有用到。就先放在这吧 public static String jedisOperate(String Session_key, String
	 * openid) { //这里需要引入一下jedis的dependenicy Jedis jedis = new Jedis("localhost");
	 * String openid = openid; String session_key = session_key; String uid =
	 * UUID.randomUUID().toString(); StringBuffer sb = new StringBuffer();
	 * sb.append(openid); sb.append(","+session_key); jedis.set(uid, sb.toString());
	 * return uid;
	 * //如果需要获取登录用户的用户名和昵称，我们就需要注意一个问题，如果昵称中有中文就会出现乱码，这是因为微信对于中文是按照ISO-8859-
	 * 1来进行编码的而我们需要的utf8编码，对于获取用户昵称出现乱码这个问题我们做一下简单的处理就可以解决： //String nickNameDecode
	 * = new String(nickName.getBytes("ISO-8859-1"),"utf-8");
	 * 
	 * }
	 */
}
