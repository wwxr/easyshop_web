/**
 * 用户表管理服务接口
 *
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshopuser;

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
import cn.finedo.easyshop.pojo.Easyshopuser;
import cn.finedo.easyshop.service.easyshopuser.domain.EasyshopuserListDomain;
import cn.finedo.easyshop.service.easyshopuser.domain.EasyshopuserQueryDomain;

@Controller
@Scope("singleton")
@RequestMapping("service/finedo/easyshopuser")
public class EasyshopuserServiceAP {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private EasyshopuserService easyshopuserservice;
	
	/**
	 * 用户表查询
	 * @param EasyshopuserQueryDomain
	 * @return ReturnValueDomain<Easyshopuser>对象
	 */
	@Permission(permission = "easyshop_easyshopuser_query")
	@Proxy(method="query", inarg="EasyshopuserQueryDomain", outarg="ReturnValueDomain<PageDomain<Easyshopuser>>")
	@ResponseBody
	@RequestMapping("/query")
	public ReturnValueDomain<PageDomain<Easyshopuser>> query(HttpServletRequest request) {
		ReturnValueDomain<PageDomain<Easyshopuser>> ret = new ReturnValueDomain<PageDomain<Easyshopuser>>();
		EasyshopuserQueryDomain easyshopuserquerydomain = null;
		 
		try {
			easyshopuserquerydomain = JsonUtil.request2Domain(request, EasyshopuserQueryDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		return easyshopuserservice.query(easyshopuserquerydomain);
	}

	/**
	 * 用户表按主键查询查询
	 * @param Easyshopuser
	 * @return ReturnValueDomain<Easyshopuser>对象
	 */
	@Permission(permission = "easyshop_easyshopuser_query")
	@Proxy(method="queryById", inarg="Easyshopuser", outarg="ReturnValueDomain<Easyshopuser>")
	@ResponseBody
	@RequestMapping("/querybyid")
	public ReturnValueDomain<Easyshopuser> queryById(HttpServletRequest request) {
		ReturnValueDomain<Easyshopuser> ret = new ReturnValueDomain<Easyshopuser>();
		Easyshopuser easyshopuser = null;
		 
		try {
			easyshopuser = JsonUtil.request2Domain(request, Easyshopuser.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		return easyshopuserservice.queryById(easyshopuser);
	}
	 
	/**
	 * 用户表新增
	 * 
	 * @param EasyshopuserListDomain
	 * @return ReturnValueDomain<String>
	 */
	@Permission(permission = "easyshop_easyshopuser_add")
	@Proxy(method="add", inarg="EasyshopuserListDomain", outarg="ReturnValueDomain<String>")
	@ResponseBody
	@RequestMapping("/add")
	public ReturnValueDomain<String> add(HttpServletRequest request) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		EasyshopuserListDomain easyshopuserlistdomain = null;
		 
		try {
			easyshopuserlistdomain = JsonUtil.request2Domain(request, EasyshopuserListDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
	
		List<Easyshopuser> easyshopuserlist= easyshopuserlistdomain.getEasyshopuserlist();
		
		List<ValidateItem> items = new ArrayList<ValidateItem>();
		items.add(new ValidateItem("points", "积分", true, DataType.INTEGER));
		items.add(new ValidateItem("openid", "openid", true, DataType.STRING));
		items.add(new ValidateItem("unionid", "unionid", true, DataType.STRING));
		items.add(new ValidateItem("phone", "手机号", true, DataType.STRING));
		items.add(new ValidateItem("promoter", "推广人编码对应二维码", true, DataType.STRING));
		items.add(new ValidateItem("username", "用户姓名", true, DataType.STRING));
		items.add(new ValidateItem("nickname", "昵称", true, DataType.STRING));
		items.add(new ValidateItem("avatar", "头像", true, DataType.STRING));
		items.add(new ValidateItem("promocode", "自己的推广码", true, DataType.STRING));
		items.add(new ValidateItem("registtime", "注册时间", true, DataType.DATE));
		items.add(new ValidateItem("gender", "性别：1-男；0-女", true, DataType.STRING));
		ReturnValueDomain<String> validret = ValidateUtil.checkForList(easyshopuserlist, items);
		if (validret.isFail()) {
			return validret;
		}

		return easyshopuserservice.add(easyshopuserlistdomain);
	 }
	/**
	 * 登录用户新增
	 * 
	 * @param EasyshopuserListDomain
	 * @return ReturnValueDomain<String>
	 */
	@Permission(permission = "easyshop_easyshopuser_add")
	@Proxy(method="addloginuser", inarg="Easyshopuser", outarg="ReturnValueDomain<Easyshopuser>")
	@ResponseBody
	@RequestMapping("/addloginuser")
	public ReturnValueDomain<Easyshopuser> addloginuser(HttpServletRequest request) {
		ReturnValueDomain<Easyshopuser> ret = new ReturnValueDomain<Easyshopuser>();
		Easyshopuser easyshopuser = null;
		
		try {
			easyshopuser = JsonUtil.request2Domain(request, Easyshopuser.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		return easyshopuserservice.addloginuser(easyshopuser);
	}

	/**
	 * 用户表修改
	 * @param EasyshopuserListDomain
	 * @return ReturnValueDomain<String>对象
	 */
	@Permission(permission = "easyshop_easyshopuser_update")
	@Proxy(method="update", inarg="EasyshopuserListDomain", outarg="ReturnValueDomain<String>")
	@ResponseBody
	@RequestMapping("/update")
	public ReturnValueDomain<String> update(HttpServletRequest request) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		EasyshopuserListDomain easyshopuserlistdomain = null;
		  
		try {
			easyshopuserlistdomain = JsonUtil.request2Domain(request, EasyshopuserListDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}

		List<Easyshopuser> easyshopuserlist= easyshopuserlistdomain.getEasyshopuserlist();
		
		List<ValidateItem> items = new ArrayList<ValidateItem>();
		items.add(new ValidateItem("userid", "主键id", true, DataType.STRING));
		items.add(new ValidateItem("points", "积分", true, DataType.INTEGER));
		items.add(new ValidateItem("openid", "openid", true, DataType.STRING));
		items.add(new ValidateItem("unionid", "unionid", true, DataType.STRING));
		items.add(new ValidateItem("phone", "手机号", true, DataType.STRING));
		items.add(new ValidateItem("promoter", "推广人编码对应二维码", true, DataType.STRING));
		items.add(new ValidateItem("username", "用户姓名", true, DataType.STRING));
		items.add(new ValidateItem("nickname", "昵称", true, DataType.STRING));
		items.add(new ValidateItem("avatar", "头像", true, DataType.STRING));
		items.add(new ValidateItem("promocode", "自己的推广码", true, DataType.STRING));
		items.add(new ValidateItem("registtime", "注册时间", true, DataType.DATE));
		items.add(new ValidateItem("gender", "性别：1-男；0-女", true, DataType.STRING));
		ReturnValueDomain<String> validret = ValidateUtil.checkForList(easyshopuserlist, items);
		if (validret.isFail()) {
			return validret;
		}

		return easyshopuserservice.update(easyshopuserlistdomain);
	}
	
	/**
	 * 用户表删除
	 * 
	 * @param EasyshopuserListDomain
	 * @return ReturnValueDomain<String>
	 */
	@Permission(permission = "easyshop_easyshopuser_delete")
	@Proxy(method="delete", inarg="EasyshopuserListDomain", outarg="ReturnValueDomain<String>")
	@ResponseBody
	@RequestMapping("/delete")
	public ReturnValueDomain<String> delete(HttpServletRequest request) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		EasyshopuserListDomain easyshopuserlistdomain = null;
		
		try {
			easyshopuserlistdomain = JsonUtil.request2Domain(request, EasyshopuserListDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		List<Easyshopuser> easyshopuserlist= easyshopuserlistdomain.getEasyshopuserlist();
		
		List<ValidateItem> items = new ArrayList<ValidateItem>();
		items.add(new ValidateItem("userid", "主键id", false, DataType.STRING));
		ReturnValueDomain<String> validret = ValidateUtil.checkForList(easyshopuserlist, items);
		if (validret.isFail()) {
			return validret;
		}
		
		return easyshopuserservice.delete(easyshopuserlistdomain);
	}
	
	/**
	 * 批量导入用户表
	 * 
	 * @param SysEntityfile
	 * @return ReturnValueDomain<FileImportResultDomain>对象
	 */
	@Permission(permission = "easyshop_easyshopuser_import")
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
		List<Easyshopuser> datalist;
		try {
			List<HeaderDomain> headerlist=new ArrayList<HeaderDomain>();
			
			headerlist.add(new HeaderDomain("0", "points", "积分"));
			headerlist.add(new HeaderDomain("1", "openid", "openid"));
			headerlist.add(new HeaderDomain("2", "unionid", "unionid"));
			headerlist.add(new HeaderDomain("3", "phone", "手机号"));
			headerlist.add(new HeaderDomain("4", "promoter", "推广人编码对应二维码"));
			headerlist.add(new HeaderDomain("5", "username", "用户姓名"));
			headerlist.add(new HeaderDomain("6", "nickname", "昵称"));
			headerlist.add(new HeaderDomain("7", "avatar", "头像"));
			headerlist.add(new HeaderDomain("8", "promocode", "自己的推广码"));
			headerlist.add(new HeaderDomain("9", "registtime", "注册时间"));
			headerlist.add(new HeaderDomain("10", "gender", "性别：1-男；0-女"));
			
			datalist=ExcelUtil.readExcel(filename, headerlist, Easyshopuser.class);
			rowcount=datalist.size();
			
			// 合法性校验
			List<ValidateItem> items = new ArrayList<ValidateItem>();
			items.add(new ValidateItem("points", "积分", true, DataType.INTEGER));
			items.add(new ValidateItem("openid", "openid", true, DataType.STRING));
			items.add(new ValidateItem("unionid", "unionid", true, DataType.STRING));
			items.add(new ValidateItem("phone", "手机号", true, DataType.STRING));
			items.add(new ValidateItem("promoter", "推广人编码对应二维码", true, DataType.STRING));
			items.add(new ValidateItem("username", "用户姓名", true, DataType.STRING));
			items.add(new ValidateItem("nickname", "昵称", true, DataType.STRING));
			items.add(new ValidateItem("avatar", "头像", true, DataType.STRING));
			items.add(new ValidateItem("promocode", "自己的推广码", true, DataType.STRING));
			items.add(new ValidateItem("registtime", "注册时间", true, DataType.DATE));
			items.add(new ValidateItem("gender", "性别：1-男；0-女", true, DataType.STRING));
			
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
		
		EasyshopuserListDomain easyshopuserlistdomain=new EasyshopuserListDomain();
		easyshopuserlistdomain.setEasyshopuserlist(datalist);
		ReturnValueDomain<String> oneret= easyshopuserservice.add(easyshopuserlistdomain);
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
	  * @param EasyshopuserQueryDomain
	  * @return ReturnValueDomain<SysEntityfile>对象
	  */
	@Permission(permission = "easyshop_easyshopuser_export")
	@Proxy(method="exportExcel", inarg="EasyshopuserQueryDomain", outarg="ReturnValueDomain<SysEntityfile>")
	@ResponseBody
	@RequestMapping("/exportexcel")
	public ReturnValueDomain<SysEntityfile> exportExcel(HttpServletRequest request) {
		ReturnValueDomain<SysEntityfile> ret=new ReturnValueDomain<SysEntityfile>();
		
		EasyshopuserQueryDomain easyshopuserquerydomain = null;
		try {
			easyshopuserquerydomain = JsonUtil.request2Domain(request, EasyshopuserQueryDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		PageParamDomain pageparam=new PageParamDomain();
		pageparam.setRownumperpage(ServerFeature.EXPORT_MAXSIZE);
		pageparam.setPageindex(0);
		easyshopuserquerydomain.setPageparam(pageparam);
		
		ReturnValueDomain<PageDomain<Easyshopuser>> queryret = easyshopuserservice.query(easyshopuserquerydomain);
		
		List<Easyshopuser> Easyshopuserlist = queryret.getObject().getDatalist();
		
		List<HeaderDomain> headerlist = new ArrayList<HeaderDomain>();
		headerlist.add(new HeaderDomain("0", "points", "积分"));
		headerlist.add(new HeaderDomain("1", "openid", "openid"));
		headerlist.add(new HeaderDomain("2", "unionid", "unionid"));
		headerlist.add(new HeaderDomain("3", "phone", "手机号"));
		headerlist.add(new HeaderDomain("4", "promoter", "推广人编码对应二维码"));
		headerlist.add(new HeaderDomain("5", "username", "用户姓名"));
		headerlist.add(new HeaderDomain("6", "nickname", "昵称"));
		headerlist.add(new HeaderDomain("7", "avatar", "头像"));
		headerlist.add(new HeaderDomain("8", "promocode", "自己的推广码"));
		headerlist.add(new HeaderDomain("9", "registtime", "注册时间"));
		headerlist.add(new HeaderDomain("10", "gender", "性别：1-男；0-女"));
		
		String filepath=ServerFeature.WEBAPP_HOME + File.separator + "download" + File.separator + DateUtil.getNowTime("yyyyMMdd");
		String filename=UUID.randomUUID().toString() + ".xlsx";
				
		try {
			ExcelUtil.writeExcel(filepath + File.separator + filename, headerlist, Easyshopuserlist);
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
