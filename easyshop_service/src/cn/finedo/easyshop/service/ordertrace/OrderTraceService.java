/**
 * 订单物品关联表管理服务
 * 
 * @version 1.0
 * @since 2019-12-23
 */
package cn.finedo.easyshop.service.ordertrace;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.alibaba.fastjson.JSON;

import cn.finedo.common.domain.ReturnValueDomain;
import cn.finedo.easyshop.pojo.AcceptResult;
import cn.finedo.easyshop.pojo.Easyshopexpress;
import cn.finedo.easyshop.util.OrderTracesByJsonUtil;
import cn.finedo.fsdp.service.common.jdbc.JdbcTemplate;

@Service
@Transactional
@Scope("singleton")
public class OrderTraceService {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Resource(name="jdbcTemplate")
	private JdbcTemplate jdbcTemplate;
	/**
	 * 查询物流轨迹
	 */
	public ReturnValueDomain<AcceptResult> getTrace(AcceptResult accept) {
		ReturnValueDomain<AcceptResult> ret=new ReturnValueDomain<AcceptResult>();
		String shipperCode=accept.getShipperCode();
		String logisticCode=accept.getLogisticCode();
		AcceptResult acceptResult=null;
		Easyshopexpress easyshopexpress=new Easyshopexpress();
		easyshopexpress.setShippercode(shipperCode);;
		String sql="SELECT imgid,imgpath,imgthumpath,shippercode, shippername FROM tb_easyshop_express WHERE shippercode=:shippercode";
		try {
			List<Easyshopexpress> list = jdbcTemplate.query(sql, easyshopexpress, Easyshopexpress.class);
			String imgpath="";
			if(list.size()>0) {
				imgpath=list.get(0).getImgpath();
			}
			String result = OrderTracesByJsonUtil.getOrderTracesByJson(shipperCode, logisticCode,accept.getOrderCode());
			acceptResult=JSON.parseObject(result,AcceptResult.class);
			acceptResult.setImgpath(imgpath);
		} catch (Exception e) {
			logger.error("获取物流信息异常",e);
			ret.setFail("获取物流信息异常");
		}
		ret.setObject(acceptResult);
		if(acceptResult.isSuccess()) {
			return ret.setSuccess("物流信息查询成功！");
		}else {
			return ret.setFail(acceptResult.getReason());
		}
	}
	
	/**
	 * 查询物流信息详情
	 */
	public ReturnValueDomain<AcceptResult> getShipper(AcceptResult accept) {
	    ReturnValueDomain<AcceptResult> ret=new ReturnValueDomain<AcceptResult>();
	    String logisticCode=accept.getLogisticCode();
	    AcceptResult acceptResult=null;
	    try {
	        String result = OrderTracesByJsonUtil.getOrderTracesByJson(logisticCode);
	        acceptResult=JSON.parseObject(result,AcceptResult.class);
	    } catch (Exception e) {
	        logger.error("获取物流信息异常",e);
	        ret.setFail("获取物流信息异常");
	    }
	    ret.setObject(acceptResult);
	    if(acceptResult.isSuccess()) {
	        return ret.setSuccess("物流信息查询成功！");
	    }else {
	        return ret.setFail(acceptResult.getReason());
	    }
	}
}
