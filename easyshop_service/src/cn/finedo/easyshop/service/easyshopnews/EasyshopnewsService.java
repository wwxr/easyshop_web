/**
 * 广告表管理服务
 * 
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshopnews;

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
import cn.finedo.easyshop.pojo.Easyshopnews;
import cn.finedo.easyshop.service.easyshopnews.domain.EasyshopnewsListDomain;
import cn.finedo.easyshop.service.easyshopnews.domain.EasyshopnewsQueryDomain;

@Service
@Transactional
@Scope("singleton")
public class EasyshopnewsService {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Resource(name="jdbcTemplate")
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private IDUtil idutil;
	
	
	/**
	 * 广告表查询
	 * @param EasyshopnewsQueryDomain
	 * @return ReturnValueDomain<PageDomain<Easyshopnews>>
	 */
	public ReturnValueDomain<PageDomain<Easyshopnews>> query(EasyshopnewsQueryDomain easyshopnewsquerydomain) {
		ReturnValueDomain<PageDomain<Easyshopnews>> ret = new ReturnValueDomain<PageDomain<Easyshopnews>>();
		
		StringBuilder sql=new StringBuilder("SELECT imgpath,imgthumpath,videopath,newsintroduction,newsid, addtime, opttime, detail, imgid, videoid, newsname FROM tb_easyshop_news WHERE 1=1");
			
		Easyshopnews easyshopnews=null;
		PageParamDomain pageparam=null;
		if(NonUtil.isNotNon(easyshopnewsquerydomain)) {
			pageparam=easyshopnewsquerydomain.getPageparam();
			easyshopnews=easyshopnewsquerydomain.getEasyshopnews();
			
			if(NonUtil.isNotNon(easyshopnews)) {
				
				if(NonUtil.isNotNon(easyshopnews.getNewsid())) {
					sql.append(" AND newsid=:newsid");
				}
				if(NonUtil.isNotNon(easyshopnews.getAddtimebegin())) {
					sql.append(" AND addtime >= " + ConvertUtil.stringToDateByMysql(":addtimebegin"));
				}
				if(NonUtil.isNotNon(easyshopnews.getAddtimeend())) {
					sql.append(" AND addtime <= " + ConvertUtil.stringToDateByMysql(":addtimeend"));
				}
				if(NonUtil.isNotNon(easyshopnews.getOpttimebegin())) {
					sql.append(" AND opttime >= " + ConvertUtil.stringToDateByMysql(":opttimebegin"));
				}
				if(NonUtil.isNotNon(easyshopnews.getOpttimeend())) {
					sql.append(" AND opttime <= " + ConvertUtil.stringToDateByMysql(":opttimeend"));
				}
				if(NonUtil.isNotNon(easyshopnews.getDetail())) {
					sql.append(" AND detail=:detail");
				}
				if(NonUtil.isNotNon(easyshopnews.getImgid())) {
					sql.append(" AND imgid=:imgid");
				}
				if(NonUtil.isNotNon(easyshopnews.getVideoid())) {
					sql.append(" AND videoid=:videoid");
				}
				if(NonUtil.isNotNon(easyshopnews.getNewsname())) {
					sql.append(" AND newsname=:newsname");
				}
			}
		}
				
		PageDomain<Easyshopnews> retpage=null;
		try {
			retpage =  jdbcTemplate.queryForPage(sql.toString(), easyshopnews, Easyshopnews.class, pageparam);
		}catch (Exception e) {
			logger.error("广告表查询异常", e);
			return ret.setFail("广告表查询异常");
		}
		
		return ret.setSuccess("查询广告表成功", retpage);
	}
	
	
	/**
	 * 广告表主键查询
	 * @param Easyshopnews
	 * @return ReturnValueDomain<Easyshopnews>
	 */
	public ReturnValueDomain<Easyshopnews> queryById(Easyshopnews easyshopnews) {
		ReturnValueDomain<Easyshopnews> ret = new ReturnValueDomain<Easyshopnews>();
		
		String sql="SELECT imgpath,imgthumpath,videopath,newsintroduction,newsid, addtime, opttime, detail, imgid, videoid, newsname FROM tb_easyshop_news WHERE newsid=:newsid";
		try {
			List<Easyshopnews> list = jdbcTemplate.query(sql, easyshopnews, Easyshopnews.class);
			if(NonUtil.isNon(list)){
				return ret.setFail("查询广告表为空");
			}
			ret.setObject(list.get(0));
		}catch (Exception e) {
			logger.error("广告表查询异常", e);
			return ret.setFail("广告表查询异常");
		}
		return ret.setSuccess("查询广告表成功");
	}
	
	/**
	 * 广告表新增
	 * @param EasyshopnewsListDomain
	 * @return ReturnValueDomain<Easyshopnews>
	 */
	public ReturnValueDomain<String> add(EasyshopnewsListDomain easyshopnewslistdomain) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		
		if (NonUtil.isNon(easyshopnewslistdomain)) {
			return ret.setFail("无广告表");
		}
		
		List<Easyshopnews> easyshopnewslist=easyshopnewslistdomain.getEasyshopnewslist();
		
		if (NonUtil.isNon(easyshopnewslist)) {
			return ret.setFail("无广告表");
		}
		
		try{
			for(Easyshopnews easyshopnews : easyshopnewslist) {
				
				String newsid=idutil.getID("easyshopnews");
				easyshopnews.setNewsid(newsid);
			}
		}catch(Exception e) {
		    logger.error("广告表处理异常", e);
			return ret.setFail("广告表处理异常");
		}
		
  		String sql="INSERT INTO tb_easyshop_news (imgpath,imgthumpath,videopath,newsid, addtime,detail, imgid, videoid, newsname,newsintroduction) VALUES (:imgpath,:imgthumpath,:videopath,:newsid, NOW(),:detail, :imgid, :videoid, :newsname,:newsintroduction)";
		
		try {
			jdbcTemplate.batchUpdate(sql, easyshopnewslist);
		} catch (Exception e) {
			logger.error("广告表入库异常", e);
			throw new TransactionException(e);
		}
		
		return ret.setSuccess("广告表新增成功");
	}
	
	/**
	 * 广告表修改
	 * @param EasyshopnewsListDomain
	 * @return ReturnValueDomain<String>
	 */
	public ReturnValueDomain<String> update(EasyshopnewsListDomain easyshopnewslistdomain) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		
		if (NonUtil.isNon(easyshopnewslistdomain)) {
			return ret.setFail("无广告表");
		}
		
		List<Easyshopnews> easyshopnewslist=easyshopnewslistdomain.getEasyshopnewslist();
		
		if (NonUtil.isNon(easyshopnewslist)) {
			return ret.setFail("无广告表");
		}
		
				
		String sql="UPDATE tb_easyshop_news SET  imgpath=:imgpath,imgthumpath=:imgthumpath,videopath=:videopath,newsintroduction=:newsintroduction,opttime=NOW(), detail=:detail, imgid=:imgid, videoid=:videoid, newsname=:newsname WHERE newsid=:newsid";
		
		try {
			jdbcTemplate.batchUpdate(sql, easyshopnewslist);
		} catch (Exception e) {
			logger.error("广告表修改异常", e);
			throw new TransactionException(e);
		}
		
		return ret.setSuccess("广告表修改成功");
	}
	
	/**
	 * 广告表删除
	 * @param EasyshopnewsListDomain
	 * @return ReturnValueDomain<SysUser>
	 */
	public ReturnValueDomain<String> delete(EasyshopnewsListDomain easyshopnewslistdomain) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		
		if (NonUtil.isNon(easyshopnewslistdomain)) {
			return ret.setFail("无广告表");
		}
		
		List<Easyshopnews> easyshopnewslist = easyshopnewslistdomain.getEasyshopnewslist();
		
		if (NonUtil.isNon(easyshopnewslist)) {
			return ret.setFail("无广告表");
		}
		
		String sql="DELETE FROM tb_easyshop_news WHERE newsid=:newsid";
		
		try {
			jdbcTemplate.batchUpdate(sql, easyshopnewslist);
		} catch (Exception e) {
			logger.error("广告表删除异常", e);
			throw new TransactionException(e);
		}
				
		return ret.setSuccess("广告表删除成功");
	}
}
