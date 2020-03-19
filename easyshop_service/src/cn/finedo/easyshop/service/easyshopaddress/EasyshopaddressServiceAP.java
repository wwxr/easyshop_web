/**
 * 咨询表管理服务接口
 *
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshopaddress;

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
import cn.finedo.easyshop.pojo.Easyshopaddress;
import cn.finedo.easyshop.service.easyshopaddress.domain.EasyshopaddressListDomain;
import cn.finedo.easyshop.service.easyshopaddress.domain.EasyshopaddressQueryDomain;

@Controller
@Scope("singleton")
@RequestMapping("service/finedo/easyshopaddress")
public class EasyshopaddressServiceAP {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private EasyshopaddressService easyshopaddressservice;
	
	/**
	 * 咨询表查询
	 * @param EasyshopaddressQueryDomain
	 * @return ReturnValueDomain<Easyshopaddress>对象
	 */
	@Permission(permission = "easyshop_easyshopaddress_query")
	@Proxy(method="query", inarg="EasyshopaddressQueryDomain", outarg="ReturnValueDomain<PageDomain<Easyshopaddress>>")
	@ResponseBody
	@RequestMapping("/query")
	public ReturnValueDomain<PageDomain<Easyshopaddress>> query(HttpServletRequest request) {
		ReturnValueDomain<PageDomain<Easyshopaddress>> ret = new ReturnValueDomain<PageDomain<Easyshopaddress>>();
		EasyshopaddressQueryDomain easyshopaddressquerydomain = null;
		 
		try {
			easyshopaddressquerydomain = JsonUtil.request2Domain(request, EasyshopaddressQueryDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		return easyshopaddressservice.query(easyshopaddressquerydomain);
	}

	/**
	 * 咨询表按主键查询查询
	 * @param Easyshopaddress
	 * @return ReturnValueDomain<Easyshopaddress>对象
	 */
	@Permission(permission = "easyshop_easyshopaddress_query")
	@Proxy(method="queryById", inarg="Easyshopaddress", outarg="ReturnValueDomain<Easyshopaddress>")
	@ResponseBody
	@RequestMapping("/querybyid")
	public ReturnValueDomain<Easyshopaddress> queryById(HttpServletRequest request) {
		ReturnValueDomain<Easyshopaddress> ret = new ReturnValueDomain<Easyshopaddress>();
		Easyshopaddress easyshopaddress = null;
		 
		try {
			easyshopaddress = JsonUtil.request2Domain(request, Easyshopaddress.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		return easyshopaddressservice.queryById(easyshopaddress);
	}
	 
	/**
	 * 咨询表新增
	 * 
	 * @param EasyshopaddressListDomain
	 * @return ReturnValueDomain<String>
	 */
	@Permission(permission = "easyshop_easyshopaddress_add")
	@Proxy(method="add", inarg="EasyshopaddressListDomain", outarg="ReturnValueDomain<String>")
	@ResponseBody
	@RequestMapping("/add")
	public ReturnValueDomain<String> add(HttpServletRequest request) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		EasyshopaddressListDomain easyshopaddresslistdomain = null;
		 
		try {
			easyshopaddresslistdomain = JsonUtil.request2Domain(request, EasyshopaddressListDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}

		return easyshopaddressservice.add(easyshopaddresslistdomain);
	 }

	/**
	 * 咨询表修改
	 * @param EasyshopaddressListDomain
	 * @return ReturnValueDomain<String>对象
	 */
	@Permission(permission = "easyshop_easyshopaddress_update")
	@Proxy(method="update", inarg="EasyshopaddressListDomain", outarg="ReturnValueDomain<String>")
	@ResponseBody
	@RequestMapping("/update")
	public ReturnValueDomain<String> update(HttpServletRequest request) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		EasyshopaddressListDomain easyshopaddresslistdomain = null;
		  
		try {
			easyshopaddresslistdomain = JsonUtil.request2Domain(request, EasyshopaddressListDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}

		return easyshopaddressservice.update(easyshopaddresslistdomain);
	}
	
	/**
	 * 咨询表删除
	 * 
	 * @param EasyshopaddressListDomain
	 * @return ReturnValueDomain<String>
	 */
	@Permission(permission = "easyshop_easyshopaddress_delete")
	@Proxy(method="delete", inarg="EasyshopaddressListDomain", outarg="ReturnValueDomain<String>")
	@ResponseBody
	@RequestMapping("/delete")
	public ReturnValueDomain<String> delete(HttpServletRequest request) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		EasyshopaddressListDomain easyshopaddresslistdomain = null;
		
		try {
			easyshopaddresslistdomain = JsonUtil.request2Domain(request, EasyshopaddressListDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		List<Easyshopaddress> easyshopaddresslist= easyshopaddresslistdomain.getEasyshopaddresslist();
		
		List<ValidateItem> items = new ArrayList<ValidateItem>();
		items.add(new ValidateItem("addressid", "咨询主键", false, DataType.STRING));
		ReturnValueDomain<String> validret = ValidateUtil.checkForList(easyshopaddresslist, items);
		if (validret.isFail()) {
			return validret;
		}
		
		return easyshopaddressservice.delete(easyshopaddresslistdomain);
	}
	
	/**
	 * 批量导入咨询表
	 * 
	 * @param SysEntityfile
	 * @return ReturnValueDomain<FileImportResultDomain>对象
	 */
	@Permission(permission = "easyshop_easyshopaddress_import")
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
		List<Easyshopaddress> datalist;
		try {
			List<HeaderDomain> headerlist=new ArrayList<HeaderDomain>();
			
			headerlist.add(new HeaderDomain("0", "userid", "用户id"));
			headerlist.add(new HeaderDomain("1", "businessid", "商家id"));
			headerlist.add(new HeaderDomain("2", "detail", "咨询内容：以json格式存储-{userid:..,time:...,text:...}"));
			headerlist.add(new HeaderDomain("3", "createtime", "创建时间"));
			
			datalist=ExcelUtil.readExcel(filename, headerlist, Easyshopaddress.class);
			rowcount=datalist.size();
			
			// 合法性校验
			List<ValidateItem> items = new ArrayList<ValidateItem>();
			items.add(new ValidateItem("userid", "用户id", true, DataType.STRING));
			items.add(new ValidateItem("businessid", "商家id", true, DataType.STRING));
			items.add(new ValidateItem("detail", "咨询内容：以json格式存储-{userid:..,time:...,text:...}", true, DataType.STRING));
			items.add(new ValidateItem("createtime", "创建时间", true, DataType.DATE));
			
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
		
		EasyshopaddressListDomain easyshopaddresslistdomain=new EasyshopaddressListDomain();
		easyshopaddresslistdomain.setEasyshopaddresslist(datalist);
		ReturnValueDomain<String> oneret= easyshopaddressservice.add(easyshopaddresslistdomain);
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
	  * @param EasyshopaddressQueryDomain
	  * @return ReturnValueDomain<SysEntityfile>对象
	  */
	@Permission(permission = "easyshop_easyshopaddress_export")
	@Proxy(method="exportExcel", inarg="EasyshopaddressQueryDomain", outarg="ReturnValueDomain<SysEntityfile>")
	@ResponseBody
	@RequestMapping("/exportexcel")
	public ReturnValueDomain<SysEntityfile> exportExcel(HttpServletRequest request) {
		ReturnValueDomain<SysEntityfile> ret=new ReturnValueDomain<SysEntityfile>();
		
		EasyshopaddressQueryDomain easyshopaddressquerydomain = null;
		try {
			easyshopaddressquerydomain = JsonUtil.request2Domain(request, EasyshopaddressQueryDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		PageParamDomain pageparam=new PageParamDomain();
		pageparam.setRownumperpage(ServerFeature.EXPORT_MAXSIZE);
		pageparam.setPageindex(0);
		easyshopaddressquerydomain.setPageparam(pageparam);
		
		ReturnValueDomain<PageDomain<Easyshopaddress>> queryret = easyshopaddressservice.query(easyshopaddressquerydomain);
		
		List<Easyshopaddress> Easyshopaddresslist = queryret.getObject().getDatalist();
		
		List<HeaderDomain> headerlist = new ArrayList<HeaderDomain>();
		headerlist.add(new HeaderDomain("0", "userid", "用户id"));
		headerlist.add(new HeaderDomain("1", "businessid", "商家id"));
		headerlist.add(new HeaderDomain("2", "detail", "咨询内容：以json格式存储-{userid:..,time:...,text:...}"));
		headerlist.add(new HeaderDomain("3", "createtime", "创建时间"));
		
		String filepath=ServerFeature.WEBAPP_HOME + File.separator + "download" + File.separator + DateUtil.getNowTime("yyyyMMdd");
		String filename=UUID.randomUUID().toString() + ".xlsx";
				
		try {
			ExcelUtil.writeExcel(filepath + File.separator + filename, headerlist, Easyshopaddresslist);
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
