/**
 * 订单表管理服务
 * 
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshoporder;

import java.util.List;
import javax.annotation.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.finedo.common.convert.ConvertUtil;
import cn.finedo.common.domain.PageDomain;
import cn.finedo.common.domain.PageParamDomain;
import cn.finedo.common.domain.ReturnValueDomain;
import cn.finedo.fsdp.service.common.exception.TransactionException;
import cn.finedo.fsdp.service.common.id.IDUtil;
import cn.finedo.fsdp.service.common.jdbc.JdbcTemplate;
import cn.finedo.common.non.NonUtil;
import cn.finedo.easyshop.pojo.Easyshoporder;
import cn.finedo.easyshop.service.easyshoporder.domain.EasyshoporderListDomain;
import cn.finedo.easyshop.service.easyshoporder.domain.EasyshoporderQueryDomain;

@Service
@Transactional
@Scope("singleton")
public class EasyshoporderService {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Resource(name="jdbcTemplate")
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private IDUtil idutil;
	
	
	/**
	 * 订单表查询
	 * @param EasyshoporderQueryDomain
	 * @return ReturnValueDomain<PageDomain<Easyshoporder>>
	 */
	public ReturnValueDomain<PageDomain<Easyshoporder>> query(EasyshoporderQueryDomain easyshoporderquerydomain) {
		ReturnValueDomain<PageDomain<Easyshoporder>> ret = new ReturnValueDomain<PageDomain<Easyshoporder>>();
		
		StringBuilder sql=new StringBuilder("SELECT b.nickname username,a.ordercode, a.userid, a.orderstate, a.shippercode, a.logisticcode, a.isinvalid, a.paytime, a.createtime, a.ordermoney, a.ispay FROM tb_easyshop_order a LEFT JOIN tb_easyshop_user b ON a.userid=b.userid WHERE 1=1");
			
		Easyshoporder easyshoporder=null;
		PageParamDomain pageparam=null;
		if(NonUtil.isNotNon(easyshoporderquerydomain)) {
			pageparam=easyshoporderquerydomain.getPageparam();
			easyshoporder=easyshoporderquerydomain.getEasyshoporder();
			
			if(NonUtil.isNotNon(easyshoporder)) {
				
				if(NonUtil.isNotNon(easyshoporder.getOrdercode())) {
					sql.append(" AND a.ordercode=:ordercode");
				}
				if(NonUtil.isNotNon(easyshoporder.getUserid())) {
					sql.append(" AND a.userid=:userid");
				}
				if(NonUtil.isNotNon(easyshoporder.getOrderstate())) {
					sql.append(" AND a.orderstate=:orderstate");
				}
				if(NonUtil.isNotNon(easyshoporder.getShippercode())) {
					sql.append(" AND a.shippercode=:shippercode");
				}
				if(NonUtil.isNotNon(easyshoporder.getLogisticcode())) {
					sql.append(" AND a.logisticcode=:logisticcode");
				}
				if(NonUtil.isNotNon(easyshoporder.getIsinvalid())) {
					sql.append(" AND a.isinvalid=:isinvalid");
				}
				if(NonUtil.isNotNon(easyshoporder.getPaytimebegin())) {
					sql.append(" AND a.paytime >= " + ConvertUtil.stringToDateByMysql(":paytimebegin"));
				}
				if(NonUtil.isNotNon(easyshoporder.getPaytimeend())) {
					sql.append(" AND a.paytime <= " + ConvertUtil.stringToDateByMysql(":paytimeend"));
				}
				if(NonUtil.isNotNon(easyshoporder.getCreatetimebegin())) {
					sql.append(" AND a.createtime >= " + ConvertUtil.stringToDateByMysql(":createtimebegin"));
				}
				if(NonUtil.isNotNon(easyshoporder.getCreatetimeend())) {
					sql.append(" AND a.createtime <= " + ConvertUtil.stringToDateByMysql(":createtimeend"));
				}
				if(NonUtil.isNotNon(easyshoporder.getOrdermoney())) {
					sql.append(" AND a.ordermoney=:ordermoney");
				}
				if(NonUtil.isNotNon(easyshoporder.getIspay())) {
					sql.append(" AND a.ispay=:ispay");
				}
			}
		}
				
		PageDomain<Easyshoporder> retpage=null;
		try {
			retpage =  jdbcTemplate.queryForPage(sql.toString(), easyshoporder, Easyshoporder.class, pageparam);
		}catch (Exception e) {
			logger.error("订单表查询异常", e);
			return ret.setFail("订单表查询异常");
		}
		
		return ret.setSuccess("查询订单表成功", retpage);
	}
	
	/**
	 * 订单表查询
	 * @param EasyshoporderQueryDomain
	 * @return ReturnValueDomain<PageDomain<Easyshoporder>>
	 */
	public ReturnValueDomain<PageDomain<Easyshoporder>> queryAllList(EasyshoporderQueryDomain easyshoporderquerydomain) {
		ReturnValueDomain<PageDomain<Easyshoporder>> ret = new ReturnValueDomain<PageDomain<Easyshoporder>>();
		
		StringBuilder sql=new StringBuilder("");
		sql.append("SELECT a.addressuser,a.addressphone,a.addressall,c.imgpath,a.ordercode, a.userid, a.orderstate, a.shippercode, a.logisticcode, a.isinvalid, a.paytime, ");
		sql.append(" a.createtime, a.ordermoney, a.ispay,b.goodsnum,b.thenprice,c.goodsname FROM tb_easyshop_order a ");
		sql.append(" LEFT JOIN tb_easyshop_ordergoods b ON a.ordercode=b.ordercode ");
		sql.append(" LEFT JOIN tb_easyshop_goods c ON b.goodsid=c.goodsid");
		Easyshoporder easyshoporder=null;
		PageParamDomain pageparam=null;
		if(NonUtil.isNotNon(easyshoporderquerydomain)) {
			pageparam=easyshoporderquerydomain.getPageparam();
			easyshoporder=easyshoporderquerydomain.getEasyshoporder();
			
			if(NonUtil.isNotNon(easyshoporder)) {
				
				if(NonUtil.isNotNon(easyshoporder.getOrdercode())) {
					sql.append(" AND a.ordercode=:ordercode");
				}
				if(NonUtil.isNotNon(easyshoporder.getUserid())) {
					sql.append(" AND a.userid=:userid");
				}
				if(NonUtil.isNotNon(easyshoporder.getOrderstate())) {
					sql.append(" AND a.orderstate=:orderstate");
				}
				if(NonUtil.isNotNon(easyshoporder.getIsinvalid())) {
					sql.append(" AND a.isinvalid=:isinvalid");
				}
				if(NonUtil.isNotNon(easyshoporder.getIspay())) {
					sql.append(" AND a.ispay=:ispay");
				}
			}
		}
		sql.append(" ORDER BY a.createtime DESC");
		PageDomain<Easyshoporder> retpage=null;
		try {
			retpage =  jdbcTemplate.queryForPage(sql.toString(), easyshoporder, Easyshoporder.class, pageparam);
		}catch (Exception e) {
			logger.error("订单表查询异常", e);
			return ret.setFail("订单表查询异常");
		}
		
		return ret.setSuccess("查询订单表成功", retpage);
	}
	
	
	/**
	 * 小程序订单查询
	 * @param EasyshoporderQueryDomain
	 * @return ReturnValueDomain<PageDomain<Easyshoporder>>
	 */
	public ReturnValueDomain<PageDomain<Easyshoporder>> queryList(EasyshoporderQueryDomain easyshoporderquerydomain) {
		ReturnValueDomain<PageDomain<Easyshoporder>> ret = new ReturnValueDomain<PageDomain<Easyshoporder>>();
		
		StringBuilder sql=new StringBuilder("SELECT  a.addressuser,a.addressphone,a.addressall,a.logisticcode,c.goodsid,c.imgthumpath,c.imgpath,a.ispay,a.isinvalid,a.orderstate, a.paytime,a.createtime,a.ordercode,c.goodsname,b.goodsnum,b.thenprice,a.ordermoney FROM tb_easyshop_order a LEFT JOIN ");
		sql.append(" tb_easyshop_ordergoods b ON a.ordercode=b.ordercode LEFT JOIN tb_easyshop_goods c ON b.goodsid=c.goodsid WHERE 1=1 ");
		Easyshoporder easyshoporder=null;
		PageParamDomain pageparam=null;
		if(NonUtil.isNotNon(easyshoporderquerydomain)) {
			pageparam=easyshoporderquerydomain.getPageparam();
			easyshoporder=easyshoporderquerydomain.getEasyshoporder();
			
			if(NonUtil.isNotNon(easyshoporder)) {
				
				if(NonUtil.isNotNon(easyshoporder.getUserid())) {
					sql.append(" AND a.userid=:userid");
				}
				if(NonUtil.isNotNon(easyshoporder.getOrderstate())) {
					sql.append(" AND a.orderstate=:orderstate");
				}
				if(NonUtil.isNotNon(easyshoporder.getIsinvalid())) {
					sql.append(" AND a.isinvalid=:isinvalid");
				}
				if(NonUtil.isNotNon(easyshoporder.getIspay())) {
					sql.append(" AND a.ispay=:ispay");
				}
				if(NonUtil.isNotNon(easyshoporder.getOrdercode())){
					sql.append(" AND a.ordercode=:ordercode");
				}
			}
		}
		sql.append(" ORDER BY a.createtime DESC");
		PageDomain<Easyshoporder> retpage=null;
		try {
			retpage =  jdbcTemplate.queryForPage(sql.toString(), easyshoporder, Easyshoporder.class, pageparam);
		}catch (Exception e) {
			logger.error("订单表查询异常", e);
			return ret.setFail("订单表查询异常");
		}
		
		return ret.setSuccess("查询订单表成功", retpage);
	}
	/**
	 * 小程序推广订单查询
	 * @param EasyshoporderQueryDomain
	 * @return ReturnValueDomain<PageDomain<Easyshoporder>>
	 */
	public ReturnValueDomain<PageDomain<Easyshoporder>> queryLowerList(EasyshoporderQueryDomain easyshoporderquerydomain) {
		ReturnValueDomain<PageDomain<Easyshoporder>> ret = new ReturnValueDomain<PageDomain<Easyshoporder>>();
		
		StringBuilder sql=new StringBuilder("SELECT a.logisticcode,d.nickname username,c.goodsid,c.imgthumpath,c.imgpath,a.ispay,a.isinvalid,a.orderstate, a.paytime,a.createtime,a.ordercode,c.goodsname,b.goodsnum,b.thenprice,a.ordermoney FROM tb_easyshop_order a LEFT JOIN ");
		sql.append(" tb_easyshop_ordergoods b ON a.ordercode=b.ordercode LEFT JOIN tb_easyshop_goods c ON b.goodsid=c.goodsid LEFT JOIN tb_easyshop_user d ON a.userid=d.userid WHERE  a.ispay='Y' AND a.orderstate='payed'  ");
		Easyshoporder easyshoporder=null;
		PageParamDomain pageparam=null;
		if(NonUtil.isNotNon(easyshoporderquerydomain)) {
			pageparam=easyshoporderquerydomain.getPageparam();
			easyshoporder=easyshoporderquerydomain.getEasyshoporder();
			
			if(NonUtil.isNotNon(easyshoporder)) {
				if(NonUtil.isNotNon(easyshoporder.getUserid())) {
					sql.append(" AND d.promocode=:userid");
				}
			}
		}
		sql.append(" ORDER BY a.createtime DESC");
		PageDomain<Easyshoporder> retpage=null;
		try {
			retpage =  jdbcTemplate.queryForPage(sql.toString(), easyshoporder, Easyshoporder.class, pageparam);
		}catch (Exception e) {
			logger.error("订单表查询异常", e);
			return ret.setFail("订单表查询异常");
		}
		
		return ret.setSuccess("查询订单表成功", retpage);
	}
	
	
	/**
	 * 订单表主键查询
	 * @param Easyshoporder
	 * @return ReturnValueDomain<Easyshoporder>
	 */
	public ReturnValueDomain<Easyshoporder> queryById(Easyshoporder easyshoporder) {
		ReturnValueDomain<Easyshoporder> ret = new ReturnValueDomain<Easyshoporder>();
		
		String sql="SELECT b.nickname username,a.ordercode, a.userid, a.orderstate, a.shippercode, a.logisticcode, a.isinvalid, a.paytime, a.createtime, a.ordermoney, a.ispay FROM tb_easyshop_order a LEFT JOIN tb_easyshop_user b ON a.userid=b.userid WHERE a.ordercode=:ordercode";
		try {
			List<Easyshoporder> list = jdbcTemplate.query(sql, easyshoporder, Easyshoporder.class);
			if(NonUtil.isNon(list)){
				return ret.setFail("查询订单表为空");
			}
			ret.setObject(list.get(0));
		}catch (Exception e) {
			logger.error("订单表查询异常", e);
			return ret.setFail("订单表查询异常");
		}
		return ret.setSuccess("查询订单表成功");
	}
	
	/**
	 * 订单表新增
	 * @param EasyshoporderListDomain
	 * @return ReturnValueDomain<Easyshoporder>
	 */
	public ReturnValueDomain<String> add(EasyshoporderListDomain easyshoporderlistdomain) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		
		if (NonUtil.isNon(easyshoporderlistdomain)) {
			return ret.setFail("无订单表");
		}
		
		List<Easyshoporder> easyshoporderlist=easyshoporderlistdomain.getEasyshoporderlist();
		
		if (NonUtil.isNon(easyshoporderlist)) {
			return ret.setFail("无订单表");
		}
		
		try{
			for(Easyshoporder easyshoporder : easyshoporderlist) {
				
				String ordercode=idutil.getID("easyshoporder");
				easyshoporder.setOrdercode(ordercode);
			}
		}catch(Exception e) {
		    logger.error("订单表处理异常", e);
			return ret.setFail("订单表处理异常");
		}
		
  		String sql="INSERT INTO tb_easyshop_order (addressall,addressuser,addressphone,ordercode, userid, orderstate, shippercode, logisticcode, isinvalid, paytime, createtime, ordermoney, ispay) VALUES (:addressall,:addressuser,:addressphone,:ordercode, :userid, :orderstate, :shippercode, :logisticcode, :isinvalid, DATE_FORMAT(:paytime, '%Y-%m-%d'), DATE_FORMAT(:createtime, '%Y-%m-%d'), :ordermoney, :ispay)";
		
		try {
			jdbcTemplate.batchUpdate(sql, easyshoporderlist);
		} catch (Exception e) {
			logger.error("订单表入库异常", e);
			throw new TransactionException(e);
		}
		
		return ret.setSuccess("订单表新增成功");
	}
	
	/**
	 * 订单表修改
	 * @param EasyshoporderListDomain
	 * @return ReturnValueDomain<String>
	 */
	public ReturnValueDomain<String> update(EasyshoporderListDomain easyshoporderlistdomain) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		
		if (NonUtil.isNon(easyshoporderlistdomain)) {
			return ret.setFail("无订单表");
		}
		
		List<Easyshoporder> easyshoporderlist=easyshoporderlistdomain.getEasyshoporderlist();
		
		if (NonUtil.isNon(easyshoporderlist)) {
			return ret.setFail("无订单表");
		}
		
				
		String sql="UPDATE tb_easyshop_order SET addressall=:addressall,addressuser=:addressuser,addressphone=:addressphone, orderstate=:orderstate, shippercode=:shippercode, logisticcode=:logisticcode, isinvalid=:isinvalid, ordermoney=:ordermoney, ispay=:ispay WHERE ordercode=:ordercode";
		
		try {
			jdbcTemplate.batchUpdate(sql, easyshoporderlist);
		} catch (Exception e) {
			logger.error("订单表修改异常", e);
			throw new TransactionException(e);
		}
		
		return ret.setSuccess("订单表修改成功");
	}
	
	/**
	 * 订单表删除
	 * @param EasyshoporderListDomain
	 * @return ReturnValueDomain<SysUser>
	 */
	public ReturnValueDomain<String> delete(EasyshoporderListDomain easyshoporderlistdomain) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		
		if (NonUtil.isNon(easyshoporderlistdomain)) {
			return ret.setFail("无订单表");
		}
		
		List<Easyshoporder> easyshoporderlist = easyshoporderlistdomain.getEasyshoporderlist();
		
		if (NonUtil.isNon(easyshoporderlist)) {
			return ret.setFail("无订单表");
		}
		
		String sql="DELETE FROM tb_easyshop_order WHERE ordercode=:ordercode";
		
		try {
			jdbcTemplate.batchUpdate(sql, easyshoporderlist);
		} catch (Exception e) {
			logger.error("订单表删除异常", e);
			throw new TransactionException(e);
		}
				
		return ret.setSuccess("订单表删除成功");
	}


	/**
	 * @param order
	 * @return
	 */
	public ReturnValueDomain<String> updatestate(Easyshoporder order) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		if (NonUtil.isNon(order)) {
			return ret.setFail("无订单表");
		}
		
				
		String sql="UPDATE tb_easyshop_order SET  orderstate=:orderstate, paytime=NOW(),wxpayid=:wxpayid WHERE ordercode=:ordercode";
		
		try {
			jdbcTemplate.update(sql, order);
		} catch (Exception e) {
			logger.error("订单表修改异常", e);
			throw new TransactionException(e);
		}
		
		return ret.setSuccess("订单表修改成功");
	}
}
