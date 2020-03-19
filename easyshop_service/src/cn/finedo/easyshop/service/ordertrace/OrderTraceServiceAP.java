/**
 * 订单物品关联表管理服务接口
 *
 * @version 1.0
 * @since 2019-12-23
 */
package cn.finedo.easyshop.service.ordertrace;

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
import cn.finedo.common.protocol.JsonUtil;
import cn.finedo.easyshop.pojo.AcceptResult;

@Controller
@Scope("singleton")
@RequestMapping("service/finedo/orderTrace")
public class OrderTraceServiceAP {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private OrderTraceService orderTraceService;
	

	/**
	 * 订单物品关联表按主键查询查询
	 * @param Easyshopordergoods
	 * @return ReturnValueDomain<Easyshopordergoods>对象
	 */
	@Proxy(method="getTrace", inarg="AcceptResult", outarg="ReturnValueDomain<AcceptResult>")
	@ResponseBody
	@RequestMapping("/getTrace")
	public ReturnValueDomain<AcceptResult> getTrace(HttpServletRequest request) {
		AcceptResult acceptResult=null;
		try {
			acceptResult = JsonUtil.request2Domain(request, AcceptResult.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
		}
		return orderTraceService.getTrace(acceptResult);
	}
	/**
	 * 查询物流信息
	 * @param Easyshopordergoods
	 * @return ReturnValueDomain<Easyshopordergoods>对象
	 */
	@Proxy(method="getShipper", inarg="AcceptResult", outarg="ReturnValueDomain<AcceptResult>")
	@ResponseBody
	@RequestMapping("/getShipper")
	public ReturnValueDomain<AcceptResult> getShipper(HttpServletRequest request) {
	    AcceptResult acceptResult=null;
	    try {
	        acceptResult = JsonUtil.request2Domain(request, AcceptResult.class);
	    }catch(Exception e) {
	        logger.error("请求参数解析异常", e);
	    }
	    return orderTraceService.getShipper(acceptResult);
	}
}
