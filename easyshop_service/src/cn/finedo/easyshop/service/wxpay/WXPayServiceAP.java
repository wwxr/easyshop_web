/**
 * 
 */
package cn.finedo.easyshop.service.wxpay;

import java.text.DecimalFormat;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import cn.finedo.common.annotation.Proxy;
import cn.finedo.common.domain.ReturnValueDomain;
import cn.finedo.common.non.NonUtil;
import cn.finedo.common.protocol.JsonUtil;
import cn.finedo.easyshop.pojo.Easyshopgoods;
import cn.finedo.easyshop.pojo.Easyshoporder;
import cn.finedo.easyshop.pojo.Easyshopuser;
import cn.finedo.easyshop.service.easyshopuser.EasyshopuserService;
import cn.finedo.easyshop.util.MathHelper;
import net.sf.json.JSONArray;

/**
 * @author 2018026
 * @datetime 5:01:39 PM
 */
@Controller
@Scope("prototype")
@RequestMapping("service/finedo/wxpay")
public class WXPayServiceAP {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private WXPayService wxPayService;
	@Autowired
	private EasyshopuserService easyshopuserservice;
	
	/**
	 * 请求下单支付
	 * @return object
	 */
	@Proxy(method="askPay", inarg="Easyshoporder", outarg="ReturnValueDomain<Easyshoporder>")
	@ResponseBody
	@RequestMapping("/askPay")
	public Object askPay(HttpServletRequest request)  throws Exception{
		Easyshoporder easyshoporder = null;
		ReturnValueDomain<Easyshoporder> ret = new ReturnValueDomain<Easyshoporder>();
		try {
			easyshoporder = JsonUtil.request2Domain(request, Easyshoporder.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		//获取用户userid
//		Easyshopuser easyshopuser=new Easyshopuser();
//		easyshopuser.setOpenid(easyshoporder.getOpenid());
//		ReturnValueDomain<Easyshopuser> retuser=easyshopuserservice.queryById(easyshopuser);
//		easyshopuser=retuser.getObject();
//		if(NonUtil.isNotNon(easyshopuser)) {
//			easyshoporder.setUserid(easyshopuser.getUserid());
//		}
		JSONArray json = JSONArray.fromObject(easyshoporder.getGoodsinfo());
        List<Easyshopgoods> goodslist = (List<Easyshopgoods>)JSONArray.toCollection(json, Easyshopgoods.class);
        String totalprice="0";
        for(Easyshopgoods goods:goodslist) {
        	//原价
        	String originalprice=goods.getOriginalprice();
        	//现价
        	String presentprice=goods.getPresentprice();
        	String count=goods.getCount();
        	if(NonUtil.isNon(originalprice)) {
        		originalprice="0";
        	}
        	if(NonUtil.isNon(presentprice)) {
        		presentprice="0";
        	}
        	DecimalFormat df = new DecimalFormat("0.00");
        	originalprice=df.format(Double.parseDouble(originalprice));
        	presentprice=df.format(Double.parseDouble(MathHelper.mul(presentprice, count)));
        	totalprice=String.valueOf(MathHelper.add(totalprice, presentprice));
        }
        easyshoporder.setOrdermoney(totalprice);
        easyshoporder.setGoodslist(goodslist);
//      单个转换
//		Easyshopgoods easyshopgoods=JSON.parseObject(goodsinfo,Easyshopgoods.class);
		//添加订单
		ret=wxPayService.askPay(easyshoporder);
		//调用订单统一API
		Wxpay wxpay=new Wxpay();
		String payinfo=wxpay.pay(easyshoporder);
		
		return ret;
		
	}
	/**
	 * 继续请求支付
	 * @return object
	 */
	@Proxy(method="goonAskPay", inarg="Easyshoporder", outarg="ReturnValueDomain<Easyshoporder>")
	@ResponseBody
	@RequestMapping("/goonAskPay")
	public Object goonAskPay(HttpServletRequest request)  throws Exception{
		Easyshoporder easyshoporder = null;
		ReturnValueDomain<Easyshoporder> ret = new ReturnValueDomain<Easyshoporder>();
		try {
			easyshoporder = JsonUtil.request2Domain(request, Easyshoporder.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		//获取用户userid
//		Easyshopuser easyshopuser=new Easyshopuser();
//		easyshopuser.setOpenid(easyshoporder.getOpenid());
//		ReturnValueDomain<Easyshopuser> retuser=easyshopuserservice.queryById(easyshopuser);
//		easyshopuser=retuser.getObject();
//		if(NonUtil.isNotNon(easyshopuser)) {
//			easyshoporder.setUserid(easyshopuser.getUserid());
//		}
		JSONArray json = JSONArray.fromObject(easyshoporder.getGoodsinfo());
		List<Easyshopgoods> goodslist = (List<Easyshopgoods>)JSONArray.toCollection(json, Easyshopgoods.class);
		String totalprice="0";
		for(Easyshopgoods goods:goodslist) {
			//原价
			String originalprice=goods.getOriginalprice();
			//现价
			String presentprice=goods.getPresentprice();
			String count=goods.getCount();
			if(NonUtil.isNon(originalprice)) {
				originalprice="0";
			}
			if(NonUtil.isNon(presentprice)) {
				presentprice="0";
			}
			DecimalFormat df = new DecimalFormat("0.00");
			originalprice=df.format(Double.parseDouble(originalprice));
			presentprice=df.format(Double.parseDouble(MathHelper.mul(presentprice, count)));
			totalprice=String.valueOf(MathHelper.add(totalprice, presentprice));
		}
		easyshoporder.setOrdermoney(totalprice);
		easyshoporder.setGoodslist(goodslist);
//      单个转换
//		Easyshopgoods easyshopgoods=JSON.parseObject(goodsinfo,Easyshopgoods.class);
		//调用订单统一API
		Wxpay wxpay=new Wxpay();
		String payinfo=wxpay.pay(easyshoporder);
		System.out.println(payinfo);
		//修改订单订单
		ret=wxPayService.goonAskPay(easyshoporder);
		return ret;
		
	}
}
