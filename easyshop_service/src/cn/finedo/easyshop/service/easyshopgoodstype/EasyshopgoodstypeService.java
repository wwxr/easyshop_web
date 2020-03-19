/**
 * 商品类型管理服务
 * 
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshopgoodstype;

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
import cn.finedo.easyshop.pojo.Easyshopgoodstype;
import cn.finedo.easyshop.pojo.Easyshopordergoods;
import cn.finedo.easyshop.service.easyshopgoodstype.domain.EasyshopgoodstypeListDomain;
import cn.finedo.easyshop.service.easyshopgoodstype.domain.EasyshopgoodstypeQueryDomain;

@Service
@Transactional
@Scope("singleton")
public class EasyshopgoodstypeService {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Resource(name="jdbcTemplate")
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private IDUtil idutil;
	
	
	/**
	 * 商品类型查询
	 * @param EasyshopgoodstypeQueryDomain
	 * @return ReturnValueDomain<PageDomain<Easyshopgoodstype>>
	 */
	public ReturnValueDomain<PageDomain<Easyshopgoodstype>> query(EasyshopgoodstypeQueryDomain easyshopgoodstypequerydomain) {
		ReturnValueDomain<PageDomain<Easyshopgoodstype>> ret = new ReturnValueDomain<PageDomain<Easyshopgoodstype>>();
		
		StringBuilder sql=new StringBuilder("SELECT a.imgpath,a.imgthumpath,a.goodstypeid, a.goodstypename, a.parentid,b.goodstypename AS parentname, a.imgid FROM tb_easyshop_goodstype a LEFT JOIN tb_easyshop_goodstype b ON a.parentid=b.goodstypeid  WHERE 1=1");
			
		Easyshopgoodstype easyshopgoodstype=null;
		PageParamDomain pageparam=null;
		if(NonUtil.isNotNon(easyshopgoodstypequerydomain)) {
			pageparam=easyshopgoodstypequerydomain.getPageparam();
			easyshopgoodstype=easyshopgoodstypequerydomain.getEasyshopgoodstype();
			
			if(NonUtil.isNotNon(easyshopgoodstype)) {
				
				if(NonUtil.isNotNon(easyshopgoodstype.getGoodstypeid())) {
					sql.append(" AND a.goodstypeid=:goodstypeid");
				}
				if(NonUtil.isNotNon(easyshopgoodstype.getGoodstypename())) {
					sql.append(" AND a.goodstypename=:goodstypename");
				}
				if(NonUtil.isNotNon(easyshopgoodstype.getParentid())) {
					sql.append(" AND a.parentid=:parentid");
				}
				if(NonUtil.isNotNon(easyshopgoodstype.getType())) {
					if("big".equals(easyshopgoodstype.getType())) {
						sql.append(" AND a.parentid=''");
					}else {
						sql.append(" AND a.parentid !=''");
					}
				}
				sql.append(" ORDER BY a.parentid ASC");
			}
		}
				
		PageDomain<Easyshopgoodstype> retpage=null;
		try {
			retpage =  jdbcTemplate.queryForPage(sql.toString(), easyshopgoodstype, Easyshopgoodstype.class, pageparam);
		}catch (Exception e) {
			logger.error("商品类型查询异常", e);
			return ret.setFail("商品类型查询异常");
		}
		
		return ret.setSuccess("查询商品类型成功", retpage);
	}
	
	/**
	 *  商品类型查询
	 * @param EasyshopordergoodsQueryDomain
	 * @return ReturnValueDomain<PageDomain<Easyshopgoodstype>>
	 */
	public ReturnValueDomain<List<Easyshopgoodstype>> querygoodstypes(Easyshopgoodstype easyshopgoodstype) {
		ReturnValueDomain<List<Easyshopgoodstype>> ret = new ReturnValueDomain<List<Easyshopgoodstype>>();
		
		StringBuilder sql=new StringBuilder("SELECT a.imgpath,a.imgthumpath,a.goodstypeid,a.goodstypename,a.imgid,b.goodstypename AS parentname ,b.imgid AS parentimgid,a.parentid ");
		sql.append(" FROM tb_easyshop_goodstype a LEFT JOIN tb_easyshop_goodstype b ON a.parentid=b.goodstypeid WHERE 1=1 ");
		if(NonUtil.isNotNon(easyshopgoodstype)) {
			if(NonUtil.isNotNon(easyshopgoodstype.getType())) {
				sql.append(" AND a.parentid !='' ");
			}
		}
		sql.append(" ORDER BY a.parentid ");
		List<Easyshopgoodstype> retpage=null;
		try {
			retpage =  jdbcTemplate.query(sql.toString(), Easyshopgoodstype.class);
		}catch (Exception e) {
			logger.error("商品类型查询异常", e);
			return ret.setFail("商品类型查询异常");
		}
		
		return ret.setSuccess("商品类型查询成功", retpage);
	}
	
	/**
	 * 商品类型主键查询
	 * @param Easyshopgoodstype
	 * @return ReturnValueDomain<Easyshopgoodstype>
	 */
	public ReturnValueDomain<Easyshopgoodstype> queryById(Easyshopgoodstype easyshopgoodstype) {
		ReturnValueDomain<Easyshopgoodstype> ret = new ReturnValueDomain<Easyshopgoodstype>();
		
		String sql="SELECT imgpath,imgthumpath,goodstypeid, goodstypename, parentid, imgid FROM tb_easyshop_goodstype WHERE goodstypeid=:goodstypeid";
		try {
			List<Easyshopgoodstype> list = jdbcTemplate.query(sql, easyshopgoodstype, Easyshopgoodstype.class);
			if(NonUtil.isNon(list)){
				return ret.setFail("查询商品类型为空");
			}
			ret.setObject(list.get(0));
		}catch (Exception e) {
			logger.error("商品类型查询异常", e);
			return ret.setFail("商品类型查询异常");
		}
		return ret.setSuccess("查询商品类型成功");
	}
	
	/**
	 * 商品类型新增
	 * @param EasyshopgoodstypeListDomain
	 * @return ReturnValueDomain<Easyshopgoodstype>
	 */
	public ReturnValueDomain<String> add(EasyshopgoodstypeListDomain easyshopgoodstypelistdomain) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		
		if (NonUtil.isNon(easyshopgoodstypelistdomain)) {
			return ret.setFail("无商品类型");
		}
		
		List<Easyshopgoodstype> easyshopgoodstypelist=easyshopgoodstypelistdomain.getEasyshopgoodstypelist();
		
		if (NonUtil.isNon(easyshopgoodstypelist)) {
			return ret.setFail("无商品类型");
		}
		
		try{
			for(Easyshopgoodstype easyshopgoodstype : easyshopgoodstypelist) {
				
				String goodstypeid=idutil.getID("easyshopgoodstype");
				easyshopgoodstype.setGoodstypeid(goodstypeid);
			}
		}catch(Exception e) {
		    logger.error("商品类型处理异常", e);
			return ret.setFail("商品类型处理异常");
		}
		
  		String sql="INSERT INTO tb_easyshop_goodstype (imgpath,imgthumpath,goodstypeid, goodstypename, parentid, imgid) VALUES (:imgpath,:imgthumpath,:goodstypeid, :goodstypename, :parentid, :imgid)";
		
		try {
			jdbcTemplate.batchUpdate(sql, easyshopgoodstypelist);
		} catch (Exception e) {
			logger.error("商品类型入库异常", e);
			throw new TransactionException(e);
		}
		
		return ret.setSuccess("商品类型新增成功");
	}
	
	/**
	 * 商品类型修改
	 * @param EasyshopgoodstypeListDomain
	 * @return ReturnValueDomain<String>
	 */
	public ReturnValueDomain<String> update(EasyshopgoodstypeListDomain easyshopgoodstypelistdomain) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		
		if (NonUtil.isNon(easyshopgoodstypelistdomain)) {
			return ret.setFail("无商品类型");
		}
		
		List<Easyshopgoodstype> easyshopgoodstypelist=easyshopgoodstypelistdomain.getEasyshopgoodstypelist();
		
		if (NonUtil.isNon(easyshopgoodstypelist)) {
			return ret.setFail("无商品类型");
		}
		
				
		String sql="UPDATE tb_easyshop_goodstype SET imgpath=:imgpath,imgthumpath=:imgthumpath,goodstypeid=:goodstypeid, goodstypename=:goodstypename, parentid=:parentid, imgid=:imgid WHERE goodstypeid=:goodstypeid";
		
		try {
			jdbcTemplate.batchUpdate(sql, easyshopgoodstypelist);
		} catch (Exception e) {
			logger.error("商品类型修改异常", e);
			throw new TransactionException(e);
		}
		
		return ret.setSuccess("商品类型修改成功");
	}
	
	/**
	 * 商品类型删除
	 * @param EasyshopgoodstypeListDomain
	 * @return ReturnValueDomain<SysUser>
	 */
	public ReturnValueDomain<String> delete(EasyshopgoodstypeListDomain easyshopgoodstypelistdomain) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		
		if (NonUtil.isNon(easyshopgoodstypelistdomain)) {
			return ret.setFail("无商品类型");
		}
		
		List<Easyshopgoodstype> easyshopgoodstypelist = easyshopgoodstypelistdomain.getEasyshopgoodstypelist();
		
		if (NonUtil.isNon(easyshopgoodstypelist)) {
			return ret.setFail("无商品类型");
		}
		
		String sql="DELETE FROM tb_easyshop_goodstype WHERE goodstypeid=:goodstypeid";
		
		try {
			jdbcTemplate.batchUpdate(sql, easyshopgoodstypelist);
		} catch (Exception e) {
			logger.error("商品类型删除异常", e);
			throw new TransactionException(e);
		}
				
		return ret.setSuccess("商品类型删除成功");
	}
}
