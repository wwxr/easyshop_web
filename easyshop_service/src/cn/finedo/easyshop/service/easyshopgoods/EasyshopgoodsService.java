/**
 * 商品表管理服务
 * 
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshopgoods;

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
import cn.finedo.easyshop.pojo.Easyshopgoods;
import cn.finedo.easyshop.service.easyshopgoods.domain.EasyshopgoodsListDomain;
import cn.finedo.easyshop.service.easyshopgoods.domain.EasyshopgoodsQueryDomain;

@Service
@Transactional
@Scope("singleton")
public class EasyshopgoodsService {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Resource(name="jdbcTemplate")
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private IDUtil idutil;
	
	
	/**
	 * 商品表查询
	 * @param EasyshopgoodsQueryDomain
	 * @return ReturnValueDomain<PageDomain<Easyshopgoods>>
	 */
	public ReturnValueDomain<PageDomain<Easyshopgoods>> query(EasyshopgoodsQueryDomain easyshopgoodsquerydomain) {
		ReturnValueDomain<PageDomain<Easyshopgoods>> ret = new ReturnValueDomain<PageDomain<Easyshopgoods>>();
		
		StringBuilder sql=new StringBuilder("SELECT a.imgpath,a.imgthumpath,a.videopath,a.goodsintroduction,a.goodsid, a.presentprice, a.originalprice, a.goodsname, a.videoid, a.imgids, a.opttime, ");
		sql.append("a.isrecommend, a.addtime, a.goodstypeid, a.detail, a.points, a.paytype,b.goodstypename  ");
		sql.append("FROM tb_easyshop_goods a LEFT JOIN tb_easyshop_goodstype b ON a.goodstypeid=b.goodstypeid WHERE 1=1 ");
			
		Easyshopgoods easyshopgoods=null;
		PageParamDomain pageparam=null;
		if(NonUtil.isNotNon(easyshopgoodsquerydomain)) {
			pageparam=easyshopgoodsquerydomain.getPageparam();
			easyshopgoods=easyshopgoodsquerydomain.getEasyshopgoods();
			
			if(NonUtil.isNotNon(easyshopgoods)) {
				
				if(NonUtil.isNotNon(easyshopgoods.getGoodsid())) {
					sql.append(" AND a.goodsid=:goodsid");
				}
				if(NonUtil.isNotNon(easyshopgoods.getPresentprice())) {
					sql.append(" AND a.presentprice=:presentprice");
				}
				if(NonUtil.isNotNon(easyshopgoods.getOriginalprice())) {
					sql.append(" AND a.originalprice=:originalprice");
				}
				if(NonUtil.isNotNon(easyshopgoods.getGoodsname())) {
					easyshopgoods.setGoodsname("%"+easyshopgoods.getGoodsname()+"%");
					sql.append(" AND a.goodsname LIKE :goodsname");
				}
				if(NonUtil.isNotNon(easyshopgoods.getOpttimebegin())) {
					sql.append(" AND opttime >= " + ConvertUtil.stringToDateByMysql(":opttimebegin"));
				}
				if(NonUtil.isNotNon(easyshopgoods.getOpttimeend())) {
					sql.append(" AND opttime <= " + ConvertUtil.stringToDateByMysql(":opttimeend"));
				}
				if(NonUtil.isNotNon(easyshopgoods.getIsrecommend())) {
					sql.append(" AND isrecommend=:isrecommend");
				}
				if(NonUtil.isNotNon(easyshopgoods.getAddtimebegin())) {
					sql.append(" AND addtime >= " + ConvertUtil.stringToDateByMysql(":addtimebegin"));
				}
				if(NonUtil.isNotNon(easyshopgoods.getAddtimeend())) {
					sql.append(" AND addtime <= " + ConvertUtil.stringToDateByMysql(":addtimeend"));
				}
				if(NonUtil.isNotNon(easyshopgoods.getGoodstypeid())) {
					sql.append(" AND a.goodstypeid=:goodstypeid");
				}
				if(NonUtil.isNotNon(easyshopgoods.getPoints())) {
					sql.append(" AND points=:points");
				}
				if(NonUtil.isNotNon(easyshopgoods.getPaytype())) {
					sql.append(" AND paytype=:paytype");
				}
			}
		}
		sql.append(" ORDER BY a.isrecommend DESC, a.addtime DESC ");	
		PageDomain<Easyshopgoods> retpage=null;
		try {
			retpage =  jdbcTemplate.queryForPage(sql.toString(), easyshopgoods, Easyshopgoods.class, pageparam);
		}catch (Exception e) {
			logger.error("商品表查询异常", e);
			return ret.setFail("商品表查询异常");
		}
		
		return ret.setSuccess("查询商品表成功", retpage);
	}
	
	
	/**
	 * 商品表主键查询
	 * @param Easyshopgoods
	 * @return ReturnValueDomain<Easyshopgoods>
	 */
	public ReturnValueDomain<Easyshopgoods> queryById(Easyshopgoods easyshopgoods) {
		ReturnValueDomain<Easyshopgoods> ret = new ReturnValueDomain<Easyshopgoods>();
		
		String sql="SELECT imgpath,imgthumpath,videopath,paramdetail,goodsintroduction,goodsid, presentprice, originalprice, goodsname, videoid, imgids, opttime, isrecommend, addtime, goodstypeid, detail, points, paytype FROM tb_easyshop_goods WHERE goodsid=:goodsid";
		try {
			List<Easyshopgoods> list = jdbcTemplate.query(sql, easyshopgoods, Easyshopgoods.class);
			if(NonUtil.isNon(list)){
				return ret.setFail("查询商品表为空");
			}
			ret.setObject(list.get(0));
		}catch (Exception e) {
			logger.error("商品表查询异常", e);
			return ret.setFail("商品表查询异常");
		}
		return ret.setSuccess("查询商品表成功");
	}
	
	/**
	 * 商品表新增
	 * @param EasyshopgoodsListDomain
	 * @return ReturnValueDomain<Easyshopgoods>
	 */
	public ReturnValueDomain<String> add(EasyshopgoodsListDomain easyshopgoodslistdomain) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		
		if (NonUtil.isNon(easyshopgoodslistdomain)) {
			return ret.setFail("无商品表");
		}
		
		List<Easyshopgoods> easyshopgoodslist=easyshopgoodslistdomain.getEasyshopgoodslist();
		
		if (NonUtil.isNon(easyshopgoodslist)) {
			return ret.setFail("无商品表");
		}
		
		try{
			for(Easyshopgoods easyshopgoods : easyshopgoodslist) {
				
				String goodsid=idutil.getID("easyshopgoods");
				easyshopgoods.setGoodsid(goodsid);
			}
		}catch(Exception e) {
		    logger.error("商品表处理异常", e);
			return ret.setFail("商品表处理异常");
		}
		
  		String sql="INSERT INTO tb_easyshop_goods (imgpath,imgthumpath,videopath,paramdetail,goodsintroduction,goodsid, presentprice, originalprice, goodsname, videoid, imgids, isrecommend, addtime, goodstypeid, detail, points, paytype) VALUES (:imgpath,:imgthumpath,:videopath,:paramdetail,:goodsintroduction,:goodsid, :presentprice, :originalprice, :goodsname, :videoid, :imgids,  :isrecommend, NOW(), :goodstypeid, :detail, :points, :paytype)";
		
		try {
			jdbcTemplate.batchUpdate(sql, easyshopgoodslist);
		} catch (Exception e) {
			logger.error("商品表入库异常", e);
			throw new TransactionException(e);
		}
		
		return ret.setSuccess("商品表新增成功");
	}
	
	/**
	 * 商品表修改
	 * @param EasyshopgoodsListDomain
	 * @return ReturnValueDomain<String>
	 */
	public ReturnValueDomain<String> update(EasyshopgoodsListDomain easyshopgoodslistdomain) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		
		if (NonUtil.isNon(easyshopgoodslistdomain)) {
			return ret.setFail("无商品表");
		}
		
		List<Easyshopgoods> easyshopgoodslist=easyshopgoodslistdomain.getEasyshopgoodslist();
		
		if (NonUtil.isNon(easyshopgoodslist)) {
			return ret.setFail("无商品表");
		}
		
				
		String sql="UPDATE tb_easyshop_goods SET imgpath=:imgpath,imgthumpath=:imgthumpath,videopath=:videopath,paramdetail=:paramdetail,goodsintroduction=:goodsintroduction, presentprice=:presentprice, originalprice=:originalprice, goodsname=:goodsname, videoid=:videoid, imgids=:imgids, opttime=NOW(), isrecommend=:isrecommend, goodstypeid=:goodstypeid, detail=:detail, points=:points, paytype=:paytype WHERE goodsid=:goodsid";
		
		try {
			jdbcTemplate.batchUpdate(sql, easyshopgoodslist);
		} catch (Exception e) {
			logger.error("商品表修改异常", e);
			throw new TransactionException(e);
		}
		
		return ret.setSuccess("商品表修改成功");
	}
	
	/**
	 * 商品表删除
	 * @param EasyshopgoodsListDomain
	 * @return ReturnValueDomain<SysUser>
	 */
	public ReturnValueDomain<String> delete(EasyshopgoodsListDomain easyshopgoodslistdomain) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		
		if (NonUtil.isNon(easyshopgoodslistdomain)) {
			return ret.setFail("无商品表");
		}
		
		List<Easyshopgoods> easyshopgoodslist = easyshopgoodslistdomain.getEasyshopgoodslist();
		
		if (NonUtil.isNon(easyshopgoodslist)) {
			return ret.setFail("无商品表");
		}
		
		String sql="DELETE FROM tb_easyshop_goods WHERE goodsid=:goodsid";
		
		try {
			jdbcTemplate.batchUpdate(sql, easyshopgoodslist);
		} catch (Exception e) {
			logger.error("商品表删除异常", e);
			throw new TransactionException(e);
		}
				
		return ret.setSuccess("商品表删除成功");
	}
}
