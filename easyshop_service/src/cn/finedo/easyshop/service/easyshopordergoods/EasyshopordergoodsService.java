/**
 * 订单物品关联表管理服务
 * 
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshopordergoods;

import java.util.List;
import javax.annotation.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.finedo.common.domain.PageDomain;
import cn.finedo.common.domain.PageParamDomain;
import cn.finedo.common.domain.ReturnValueDomain;
import cn.finedo.fsdp.service.common.exception.TransactionException;
import cn.finedo.fsdp.service.common.id.IDUtil;
import cn.finedo.fsdp.service.common.jdbc.JdbcTemplate;
import cn.finedo.common.non.NonUtil;
import cn.finedo.easyshop.pojo.Easyshopordergoods;
import cn.finedo.easyshop.service.easyshopordergoods.domain.EasyshopordergoodsListDomain;
import cn.finedo.easyshop.service.easyshopordergoods.domain.EasyshopordergoodsQueryDomain;

@Service
@Transactional
@Scope("singleton")
public class EasyshopordergoodsService {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Resource(name="jdbcTemplate")
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private IDUtil idutil;
	
	
	/**
	 * 订单物品关联表查询
	 * @param EasyshopordergoodsQueryDomain
	 * @return ReturnValueDomain<PageDomain<Easyshopordergoods>>
	 */
	public ReturnValueDomain<PageDomain<Easyshopordergoods>> query(EasyshopordergoodsQueryDomain easyshopordergoodsquerydomain) {
		ReturnValueDomain<PageDomain<Easyshopordergoods>> ret = new ReturnValueDomain<PageDomain<Easyshopordergoods>>();
		
		StringBuilder sql=new StringBuilder("SELECT ordergoodsid, ordercode, goodsid FROM tb_easyshop_ordergoods WHERE 1=1");
			
		Easyshopordergoods easyshopordergoods=null;
		PageParamDomain pageparam=null;
		if(NonUtil.isNotNon(easyshopordergoodsquerydomain)) {
			pageparam=easyshopordergoodsquerydomain.getPageparam();
			easyshopordergoods=easyshopordergoodsquerydomain.getEasyshopordergoods();
			
			if(NonUtil.isNotNon(easyshopordergoods)) {
				
				if(NonUtil.isNotNon(easyshopordergoods.getOrdergoodsid())) {
					sql.append(" AND ordergoodsid=:ordergoodsid");
				}
				if(NonUtil.isNotNon(easyshopordergoods.getOrdercode())) {
					sql.append(" AND ordercode=:ordercode");
				}
				if(NonUtil.isNotNon(easyshopordergoods.getGoodsid())) {
					sql.append(" AND goodsid=:goodsid");
				}
			}
		}
				
		PageDomain<Easyshopordergoods> retpage=null;
		try {
			retpage =  jdbcTemplate.queryForPage(sql.toString(), easyshopordergoods, Easyshopordergoods.class, pageparam);
		}catch (Exception e) {
			logger.error("订单物品关联表查询异常", e);
			return ret.setFail("订单物品关联表查询异常");
		}
		
		return ret.setSuccess("查询订单物品关联表成功", retpage);
	}
	
	
	/**
	 * 订单物品关联表主键查询
	 * @param Easyshopordergoods
	 * @return ReturnValueDomain<Easyshopordergoods>
	 */
	public ReturnValueDomain<Easyshopordergoods> queryById(Easyshopordergoods easyshopordergoods) {
		ReturnValueDomain<Easyshopordergoods> ret = new ReturnValueDomain<Easyshopordergoods>();
		
		String sql="SELECT ordergoodsid, ordercode, goodsid FROM tb_easyshop_ordergoods WHERE ordergoodsid=:ordergoodsid";
		try {
			List<Easyshopordergoods> list = jdbcTemplate.query(sql, easyshopordergoods, Easyshopordergoods.class);
			if(NonUtil.isNon(list)){
				return ret.setFail("查询订单物品关联表为空");
			}
			ret.setObject(list.get(0));
		}catch (Exception e) {
			logger.error("订单物品关联表查询异常", e);
			return ret.setFail("订单物品关联表查询异常");
		}
		return ret.setSuccess("查询订单物品关联表成功");
	}
	
	/**
	 * 订单物品关联表新增
	 * @param EasyshopordergoodsListDomain
	 * @return ReturnValueDomain<Easyshopordergoods>
	 */
	public ReturnValueDomain<String> add(EasyshopordergoodsListDomain easyshopordergoodslistdomain) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		
		if (NonUtil.isNon(easyshopordergoodslistdomain)) {
			return ret.setFail("无订单物品关联表");
		}
		
		List<Easyshopordergoods> easyshopordergoodslist=easyshopordergoodslistdomain.getEasyshopordergoodslist();
		
		if (NonUtil.isNon(easyshopordergoodslist)) {
			return ret.setFail("无订单物品关联表");
		}
		
		try{
			for(Easyshopordergoods easyshopordergoods : easyshopordergoodslist) {
				
				String ordergoodsid=idutil.getID("easyshopordergoods");
				easyshopordergoods.setOrdergoodsid(ordergoodsid);
			}
		}catch(Exception e) {
		    logger.error("订单物品关联表处理异常", e);
			return ret.setFail("订单物品关联表处理异常");
		}
		
  		String sql="INSERT INTO tb_easyshop_ordergoods (ordergoodsid, ordercode, goodsid) VALUES (:ordergoodsid, :ordercode, :goodsid)";
		
		try {
			jdbcTemplate.batchUpdate(sql, easyshopordergoodslist);
		} catch (Exception e) {
			logger.error("订单物品关联表入库异常", e);
			throw new TransactionException(e);
		}
		
		return ret.setSuccess("订单物品关联表新增成功");
	}
	
	/**
	 * 订单物品关联表修改
	 * @param EasyshopordergoodsListDomain
	 * @return ReturnValueDomain<String>
	 */
	public ReturnValueDomain<String> update(EasyshopordergoodsListDomain easyshopordergoodslistdomain) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		
		if (NonUtil.isNon(easyshopordergoodslistdomain)) {
			return ret.setFail("无订单物品关联表");
		}
		
		List<Easyshopordergoods> easyshopordergoodslist=easyshopordergoodslistdomain.getEasyshopordergoodslist();
		
		if (NonUtil.isNon(easyshopordergoodslist)) {
			return ret.setFail("无订单物品关联表");
		}
		
				
		String sql="UPDATE tb_easyshop_ordergoods SET ordergoodsid=:ordergoodsid, ordercode=:ordercode, goodsid=:goodsid WHERE ordergoodsid=:ordergoodsid";
		
		try {
			jdbcTemplate.batchUpdate(sql, easyshopordergoodslist);
		} catch (Exception e) {
			logger.error("订单物品关联表修改异常", e);
			throw new TransactionException(e);
		}
		
		return ret.setSuccess("订单物品关联表修改成功");
	}
	
	/**
	 * 订单物品关联表删除
	 * @param EasyshopordergoodsListDomain
	 * @return ReturnValueDomain<SysUser>
	 */
	public ReturnValueDomain<String> delete(EasyshopordergoodsListDomain easyshopordergoodslistdomain) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		
		if (NonUtil.isNon(easyshopordergoodslistdomain)) {
			return ret.setFail("无订单物品关联表");
		}
		
		List<Easyshopordergoods> easyshopordergoodslist = easyshopordergoodslistdomain.getEasyshopordergoodslist();
		
		if (NonUtil.isNon(easyshopordergoodslist)) {
			return ret.setFail("无订单物品关联表");
		}
		
		String sql="DELETE FROM tb_easyshop_ordergoods WHERE ordergoodsid=:ordergoodsid";
		
		try {
			jdbcTemplate.batchUpdate(sql, easyshopordergoodslist);
		} catch (Exception e) {
			logger.error("订单物品关联表删除异常", e);
			throw new TransactionException(e);
		}
				
		return ret.setSuccess("订单物品关联表删除成功");
	}
}
