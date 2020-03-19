/**
 * 商品表管理服务接口
 *
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshopgoods;

import java.io.File;
import java.util.List;
import java.util.ArrayList;
import java.util.UUID;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import cn.finedo.common.annotation.Permission;
import cn.finedo.common.annotation.Proxy;
import cn.finedo.common.date.DateUtil;
import cn.finedo.common.domain.FileImportResultDomain;
import cn.finedo.common.domain.PageDomain;
import cn.finedo.common.domain.PageParamDomain;
import cn.finedo.common.domain.ResultDomain;
import cn.finedo.common.domain.ReturnValueDomain;
import cn.finedo.common.pojo.SysEntityfile;
import cn.finedo.common.protocol.JsonUtil;
import cn.finedo.common.valid.DataType;
import cn.finedo.common.valid.ValidateItem;
import cn.finedo.common.valid.ValidateUtil;
import cn.finedo.fsdp.server.framework.ServerFeature;
import cn.finedo.fsdp.service.common.excel.ExcelUtil;
import cn.finedo.fsdp.service.common.excel.HeaderDomain;
import cn.finedo.fsdp.service.common.configure.ConfigureUtil;
import cn.finedo.fsdp.service.file.FileServiceAPProxy;
import cn.finedo.easyshop.pojo.Easyshopgoods;
import cn.finedo.easyshop.service.easyshopgoods.domain.EasyshopgoodsListDomain;
import cn.finedo.easyshop.service.easyshopgoods.domain.EasyshopgoodsQueryDomain;

@Controller
@Scope("singleton")
@RequestMapping("service/finedo/easyshopgoods")
public class EasyshopgoodsServiceAP {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private EasyshopgoodsService easyshopgoodsservice;
	
	/**
	 * 商品表查询
	 * @param EasyshopgoodsQueryDomain
	 * @return ReturnValueDomain<Easyshopgoods>对象
	 */
	@Permission(permission = "easyshop_easyshopgoods_query")
	@Proxy(method="query", inarg="EasyshopgoodsQueryDomain", outarg="ReturnValueDomain<PageDomain<Easyshopgoods>>")
	@ResponseBody
	@RequestMapping("/query")
	public ReturnValueDomain<PageDomain<Easyshopgoods>> query(HttpServletRequest request) {
		ReturnValueDomain<PageDomain<Easyshopgoods>> ret = new ReturnValueDomain<PageDomain<Easyshopgoods>>();
		EasyshopgoodsQueryDomain easyshopgoodsquerydomain = null;
		 
		try {
			easyshopgoodsquerydomain = JsonUtil.request2Domain(request, EasyshopgoodsQueryDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		return easyshopgoodsservice.query(easyshopgoodsquerydomain);
	}

	/**
	 * 商品表按主键查询查询
	 * @param Easyshopgoods
	 * @return ReturnValueDomain<Easyshopgoods>对象
	 */
	@Permission(permission = "easyshop_easyshopgoods_query")
	@Proxy(method="queryById", inarg="Easyshopgoods", outarg="ReturnValueDomain<Easyshopgoods>")
	@ResponseBody
	@RequestMapping("/querybyid")
	public ReturnValueDomain<Easyshopgoods> queryById(HttpServletRequest request) {
		ReturnValueDomain<Easyshopgoods> ret = new ReturnValueDomain<Easyshopgoods>();
		Easyshopgoods easyshopgoods = null;
		 
		try {
			easyshopgoods = JsonUtil.request2Domain(request, Easyshopgoods.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		return easyshopgoodsservice.queryById(easyshopgoods);
	}
	 
	/**
	 * 商品表新增
	 * 
	 * @param EasyshopgoodsListDomain
	 * @return ReturnValueDomain<String>
	 */
	@Permission(permission = "easyshop_easyshopgoods_add")
	@Proxy(method="add", inarg="EasyshopgoodsListDomain", outarg="ReturnValueDomain<String>")
	@ResponseBody
	@RequestMapping("/add")
	public ReturnValueDomain<String> add(HttpServletRequest request) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		EasyshopgoodsListDomain easyshopgoodslistdomain = null;
		 
		try {
			easyshopgoodslistdomain = JsonUtil.request2Domain(request, EasyshopgoodsListDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
	
		List<Easyshopgoods> easyshopgoodslist= easyshopgoodslistdomain.getEasyshopgoodslist();
		
		List<ValidateItem> items = new ArrayList<ValidateItem>();
		items.add(new ValidateItem("presentprice", "现价", true, DataType.STRING));
		items.add(new ValidateItem("originalprice", "原价", true, DataType.STRING));
		items.add(new ValidateItem("goodsname", "商品名称", true, DataType.STRING));
		items.add(new ValidateItem("videoid", "视频id", true, DataType.STRING));
		items.add(new ValidateItem("imgids", "图片ids", true, DataType.STRING));
		items.add(new ValidateItem("opttime", "修改时间", true, DataType.DATE));
		items.add(new ValidateItem("isrecommend", "是否推荐：Y-是；N-否", true, DataType.STRING));
		items.add(new ValidateItem("addtime", "添加时间", true, DataType.DATE));
		items.add(new ValidateItem("goodstypeid", "商品类型id", true, DataType.STRING));
		items.add(new ValidateItem("detail", "物品详情", true, DataType.STRING));
		items.add(new ValidateItem("points", "所需积分", true, DataType.STRING));
		items.add(new ValidateItem("paytype", "支付类型：money-金钱；points-积分；all-金钱+积分", true, DataType.STRING));
		ReturnValueDomain<String> validret = ValidateUtil.checkForList(easyshopgoodslist, items);
		if (validret.isFail()) {
			return validret;
		}

		return easyshopgoodsservice.add(easyshopgoodslistdomain);
	 }

	/**
	 * 商品表修改
	 * @param EasyshopgoodsListDomain
	 * @return ReturnValueDomain<String>对象
	 */
	@Permission(permission = "easyshop_easyshopgoods_update")
	@Proxy(method="update", inarg="EasyshopgoodsListDomain", outarg="ReturnValueDomain<String>")
	@ResponseBody
	@RequestMapping("/update")
	public ReturnValueDomain<String> update(HttpServletRequest request) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		EasyshopgoodsListDomain easyshopgoodslistdomain = null;
		  
		try {
			easyshopgoodslistdomain = JsonUtil.request2Domain(request, EasyshopgoodsListDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}

		List<Easyshopgoods> easyshopgoodslist= easyshopgoodslistdomain.getEasyshopgoodslist();
		
		List<ValidateItem> items = new ArrayList<ValidateItem>();
		items.add(new ValidateItem("goodsid", "商品ID", true, DataType.STRING));
		items.add(new ValidateItem("presentprice", "现价", true, DataType.STRING));
		items.add(new ValidateItem("originalprice", "原价", true, DataType.STRING));
		items.add(new ValidateItem("goodsname", "商品名称", true, DataType.STRING));
		items.add(new ValidateItem("videoid", "视频id", true, DataType.STRING));
		items.add(new ValidateItem("imgids", "图片ids", true, DataType.STRING));
		items.add(new ValidateItem("opttime", "修改时间", true, DataType.DATE));
		items.add(new ValidateItem("isrecommend", "是否推荐：Y-是；N-否", true, DataType.STRING));
		items.add(new ValidateItem("addtime", "添加时间", true, DataType.DATE));
		items.add(new ValidateItem("goodstypeid", "商品类型id", true, DataType.STRING));
		items.add(new ValidateItem("detail", "物品详情", true, DataType.STRING));
		items.add(new ValidateItem("points", "所需积分", true, DataType.STRING));
		items.add(new ValidateItem("paytype", "支付类型：money-金钱；points-积分；all-金钱+积分", true, DataType.STRING));
		ReturnValueDomain<String> validret = ValidateUtil.checkForList(easyshopgoodslist, items);
		if (validret.isFail()) {
			return validret;
		}

		return easyshopgoodsservice.update(easyshopgoodslistdomain);
	}
	
	/**
	 * 商品表删除
	 * 
	 * @param EasyshopgoodsListDomain
	 * @return ReturnValueDomain<String>
	 */
	@Permission(permission = "easyshop_easyshopgoods_delete")
	@Proxy(method="delete", inarg="EasyshopgoodsListDomain", outarg="ReturnValueDomain<String>")
	@ResponseBody
	@RequestMapping("/delete")
	public ReturnValueDomain<String> delete(HttpServletRequest request) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		EasyshopgoodsListDomain easyshopgoodslistdomain = null;
		
		try {
			easyshopgoodslistdomain = JsonUtil.request2Domain(request, EasyshopgoodsListDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		List<Easyshopgoods> easyshopgoodslist= easyshopgoodslistdomain.getEasyshopgoodslist();
		
		List<ValidateItem> items = new ArrayList<ValidateItem>();
		items.add(new ValidateItem("goodsid", "商品ID", false, DataType.STRING));
		ReturnValueDomain<String> validret = ValidateUtil.checkForList(easyshopgoodslist, items);
		if (validret.isFail()) {
			return validret;
		}
		
		return easyshopgoodsservice.delete(easyshopgoodslistdomain);
	}
	
	/**
	 * 批量导入商品表
	 * 
	 * @param SysEntityfile
	 * @return ReturnValueDomain<FileImportResultDomain>对象
	 */
	@Permission(permission = "easyshop_easyshopgoods_import")
	@Proxy(method="importExcel", inarg="SysEntityfile", outarg="ReturnValueDomain<FileImportResultDomain>")
	@ResponseBody
	@RequestMapping(value="/importexcel")
	public ReturnValueDomain<FileImportResultDomain> importExcel(HttpServletRequest request) {
		ReturnValueDomain<FileImportResultDomain> ret=new ReturnValueDomain<FileImportResultDomain>();
		
		SysEntityfile entityfile = null;
		try {
			entityfile = JsonUtil.request2Domain(request, SysEntityfile.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}

		ReturnValueDomain<SysEntityfile> queryfileret=FileServiceAPProxy.queryById(entityfile);
		entityfile=queryfileret.getObject();
		
		String uploadpath = ConfigureUtil.getParamByName("系统基本参数", "上传路径");
		String filename=uploadpath + File.separator + entityfile.getFilepath() + File.separator + entityfile.getFileid() + entityfile.getFiletype();
				
		// 总记录数
		int rowcount=0;
		// 成功记录数 
		int successcount=0;
		// 失败明细
		List<ResultDomain> faillist=new ArrayList<ResultDomain>();
		List<Easyshopgoods> datalist;
		try {
			List<HeaderDomain> headerlist=new ArrayList<HeaderDomain>();
			
			headerlist.add(new HeaderDomain("0", "presentprice", "现价"));
			headerlist.add(new HeaderDomain("1", "originalprice", "原价"));
			headerlist.add(new HeaderDomain("2", "goodsname", "商品名称"));
			headerlist.add(new HeaderDomain("3", "videoid", "视频id"));
			headerlist.add(new HeaderDomain("4", "imgids", "图片ids"));
			headerlist.add(new HeaderDomain("5", "opttime", "修改时间"));
			headerlist.add(new HeaderDomain("6", "isrecommend", "是否推荐：Y-是；N-否"));
			headerlist.add(new HeaderDomain("7", "addtime", "添加时间"));
			headerlist.add(new HeaderDomain("8", "goodstypeid", "商品类型id"));
			headerlist.add(new HeaderDomain("9", "detail", "物品详情"));
			headerlist.add(new HeaderDomain("10", "points", "所需积分"));
			headerlist.add(new HeaderDomain("11", "paytype", "支付类型：money-金钱；points-积分；all-金钱+积分"));
			
			datalist=ExcelUtil.readExcel(filename, headerlist, Easyshopgoods.class);
			rowcount=datalist.size();
			
			// 合法性校验
			List<ValidateItem> items = new ArrayList<ValidateItem>();
			items.add(new ValidateItem("presentprice", "现价", true, DataType.STRING));
			items.add(new ValidateItem("originalprice", "原价", true, DataType.STRING));
			items.add(new ValidateItem("goodsname", "商品名称", true, DataType.STRING));
			items.add(new ValidateItem("videoid", "视频id", true, DataType.STRING));
			items.add(new ValidateItem("imgids", "图片ids", true, DataType.STRING));
			items.add(new ValidateItem("opttime", "修改时间", true, DataType.DATE));
			items.add(new ValidateItem("isrecommend", "是否推荐：Y-是；N-否", true, DataType.STRING));
			items.add(new ValidateItem("addtime", "添加时间", true, DataType.DATE));
			items.add(new ValidateItem("goodstypeid", "商品类型id", true, DataType.STRING));
			items.add(new ValidateItem("detail", "物品详情", true, DataType.STRING));
			items.add(new ValidateItem("points", "所需积分", true, DataType.STRING));
			items.add(new ValidateItem("paytype", "支付类型：money-金钱；points-积分；all-金钱+积分", true, DataType.STRING));
			
			ReturnValueDomain<String> validret = ValidateUtil.checkForList(datalist, items);
			int failindex=0;
			for(ResultDomain rd : validret.getResultlist()) {
				rd.setResultdesc("[行号:" + failindex + 2 + "]" + rd.getResultdesc());
				faillist.add(rd);
				
				failindex++;
			}
			successcount=rowcount - failindex;
		}catch(Exception e) {
			logger.error("导入失败", e);
			return ret.setFail("导入失败");
		}
		
		if(successcount != rowcount) {
			FileImportResultDomain importresult=new FileImportResultDomain();
			importresult.setRowcount(rowcount);
			importresult.setSuccesscount(successcount);
			importresult.setFailcount(rowcount-successcount);
			importresult.setFaillist(faillist);
						
			return ret.setFail("导入数据合法性校验不通过", importresult);
		}
		
		EasyshopgoodsListDomain easyshopgoodslistdomain=new EasyshopgoodsListDomain();
		easyshopgoodslistdomain.setEasyshopgoodslist(datalist);
		ReturnValueDomain<String> oneret= easyshopgoodsservice.add(easyshopgoodslistdomain);
		if(oneret.isFail()) {
			return ret.setFail("导入失败:" + oneret.getResultdesc());
		}
	
		FileImportResultDomain importresult=new FileImportResultDomain();
		importresult.setRowcount(rowcount);
		importresult.setSuccesscount(successcount);
		importresult.setFailcount(rowcount-successcount);
		importresult.setFaillist(faillist);
		
		return ret.setSuccess("导入成功", importresult);
	}
	
	 /**
	  * 批量导出用户信息
	  * 
	  * @param EasyshopgoodsQueryDomain
	  * @return ReturnValueDomain<SysEntityfile>对象
	  */
	@Permission(permission = "easyshop_easyshopgoods_export")
	@Proxy(method="exportExcel", inarg="EasyshopgoodsQueryDomain", outarg="ReturnValueDomain<SysEntityfile>")
	@ResponseBody
	@RequestMapping("/exportexcel")
	public ReturnValueDomain<SysEntityfile> exportExcel(HttpServletRequest request) {
		ReturnValueDomain<SysEntityfile> ret=new ReturnValueDomain<SysEntityfile>();
		
		EasyshopgoodsQueryDomain easyshopgoodsquerydomain = null;
		try {
			easyshopgoodsquerydomain = JsonUtil.request2Domain(request, EasyshopgoodsQueryDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		PageParamDomain pageparam=new PageParamDomain();
		pageparam.setRownumperpage(ServerFeature.EXPORT_MAXSIZE);
		pageparam.setPageindex(0);
		easyshopgoodsquerydomain.setPageparam(pageparam);
		
		ReturnValueDomain<PageDomain<Easyshopgoods>> queryret = easyshopgoodsservice.query(easyshopgoodsquerydomain);
		
		List<Easyshopgoods> Easyshopgoodslist = queryret.getObject().getDatalist();
		
		List<HeaderDomain> headerlist = new ArrayList<HeaderDomain>();
		headerlist.add(new HeaderDomain("0", "presentprice", "现价"));
		headerlist.add(new HeaderDomain("1", "originalprice", "原价"));
		headerlist.add(new HeaderDomain("2", "goodsname", "商品名称"));
		headerlist.add(new HeaderDomain("3", "videoid", "视频id"));
		headerlist.add(new HeaderDomain("4", "imgids", "图片ids"));
		headerlist.add(new HeaderDomain("5", "opttime", "修改时间"));
		headerlist.add(new HeaderDomain("6", "isrecommend", "是否推荐：Y-是；N-否"));
		headerlist.add(new HeaderDomain("7", "addtime", "添加时间"));
		headerlist.add(new HeaderDomain("8", "goodstypeid", "商品类型id"));
		headerlist.add(new HeaderDomain("9", "detail", "物品详情"));
		headerlist.add(new HeaderDomain("10", "points", "所需积分"));
		headerlist.add(new HeaderDomain("11", "paytype", "支付类型：money-金钱；points-积分；all-金钱+积分"));
		
		String filepath=ServerFeature.WEBAPP_HOME + File.separator + "download" + File.separator + DateUtil.getNowTime("yyyyMMdd");
		String filename=UUID.randomUUID().toString() + ".xlsx";
				
		try {
			ExcelUtil.writeExcel(filepath + File.separator + filename, headerlist, Easyshopgoodslist);
		} catch (Exception e) {
			logger.error("生成excel文件失败", e);
			return ret.setFail("生成excel文件失败:" + e.getMessage());
		}
		
		SysEntityfile entityfile=new SysEntityfile();
		entityfile.setFilename(filename);
		entityfile.setFilepath(filepath);
		return ret.setSuccess("生成excel文件成功", entityfile);
	}
}
