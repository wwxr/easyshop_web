/**
 * 订单表管理服务接口
 *
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshoporder;

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
import cn.finedo.easyshop.pojo.Easyshoporder;
import cn.finedo.easyshop.service.easyshoporder.domain.EasyshoporderListDomain;
import cn.finedo.easyshop.service.easyshoporder.domain.EasyshoporderQueryDomain;

@Controller
@Scope("singleton")
@RequestMapping("service/finedo/easyshoporder")
public class EasyshoporderServiceAP {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private EasyshoporderService easyshoporderservice;
	
	/**
	 * 订单表查询
	 * @param EasyshoporderQueryDomain
	 * @return ReturnValueDomain<Easyshoporder>对象
	 */
	@Permission(permission = "easyshop_easyshoporder_query")
	@Proxy(method="query", inarg="EasyshoporderQueryDomain", outarg="ReturnValueDomain<PageDomain<Easyshoporder>>")
	@ResponseBody
	@RequestMapping("/query")
	public ReturnValueDomain<PageDomain<Easyshoporder>> query(HttpServletRequest request) {
		ReturnValueDomain<PageDomain<Easyshoporder>> ret = new ReturnValueDomain<PageDomain<Easyshoporder>>();
		EasyshoporderQueryDomain easyshoporderquerydomain = null;
		 
		try {
			easyshoporderquerydomain = JsonUtil.request2Domain(request, EasyshoporderQueryDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		return easyshoporderservice.query(easyshoporderquerydomain);
	}
	/**
	 *小程序订单查询
	 * @param EasyshoporderQueryDomain
	 * @return ReturnValueDomain<Easyshoporder>对象
	 */
	@Permission(permission = "easyshop_easyshoporder_query")
	@Proxy(method="queryList", inarg="EasyshoporderQueryDomain", outarg="ReturnValueDomain<PageDomain<Easyshoporder>>")
	@ResponseBody
	@RequestMapping("/queryList")
	public ReturnValueDomain<PageDomain<Easyshoporder>> queryList(HttpServletRequest request) {
		ReturnValueDomain<PageDomain<Easyshoporder>> ret = new ReturnValueDomain<PageDomain<Easyshoporder>>();
		EasyshoporderQueryDomain easyshoporderquerydomain = null;
		
		try {
			easyshoporderquerydomain = JsonUtil.request2Domain(request, EasyshoporderQueryDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		ret=easyshoporderservice.queryList(easyshoporderquerydomain);
		return ret;
	}
	/**
	 *小程序我的推广订单查询
	 * @param EasyshoporderQueryDomain
	 * @return ReturnValueDomain<Easyshoporder>对象
	 */
	@Permission(permission = "easyshop_easyshoporder_query")
	@Proxy(method="queryLowerList", inarg="EasyshoporderQueryDomain", outarg="ReturnValueDomain<PageDomain<Easyshoporder>>")
	@ResponseBody
	@RequestMapping("/queryLowerList")
	public ReturnValueDomain<PageDomain<Easyshoporder>> queryLowerList(HttpServletRequest request) {
		ReturnValueDomain<PageDomain<Easyshoporder>> ret = new ReturnValueDomain<PageDomain<Easyshoporder>>();
		EasyshoporderQueryDomain easyshoporderquerydomain = null;
		
		try {
			easyshoporderquerydomain = JsonUtil.request2Domain(request, EasyshoporderQueryDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		ret=easyshoporderservice.queryLowerList(easyshoporderquerydomain);
		return ret;
	}

	/**
	 * 订单表按主键查询查询
	 * @param Easyshoporder
	 * @return ReturnValueDomain<Easyshoporder>对象
	 */
	@Permission(permission = "easyshop_easyshoporder_query")
	@Proxy(method="queryById", inarg="Easyshoporder", outarg="ReturnValueDomain<Easyshoporder>")
	@ResponseBody
	@RequestMapping("/querybyid")
	public ReturnValueDomain<Easyshoporder> queryById(HttpServletRequest request) {
		ReturnValueDomain<Easyshoporder> ret = new ReturnValueDomain<Easyshoporder>();
		Easyshoporder easyshoporder = null;
		 
		try {
			easyshoporder = JsonUtil.request2Domain(request, Easyshoporder.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		return easyshoporderservice.queryById(easyshoporder);
	}
	 
	/**
	 * 订单表新增
	 * 
	 * @param EasyshoporderListDomain
	 * @return ReturnValueDomain<String>
	 */
	@Permission(permission = "easyshop_easyshoporder_add")
	@Proxy(method="add", inarg="EasyshoporderListDomain", outarg="ReturnValueDomain<String>")
	@ResponseBody
	@RequestMapping("/add")
	public ReturnValueDomain<String> add(HttpServletRequest request) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		EasyshoporderListDomain easyshoporderlistdomain = null;
		 
		try {
			easyshoporderlistdomain = JsonUtil.request2Domain(request, EasyshoporderListDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
	
		List<Easyshoporder> easyshoporderlist= easyshoporderlistdomain.getEasyshoporderlist();
		
		List<ValidateItem> items = new ArrayList<ValidateItem>();
		items.add(new ValidateItem("userid", "用户id", true, DataType.STRING));
		items.add(new ValidateItem("orderstate", "订单状态：待付款-nopay;已付款-payed;invalid-已失效", true, DataType.STRING));
		items.add(new ValidateItem("shippercode", "快递公司编码", true, DataType.STRING));
		items.add(new ValidateItem("logisticcode", "物流单号", true, DataType.STRING));
		items.add(new ValidateItem("isinvalid", "是否失效：Y-是；N-否", true, DataType.STRING));
		items.add(new ValidateItem("paytime", "支付时间", true, DataType.DATE));
		items.add(new ValidateItem("createtime", "创建时间", true, DataType.DATE));
		items.add(new ValidateItem("ordermoney", "订单金额", true, DataType.STRING));
		items.add(new ValidateItem("ispay", "是否支付:Y-是；N-否", true, DataType.STRING));
		ReturnValueDomain<String> validret = ValidateUtil.checkForList(easyshoporderlist, items);
		if (validret.isFail()) {
			return validret;
		}

		return easyshoporderservice.add(easyshoporderlistdomain);
	 }

	/**
	 * 订单表修改
	 * @param EasyshoporderListDomain
	 * @return ReturnValueDomain<String>对象
	 */
	@Permission(permission = "easyshop_easyshoporder_update")
	@Proxy(method="update", inarg="EasyshoporderListDomain", outarg="ReturnValueDomain<String>")
	@ResponseBody
	@RequestMapping("/update")
	public ReturnValueDomain<String> update(HttpServletRequest request) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		EasyshoporderListDomain easyshoporderlistdomain = null;
		  
		try {
			easyshoporderlistdomain = JsonUtil.request2Domain(request, EasyshoporderListDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}

		List<Easyshoporder> easyshoporderlist= easyshoporderlistdomain.getEasyshoporderlist();
		
		List<ValidateItem> items = new ArrayList<ValidateItem>();
		items.add(new ValidateItem("ordercode", "主键id", true, DataType.STRING));
		items.add(new ValidateItem("userid", "用户id", true, DataType.STRING));
		items.add(new ValidateItem("orderstate", "订单状态：待付款-nopay;已付款-payed;invalid-已失效", true, DataType.STRING));
		items.add(new ValidateItem("shippercode", "快递公司编码", true, DataType.STRING));
		items.add(new ValidateItem("logisticcode", "物流单号", true, DataType.STRING));
		items.add(new ValidateItem("isinvalid", "是否失效：Y-是；N-否", true, DataType.STRING));
		items.add(new ValidateItem("paytime", "支付时间", true, DataType.DATE));
		items.add(new ValidateItem("createtime", "创建时间", true, DataType.DATE));
		items.add(new ValidateItem("ordermoney", "订单金额", true, DataType.STRING));
		items.add(new ValidateItem("ispay", "是否支付:Y-是；N-否", true, DataType.STRING));
		ReturnValueDomain<String> validret = ValidateUtil.checkForList(easyshoporderlist, items);
		if (validret.isFail()) {
			return validret;
		}

		return easyshoporderservice.update(easyshoporderlistdomain);
	}
	
	/**
	 * 订单表删除
	 * 
	 * @param EasyshoporderListDomain
	 * @return ReturnValueDomain<String>
	 */
	@Permission(permission = "easyshop_easyshoporder_delete")
	@Proxy(method="delete", inarg="EasyshoporderListDomain", outarg="ReturnValueDomain<String>")
	@ResponseBody
	@RequestMapping("/delete")
	public ReturnValueDomain<String> delete(HttpServletRequest request) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		EasyshoporderListDomain easyshoporderlistdomain = null;
		
		try {
			easyshoporderlistdomain = JsonUtil.request2Domain(request, EasyshoporderListDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		List<Easyshoporder> easyshoporderlist= easyshoporderlistdomain.getEasyshoporderlist();
		
		List<ValidateItem> items = new ArrayList<ValidateItem>();
		items.add(new ValidateItem("ordercode", "主键id", false, DataType.STRING));
		ReturnValueDomain<String> validret = ValidateUtil.checkForList(easyshoporderlist, items);
		if (validret.isFail()) {
			return validret;
		}
		
		return easyshoporderservice.delete(easyshoporderlistdomain);
	}
	
	/**
	 * 批量导入订单表
	 * 
	 * @param SysEntityfile
	 * @return ReturnValueDomain<FileImportResultDomain>对象
	 */
	@Permission(permission = "easyshop_easyshoporder_import")
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
		List<Easyshoporder> datalist;
		try {
			List<HeaderDomain> headerlist=new ArrayList<HeaderDomain>();
			
			headerlist.add(new HeaderDomain("0", "userid", "用户id"));
			headerlist.add(new HeaderDomain("1", "orderstate", "订单状态：待付款-nopay;已付款-payed;invalid-已失效"));
			headerlist.add(new HeaderDomain("2", "shippercode", "快递公司编码"));
			headerlist.add(new HeaderDomain("3", "logisticcode", "物流单号"));
			headerlist.add(new HeaderDomain("4", "isinvalid", "是否失效：Y-是；N-否"));
			headerlist.add(new HeaderDomain("5", "paytime", "支付时间"));
			headerlist.add(new HeaderDomain("6", "createtime", "创建时间"));
			headerlist.add(new HeaderDomain("7", "ordermoney", "订单金额"));
			headerlist.add(new HeaderDomain("8", "ispay", "是否支付:Y-是；N-否"));
			
			datalist=ExcelUtil.readExcel(filename, headerlist, Easyshoporder.class);
			rowcount=datalist.size();
			
			// 合法性校验
			List<ValidateItem> items = new ArrayList<ValidateItem>();
			items.add(new ValidateItem("userid", "用户id", true, DataType.STRING));
			items.add(new ValidateItem("orderstate", "订单状态：待付款-nopay;已付款-payed;invalid-已失效", true, DataType.STRING));
			items.add(new ValidateItem("shippercode", "快递公司编码", true, DataType.STRING));
			items.add(new ValidateItem("logisticcode", "物流单号", true, DataType.STRING));
			items.add(new ValidateItem("isinvalid", "是否失效：Y-是；N-否", true, DataType.STRING));
			items.add(new ValidateItem("paytime", "支付时间", true, DataType.DATE));
			items.add(new ValidateItem("createtime", "创建时间", true, DataType.DATE));
			items.add(new ValidateItem("ordermoney", "订单金额", true, DataType.STRING));
			items.add(new ValidateItem("ispay", "是否支付:Y-是；N-否", true, DataType.STRING));
			
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
		
		EasyshoporderListDomain easyshoporderlistdomain=new EasyshoporderListDomain();
		easyshoporderlistdomain.setEasyshoporderlist(datalist);
		ReturnValueDomain<String> oneret= easyshoporderservice.add(easyshoporderlistdomain);
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
	  * @param EasyshoporderQueryDomain
	  * @return ReturnValueDomain<SysEntityfile>对象
	  */
	@Permission(permission = "easyshop_easyshoporder_export")
	@Proxy(method="exportExcel", inarg="EasyshoporderQueryDomain", outarg="ReturnValueDomain<SysEntityfile>")
	@ResponseBody
	@RequestMapping("/exportexcel")
	public ReturnValueDomain<SysEntityfile> exportExcel(HttpServletRequest request) {
		ReturnValueDomain<SysEntityfile> ret=new ReturnValueDomain<SysEntityfile>();
		
		EasyshoporderQueryDomain easyshoporderquerydomain = null;
		try {
			easyshoporderquerydomain = JsonUtil.request2Domain(request, EasyshoporderQueryDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		PageParamDomain pageparam=new PageParamDomain();
		pageparam.setRownumperpage(ServerFeature.EXPORT_MAXSIZE);
		pageparam.setPageindex(0);
		easyshoporderquerydomain.setPageparam(pageparam);
		
		ReturnValueDomain<PageDomain<Easyshoporder>> queryret = easyshoporderservice.query(easyshoporderquerydomain);
		
		List<Easyshoporder> Easyshoporderlist = queryret.getObject().getDatalist();
		
		List<HeaderDomain> headerlist = new ArrayList<HeaderDomain>();
		headerlist.add(new HeaderDomain("0", "userid", "用户id"));
		headerlist.add(new HeaderDomain("1", "orderstate", "订单状态：待付款-nopay;已付款-payed;invalid-已失效"));
		headerlist.add(new HeaderDomain("2", "shippercode", "快递公司编码"));
		headerlist.add(new HeaderDomain("3", "logisticcode", "物流单号"));
		headerlist.add(new HeaderDomain("4", "isinvalid", "是否失效：Y-是；N-否"));
		headerlist.add(new HeaderDomain("5", "paytime", "支付时间"));
		headerlist.add(new HeaderDomain("6", "createtime", "创建时间"));
		headerlist.add(new HeaderDomain("7", "ordermoney", "订单金额"));
		headerlist.add(new HeaderDomain("8", "ispay", "是否支付:Y-是；N-否"));
		
		String filepath=ServerFeature.WEBAPP_HOME + File.separator + "download" + File.separator + DateUtil.getNowTime("yyyyMMdd");
		String filename=UUID.randomUUID().toString() + ".xlsx";
				
		try {
			ExcelUtil.writeExcel(filepath + File.separator + filename, headerlist, Easyshoporderlist);
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
