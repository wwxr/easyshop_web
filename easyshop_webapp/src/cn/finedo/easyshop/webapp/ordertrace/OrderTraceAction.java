/**
 * 物流轨迹
 */
package cn.finedo.easyshop.webapp.ordertrace;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.finedo.common.domain.ReturnValueDomain;
import cn.finedo.common.non.NonUtil;
import cn.finedo.common.protocol.FormUtil;
import cn.finedo.easyshop.pojo.AcceptResult;
import cn.finedo.easyshop.pojo.Shipper;
import cn.finedo.easyshop.service.ordertrace.OrderTraceServiceAPProxy;


/**
 * @author 2018026
 */
@Controller
@Scope("singleton")
@RequestMapping("/finedo/orderTrace")
public class OrderTraceAction {
	/**
	 * 物流详情查询
	 */
	@RequestMapping("/getTrace")
	@ResponseBody
	public Object getTrace(HttpServletRequest request) throws Exception {
		AcceptResult acceptResult = FormUtil.request2Domain(request, AcceptResult.class);
		ReturnValueDomain<AcceptResult> ret=new ReturnValueDomain<AcceptResult>();
//		查看订单公司信息
		ret = OrderTraceServiceAPProxy.getShipper(acceptResult);
		AcceptResult acceptResult1=ret.getObject();
		List<Shipper> shippers=acceptResult1.getShippers();
		if(NonUtil.isNon(shippers)){
		    return ret.setFail("未查到该物流信息");
		}
		Shipper shipper=shippers.get(0);
		String shipperCode=shipper.getShipperCode();
		acceptResult.setShipperCode(shipperCode);
//		查看物流轨迹
		ret = OrderTraceServiceAPProxy.getTrace(acceptResult);
		ret.getObject().setShippers(shippers);
		return ret;
	}
}
