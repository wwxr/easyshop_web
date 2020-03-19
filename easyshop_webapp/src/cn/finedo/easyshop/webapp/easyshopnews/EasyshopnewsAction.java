/**
 * 广告表管理Action
 * 
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.webapp.easyshopnews;

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
import cn.finedo.easyshop.pojo.Easyshopnews;
import cn.finedo.easyshop.service.easyshopnews.EasyshopnewsServiceAPProxy;
import cn.finedo.easyshop.service.easyshopnews.domain.EasyshopnewsListDomain;
import cn.finedo.easyshop.service.easyshopnews.domain.EasyshopnewsQueryDomain;

@Controller
@Scope("singleton")
@RequestMapping("/finedo/easyshopnews")
public class EasyshopnewsAction {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/**
	 * 跳转广告表列表页面
	 */
	@RequestMapping("/list")
	public String list(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopnews/list.jsp";
	}

	/**
	 * 跳转广告表增加页面
	 */
	@RequestMapping("/addindex")
	public String addIndex(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopnews/add.jsp";
	}

	/**
	 * 跳转广告表修改页面
	 */
	@RequestMapping("/updateindex")
	public String updateIndex(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopnews/modify.jsp";
	}

	/**
	 * 跳转广告表详情页面
	 */
	@RequestMapping("/detailindex")
	public String detailIndex(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopnews/detail.jsp";
	}
	
	/**
	 * 广告表查询
	 * @param Easyshopnews
	 * @param PageParamDomain
	 */
	@RequestMapping("/query")
	@ResponseBody
	public Object query(HttpServletRequest request) throws Exception {
		Easyshopnews easyshopnews = FormUtil.request2Domain(request, Easyshopnews.class);
		PageParamDomain pageparam=PageUtil.getPageParam(request);
		
		EasyshopnewsQueryDomain easyshopnewsquerydomain = new EasyshopnewsQueryDomain();
		easyshopnewsquerydomain.setEasyshopnews(easyshopnews);
		easyshopnewsquerydomain.setPageparam(pageparam);
		
		ReturnValueDomain<PageDomain<Easyshopnews>> ret=EasyshopnewsServiceAPProxy.query(easyshopnewsquerydomain);
		PageDomain<Easyshopnews> page = ret.getObject();
		
		return PageUtil.build(page.getDatalist(), page.getRowcount());
	}
	
	/**
	 * 广告表按主键查询
	 * @param Easyshopnews
	 * @param PageParamDomain
	 */
	@RequestMapping("/querybyid")
	@ResponseBody
	public Object queryById(HttpServletRequest request) throws Exception {
		Easyshopnews easyshopnews = FormUtil.request2Domain(request, Easyshopnews.class);
		ReturnValueDomain<Easyshopnews> ret = EasyshopnewsServiceAPProxy.queryById(easyshopnews);
		return ret;
	}
	
	/**
	 * 广告表新增
	 * @param EasyshopnewsListDomain
	 */
	@RequestMapping("/add")
	@ResponseBody
	public Object add(HttpServletRequest request) throws Exception {
		Easyshopnews easyshopnews = FormUtil.request2Domain(request, Easyshopnews.class);
		
		EasyshopnewsListDomain easyshopnewslistdomain = new EasyshopnewsListDomain();
		List<Easyshopnews> easyshopnewslist=new ArrayList<Easyshopnews>();
		easyshopnewslist.add(easyshopnews);
		easyshopnewslistdomain.setEasyshopnewslist(easyshopnewslist);
	
		ReturnValueDomain<String> ret=EasyshopnewsServiceAPProxy.add(easyshopnewslistdomain);
		
		return ret;
	}
	
	/**
	 * 广告表修改
	 * @param EasyshopnewsListDomain
	 */
	@RequestMapping("/modify")
	@ResponseBody
	public Object modify(HttpServletRequest request) throws Exception {
		// 传入的领域对象
		Easyshopnews easyshopnews = FormUtil.request2Domain(request, Easyshopnews.class);
		
		EasyshopnewsListDomain easyshopnewslistdomain = new EasyshopnewsListDomain();
		List<Easyshopnews> easyshopnewslist=new ArrayList<Easyshopnews>();
		easyshopnewslist.add(easyshopnews);
		easyshopnewslistdomain.setEasyshopnewslist(easyshopnewslist);
		
		ReturnValueDomain<String> ret=EasyshopnewsServiceAPProxy.update(easyshopnewslistdomain);
		
		return ret;
	}

	/**
	 * 广告表删除
	 * @param EasyshopnewsListDomain
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public Object delete(HttpServletRequest request) throws Exception{
		// 传入的领域对象
		List<Easyshopnews> easyshopnewslist=new ArrayList<Easyshopnews>();
		
		String idsstr = request.getParameter("id");
		String[] idarray = idsstr.split(",");
		for(String id : idarray){
			Easyshopnews easyshopnews = new Easyshopnews();
			
			easyshopnews.setNewsid(id);
			easyshopnewslist.add(easyshopnews);
		}
		EasyshopnewsListDomain easyshopnewslistdomain = new EasyshopnewsListDomain();
		easyshopnewslistdomain.setEasyshopnewslist(easyshopnewslist);
		
		ReturnValueDomain<String> ret=EasyshopnewsServiceAPProxy.delete(easyshopnewslistdomain);
		
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
		
		return EasyshopnewsServiceAPProxy.importExcel(entityfile);
	}
	
	/**
	 * 导出
	 */
	@RequestMapping(value="/exportexcel")
	public void exportExcel(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Easyshopnews easyshopnews=FormUtil.request2Domain(request, Easyshopnews.class);
		EasyshopnewsQueryDomain easyshopnewsquerydomain = new EasyshopnewsQueryDomain();
		easyshopnewsquerydomain.setEasyshopnews(easyshopnews);

		ReturnValueDomain<SysEntityfile> ret=EasyshopnewsServiceAPProxy.exportExcel(easyshopnewsquerydomain);
		SysEntityfile entityfile=ret.getObject();
		String filepath=entityfile.getFilepath();
		String filename=entityfile.getFilename();
		
		FileDownloadUtil.filedownload(filename, filepath + File.separator + filename, request, response);
	}
}
