/**
 * 
 */
package cn.finedo.easyshop.webapp.wxpay;

import javax.servlet.http.HttpServletRequest;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import cn.finedo.common.domain.ReturnValueDomain;
import cn.finedo.common.protocol.FormUtil;
import cn.finedo.easyshop.pojo.Easyshoporder;
import cn.finedo.easyshop.service.wxpay.WXPayServiceAPProxy;

/**
 * @author 2018026
 * @datetime 3:08:37 PM
 */
@Controller
@Scope("singleton")
@RequestMapping("/finedo/wxpay")
public class WXPayAction {
	/**
	 * 请求下单支付
	 * @return object
	 */
	@RequestMapping("/askPay")
	@ResponseBody
	public Object askPay(HttpServletRequest request)  throws Exception{
		Easyshoporder easyshoporder = FormUtil.request2Domain(request, Easyshoporder.class);
		ReturnValueDomain<Easyshoporder> ret = WXPayServiceAPProxy.askPay(easyshoporder);
		return ret;
		
	}
	/**
	 * 继续请求支付
	 * @return object
	 */
	@RequestMapping("/goonAskPay")
	@ResponseBody
	public Object goonAskPay(HttpServletRequest request)  throws Exception{
		Easyshoporder easyshoporder = FormUtil.request2Domain(request, Easyshoporder.class);
		ReturnValueDomain<Easyshoporder> ret = WXPayServiceAPProxy.goonAskPay(easyshoporder);
		return ret;
		
	}
}
