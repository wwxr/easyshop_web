/**
 * 地址管理服务
 * 
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshopaddress;

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
import cn.finedo.easyshop.pojo.Easyshopaddress;
import cn.finedo.easyshop.service.easyshopaddress.domain.EasyshopaddressListDomain;
import cn.finedo.easyshop.service.easyshopaddress.domain.EasyshopaddressQueryDomain;

@Service
@Transactional
@Scope("singleton")
public class EasyshopaddressService {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Resource(name="jdbcTemplate")
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private IDUtil idutil;
	
	
	/**
	 * 地址查询
	 * @param EasyshopaddressQueryDomain
	 * @return ReturnValueDomain<PageDomain<Easyshopaddress>>
	 */
	public ReturnValueDomain<PageDomain<Easyshopaddress>> query(EasyshopaddressQueryDomain easyshopaddressquerydomain) {
		ReturnValueDomain<PageDomain<Easyshopaddress>> ret = new ReturnValueDomain<PageDomain<Easyshopaddress>>();
		
		StringBuilder sql=new StringBuilder("SELECT a.phone,a.username,b.nickname,a.addressid, a.userid, a.province, a.city, a.area,a.provincenum, a.citynum, a.areanum,a.address,a.isdefault,a.addtime FROM tb_easyshop_address a ");
			sql.append(" LEFT JOIN tb_easyshop_user b ON a.userid=b.userid  WHERE 1=1 ");
		Easyshopaddress easyshopaddress=null;
		PageParamDomain pageparam=null;
		if(NonUtil.isNotNon(easyshopaddressquerydomain)) {
			pageparam=easyshopaddressquerydomain.getPageparam();
			easyshopaddress=easyshopaddressquerydomain.getEasyshopaddress();
			
			if(NonUtil.isNotNon(easyshopaddress)) {
				
				if(NonUtil.isNotNon(easyshopaddress.getAddressid())) {
					sql.append(" AND a.addressid=:addressid");
				}
				if(NonUtil.isNotNon(easyshopaddress.getUserid())) {
					sql.append(" AND a.userid=:userid");
				}
				if(NonUtil.isNotNon(easyshopaddress.getIsdefault())) {
					sql.append(" AND a.isdefault=:isdefault");
				}
				if(NonUtil.isNotNon(easyshopaddress.getAddtime())) {
					sql.append(" AND a.addtime >= " + ConvertUtil.stringToDateByMysql(":addtime"));
				}
			}
		}
		sql.append(" ORDER BY a.isdefault DESC,a.addtime DESC  ");
		PageDomain<Easyshopaddress> retpage=null;
		try {
			retpage =  jdbcTemplate.queryForPage(sql.toString(), easyshopaddress, Easyshopaddress.class, pageparam);
		}catch (Exception e) {
			logger.error("地址查询异常", e);
			return ret.setFail("地址查询异常");
		}
		
		return ret.setSuccess("查询地址成功", retpage);
	}
	
	
	/**
	 * 地址主键查询
	 * @param Easyshopaddress
	 * @return ReturnValueDomain<Easyshopaddress>
	 */
	public ReturnValueDomain<Easyshopaddress> queryById(Easyshopaddress easyshopaddress) {
		ReturnValueDomain<Easyshopaddress> ret = new ReturnValueDomain<Easyshopaddress>();
		
		String sql="SELECT phone,username,addressid, userid, province, city, area,provincenum, citynum, areanum,address,isdefault,addtime FROM tb_easyshop_address WHERE addressid=:addressid";
		try {
			List<Easyshopaddress> list = jdbcTemplate.query(sql, easyshopaddress, Easyshopaddress.class);
			if(NonUtil.isNon(list)){
				return ret.setFail("查询地址为空");
			}
			ret.setObject(list.get(0));
		}catch (Exception e) {
			logger.error("地址查询异常", e);
			return ret.setFail("地址查询异常");
		}
		return ret.setSuccess("查询地址成功");
	}
	
	/**
	 * 地址新增
	 * @param EasyshopaddressListDomain
	 * @return ReturnValueDomain<Easyshopaddress>
	 */
	public ReturnValueDomain<String> add(EasyshopaddressListDomain easyshopaddresslistdomain) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		
		if (NonUtil.isNon(easyshopaddresslistdomain)) {
			return ret.setFail("无地址");
		}
		
		List<Easyshopaddress> easyshopaddresslist=easyshopaddresslistdomain.getEasyshopaddresslist();
		
		if (NonUtil.isNon(easyshopaddresslist)) {
			return ret.setFail("无地址");
		}
		
		try{
			for(Easyshopaddress easyshopaddress : easyshopaddresslist) {
				
				String addressid=idutil.getID("easyshopaddress");
				easyshopaddress.setAddressid(addressid);
			}
		}catch(Exception e) {
		    logger.error("地址处理异常", e);
			return ret.setFail("地址处理异常");
		}
		
  		String sql="INSERT INTO tb_easyshop_address ( phone,username,provincenum, citynum, areanum,addressid, userid, province, city, area,address,isdefault,addtime ) VALUES (  :phone,:username,:provincenum, :citynum, :areanum,:addressid, :userid, :province, :city, :area,:address,:isdefault,NOW() )";
		String isdefault=easyshopaddresslist.get(0).getIsdefault();
		String sql1="UPDATE tb_easyshop_address SET isdefault='N' WHERE addressid!=:addressid AND userid=:userid ";
		try {
			if("Y".equals(isdefault)) {
				jdbcTemplate.batchUpdate(sql1,easyshopaddresslist);
			}
			jdbcTemplate.batchUpdate(sql, easyshopaddresslist);
		} catch (Exception e) {
			logger.error("地址入库异常", e);
			throw new TransactionException(e);
		}
		
		return ret.setSuccess("地址新增成功");
	}
	
	/**
	 * 地址修改
	 * @param EasyshopaddressListDomain
	 * @return ReturnValueDomain<String>
	 */
	public ReturnValueDomain<String> update(EasyshopaddressListDomain easyshopaddresslistdomain) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		
		if (NonUtil.isNon(easyshopaddresslistdomain)) {
			return ret.setFail("无地址");
		}
		
		List<Easyshopaddress> easyshopaddresslist=easyshopaddresslistdomain.getEasyshopaddresslist();
		
		if (NonUtil.isNon(easyshopaddresslist)) {
			return ret.setFail("无地址");
		}
		
				
		String sql="UPDATE tb_easyshop_address SET  phone=:phone,username=:username,provincenum=:provincenum, citynum=:citynum, areanum=:areanum, addressid=:addressid, userid=:userid, province=:province, city=:city, area=:area,address=:address,isdefault=:isdefault  WHERE addressid=:addressid";
		String isdefault=easyshopaddresslist.get(0).getIsdefault();
		String sql1="UPDATE tb_easyshop_address SET isdefault='N' WHERE addressid!=:addressid AND userid=:userid  ";
		try {
			if("Y".equals(isdefault)) {
				jdbcTemplate.batchUpdate(sql1,easyshopaddresslist);
			}
			jdbcTemplate.batchUpdate(sql, easyshopaddresslist);
		} catch (Exception e) {
			logger.error("地址修改异常", e);
			throw new TransactionException(e);
		}
		
		return ret.setSuccess("地址修改成功");
	}
	
	/**
	 * 地址删除
	 * @param EasyshopaddressListDomain
	 * @return ReturnValueDomain<SysUser>
	 */
	public ReturnValueDomain<String> delete(EasyshopaddressListDomain easyshopaddresslistdomain) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		
		if (NonUtil.isNon(easyshopaddresslistdomain)) {
			return ret.setFail("无地址");
		}
		
		List<Easyshopaddress> easyshopaddresslist = easyshopaddresslistdomain.getEasyshopaddresslist();
		
		if (NonUtil.isNon(easyshopaddresslist)) {
			return ret.setFail("无地址");
		}
		
		String sql="DELETE FROM tb_easyshop_address WHERE addressid=:addressid";
		
		try {
			jdbcTemplate.batchUpdate(sql, easyshopaddresslist);
		} catch (Exception e) {
			logger.error("地址删除异常", e);
			throw new TransactionException(e);
		}
				
		return ret.setSuccess("地址删除成功");
	}
}
