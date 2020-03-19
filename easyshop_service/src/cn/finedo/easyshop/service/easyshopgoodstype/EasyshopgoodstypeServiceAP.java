/**
 * 商品类型管理服务接口
 *
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshopgoodstype;

import java.io.File;
import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;
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
import cn.finedo.common.non.NonUtil;
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
import cn.finedo.easyshop.pojo.Easyshopgoodstype;
import cn.finedo.easyshop.pojo.ResultGoodsType;
import cn.finedo.easyshop.service.easyshopgoodstype.domain.EasyshopgoodstypeListDomain;
import cn.finedo.easyshop.service.easyshopgoodstype.domain.EasyshopgoodstypeQueryDomain;

@Controller
@Scope("singleton")
@RequestMapping("service/finedo/easyshopgoodstype")
public class EasyshopgoodstypeServiceAP {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	private static final String strs="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	
	@Autowired
	private EasyshopgoodstypeService easyshopgoodstypeservice;
	
	/**
	 * 商品类型查询
	 * @param EasyshopgoodstypeQueryDomain
	 * @return ReturnValueDomain<Easyshopgoodstype>对象
	 */
	@Permission(permission = "easyshop_easyshopgoodstype_query")
	@Proxy(method="query", inarg="EasyshopgoodstypeQueryDomain", outarg="ReturnValueDomain<PageDomain<Easyshopgoodstype>>")
	@ResponseBody
	@RequestMapping("/query")
	public ReturnValueDomain<PageDomain<Easyshopgoodstype>> query(HttpServletRequest request) {
		ReturnValueDomain<PageDomain<Easyshopgoodstype>> ret = new ReturnValueDomain<PageDomain<Easyshopgoodstype>>();
		EasyshopgoodstypeQueryDomain easyshopgoodstypequerydomain = null;
		 
		try {
			easyshopgoodstypequerydomain = JsonUtil.request2Domain(request, EasyshopgoodstypeQueryDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		return easyshopgoodstypeservice.query(easyshopgoodstypequerydomain);
	}
	/**
	 * 全部商品类型查询
	 * @param EasyshopgoodstypeQueryDomain
	 * @return ReturnValueDomain<Easyshopgoodstype>对象
	 */
	@Permission(permission = "easyshop_easyshopgoodstype_query")
	@Proxy(method="querygoodstypes", inarg="Easyshopgoodstype", outarg="ReturnValueDomain<List<ResultGoodsType>>")
	@ResponseBody
	@RequestMapping("/querygoodstypes")
	public ReturnValueDomain<List<ResultGoodsType>> querygoodstypes(HttpServletRequest request) {
		ReturnValueDomain<List<ResultGoodsType>> ret=new ReturnValueDomain<List<ResultGoodsType>>();
		ReturnValueDomain<List<Easyshopgoodstype>> retlist=easyshopgoodstypeservice.querygoodstypes(new Easyshopgoodstype());
		List<ResultGoodsType> resultGoodsTypes=new ArrayList<ResultGoodsType>();
		ResultGoodsType resultGoodsType=new ResultGoodsType();
		Easyshopgoodstype goodstype=new Easyshopgoodstype();
		List<Easyshopgoodstype> eList=new ArrayList<Easyshopgoodstype>();
//		全部类型
		List<Easyshopgoodstype> list=retlist.getObject();
		Iterator<Easyshopgoodstype> it = list.iterator();
		 while (it.hasNext()) {
			 resultGoodsType=new ResultGoodsType();
			 goodstype =(Easyshopgoodstype) it.next();
	         if(NonUtil.isNon(goodstype.getParentid())) {
	        	 resultGoodsType.setTypeid(goodstype.getGoodstypeid());
	        	 resultGoodsType.setTypename(goodstype.getGoodstypename());
	        	 it.remove();
	        	 resultGoodsTypes.add(resultGoodsType);
	         }
	        }
		 for(int i=0;i<resultGoodsTypes.size();i++) {
			 resultGoodsType=resultGoodsTypes.get(i);
			 String typeid=resultGoodsType.getTypeid();
			 String typename=resultGoodsType.getTypename();
			 eList=new ArrayList<Easyshopgoodstype>();
			 for(int j=0;j<list.size();j++) {
				 if(typeid.equals(list.get(j).getParentid())) {
					 goodstype=list.get(j);
					 eList.add(goodstype);
				 }
			 }
			 resultGoodsType.setIdentify(strs.charAt(i)+"");
			 resultGoodsType.setGoodstypes(eList);
			 resultGoodsType.setTypename(typename);
		 }
		 ret.setObject(resultGoodsTypes);
		return ret;
	}
	/**
	 * 全部商品类型查询
	 * @param EasyshopgoodstypeQueryDomain
	 * @return ReturnValueDomain<Easyshopgoodstype>对象
	 */
	@Permission(permission = "easyshop_easyshopgoodstype_query")
	@Proxy(method="querygoodstypelist", inarg="Easyshopgoodstype", outarg="ReturnValueDomain<List<Easyshopgoodstype>>")
	@ResponseBody
	@RequestMapping("/querygoodstypelist")
	public ReturnValueDomain<List<Easyshopgoodstype>> querygoodstypelist(HttpServletRequest request) {
		Easyshopgoodstype easyshopgoodstype = null;
		ReturnValueDomain<List<Easyshopgoodstype>> ret=new ReturnValueDomain<List<Easyshopgoodstype>>();
		try {
			easyshopgoodstype = JsonUtil.request2Domain(request, Easyshopgoodstype.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		ret=easyshopgoodstypeservice.querygoodstypes(easyshopgoodstype);
		return ret;
	}

	/**
	 * 商品类型按主键查询查询
	 * @param Easyshopgoodstype
	 * @return ReturnValueDomain<Easyshopgoodstype>对象
	 */
	@Permission(permission = "easyshop_easyshopgoodstype_query")
	@Proxy(method="queryById", inarg="Easyshopgoodstype", outarg="ReturnValueDomain<Easyshopgoodstype>")
	@ResponseBody
	@RequestMapping("/querybyid")
	public ReturnValueDomain<Easyshopgoodstype> queryById(HttpServletRequest request) {
		ReturnValueDomain<Easyshopgoodstype> ret = new ReturnValueDomain<Easyshopgoodstype>();
		Easyshopgoodstype easyshopgoodstype = null;
		 
		try {
			easyshopgoodstype = JsonUtil.request2Domain(request, Easyshopgoodstype.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		return easyshopgoodstypeservice.queryById(easyshopgoodstype);
	}
	 
	/**
	 * 商品类型新增
	 * 
	 * @param EasyshopgoodstypeListDomain
	 * @return ReturnValueDomain<String>
	 */
	@Permission(permission = "easyshop_easyshopgoodstype_add")
	@Proxy(method="add", inarg="EasyshopgoodstypeListDomain", outarg="ReturnValueDomain<String>")
	@ResponseBody
	@RequestMapping("/add")
	public ReturnValueDomain<String> add(HttpServletRequest request) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		EasyshopgoodstypeListDomain easyshopgoodstypelistdomain = null;
		 
		try {
			easyshopgoodstypelistdomain = JsonUtil.request2Domain(request, EasyshopgoodstypeListDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}

		return easyshopgoodstypeservice.add(easyshopgoodstypelistdomain);
	 }

	/**
	 * 商品类型修改
	 * @param EasyshopgoodstypeListDomain
	 * @return ReturnValueDomain<String>对象
	 */
	@Permission(permission = "easyshop_easyshopgoodstype_update")
	@Proxy(method="update", inarg="EasyshopgoodstypeListDomain", outarg="ReturnValueDomain<String>")
	@ResponseBody
	@RequestMapping("/update")
	public ReturnValueDomain<String> update(HttpServletRequest request) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		EasyshopgoodstypeListDomain easyshopgoodstypelistdomain = null;
		  
		try {
			easyshopgoodstypelistdomain = JsonUtil.request2Domain(request, EasyshopgoodstypeListDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}

		List<Easyshopgoodstype> easyshopgoodstypelist= easyshopgoodstypelistdomain.getEasyshopgoodstypelist();
		
		List<ValidateItem> items = new ArrayList<ValidateItem>();
		items.add(new ValidateItem("goodstypeid", "商品类型id", true, DataType.STRING));
		items.add(new ValidateItem("goodstypename", "类型名称", true, DataType.STRING));
		items.add(new ValidateItem("parentid", "父类id", true, DataType.STRING));
		items.add(new ValidateItem("imgid", "banner图id", true, DataType.STRING));
		ReturnValueDomain<String> validret = ValidateUtil.checkForList(easyshopgoodstypelist, items);
		if (validret.isFail()) {
			return validret;
		}

		return easyshopgoodstypeservice.update(easyshopgoodstypelistdomain);
	}
	
	/**
	 * 商品类型删除
	 * 
	 * @param EasyshopgoodstypeListDomain
	 * @return ReturnValueDomain<String>
	 */
	@Permission(permission = "easyshop_easyshopgoodstype_delete")
	@Proxy(method="delete", inarg="EasyshopgoodstypeListDomain", outarg="ReturnValueDomain<String>")
	@ResponseBody
	@RequestMapping("/delete")
	public ReturnValueDomain<String> delete(HttpServletRequest request) {
		ReturnValueDomain<String> ret = new ReturnValueDomain<String>();
		EasyshopgoodstypeListDomain easyshopgoodstypelistdomain = null;
		
		try {
			easyshopgoodstypelistdomain = JsonUtil.request2Domain(request, EasyshopgoodstypeListDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		List<Easyshopgoodstype> easyshopgoodstypelist= easyshopgoodstypelistdomain.getEasyshopgoodstypelist();
		
		List<ValidateItem> items = new ArrayList<ValidateItem>();
		items.add(new ValidateItem("goodstypeid", "商品类型id", false, DataType.STRING));
		ReturnValueDomain<String> validret = ValidateUtil.checkForList(easyshopgoodstypelist, items);
		if (validret.isFail()) {
			return validret;
		}
		
		return easyshopgoodstypeservice.delete(easyshopgoodstypelistdomain);
	}
	
	/**
	 * 批量导入商品类型
	 * 
	 * @param SysEntityfile
	 * @return ReturnValueDomain<FileImportResultDomain>对象
	 */
	@Permission(permission = "easyshop_easyshopgoodstype_import")
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
		List<Easyshopgoodstype> datalist;
		try {
			List<HeaderDomain> headerlist=new ArrayList<HeaderDomain>();
			
			headerlist.add(new HeaderDomain("0", "goodstypename", "类型名称"));
			headerlist.add(new HeaderDomain("1", "parentid", "父类id"));
			headerlist.add(new HeaderDomain("2", "imgid", "banner图id"));
			
			datalist=ExcelUtil.readExcel(filename, headerlist, Easyshopgoodstype.class);
			rowcount=datalist.size();
			
			// 合法性校验
			List<ValidateItem> items = new ArrayList<ValidateItem>();
			items.add(new ValidateItem("goodstypename", "类型名称", true, DataType.STRING));
			items.add(new ValidateItem("parentid", "父类id", true, DataType.STRING));
			items.add(new ValidateItem("imgid", "banner图id", true, DataType.STRING));
			
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
		
		EasyshopgoodstypeListDomain easyshopgoodstypelistdomain=new EasyshopgoodstypeListDomain();
		easyshopgoodstypelistdomain.setEasyshopgoodstypelist(datalist);
		ReturnValueDomain<String> oneret= easyshopgoodstypeservice.add(easyshopgoodstypelistdomain);
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
	  * @param EasyshopgoodstypeQueryDomain
	  * @return ReturnValueDomain<SysEntityfile>对象
	  */
	@Permission(permission = "easyshop_easyshopgoodstype_export")
	@Proxy(method="exportExcel", inarg="EasyshopgoodstypeQueryDomain", outarg="ReturnValueDomain<SysEntityfile>")
	@ResponseBody
	@RequestMapping("/exportexcel")
	public ReturnValueDomain<SysEntityfile> exportExcel(HttpServletRequest request) {
		ReturnValueDomain<SysEntityfile> ret=new ReturnValueDomain<SysEntityfile>();
		
		EasyshopgoodstypeQueryDomain easyshopgoodstypequerydomain = null;
		try {
			easyshopgoodstypequerydomain = JsonUtil.request2Domain(request, EasyshopgoodstypeQueryDomain.class);
		}catch(Exception e) {
			logger.error("请求参数解析异常", e);
			return ret.setFail("请求参数解析异常");
		}
		
		PageParamDomain pageparam=new PageParamDomain();
		pageparam.setRownumperpage(ServerFeature.EXPORT_MAXSIZE);
		pageparam.setPageindex(0);
		easyshopgoodstypequerydomain.setPageparam(pageparam);
		
		ReturnValueDomain<PageDomain<Easyshopgoodstype>> queryret = easyshopgoodstypeservice.query(easyshopgoodstypequerydomain);
		
		List<Easyshopgoodstype> Easyshopgoodstypelist = queryret.getObject().getDatalist();
		
		List<HeaderDomain> headerlist = new ArrayList<HeaderDomain>();
		headerlist.add(new HeaderDomain("0", "goodstypename", "类型名称"));
		headerlist.add(new HeaderDomain("1", "parentid", "父类id"));
		headerlist.add(new HeaderDomain("2", "imgid", "banner图id"));
		
		String filepath=ServerFeature.WEBAPP_HOME + File.separator + "download" + File.separator + DateUtil.getNowTime("yyyyMMdd");
		String filename=UUID.randomUUID().toString() + ".xlsx";
				
		try {
			ExcelUtil.writeExcel(filepath + File.separator + filename, headerlist, Easyshopgoodstypelist);
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
