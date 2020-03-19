/**
 * 商品类型管理Action
 * 
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.webapp.easyshopgoodstype;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import cn.finedo.common.domain.PageDomain;
import cn.finedo.common.domain.PageParamDomain;
import cn.finedo.common.domain.ReturnValueDomain;
import cn.finedo.common.file.FileDownloadUtil;
import cn.finedo.common.non.NonUtil;
import cn.finedo.common.pojo.SysEntityfile;
import cn.finedo.common.protocol.FormUtil;
import cn.finedo.fsdp.webapp.common.utils.PageUtil;
import cn.finedo.easyshop.pojo.Easyshopgoodstype;
import cn.finedo.easyshop.pojo.ResultGoodsType;
import cn.finedo.easyshop.service.easyshopgoodstype.EasyshopgoodstypeServiceAPProxy;
import cn.finedo.easyshop.service.easyshopgoodstype.domain.EasyshopgoodstypeListDomain;
import cn.finedo.easyshop.service.easyshopgoodstype.domain.EasyshopgoodstypeQueryDomain;

@Controller
@Scope("singleton")
@RequestMapping("/finedo/easyshopgoodstype")
public class EasyshopgoodstypeAction {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/**
	 * 跳转商品类型列表页面
	 */
	@RequestMapping("/list")
	public String list(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopgoodstype/list.jsp";
	}

	/**
	 * 跳转商品类型增加页面
	 */
	@RequestMapping("/addindex")
	public String addIndex(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopgoodstype/add.jsp";
	}

	/**
	 * 跳转商品类型修改页面
	 */
	@RequestMapping("/updateindex")
	public String updateIndex(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopgoodstype/modify.jsp";
	}

	/**
	 * 跳转商品类型详情页面
	 */
	@RequestMapping("/detailindex")
	public String detailIndex(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopgoodstype/detail.jsp";
	}
	
	/**
	 * 商品类型查询
	 * @param Easyshopgoodstype
	 * @param PageParamDomain
	 */
	@RequestMapping("/query")
	@ResponseBody
	public Object query(HttpServletRequest request) throws Exception {
		Easyshopgoodstype easyshopgoodstype = FormUtil.request2Domain(request, Easyshopgoodstype.class);
		PageParamDomain pageparam=PageUtil.getPageParam(request);
		
		EasyshopgoodstypeQueryDomain easyshopgoodstypequerydomain = new EasyshopgoodstypeQueryDomain();
		easyshopgoodstypequerydomain.setEasyshopgoodstype(easyshopgoodstype);
		easyshopgoodstypequerydomain.setPageparam(pageparam);
		
		ReturnValueDomain<PageDomain<Easyshopgoodstype>> ret=EasyshopgoodstypeServiceAPProxy.query(easyshopgoodstypequerydomain);
		PageDomain<Easyshopgoodstype> page = ret.getObject();
		
		return PageUtil.build(page.getDatalist(), page.getRowcount());
	}
	/**
	 * 商品类型查询
	 * @param Easyshopgoodstype
	 * @param PageParamDomain
	 */
	@RequestMapping("/querygoodstypes")
	@ResponseBody
	public Object querygoodstypes(HttpServletRequest request) throws Exception {
		Easyshopgoodstype easyshopgoodstype = FormUtil.request2Domain(request, Easyshopgoodstype.class);
		ReturnValueDomain<List<ResultGoodsType>> ret=EasyshopgoodstypeServiceAPProxy.querygoodstypes(easyshopgoodstype);
		
		return ret;
	}
	/**
	 * 商品类型查询
	 * @param Easyshopgoodstype
	 * @param PageParamDomain
	 */
	@RequestMapping("/querygoodstypelist")
	@ResponseBody
	public Object querygoodstypelist(HttpServletRequest request) throws Exception {
		Easyshopgoodstype easyshopgoodstype = FormUtil.request2Domain(request, Easyshopgoodstype.class);
		ReturnValueDomain<List<Easyshopgoodstype>> ret=EasyshopgoodstypeServiceAPProxy.querygoodstypelist(easyshopgoodstype);
		
		return ret;
	}
	
	/**
	 * 商品类型按主键查询
	 * @param Easyshopgoodstype
	 * @param PageParamDomain
	 */
	@RequestMapping("/querybyid")
	@ResponseBody
	public Object queryById(HttpServletRequest request) throws Exception {
		Easyshopgoodstype easyshopgoodstype = FormUtil.request2Domain(request, Easyshopgoodstype.class);
		ReturnValueDomain<Easyshopgoodstype> ret = EasyshopgoodstypeServiceAPProxy.queryById(easyshopgoodstype);
		return ret;
	}
	
	/**
	 * 商品类型新增
	 * @param EasyshopgoodstypeListDomain
	 */
	@RequestMapping("/add")
	@ResponseBody
	public Object add(HttpServletRequest request) throws Exception {
		Easyshopgoodstype easyshopgoodstype = FormUtil.request2Domain(request, Easyshopgoodstype.class);
		
		EasyshopgoodstypeListDomain easyshopgoodstypelistdomain = new EasyshopgoodstypeListDomain();
		List<Easyshopgoodstype> easyshopgoodstypelist=new ArrayList<Easyshopgoodstype>();
		easyshopgoodstypelist.add(easyshopgoodstype);
		easyshopgoodstypelistdomain.setEasyshopgoodstypelist(easyshopgoodstypelist);
	
		ReturnValueDomain<String> ret=EasyshopgoodstypeServiceAPProxy.add(easyshopgoodstypelistdomain);
		
		return ret;
	}
	
	/**
	 * 商品类型修改
	 * @param EasyshopgoodstypeListDomain
	 */
	@RequestMapping("/modify")
	@ResponseBody
	public Object modify(HttpServletRequest request) throws Exception {
		// 传入的领域对象
		Easyshopgoodstype easyshopgoodstype = FormUtil.request2Domain(request, Easyshopgoodstype.class);
		
		EasyshopgoodstypeListDomain easyshopgoodstypelistdomain = new EasyshopgoodstypeListDomain();
		List<Easyshopgoodstype> easyshopgoodstypelist=new ArrayList<Easyshopgoodstype>();
		easyshopgoodstypelist.add(easyshopgoodstype);
		easyshopgoodstypelistdomain.setEasyshopgoodstypelist(easyshopgoodstypelist);
		
		ReturnValueDomain<String> ret=EasyshopgoodstypeServiceAPProxy.update(easyshopgoodstypelistdomain);
		
		return ret;
	}

	/**
	 * 商品类型删除
	 * @param EasyshopgoodstypeListDomain
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public Object delete(HttpServletRequest request) throws Exception{
		// 传入的领域对象
		List<Easyshopgoodstype> easyshopgoodstypelist=new ArrayList<Easyshopgoodstype>();
		
		String idsstr = request.getParameter("id");
		String[] idarray = idsstr.split(",");
		for(String id : idarray){
			Easyshopgoodstype easyshopgoodstype = new Easyshopgoodstype();
			
			easyshopgoodstype.setGoodstypeid(id);
			easyshopgoodstypelist.add(easyshopgoodstype);
		}
		EasyshopgoodstypeListDomain easyshopgoodstypelistdomain = new EasyshopgoodstypeListDomain();
		easyshopgoodstypelistdomain.setEasyshopgoodstypelist(easyshopgoodstypelist);
		
		ReturnValueDomain<String> ret=EasyshopgoodstypeServiceAPProxy.delete(easyshopgoodstypelistdomain);
		
		return ret;
	}
	
	/**
	 * 导入
	 */
	@RequestMapping(value="/importexcel")
	@ResponseBody
	public Object importExcel(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String fileid=request.getParameter("fileid");
		
		SysEntityfile entityfile=new SysEntityfile();
		entityfile.setFileid(fileid);
		
		return EasyshopgoodstypeServiceAPProxy.importExcel(entityfile);
	}
	
	/**
	 * 导出
	 */
	@RequestMapping(value="/exportexcel")
	public void exportExcel(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Easyshopgoodstype easyshopgoodstype=FormUtil.request2Domain(request, Easyshopgoodstype.class);
		EasyshopgoodstypeQueryDomain easyshopgoodstypequerydomain = new EasyshopgoodstypeQueryDomain();
		easyshopgoodstypequerydomain.setEasyshopgoodstype(easyshopgoodstype);

		ReturnValueDomain<SysEntityfile> ret=EasyshopgoodstypeServiceAPProxy.exportExcel(easyshopgoodstypequerydomain);
		SysEntityfile entityfile=ret.getObject();
		String filepath=entityfile.getFilepath();
		String filename=entityfile.getFilename();
		
		FileDownloadUtil.filedownload(filename, filepath + File.separator + filename, request, response);
	}
}
