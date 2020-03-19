/**
 * 广告表管理服务接口
 *
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshopnews;

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
import cn.finedo.easyshop.pojo.Easyshopnews;
import cn.finedo.easyshop.service.easyshopnews.domain.EasyshopnewsListDomain;
import cn.finedo.easyshop.service.easyshopnews.domain.EasyshopnewsQueryDomain;

@Controller
@Scope("singleton")
@RequestMapping("service/finedo/easyshopnews")
public class EasyshopnewsServiceAP {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private EasyshopnewsService easyshopnewsservice;
	
	/**
	 * 广告表查询
	 * @param EasyshopnewsQueryDomain
	 * @return ReturnValueDomain<Easyshopnews>对象
	 */
	@Permission(permission = "easyshop_easyshopnews_query")
	@Proxy(method="query", inarg="EasyshopnewsQueryDomain", outarg="ReturnValueDomain<PageDomain<Easyshopnews>>")
	@ResponseBody
	@RequestMapping("/query")
	public ReturnValueDomain<PageDomain<Easyshopnews>> query(HttpServletRequest request) {
		ReturnValueDomain<PageDomain<Easyshopnews>> ret = new ReturnValueDomain<PageDomain<Easyshopnews>>();
		EasyshopnewsQueryDomain easyshopnewsquerydomain = null;
		 
		try {
			easyshopnewsquerydomain = JsonUtil.request2Domain(request, EasyshopnewsQueryDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		return easyshopnewsservice.query(easyshopnewsquerydomain);
	}

	/**
	 * 广告表按主键查询查询
	 * @param Easyshopnews
	 * @return ReturnValueDomain<Easyshopnews>对象
	 */
	@Permission(permission = "easyshop_easyshopnews_query")
	@Proxy(method="queryById", inarg="Easyshopnews", outarg="ReturnValueDomain<Easyshopnews>")
	@ResponseBody
	@RequestMapping("/querybyid")
	public ReturnValueDomain<Easyshopnews> queryById(HttpServletRequest request) {
		ReturnValueDomain<Easyshopnews> ret = new ReturnValueDomain<Easyshopnews>();
		Easyshopnews easyshopnews = null;
		 
		try {
			easyshopnews = JsonUtil.request2Domain(request, Easyshopnews.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		return easyshopnewsservice.queryById(easyshopnews);
	}
	 
	/**
	 * 广告表新增
	 * 
	 * @param EasyshopnewsListDomain
	 * @return ReturnValueDomain<String>
	 */
	@Permission(permission = "easyshop_easyshopnews_add")
	@Proxy(method="add", inarg="EasyshopnewsListDomain", outarg="ReturnValueDomain<String>")
	@ResponseBody
	@RequestMapping("/add")
	public ReturnValueDomain<String> add(HttpServletRequest request) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		EasyshopnewsListDomain easyshopnewslistdomain = null;
		 
		try {
			easyshopnewslistdomain = JsonUtil.request2Domain(request, EasyshopnewsListDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
	
		List<Easyshopnews> easyshopnewslist= easyshopnewslistdomain.getEasyshopnewslist();
		
		List<ValidateItem> items = new ArrayList<ValidateItem>();
		items.add(new ValidateItem("addtime", "添加时间", true, DataType.DATE));
		items.add(new ValidateItem("opttime", "修改时间", true, DataType.DATE));
		items.add(new ValidateItem("detail", "详情", true, DataType.STRING));
		items.add(new ValidateItem("imgid", "banner图", true, DataType.STRING));
		items.add(new ValidateItem("videoid", "视频id", true, DataType.STRING));
		items.add(new ValidateItem("newsname", "广告名称", true, DataType.STRING));
		ReturnValueDomain<String> validret = ValidateUtil.checkForList(easyshopnewslist, items);
		if (validret.isFail()) {
			return validret;
		}

		return easyshopnewsservice.add(easyshopnewslistdomain);
	 }

	/**
	 * 广告表修改
	 * @param EasyshopnewsListDomain
	 * @return ReturnValueDomain<String>对象
	 */
	@Permission(permission = "easyshop_easyshopnews_update")
	@Proxy(method="update", inarg="EasyshopnewsListDomain", outarg="ReturnValueDomain<String>")
	@ResponseBody
	@RequestMapping("/update")
	public ReturnValueDomain<String> update(HttpServletRequest request) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		EasyshopnewsListDomain easyshopnewslistdomain = null;
		  
		try {
			easyshopnewslistdomain = JsonUtil.request2Domain(request, EasyshopnewsListDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}

		List<Easyshopnews> easyshopnewslist= easyshopnewslistdomain.getEasyshopnewslist();
		
		List<ValidateItem> items = new ArrayList<ValidateItem>();
		items.add(new ValidateItem("newsid", "主键id", true, DataType.STRING));
		items.add(new ValidateItem("addtime", "添加时间", true, DataType.DATE));
		items.add(new ValidateItem("opttime", "修改时间", true, DataType.DATE));
		items.add(new ValidateItem("detail", "详情", true, DataType.STRING));
		items.add(new ValidateItem("imgid", "banner图", true, DataType.STRING));
		items.add(new ValidateItem("videoid", "视频id", true, DataType.STRING));
		items.add(new ValidateItem("newsname", "广告名称", true, DataType.STRING));
		ReturnValueDomain<String> validret = ValidateUtil.checkForList(easyshopnewslist, items);
		if (validret.isFail()) {
			return validret;
		}

		return easyshopnewsservice.update(easyshopnewslistdomain);
	}
	
	/**
	 * 广告表删除
	 * 
	 * @param EasyshopnewsListDomain
	 * @return ReturnValueDomain<String>
	 */
	@Permission(permission = "easyshop_easyshopnews_delete")
	@Proxy(method="delete", inarg="EasyshopnewsListDomain", outarg="ReturnValueDomain<String>")
	@ResponseBody
	@RequestMapping("/delete")
	public ReturnValueDomain<String> delete(HttpServletRequest request) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		EasyshopnewsListDomain easyshopnewslistdomain = null;
		
		try {
			easyshopnewslistdomain = JsonUtil.request2Domain(request, EasyshopnewsListDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		List<Easyshopnews> easyshopnewslist= easyshopnewslistdomain.getEasyshopnewslist();
		
		List<ValidateItem> items = new ArrayList<ValidateItem>();
		items.add(new ValidateItem("newsid", "主键id", false, DataType.STRING));
		ReturnValueDomain<String> validret = ValidateUtil.checkForList(easyshopnewslist, items);
		if (validret.isFail()) {
			return validret;
		}
		
		return easyshopnewsservice.delete(easyshopnewslistdomain);
	}
	
	/**
	 * 批量导入广告表
	 * 
	 * @param SysEntityfile
	 * @return ReturnValueDomain<FileImportResultDomain>对象
	 */
	@Permission(permission = "easyshop_easyshopnews_import")
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
		List<Easyshopnews> datalist;
		try {
			List<HeaderDomain> headerlist=new ArrayList<HeaderDomain>();
			
			headerlist.add(new HeaderDomain("0", "addtime", "添加时间"));
			headerlist.add(new HeaderDomain("1", "opttime", "修改时间"));
			headerlist.add(new HeaderDomain("2", "detail", "详情"));
			headerlist.add(new HeaderDomain("3", "imgid", "banner图"));
			headerlist.add(new HeaderDomain("4", "videoid", "视频id"));
			headerlist.add(new HeaderDomain("5", "newsname", "广告名称"));
			
			datalist=ExcelUtil.readExcel(filename, headerlist, Easyshopnews.class);
			rowcount=datalist.size();
			
			// 合法性校验
			List<ValidateItem> items = new ArrayList<ValidateItem>();
			items.add(new ValidateItem("addtime", "添加时间", true, DataType.DATE));
			items.add(new ValidateItem("opttime", "修改时间", true, DataType.DATE));
			items.add(new ValidateItem("detail", "详情", true, DataType.STRING));
			items.add(new ValidateItem("imgid", "banner图", true, DataType.STRING));
			items.add(new ValidateItem("videoid", "视频id", true, DataType.STRING));
			items.add(new ValidateItem("newsname", "广告名称", true, DataType.STRING));
			
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
		
		EasyshopnewsListDomain easyshopnewslistdomain=new EasyshopnewsListDomain();
		easyshopnewslistdomain.setEasyshopnewslist(datalist);
		ReturnValueDomain<String> oneret= easyshopnewsservice.add(easyshopnewslistdomain);
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
	  * @param EasyshopnewsQueryDomain
	  * @return ReturnValueDomain<SysEntityfile>对象
	  */
	@Permission(permission = "easyshop_easyshopnews_export")
	@Proxy(method="exportExcel", inarg="EasyshopnewsQueryDomain", outarg="ReturnValueDomain<SysEntityfile>")
	@ResponseBody
	@RequestMapping("/exportexcel")
	public ReturnValueDomain<SysEntityfile> exportExcel(HttpServletRequest request) {
		ReturnValueDomain<SysEntityfile> ret=new ReturnValueDomain<SysEntityfile>();
		
		EasyshopnewsQueryDomain easyshopnewsquerydomain = null;
		try {
			easyshopnewsquerydomain = JsonUtil.request2Domain(request, EasyshopnewsQueryDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		PageParamDomain pageparam=new PageParamDomain();
		pageparam.setRownumperpage(ServerFeature.EXPORT_MAXSIZE);
		pageparam.setPageindex(0);
		easyshopnewsquerydomain.setPageparam(pageparam);
		
		ReturnValueDomain<PageDomain<Easyshopnews>> queryret = easyshopnewsservice.query(easyshopnewsquerydomain);
		
		List<Easyshopnews> Easyshopnewslist = queryret.getObject().getDatalist();
		
		List<HeaderDomain> headerlist = new ArrayList<HeaderDomain>();
		headerlist.add(new HeaderDomain("0", "addtime", "添加时间"));
		headerlist.add(new HeaderDomain("1", "opttime", "修改时间"));
		headerlist.add(new HeaderDomain("2", "detail", "详情"));
		headerlist.add(new HeaderDomain("3", "imgid", "banner图"));
		headerlist.add(new HeaderDomain("4", "videoid", "视频id"));
		headerlist.add(new HeaderDomain("5", "newsname", "广告名称"));
		
		String filepath=ServerFeature.WEBAPP_HOME + File.separator + "download" + File.separator + DateUtil.getNowTime("yyyyMMdd");
		String filename=UUID.randomUUID().toString() + ".xlsx";
				
		try {
			ExcelUtil.writeExcel(filepath + File.separator + filename, headerlist, Easyshopnewslist);
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
