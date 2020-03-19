/**
 * 订单物品关联表管理服务接口
 *
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshopordergoods;

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
import cn.finedo.easyshop.pojo.Easyshopordergoods;
import cn.finedo.easyshop.service.easyshopordergoods.domain.EasyshopordergoodsListDomain;
import cn.finedo.easyshop.service.easyshopordergoods.domain.EasyshopordergoodsQueryDomain;

@Controller
@Scope("singleton")
@RequestMapping("service/finedo/easyshopordergoods")
public class EasyshopordergoodsServiceAP {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private EasyshopordergoodsService easyshopordergoodsservice;
	
	/**
	 * 订单物品关联表查询
	 * @param EasyshopordergoodsQueryDomain
	 * @return ReturnValueDomain<Easyshopordergoods>对象
	 */
	@Permission(permission = "easyshop_easyshopordergoods_query")
	@Proxy(method="query", inarg="EasyshopordergoodsQueryDomain", outarg="ReturnValueDomain<PageDomain<Easyshopordergoods>>")
	@ResponseBody
	@RequestMapping("/query")
	public ReturnValueDomain<PageDomain<Easyshopordergoods>> query(HttpServletRequest request) {
		ReturnValueDomain<PageDomain<Easyshopordergoods>> ret = new ReturnValueDomain<PageDomain<Easyshopordergoods>>();
		EasyshopordergoodsQueryDomain easyshopordergoodsquerydomain = null;
		 
		try {
			easyshopordergoodsquerydomain = JsonUtil.request2Domain(request, EasyshopordergoodsQueryDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		return easyshopordergoodsservice.query(easyshopordergoodsquerydomain);
	}

	/**
	 * 订单物品关联表按主键查询查询
	 * @param Easyshopordergoods
	 * @return ReturnValueDomain<Easyshopordergoods>对象
	 */
	@Permission(permission = "easyshop_easyshopordergoods_query")
	@Proxy(method="queryById", inarg="Easyshopordergoods", outarg="ReturnValueDomain<Easyshopordergoods>")
	@ResponseBody
	@RequestMapping("/querybyid")
	public ReturnValueDomain<Easyshopordergoods> queryById(HttpServletRequest request) {
		ReturnValueDomain<Easyshopordergoods> ret = new ReturnValueDomain<Easyshopordergoods>();
		Easyshopordergoods easyshopordergoods = null;
		 
		try {
			easyshopordergoods = JsonUtil.request2Domain(request, Easyshopordergoods.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		return easyshopordergoodsservice.queryById(easyshopordergoods);
	}
	 
	/**
	 * 订单物品关联表新增
	 * 
	 * @param EasyshopordergoodsListDomain
	 * @return ReturnValueDomain<String>
	 */
	@Permission(permission = "easyshop_easyshopordergoods_add")
	@Proxy(method="add", inarg="EasyshopordergoodsListDomain", outarg="ReturnValueDomain<String>")
	@ResponseBody
	@RequestMapping("/add")
	public ReturnValueDomain<String> add(HttpServletRequest request) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		EasyshopordergoodsListDomain easyshopordergoodslistdomain = null;
		 
		try {
			easyshopordergoodslistdomain = JsonUtil.request2Domain(request, EasyshopordergoodsListDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
	
		List<Easyshopordergoods> easyshopordergoodslist= easyshopordergoodslistdomain.getEasyshopordergoodslist();
		
		List<ValidateItem> items = new ArrayList<ValidateItem>();
		items.add(new ValidateItem("ordercode", "订单编号", true, DataType.STRING));
		items.add(new ValidateItem("goodsid", "物品id", true, DataType.STRING));
		ReturnValueDomain<String> validret = ValidateUtil.checkForList(easyshopordergoodslist, items);
		if (validret.isFail()) {
			return validret;
		}

		return easyshopordergoodsservice.add(easyshopordergoodslistdomain);
	 }

	/**
	 * 订单物品关联表修改
	 * @param EasyshopordergoodsListDomain
	 * @return ReturnValueDomain<String>对象
	 */
	@Permission(permission = "easyshop_easyshopordergoods_update")
	@Proxy(method="update", inarg="EasyshopordergoodsListDomain", outarg="ReturnValueDomain<String>")
	@ResponseBody
	@RequestMapping("/update")
	public ReturnValueDomain<String> update(HttpServletRequest request) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		EasyshopordergoodsListDomain easyshopordergoodslistdomain = null;
		  
		try {
			easyshopordergoodslistdomain = JsonUtil.request2Domain(request, EasyshopordergoodsListDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}

		List<Easyshopordergoods> easyshopordergoodslist= easyshopordergoodslistdomain.getEasyshopordergoodslist();
		
		List<ValidateItem> items = new ArrayList<ValidateItem>();
		items.add(new ValidateItem("ordergoodsid", "订单物品关联主键id", true, DataType.STRING));
		items.add(new ValidateItem("ordercode", "订单编号", true, DataType.STRING));
		items.add(new ValidateItem("goodsid", "物品id", true, DataType.STRING));
		ReturnValueDomain<String> validret = ValidateUtil.checkForList(easyshopordergoodslist, items);
		if (validret.isFail()) {
			return validret;
		}

		return easyshopordergoodsservice.update(easyshopordergoodslistdomain);
	}
	
	/**
	 * 订单物品关联表删除
	 * 
	 * @param EasyshopordergoodsListDomain
	 * @return ReturnValueDomain<String>
	 */
	@Permission(permission = "easyshop_easyshopordergoods_delete")
	@Proxy(method="delete", inarg="EasyshopordergoodsListDomain", outarg="ReturnValueDomain<String>")
	@ResponseBody
	@RequestMapping("/delete")
	public ReturnValueDomain<String> delete(HttpServletRequest request) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		EasyshopordergoodsListDomain easyshopordergoodslistdomain = null;
		
		try {
			easyshopordergoodslistdomain = JsonUtil.request2Domain(request, EasyshopordergoodsListDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		List<Easyshopordergoods> easyshopordergoodslist= easyshopordergoodslistdomain.getEasyshopordergoodslist();
		
		List<ValidateItem> items = new ArrayList<ValidateItem>();
		items.add(new ValidateItem("ordergoodsid", "订单物品关联主键id", false, DataType.STRING));
		ReturnValueDomain<String> validret = ValidateUtil.checkForList(easyshopordergoodslist, items);
		if (validret.isFail()) {
			return validret;
		}
		
		return easyshopordergoodsservice.delete(easyshopordergoodslistdomain);
	}
	
	/**
	 * 批量导入订单物品关联表
	 * 
	 * @param SysEntityfile
	 * @return ReturnValueDomain<FileImportResultDomain>对象
	 */
	@Permission(permission = "easyshop_easyshopordergoods_import")
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
		List<Easyshopordergoods> datalist;
		try {
			List<HeaderDomain> headerlist=new ArrayList<HeaderDomain>();
			
			headerlist.add(new HeaderDomain("0", "ordercode", "订单编号"));
			headerlist.add(new HeaderDomain("1", "goodsid", "物品id"));
			
			datalist=ExcelUtil.readExcel(filename, headerlist, Easyshopordergoods.class);
			rowcount=datalist.size();
			
			// 合法性校验
			List<ValidateItem> items = new ArrayList<ValidateItem>();
			items.add(new ValidateItem("ordercode", "订单编号", true, DataType.STRING));
			items.add(new ValidateItem("goodsid", "物品id", true, DataType.STRING));
			
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
		
		EasyshopordergoodsListDomain easyshopordergoodslistdomain=new EasyshopordergoodsListDomain();
		easyshopordergoodslistdomain.setEasyshopordergoodslist(datalist);
		ReturnValueDomain<String> oneret= easyshopordergoodsservice.add(easyshopordergoodslistdomain);
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
	  * @param EasyshopordergoodsQueryDomain
	  * @return ReturnValueDomain<SysEntityfile>对象
	  */
	@Permission(permission = "easyshop_easyshopordergoods_export")
	@Proxy(method="exportExcel", inarg="EasyshopordergoodsQueryDomain", outarg="ReturnValueDomain<SysEntityfile>")
	@ResponseBody
	@RequestMapping("/exportexcel")
	public ReturnValueDomain<SysEntityfile> exportExcel(HttpServletRequest request) {
		ReturnValueDomain<SysEntityfile> ret=new ReturnValueDomain<SysEntityfile>();
		
		EasyshopordergoodsQueryDomain easyshopordergoodsquerydomain = null;
		try {
			easyshopordergoodsquerydomain = JsonUtil.request2Domain(request, EasyshopordergoodsQueryDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		PageParamDomain pageparam=new PageParamDomain();
		pageparam.setRownumperpage(ServerFeature.EXPORT_MAXSIZE);
		pageparam.setPageindex(0);
		easyshopordergoodsquerydomain.setPageparam(pageparam);
		
		ReturnValueDomain<PageDomain<Easyshopordergoods>> queryret = easyshopordergoodsservice.query(easyshopordergoodsquerydomain);
		
		List<Easyshopordergoods> Easyshopordergoodslist = queryret.getObject().getDatalist();
		
		List<HeaderDomain> headerlist = new ArrayList<HeaderDomain>();
		headerlist.add(new HeaderDomain("0", "ordercode", "订单编号"));
		headerlist.add(new HeaderDomain("1", "goodsid", "物品id"));
		
		String filepath=ServerFeature.WEBAPP_HOME + File.separator + "download" + File.separator + DateUtil.getNowTime("yyyyMMdd");
		String filename=UUID.randomUUID().toString() + ".xlsx";
				
		try {
			ExcelUtil.writeExcel(filepath + File.separator + filename, headerlist, Easyshopordergoodslist);
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
