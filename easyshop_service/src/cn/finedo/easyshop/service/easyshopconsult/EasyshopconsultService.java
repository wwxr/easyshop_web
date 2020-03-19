/**
 * 咨询表管理服务
 * 
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshopconsult;

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
import cn.finedo.easyshop.pojo.Easyshopconsult;
import cn.finedo.easyshop.service.easyshopconsult.domain.EasyshopconsultListDomain;
import cn.finedo.easyshop.service.easyshopconsult.domain.EasyshopconsultQueryDomain;

@Service
@Transactional
@Scope("singleton")
public class EasyshopconsultService {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Resource(name="jdbcTemplate")
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private IDUtil idutil;
	
	
	/**
	 * 咨询表查询
	 * @param EasyshopaddressQueryDomain
	 * @return ReturnValueDomain<PageDomain<Easyshopconsult>>
	 */
	public ReturnValueDomain<PageDomain<Easyshopconsult>> query(EasyshopconsultQueryDomain easyshopconsultquerydomain) {
		ReturnValueDomain<PageDomain<Easyshopconsult>> ret = new ReturnValueDomain<PageDomain<Easyshopconsult>>();
		
		StringBuilder sql=new StringBuilder("SELECT consultid, userid, businessid, detail, createtime FROM tb_easyshop_consult WHERE 1=1");
			
		Easyshopconsult easyshopconsult=null;
		PageParamDomain pageparam=null;
		if(NonUtil.isNotNon(easyshopconsultquerydomain)) {
			pageparam=easyshopconsultquerydomain.getPageparam();
			easyshopconsult=easyshopconsultquerydomain.getEasyshopconsult();
			
			if(NonUtil.isNotNon(easyshopconsult)) {
				
				if(NonUtil.isNotNon(easyshopconsult.getConsultid())) {
					sql.append(" AND consultid=:consultid");
				}
				if(NonUtil.isNotNon(easyshopconsult.getUserid())) {
					sql.append(" AND userid=:userid");
				}
				if(NonUtil.isNotNon(easyshopconsult.getBusinessid())) {
					sql.append(" AND businessid=:businessid");
				}
				if(NonUtil.isNotNon(easyshopconsult.getDetail())) {
					sql.append(" AND detail=:detail");
				}
				if(NonUtil.isNotNon(easyshopconsult.getCreatetimebegin())) {
					sql.append(" AND createtime >= " + ConvertUtil.stringToDateByMysql(":createtimebegin"));
				}
				if(NonUtil.isNotNon(easyshopconsult.getCreatetimeend())) {
					sql.append(" AND createtime <= " + ConvertUtil.stringToDateByMysql(":createtimeend"));
				}
			}
		}
				
		PageDomain<Easyshopconsult> retpage=null;
		try {
			retpage =  jdbcTemplate.queryForPage(sql.toString(), easyshopconsult, Easyshopconsult.class, pageparam);
		}catch (Exception e) {
			logger.error("咨询表查询异常", e);
			return ret.setFail("咨询表查询异常");
		}
		
		return ret.setSuccess("查询咨询表成功", retpage);
	}
	
	
	/**
	 * 咨询表主键查询
	 * @param Easyshopconsult
	 * @return ReturnValueDomain<Easyshopconsult>
	 */
	public ReturnValueDomain<Easyshopconsult> queryById(Easyshopconsult easyshopconsult) {
		ReturnValueDomain<Easyshopconsult> ret = new ReturnValueDomain<Easyshopconsult>();
		
		String sql="SELECT consultid, userid, businessid, detail, createtime FROM tb_easyshop_consult WHERE consultid=:consultid";
		try {
			List<Easyshopconsult> list = jdbcTemplate.query(sql, easyshopconsult, Easyshopconsult.class);
			if(NonUtil.isNon(list)){
				return ret.setFail("查询咨询表为空");
			}
			ret.setObject(list.get(0));
		}catch (Exception e) {
			logger.error("咨询表查询异常", e);
			return ret.setFail("咨询表查询异常");
		}
		return ret.setSuccess("查询咨询表成功");
	}
	
	/**
	 * 咨询表新增
	 * @param EasyshopaddressListDomain
	 * @return ReturnValueDomain<Easyshopconsult>
	 */
	public ReturnValueDomain<String> add(EasyshopconsultListDomain easyshopconsultlistdomain) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		
		if (NonUtil.isNon(easyshopconsultlistdomain)) {
			return ret.setFail("无咨询表");
		}
		
		List<Easyshopconsult> easyshopconsultlist=easyshopconsultlistdomain.getEasyshopconsultlist();
		
		if (NonUtil.isNon(easyshopconsultlist)) {
			return ret.setFail("无咨询表");
		}
		
		try{
			for(Easyshopconsult easyshopconsult : easyshopconsultlist) {
				
				String consultid=idutil.getID("easyshopconsult");
				easyshopconsult.setConsultid(consultid);
			}
		}catch(Exception e) {
		    logger.error("咨询表处理异常", e);
			return ret.setFail("咨询表处理异常");
		}
		
  		String sql="INSERT INTO tb_easyshop_consult (consultid, userid, businessid, detail, createtime) VALUES (:consultid, :userid, :businessid, :detail, DATE_FORMAT(:createtime, '%Y-%m-%d'))";
		
		try {
			jdbcTemplate.batchUpdate(sql, easyshopconsultlist);
		} catch (Exception e) {
			logger.error("咨询表入库异常", e);
			throw new TransactionException(e);
		}
		
		return ret.setSuccess("咨询表新增成功");
	}
	
	/**
	 * 咨询表修改
	 * @param EasyshopaddressListDomain
	 * @return ReturnValueDomain<String>
	 */
	public ReturnValueDomain<String> update(EasyshopconsultListDomain easyshopconsultlistdomain) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		
		if (NonUtil.isNon(easyshopconsultlistdomain)) {
			return ret.setFail("无咨询表");
		}
		
		List<Easyshopconsult> easyshopconsultlist=easyshopconsultlistdomain.getEasyshopconsultlist();
		
		if (NonUtil.isNon(easyshopconsultlist)) {
			return ret.setFail("无咨询表");
		}
		
				
		String sql="UPDATE tb_easyshop_consult SET consultid=:consultid, userid=:userid, businessid=:businessid, detail=:detail, createtime=DATE_FORMAT(:createtime, '%Y-%m-%d') WHERE consultid=:consultid";
		
		try {
			jdbcTemplate.batchUpdate(sql, easyshopconsultlist);
		} catch (Exception e) {
			logger.error("咨询表修改异常", e);
			throw new TransactionException(e);
		}
		
		return ret.setSuccess("咨询表修改成功");
	}
	
	/**
	 * 咨询表删除
	 * @param EasyshopaddressListDomain
	 * @return ReturnValueDomain<SysUser>
	 */
	public ReturnValueDomain<String> delete(EasyshopconsultListDomain easyshopconsultlistdomain) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		
		if (NonUtil.isNon(easyshopconsultlistdomain)) {
			return ret.setFail("无咨询表");
		}
		
		List<Easyshopconsult> easyshopconsultlist = easyshopconsultlistdomain.getEasyshopconsultlist();
		
		if (NonUtil.isNon(easyshopconsultlist)) {
			return ret.setFail("无咨询表");
		}
		
		String sql="DELETE FROM tb_easyshop_consult WHERE consultid=:consultid";
		
		try {
			jdbcTemplate.batchUpdate(sql, easyshopconsultlist);
		} catch (Exception e) {
			logger.error("咨询表删除异常", e);
			throw new TransactionException(e);
		}
				
		return ret.setSuccess("咨询表删除成功");
	}
}
