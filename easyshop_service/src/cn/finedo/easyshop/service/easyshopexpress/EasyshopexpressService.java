/**
 * 物流表管理服务
 * 
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshopexpress;

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
import cn.finedo.easyshop.pojo.Easyshopexpress;
import cn.finedo.easyshop.service.easyshopexpress.domain.EasyshopexpressListDomain;
import cn.finedo.easyshop.service.easyshopexpress.domain.EasyshopexpressQueryDomain;

@Service
@Transactional
@Scope("singleton")
public class EasyshopexpressService {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Resource(name="jdbcTemplate")
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private IDUtil idutil;
	
	
	/**
	 * 物流表查询
	 * @param EasyshopexpressQueryDomain
	 * @return ReturnValueDomain<PageDomain<Easyshopexpress>>
	 */
	public ReturnValueDomain<PageDomain<Easyshopexpress>> query(EasyshopexpressQueryDomain easyshopexpressquerydomain) {
		ReturnValueDomain<PageDomain<Easyshopexpress>> ret = new ReturnValueDomain<PageDomain<Easyshopexpress>>();
		
		StringBuilder sql=new StringBuilder("SELECT imgid,imgpath,imgthumpath,shippercode, shippername FROM tb_easyshop_express WHERE 1=1");
			
		Easyshopexpress easyshopexpress=null;
		PageParamDomain pageparam=null;
		if(NonUtil.isNotNon(easyshopexpressquerydomain)) {
			pageparam=easyshopexpressquerydomain.getPageparam();
			easyshopexpress=easyshopexpressquerydomain.getEasyshopexpress();
			
			if(NonUtil.isNotNon(easyshopexpress)) {
				
				if(NonUtil.isNotNon(easyshopexpress.getShippercode())) {
					sql.append(" AND shippercode=:shippercode");
				}
				if(NonUtil.isNotNon(easyshopexpress.getShippername())) {
					easyshopexpress.setShippername("%"+easyshopexpress.getShippername()+"%");
					sql.append(" AND shippername LIKE :shippername");
				}
				if(NonUtil.isNotNon(easyshopexpress.getQueryname())) {
					sql.append(" AND shippername = :queryname");
				}
			}
		}
				
		PageDomain<Easyshopexpress> retpage=null;
		try {
			retpage =  jdbcTemplate.queryForPage(sql.toString(), easyshopexpress, Easyshopexpress.class, pageparam);
		}catch (Exception e) {
			logger.error("物流表查询异常", e);
			return ret.setFail("物流表查询异常");
		}
		
		return ret.setSuccess("查询物流表成功", retpage);
	}
	
	
	/**
	 * 物流表主键查询
	 * @param Easyshopexpress
	 * @return ReturnValueDomain<Easyshopexpress>
	 */
	public ReturnValueDomain<Easyshopexpress> queryById(Easyshopexpress easyshopexpress) {
		ReturnValueDomain<Easyshopexpress> ret = new ReturnValueDomain<Easyshopexpress>();
		
		String sql="SELECT imgid,imgpath,imgthumpath,shippercode, shippername FROM tb_easyshop_express WHERE shippercode=:shippercode";
		try {
			List<Easyshopexpress> list = jdbcTemplate.query(sql, easyshopexpress, Easyshopexpress.class);
			if(NonUtil.isNon(list)){
				return ret.setFail("查询物流表为空");
			}
			ret.setObject(list.get(0));
		}catch (Exception e) {
			logger.error("物流表查询异常", e);
			return ret.setFail("物流表查询异常");
		}
		return ret.setSuccess("查询物流表成功");
	}
	
	/**
	 * 物流表新增
	 * @param EasyshopexpressListDomain
	 * @return ReturnValueDomain<Easyshopexpress>
	 */
	public ReturnValueDomain<String> add(EasyshopexpressListDomain easyshopexpresslistdomain) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		
		if (NonUtil.isNon(easyshopexpresslistdomain)) {
			return ret.setFail("无物流表");
		}
		
		List<Easyshopexpress> easyshopexpresslist=easyshopexpresslistdomain.getEasyshopexpresslist();
		
		if (NonUtil.isNon(easyshopexpresslist)) {
			return ret.setFail("无物流表");
		}
		
  		String sql="INSERT INTO tb_easyshop_express (imgid,imgpath,imgthumpath,shippercode, shippername) VALUES (:imgid,:imgpath,:imgthumpath,:shippercode, :shippername)";
		
		try {
			jdbcTemplate.batchUpdate(sql, easyshopexpresslist);
		} catch (Exception e) {
			logger.error("物流表入库异常", e);
			throw new TransactionException(e);
		}
		
		return ret.setSuccess("物流表新增成功");
	}
	
	/**
	 * 物流表修改
	 * @param EasyshopexpressListDomain
	 * @return ReturnValueDomain<String>
	 */
	public ReturnValueDomain<String> update(EasyshopexpressListDomain easyshopexpresslistdomain) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		
		if (NonUtil.isNon(easyshopexpresslistdomain)) {
			return ret.setFail("无物流表");
		}
		
		List<Easyshopexpress> easyshopexpresslist=easyshopexpresslistdomain.getEasyshopexpresslist();
		
		if (NonUtil.isNon(easyshopexpresslist)) {
			return ret.setFail("无物流表");
		}
		
				
		String sql="UPDATE tb_easyshop_express SET imgid=:imgid,imgpath=:imgpath,imgthumpath=:imgthumpath, shippername=:shippername WHERE shippercode=:shippercode";
		
		try {
			jdbcTemplate.batchUpdate(sql, easyshopexpresslist);
		} catch (Exception e) {
			logger.error("物流表修改异常", e);
			throw new TransactionException(e);
		}
		
		return ret.setSuccess("物流表修改成功");
	}
	
	/**
	 * 物流表删除
	 * @param EasyshopexpressListDomain
	 * @return ReturnValueDomain<SysUser>
	 */
	public ReturnValueDomain<String> delete(EasyshopexpressListDomain easyshopexpresslistdomain) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		
		if (NonUtil.isNon(easyshopexpresslistdomain)) {
			return ret.setFail("无物流表");
		}
		
		List<Easyshopexpress> easyshopexpresslist = easyshopexpresslistdomain.getEasyshopexpresslist();
		
		if (NonUtil.isNon(easyshopexpresslist)) {
			return ret.setFail("无物流表");
		}
		
		String sql="DELETE FROM tb_easyshop_express WHERE shippercode=:shippercode";
		
		try {
			jdbcTemplate.batchUpdate(sql, easyshopexpresslist);
		} catch (Exception e) {
			logger.error("物流表删除异常", e);
			throw new TransactionException(e);
		}
				
		return ret.setSuccess("物流表删除成功");
	}
}
