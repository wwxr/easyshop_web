/**
 * 用户表管理服务
 * 
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshopuser;

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
import cn.finedo.easyshop.pojo.Easyshopuser;
import cn.finedo.easyshop.service.easyshopuser.domain.EasyshopuserListDomain;
import cn.finedo.easyshop.service.easyshopuser.domain.EasyshopuserQueryDomain;

@Service
@Transactional
@Scope("singleton")
public class EasyshopuserService {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Resource(name="jdbcTemplate")
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private IDUtil idutil;
	
	
	/**
	 * 用户表查询
	 * @param EasyshopuserQueryDomain
	 * @return ReturnValueDomain<PageDomain<Easyshopuser>>
	 */
	public ReturnValueDomain<PageDomain<Easyshopuser>> query(EasyshopuserQueryDomain easyshopuserquerydomain) {
		ReturnValueDomain<PageDomain<Easyshopuser>> ret = new ReturnValueDomain<PageDomain<Easyshopuser>>();
		
		StringBuilder sql=new StringBuilder("SELECT country,province,city,userid, points, openid, unionid, phone, promoter, username, nickname, avatar, promocode, registtime, gender FROM tb_easyshop_user WHERE 1=1");
			
		Easyshopuser easyshopuser=null;
		PageParamDomain pageparam=null;
		if(NonUtil.isNotNon(easyshopuserquerydomain)) {
			pageparam=easyshopuserquerydomain.getPageparam();
			easyshopuser=easyshopuserquerydomain.getEasyshopuser();
			
			if(NonUtil.isNotNon(easyshopuser)) {
				
				if(NonUtil.isNotNon(easyshopuser.getUserid())) {
					sql.append(" AND userid=:userid");
				}
				if(NonUtil.isNotNon(easyshopuser.getPoints())) {
					sql.append(" AND points=:points");
				}
				if(NonUtil.isNotNon(easyshopuser.getOpenid())) {
					sql.append(" AND openid=:openid");
				}
				if(NonUtil.isNotNon(easyshopuser.getUnionid())) {
					sql.append(" AND unionid=:unionid");
				}
				if(NonUtil.isNotNon(easyshopuser.getPhone())) {
					sql.append(" AND phone=:phone");
				}
				if(NonUtil.isNotNon(easyshopuser.getPromoter())) {
					sql.append(" AND promoter=:promoter");
				}
				if(NonUtil.isNotNon(easyshopuser.getUsername())) {
					easyshopuser.setUsername("%"+easyshopuser.getUsername()+"%");
					sql.append(" AND username LIKE :username");
				}
				if(NonUtil.isNotNon(easyshopuser.getNickname())) {
					easyshopuser.setNickname("%"+easyshopuser.getNickname()+"%");
					sql.append(" AND nickname LIKE :nickname");
				}
				if(NonUtil.isNotNon(easyshopuser.getAvatar())) {
					sql.append(" AND avatar=:avatar");
				}
				if(NonUtil.isNotNon(easyshopuser.getPromocode())) {
					sql.append(" AND promocode=:promocode");
				}
				if(NonUtil.isNotNon(easyshopuser.getRegisttimebegin())) {
					sql.append(" AND registtime >= " + ConvertUtil.stringToDateByMysql(":registtimebegin"));
				}
				if(NonUtil.isNotNon(easyshopuser.getRegisttimeend())) {
					sql.append(" AND registtime <= " + ConvertUtil.stringToDateByMysql(":registtimeend"));
				}
				if(NonUtil.isNotNon(easyshopuser.getGender())) {
					sql.append(" AND gender=:gender");
				}
			}
		}
				
		PageDomain<Easyshopuser> retpage=null;
		try {
			retpage =  jdbcTemplate.queryForPage(sql.toString(), easyshopuser, Easyshopuser.class, pageparam);
		}catch (Exception e) {
			logger.error("用户表查询异常", e);
			return ret.setFail("用户表查询异常");
		}
		
		return ret.setSuccess("查询用户表成功", retpage);
	}
	
	
	/**
	 * 用户表主键查询
	 * @param Easyshopuser
	 * @return ReturnValueDomain<Easyshopuser>
	 */
	public ReturnValueDomain<Easyshopuser> queryById(Easyshopuser easyshopuser) {
		ReturnValueDomain<Easyshopuser> ret = new ReturnValueDomain<Easyshopuser>();
		StringBuffer sql=new StringBuffer("SELECT country,province,city,userid, points, openid, unionid, phone, promoter, username, nickname, avatar, promocode, registtime, gender FROM tb_easyshop_user WHERE 1=1 ");
		if(NonUtil.isNotNon(easyshopuser.getUserid())) {
			sql.append(" AND userid=:userid");
		}
		if(NonUtil.isNotNon(easyshopuser.getOpenid())) {
			sql.append(" AND openid=:openid");
		}
		try {
			List<Easyshopuser> list = jdbcTemplate.query(sql.toString(), easyshopuser, Easyshopuser.class);
			if(NonUtil.isNon(list)){
				return ret.setFail("查询用户表为空");
			}
			ret.setObject(list.get(0));
		}catch (Exception e) {
			logger.error("用户表查询异常", e);
			return ret.setFail("用户表查询异常");
		}
		return ret.setSuccess("查询用户表成功");
	}
	
	/**
	 * 用户表新增
	 * @param EasyshopuserListDomain
	 * @return ReturnValueDomain<Easyshopuser>
	 */
	public ReturnValueDomain<String> add(EasyshopuserListDomain easyshopuserlistdomain) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		
		if (NonUtil.isNon(easyshopuserlistdomain)) {
			return ret.setFail("无用户表");
		}
		
		List<Easyshopuser> easyshopuserlist=easyshopuserlistdomain.getEasyshopuserlist();
		
		if (NonUtil.isNon(easyshopuserlist)) {
			return ret.setFail("无用户表");
		}
		
		try{
			for(Easyshopuser easyshopuser : easyshopuserlist) {
				
				String userid=idutil.getID("easyshopuser");
				easyshopuser.setUserid(userid);
			}
		}catch(Exception e) {
		    logger.error("用户表处理异常", e);
			return ret.setFail("用户表处理异常");
		}
		
  		StringBuffer sql=new StringBuffer("INSERT INTO tb_easyshop_user (userid, points, openid, unionid, phone, promoter, username, nickname, avatar, promocode, registtime, gender,country,province,city) VALUES");
  				sql.append( " (:userid, :points, :openid, :unionid, :phone, :promoter, :username, :nickname, :avatar, :promocode, NOW(), :gender,:country,:province,:city)");
		
		try {
			jdbcTemplate.batchUpdate(sql.toString(), easyshopuserlist);
		} catch (Exception e) {
			logger.error("用户表入库异常", e);
			throw new TransactionException(e);
		}
		
		return ret.setSuccess("用户表新增成功");
	}
	/**
	 * 登录用户新增
	 * @param EasyshopuserListDomain
	 * @return ReturnValueDomain<Easyshopuser>
	 */
	public ReturnValueDomain<Easyshopuser> addloginuser(Easyshopuser easyshopuser) {
		ReturnValueDomain<Easyshopuser> ret = new ReturnValueDomain<Easyshopuser>();
		
		if (NonUtil.isNon(easyshopuser)) {
			return ret.setFail("无用户表");
		}
		try{
			String userid=idutil.getID("easyshopuser");
			easyshopuser.setUserid(userid);
		}catch(Exception e) {
			logger.error("用户表处理异常", e);
			return ret.setFail("用户表处理异常");
		}
		
		String sql="INSERT INTO tb_easyshop_user (userid, points, openid, unionid, phone, promoter, username, nickname, avatar, promocode, registtime, gender,country,province,city) VALUES (:userid, 0, :openid, :unionid, :phone, :promoter, :username, :nickname, :avatar, :promocode, NOW(), :gender,:country,:province,:city)";
		
		try {
			jdbcTemplate.update(sql, easyshopuser);
		} catch (Exception e) {
			logger.error("用户表入库异常", e);
			throw new TransactionException(e);
		}
		ret.setObject(easyshopuser);
		return ret.setSuccess("用户表新增成功");
	}
	
	/**
	 * 用户表修改
	 * @param EasyshopuserListDomain
	 * @return ReturnValueDomain<String>
	 */
	public ReturnValueDomain<String> update(EasyshopuserListDomain easyshopuserlistdomain) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		
		if (NonUtil.isNon(easyshopuserlistdomain)) {
			return ret.setFail("无用户表");
		}
		
		List<Easyshopuser> easyshopuserlist=easyshopuserlistdomain.getEasyshopuserlist();
		
		if (NonUtil.isNon(easyshopuserlist)) {
			return ret.setFail("无用户表");
		}
		
				
		String sql="UPDATE tb_easyshop_user SET userid=:userid, points=:points, openid=:openid, unionid=:unionid, phone=:phone, promoter=:promoter, username=:username, nickname=:nickname, avatar=:avatar, promocode=:promocode, registtime=DATE_FORMAT(:registtime, '%Y-%m-%d'), gender=:gender WHERE userid=:userid";
		
		try {
			jdbcTemplate.batchUpdate(sql, easyshopuserlist);
		} catch (Exception e) {
			logger.error("用户表修改异常", e);
			throw new TransactionException(e);
		}
		
		return ret.setSuccess("用户表修改成功");
	}
	
	/**
	 * 用户表删除
	 * @param EasyshopuserListDomain
	 * @return ReturnValueDomain<SysUser>
	 */
	public ReturnValueDomain<String> delete(EasyshopuserListDomain easyshopuserlistdomain) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		
		if (NonUtil.isNon(easyshopuserlistdomain)) {
			return ret.setFail("无用户表");
		}
		
		List<Easyshopuser> easyshopuserlist = easyshopuserlistdomain.getEasyshopuserlist();
		
		if (NonUtil.isNon(easyshopuserlist)) {
			return ret.setFail("无用户表");
		}
		
		String sql="DELETE FROM tb_easyshop_user WHERE userid=:userid";
		
		try {
			jdbcTemplate.batchUpdate(sql, easyshopuserlist);
		} catch (Exception e) {
			logger.error("用户表删除异常", e);
			throw new TransactionException(e);
		}
				
		return ret.setSuccess("用户表删除成功");
	}
}
