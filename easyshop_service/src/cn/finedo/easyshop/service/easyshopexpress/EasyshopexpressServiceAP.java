/**
 * 物流表管理服务接口
 *
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshopexpress;

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
import cn.finedo.easyshop.pojo.Easyshopexpress;
import cn.finedo.easyshop.service.easyshopexpress.domain.EasyshopexpressListDomain;
import cn.finedo.easyshop.service.easyshopexpress.domain.EasyshopexpressQueryDomain;

@Controller
@Scope("singleton")
@RequestMapping("service/finedo/easyshopexpress")
public class EasyshopexpressServiceAP {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private EasyshopexpressService easyshopexpressservice;
	
	/**
	 * 物流表查询
	 * @param EasyshopexpressQueryDomain
	 * @return ReturnValueDomain<Easyshopexpress>对象
	 */
	@Permission(permission = "easyshop_easyshopexpress_query")
	@Proxy(method="query", inarg="EasyshopexpressQueryDomain", outarg="ReturnValueDomain<PageDomain<Easyshopexpress>>")
	@ResponseBody
	@RequestMapping("/query")
	public ReturnValueDomain<PageDomain<Easyshopexpress>> query(HttpServletRequest request) {
		ReturnValueDomain<PageDomain<Easyshopexpress>> ret = new ReturnValueDomain<PageDomain<Easyshopexpress>>();
		EasyshopexpressQueryDomain easyshopexpressquerydomain = null;
		 
		try {
			easyshopexpressquerydomain = JsonUtil.request2Domain(request, EasyshopexpressQueryDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		return easyshopexpressservice.query(easyshopexpressquerydomain);
	}

	/**
	 * 物流表按主键查询查询
	 * @param Easyshopexpress
	 * @return ReturnValueDomain<Easyshopexpress>对象
	 */
	@Permission(permission = "easyshop_easyshopexpress_query")
	@Proxy(method="queryById", inarg="Easyshopexpress", outarg="ReturnValueDomain<Easyshopexpress>")
	@ResponseBody
	@RequestMapping("/querybyid")
	public ReturnValueDomain<Easyshopexpress> queryById(HttpServletRequest request) {
		ReturnValueDomain<Easyshopexpress> ret = new ReturnValueDomain<Easyshopexpress>();
		Easyshopexpress easyshopexpress = null;
		 
		try {
			easyshopexpress = JsonUtil.request2Domain(request, Easyshopexpress.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		return easyshopexpressservice.queryById(easyshopexpress);
	}
	 
	/**
	 * 物流表新增
	 * 
	 * @param EasyshopexpressListDomain
	 * @return ReturnValueDomain<String>
	 */
	@Permission(permission = "easyshop_easyshopexpress_add")
	@Proxy(method="add", inarg="EasyshopexpressListDomain", outarg="ReturnValueDomain<String>")
	@ResponseBody
	@RequestMapping("/add")
	public ReturnValueDomain<String> add(HttpServletRequest request) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		EasyshopexpressListDomain easyshopexpresslistdomain = null;
		 
		try {
			easyshopexpresslistdomain = JsonUtil.request2Domain(request, EasyshopexpressListDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
	
		List<Easyshopexpress> easyshopexpresslist= easyshopexpresslistdomain.getEasyshopexpresslist();
		
		List<ValidateItem> items = new ArrayList<ValidateItem>();
		items.add(new ValidateItem("shippername", "物流名称", true, DataType.STRING));
		ReturnValueDomain<String> validret = ValidateUtil.checkForList(easyshopexpresslist, items);
		if (validret.isFail()) {
			return validret;
		}

		return easyshopexpressservice.add(easyshopexpresslistdomain);
	 }

	/**
	 * 物流表修改
	 * @param EasyshopexpressListDomain
	 * @return ReturnValueDomain<String>对象
	 */
	@Permission(permission = "easyshop_easyshopexpress_update")
	@Proxy(method="update", inarg="EasyshopexpressListDomain", outarg="ReturnValueDomain<String>")
	@ResponseBody
	@RequestMapping("/update")
	public ReturnValueDomain<String> update(HttpServletRequest request) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		EasyshopexpressListDomain easyshopexpresslistdomain = null;
		  
		try {
			easyshopexpresslistdomain = JsonUtil.request2Domain(request, EasyshopexpressListDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}

		List<Easyshopexpress> easyshopexpresslist= easyshopexpresslistdomain.getEasyshopexpresslist();
		
		List<ValidateItem> items = new ArrayList<ValidateItem>();
		items.add(new ValidateItem("shippercode", "物流编号", true, DataType.STRING));
		items.add(new ValidateItem("shippername", "物流名称", true, DataType.STRING));
		ReturnValueDomain<String> validret = ValidateUtil.checkForList(easyshopexpresslist, items);
		if (validret.isFail()) {
			return validret;
		}

		return easyshopexpressservice.update(easyshopexpresslistdomain);
	}
	
	/**
	 * 物流表删除
	 * 
	 * @param EasyshopexpressListDomain
	 * @return ReturnValueDomain<String>
	 */
	@Permission(permission = "easyshop_easyshopexpress_delete")
	@Proxy(method="delete", inarg="EasyshopexpressListDomain", outarg="ReturnValueDomain<String>")
	@ResponseBody
	@RequestMapping("/delete")
	public ReturnValueDomain<String> delete(HttpServletRequest request) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		EasyshopexpressListDomain easyshopexpresslistdomain = null;
		
		try {
			easyshopexpresslistdomain = JsonUtil.request2Domain(request, EasyshopexpressListDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		List<Easyshopexpress> easyshopexpresslist= easyshopexpresslistdomain.getEasyshopexpresslist();
		
		List<ValidateItem> items = new ArrayList<ValidateItem>();
		items.add(new ValidateItem("shippercode", "物流编号", false, DataType.STRING));
		ReturnValueDomain<String> validret = ValidateUtil.checkForList(easyshopexpresslist, items);
		if (validret.isFail()) {
			return validret;
		}
		
		return easyshopexpressservice.delete(easyshopexpresslistdomain);
	}
	
	/**
	 * 批量导入物流表
	 * 
	 * @param SysEntityfile
	 * @return ReturnValueDomain<FileImportResultDomain>对象
	 */
	@Permission(permission = "easyshop_easyshopexpress_import")
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
		List<Easyshopexpress> datalist;
		try {
			List<HeaderDomain> headerlist=new ArrayList<HeaderDomain>();
			
			headerlist.add(new HeaderDomain("0", "shippername", "物流名称"));
			
			datalist=ExcelUtil.readExcel(filename, headerlist, Easyshopexpress.class);
			rowcount=datalist.size();
			
			// 合法性校验
			List<ValidateItem> items = new ArrayList<ValidateItem>();
			items.add(new ValidateItem("shippername", "物流名称", true, DataType.STRING));
			
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
		
		EasyshopexpressListDomain easyshopexpresslistdomain=new EasyshopexpressListDomain();
		easyshopexpresslistdomain.setEasyshopexpresslist(datalist);
		ReturnValueDomain<String> oneret= easyshopexpressservice.add(easyshopexpresslistdomain);
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
	  * @param EasyshopexpressQueryDomain
	  * @return ReturnValueDomain<SysEntityfile>对象
	  */
	@Permission(permission = "easyshop_easyshopexpress_export")
	@Proxy(method="exportExcel", inarg="EasyshopexpressQueryDomain", outarg="ReturnValueDomain<SysEntityfile>")
	@ResponseBody
	@RequestMapping("/exportexcel")
	public ReturnValueDomain<SysEntityfile> exportExcel(HttpServletRequest request) {
		ReturnValueDomain<SysEntityfile> ret=new ReturnValueDomain<SysEntityfile>();
		
		EasyshopexpressQueryDomain easyshopexpressquerydomain = null;
		try {
			easyshopexpressquerydomain = JsonUtil.request2Domain(request, EasyshopexpressQueryDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		PageParamDomain pageparam=new PageParamDomain();
		pageparam.setRownumperpage(ServerFeature.EXPORT_MAXSIZE);
		pageparam.setPageindex(0);
		easyshopexpressquerydomain.setPageparam(pageparam);
		
		ReturnValueDomain<PageDomain<Easyshopexpress>> queryret = easyshopexpressservice.query(easyshopexpressquerydomain);
		
		List<Easyshopexpress> Easyshopexpresslist = queryret.getObject().getDatalist();
		
		List<HeaderDomain> headerlist = new ArrayList<HeaderDomain>();
		headerlist.add(new HeaderDomain("0", "shippername", "物流名称"));
		
		String filepath=ServerFeature.WEBAPP_HOME + File.separator + "download" + File.separator + DateUtil.getNowTime("yyyyMMdd");
		String filename=UUID.randomUUID().toString() + ".xlsx";
				
		try {
			ExcelUtil.writeExcel(filepath + File.separator + filename, headerlist, Easyshopexpresslist);
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
