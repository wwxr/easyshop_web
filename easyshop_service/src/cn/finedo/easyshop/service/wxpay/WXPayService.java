/**
 * 
 */
package cn.finedo.easyshop.service.wxpay;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.finedo.common.domain.ReturnValueDomain;
import cn.finedo.common.non.NonUtil;
import cn.finedo.easyshop.pojo.Easyshopgoods;
import cn.finedo.easyshop.pojo.Easyshoporder;
import cn.finedo.easyshop.pojo.Easyshopordergoods;
import cn.finedo.easyshop.service.easyshoporder.domain.EasyshoporderListDomain;
import cn.finedo.fsdp.service.common.exception.TransactionException;
import cn.finedo.fsdp.service.common.id.IDUtil;
import cn.finedo.fsdp.service.common.jdbc.JdbcTemplate;

/**
 * @author 2018026
 * @datetime 5:01:53 PM
 */
@Service
@Transactional
@Scope("singleton")
public class WXPayService {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Resource(name="jdbcTemplate")
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private IDUtil idutil;
	

	/**
	 * 请求下单支付
	 * @return object
	 */
	
	public ReturnValueDomain<Easyshoporder> askPay(Easyshoporder easyshoporder) {
		ReturnValueDomain<Easyshoporder> ret = new ReturnValueDomain<Easyshoporder>();
		List<Easyshopgoods> goodslist=new ArrayList<Easyshopgoods>();
		if (NonUtil.isNon(easyshoporder)) {
			return ret.setFail("无订单表");
		}
		goodslist=easyshoporder.getGoodslist();
		try{
			String ordercode=idutil.getID("easyshoporder");
			easyshoporder.setOrdercode(ordercode);
			for(Easyshopgoods easyshopgoods:goodslist) {
				String ordergoodsid=idutil.getID("easyshopordergoods");
				easyshopgoods.setOrdercode(ordercode);
				easyshopgoods.setOrdergoodsid(ordergoodsid);
			}
		}catch(Exception e) {
		    logger.error("订单表处理异常", e);
			return ret.setFail("订单表处理异常");
		}
		
  		String sql="INSERT INTO tb_easyshop_order (addressuser,addressphone,addressall,ordercode, userid, orderstate, shippercode, logisticcode, isinvalid, createtime, ordermoney, ispay,openid) VALUES (:addressuser,:addressphone,:addressall,:ordercode, :userid,'nopay', :shippercode, :logisticcode,'N',  NOW(), :ordermoney, 'N',:openid)";
		String sql1="INSERT INTO tb_easyshop_ordergoods(ordergoodsid,ordercode,goodsid,goodsnum,thenprice)VALUES(:ordergoodsid,:ordercode,:goodsid,:count,:presentprice)";
		try {
			jdbcTemplate.update(sql, easyshoporder);
			jdbcTemplate.batchUpdate(sql1, goodslist);
		} catch (Exception e) {
			logger.error("订单表入库异常", e);
			throw new TransactionException(e);
		}
		
		return ret.setSuccess("订单表新增成功",easyshoporder);
	}
	
	/**
	 * 订单表修改
	 * @param EasyshoporderListDomain
	 * @return ReturnValueDomain<String>
	 */
	public ReturnValueDomain<Easyshoporder> goonAskPay(Easyshoporder easyshoporder) {
		ReturnValueDomain<Easyshoporder> ret = new ReturnValueDomain<Easyshoporder>();
		
		if (NonUtil.isNon(easyshoporder)) {
			return ret.setFail("无订单表");
		}
				
		String sql="UPDATE tb_easyshop_order SET addressall=:addressall,addressuser=:addressuser,addressphone=:addressphone, paytime=:paytime,wxpayid=:wxpayid, orderstate=:orderstate,ispay=:ispay WHERE ordercode=:ordercode";
		
		try {
			jdbcTemplate.update(sql, easyshoporder);
		} catch (Exception e) {
			logger.error("订单表修改异常", e);
			throw new TransactionException(e);
		}
		
		return ret.setSuccess("订单表修改成功",easyshoporder);
	}

}
