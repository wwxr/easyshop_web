/**
 * 
 */
package cn.finedo.easyshop.util;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

/**
 * @author 2018026
 * @datetime 11:43:00 AM
 */
public class OrderTracesByJsonUtil {
	
	/**
     * Json方式 查询订单物流轨迹
	 * @throws Exception 
     */
	public static String getOrderTracesByJson(String expCode, String expNo,String orderCode) throws Exception{
		String requestData= "{'OrderCode':'"+orderCode+"','ShipperCode':'" + expCode + "','LogisticCode':'" + expNo + "'}";
		ParamUtil paramUtil=new ParamUtil();
		Properties pro = paramUtil.getParam();
		
		Map<String, String> params = new HashMap<String, String>();
		params.put("RequestData", Base64Util.urlEncoder(requestData, "UTF-8"));
		params.put("EBusinessID",pro.getProperty("EBusinessID"));
		params.put("RequestType", "1002");
		String dataSign=EncryptUtil.encrypt(requestData, pro.getProperty("AppKey"), "UTF-8");
		params.put("DataSign", Base64Util.urlEncoder(dataSign, "UTF-8"));
		params.put("DataType", "2");
		
		String result=SendUtil.sendPost( pro.getProperty("ReqURL"), params);	
		
		//根据公司业务处理返回的信息......
		
		return result;
	}
	
	/**
     * Json方式 单号识别
     * @throws Exception 
     */
    public static String getOrderTracesByJson(String expNo) throws Exception{
    	ParamUtil paramUtil=new ParamUtil();
		Properties pro = paramUtil.getParam();
    	
        String requestData= "{'LogisticCode':'" + expNo + "'}";
        
        Map<String, String> params = new HashMap<String, String>();
        params.put("RequestData", Base64Util.urlEncoder(requestData, "UTF-8"));
        params.put("EBusinessID", pro.getProperty("EBusinessID"));
        params.put("RequestType", "2002");
        String dataSign=EncryptUtil.encrypt(requestData, pro.getProperty("AppKey"), "UTF-8");
        params.put("DataSign", Base64Util.urlEncoder(dataSign, "UTF-8"));
        params.put("DataType", "2");
        
        String result=SendUtil.sendPost(pro.getProperty("ReqURL"), params); 
        
        //根据公司业务处理返回的信息......
        
        return result;
    }
 
}
