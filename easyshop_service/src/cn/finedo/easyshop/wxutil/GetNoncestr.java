package cn.finedo.easyshop.wxutil;

import java.util.UUID;
/**
 * 生成随机的32位字符串
 * @author 2017136
 *
 */
public class GetNoncestr {
	public static String getUUID(){    
		String uuid = UUID.randomUUID().toString().trim().replaceAll("-", "");    
		return uuid;    
	}   
}
