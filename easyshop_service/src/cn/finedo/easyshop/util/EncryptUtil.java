/**
 * 
 */
package cn.finedo.easyshop.util;

import java.io.UnsupportedEncodingException;

/**
 * @author 2018026
 * @datetime 11:38:37 AM
 */
public class EncryptUtil {
	/**
     * 电商Sign签名生成
     * @param content 内容   
     * @param keyValue Appkey  
     * @param charset 编码方式
	 * @throws UnsupportedEncodingException ,Exception
	 * @return DataSign签名
     */
	public static String encrypt (String content, String keyValue, String charset) throws UnsupportedEncodingException, Exception
	{
		if (keyValue != null)
		{
			return Base64Util.base64(MD5Util.MD5(content + keyValue, charset), charset);
		}
		return Base64Util.base64(MD5Util.MD5(content, charset), charset);
	}
}
