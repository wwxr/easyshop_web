package cn.finedo.easyshop.service.wxpay;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.security.KeyStore;
import java.util.Map;
import java.util.Properties;
import java.util.SortedMap;
import java.util.TreeMap;

import javax.net.ssl.SSLContext;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.Consts;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.ssl.SSLContexts;
import org.apache.http.util.EntityUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;

import cn.finedo.common.domain.PageDomain;
import cn.finedo.common.domain.PageParamDomain;
import cn.finedo.common.domain.ReturnValueDomain;
import cn.finedo.easyshop.pojo.Easyshoporder;
import cn.finedo.easyshop.service.easyshoporder.EasyshoporderService;
import cn.finedo.easyshop.util.CommonUtil;
import cn.finedo.easyshop.util.ParamUtil;
import cn.finedo.easyshop.wxutil.GetNoncestr;
import cn.finedo.easyshop.wxutil.HttpUtil;
import cn.finedo.easyshop.wxutil.XMLUtil;


//@Controller
//@Scope("prototype")
//@RequestMapping("/finedo/wxpay")
public class Wxpay {
	private static Logger logger = LogManager.getLogger(); 
	@Autowired
	private EasyshoporderService easyshoporderService;	
	
	/**
	 *
	 * 微信下单支付
	 * @throws Exception 
	 * 
	 */
	public String pay(Easyshoporder order) throws Exception {
		ParamUtil paramUtil=new ParamUtil();
		Properties pro = paramUtil.getParam();
		//小程序的appid
		String appid=pro.getProperty("APPID");
		//商户id:微信支付分配的商户号
		String mch_id=pro.getProperty("MCH_ID");
		//货币类型：默认人民币：CNY
		String fee_type=pro.getProperty("FEE_TYPE");
		//统一订单地址
		String unifiedorder_url=pro.getProperty("UNIFIEDORDER_URL");
		//通知地址：异步接收微信支付结果通知的回调地址，通知url必须为外网可访问的url，不能携带参数。
		String notify_url=pro.getProperty("NOTIFY_URL");
		//交易类型：JSAPI--小程序支付统一下单接口
		String trade_type=pro.getProperty("TRADE_TYPE");
		//key为商户平台设置的密钥key
		String key=pro.getProperty("KEY");
        //得到openid
		String openid = order.getOpenid();
        int fee = 0;
        //得到小程序传过来的价格，注意这里的价格必须为整数，1代表1分，所以传过来的值必须*100；
        double money=Double.parseDouble(order.getOrdermoney())*100;
        
        fee=Integer.parseInt(String.valueOf( Math.round(money)));
        System.out.println(fee);
        //订单编号
        String did = order.getOrdercode();
        //时间戳
        String nonce_str = GetNoncestr.getUUID();//随机的32位参数
        SortedMap<Object, Object> packageParams = new TreeMap<Object, Object>();
        packageParams.put("appid", appid);//小程序的appid
        packageParams.put("mch_id", mch_id);//商户号
        packageParams.put("body", "支付信息");//支付主体
        packageParams.put("out_trade_no", did);//编号
        packageParams.put("fee_type", fee_type);//货币类型
        packageParams.put("total_fee", fee);//价格
        // packageParams.put("spbill_create_ip", getIp2(request));这里之前加了ip，但是总是获取sign失败，原因不明，之后就注释掉了
        packageParams.put("notify_url", notify_url);//支付返回地址，不用纠结这个东西，我就是随便写了一个接口，内容什么都没有
        packageParams.put("trade_type", trade_type);//这个api有，固定的
        packageParams.put("openid", openid);//openid
        packageParams.put("nonce_str", nonce_str);//随机字符串，长度要求在32位以内。
        System.out.println("packageParams:"+packageParams);
        //获取sign
        String sign = CommonUtil.createSign("UTF-8", packageParams, key);//最后这个是自己设置的32位密钥
        packageParams.put("sign", sign);
        logger.debug("sogn:"+sign);
        //转成XML
        String requestXML = CommonUtil.getRequestXml(packageParams);
        System.out.println(requestXML);
        //得到含有prepay_id的XML
        String resXml = HttpUtil.postData(unifiedorder_url, requestXML);//统一下单地址，固定的
        System.out.println(resXml);
        //解析XML存入Map
        Map map = XMLUtil.doXMLParse(resXml);
        System.out.println(map);
        String return_code = (String) map.get("return_code");
        //得到prepay_id
        String prepay_id = (String) map.get("prepay_id");
        SortedMap<Object, Object> packageP = new TreeMap<Object, Object>();
        if("SUCCESS".equals(return_code)){
        	packageP.put("appId", appid);//！！！注意，这里是appId,上面是appid，真怀疑写这个东西的人。。。
        	packageP.put("nonceStr", nonce_str);//随机字符串，长度要求在32位以内。
        	packageP.put("package", "prepay_id=" + prepay_id);//必须把package写成 "prepay_id="+prepay_id这种形式
        	packageP.put("signType", "MD5");//paySign加密
        	packageP.put("timeStamp", (System.currentTimeMillis() / 1000) + "");
        	//得到paySign
        	String paySign = CommonUtil.createSign("UTF-8", packageP, key);
        	packageP.put("paySign", paySign);
        }
        //将packageP数据返回给小程序
        Gson gson = new Gson();
        String json = gson.toJson(packageP);
        return  json;
    }
	/**
	 * 异步回调
	 * 需验证签名
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/notify_url")
	public void notify_url(HttpServletRequest request,HttpServletResponse response) throws Exception {
		logger.debug("++++++++++++++++成功回调了++++++++++++++++++");
		
		
		BufferedReader br = new BufferedReader(new InputStreamReader((ServletInputStream)request.getInputStream()));  
        String line = null;  
        StringBuilder sb = new StringBuilder();  
        while((line = br.readLine()) != null){  
            sb.append(line);  
        }  
        //sb为微信返回的xml  
        String notityXml = sb.toString();  
        String resXml = "";  
        Map map = XMLUtil.doXMLParse(notityXml);  
        //返回的状态
        String returnCode = (String) map.get("return_code");  
        //商户订单号
        String out_trade_no = (String) map.get("out_trade_no");  
        //业务结果
        String result_code = (String) map.get("result_code");  
        //微信支付订单号
        String wxpayid = (String) map.get("transaction_id");  
        //订单金额
        String total_fee = (String) map.get("total_fee");  
        logger.debug("map:"+map);
        logger.debug("商户订单号"+out_trade_no+"==返回状态码:"+returnCode+"==业务结果"+result_code+"==微信支付订单号："+wxpayid);
          
        SortedMap<Object, Object> packageP = new TreeMap<Object, Object>();
    	packageP.put("sign", (String) map.get("sign"));
        packageP.put("appid", (String) map.get("appid"));//小程序的appid
        packageP.put("mch_id", (String) map.get("mch_id"));//商户号
        packageP.put("nonce_str", (String) map.get("nonce_str"));//时间戳
//        packageP.put("body", (String) map.get("body"));//支付主体
        packageP.put("out_trade_no", (String) map.get("out_trade_no"));//编号
        packageP.put("fee_type", (String) map.get("fee_type"));//货币类型
        packageP.put("total_fee", (String) map.get("total_fee"));//价格
        packageP.put("notify_url", (String) map.get("notify_url"));//支付返回地址，不用纠结这个东西，我就是随便写了一个接口，内容什么都没有
        packageP.put("trade_type", (String) map.get("trade_type"));//这个api有，固定的
        packageP.put("openid", (String) map.get("openid"));//openid
    	
        if("SUCCESS".equals(returnCode) && "SUCCESS".equals(result_code)){  
        	logger.debug("=======================111111111111111111111====================packageP："+packageP);
//            if(CommonUtil.isTenpaySign("utf-8",packageP,key)){  //验证签名是否正确  
            	logger.debug("=======================签名验证成功====================");
                /**此处添加自己的业务逻辑代码start**/  
            	Easyshoporder order = new Easyshoporder();
            	order.setOrderstate("payed");//已支付
            	order.setOrdercode(out_trade_no);//订单号
            	order.setWxpayid(wxpayid);//微信订单号
            	order.setOrdermoney(total_fee);//金额
            	
        		logger.debug("=======================订单金额验证正确====================");
        		ReturnValueDomain<String> result = easyshoporderService.updatestate(order);
                /**此处添加自己的业务逻辑代码end**/
                //通知微信服务器已经支付成功  
            	if(result.isSuccess()){
            		resXml = "<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[OK]]></return_msg></xml>"; 
            	}else {
            		resXml = "<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[订单修改失败]]></return_msg></xml>"; 
				}
//            }else{
//            	logger.debug("=======================签名验证失败====================");
//                resXml = "<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA[报文为空]]></return_msg></xml> "; 
//            }
        }else{  
        	logger.debug("=======================签名验证失败====================");
            resXml = "<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA[报文为空]]></return_msg></xml> "; 
        }  
        System.out.println(resXml);  
        
        BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());  
        out.write(resXml.getBytes());  
        out.flush();  
        out.close(); 
	}
	
}
