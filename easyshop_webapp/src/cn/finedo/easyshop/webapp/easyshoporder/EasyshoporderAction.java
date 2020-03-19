/**
 * 订单表管理Action
 * 
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.webapp.easyshoporder;

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
import cn.finedo.easyshop.pojo.Easyshoporder;
import cn.finedo.easyshop.service.easyshoporder.EasyshoporderServiceAPProxy;
import cn.finedo.easyshop.service.easyshoporder.domain.EasyshoporderListDomain;
import cn.finedo.easyshop.service.easyshoporder.domain.EasyshoporderQueryDomain;

@Controller
@Scope("singleton")
@RequestMapping("/finedo/easyshoporder")
public class EasyshoporderAction {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/**
	 * 跳转订单表列表页面
	 */
	@RequestMapping("/list")
	public String list(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshoporder/list.jsp";
	}

	/**
	 * 跳转订单表增加页面
	 */
	@RequestMapping("/addindex")
	public String addIndex(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshoporder/add.jsp";
	}

	/**
	 * 跳转订单表修改页面
	 */
	@RequestMapping("/updateindex")
	public String updateIndex(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshoporder/modify.jsp";
	}

	/**
	 * 跳转订单表详情页面
	 */
	@RequestMapping("/detailindex")
	public String detailIndex(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshoporder/detail.jsp";
	}
	
	/**
	 * 订单表查询
	 * @param Easyshoporder
	 * @param PageParamDomain
	 */
	@RequestMapping("/query")
	@ResponseBody
	public Object query(HttpServletRequest request) throws Exception {
		Easyshoporder easyshoporder = FormUtil.request2Domain(request, Easyshoporder.class);
		PageParamDomain pageparam=PageUtil.getPageParam(request);
		
		EasyshoporderQueryDomain easyshoporderquerydomain = new EasyshoporderQueryDomain();
		easyshoporderquerydomain.setEasyshoporder(easyshoporder);
		easyshoporderquerydomain.setPageparam(pageparam);
		
		ReturnValueDomain<PageDomain<Easyshoporder>> ret=EasyshoporderServiceAPProxy.query(easyshoporderquerydomain);
		PageDomain<Easyshoporder> page = ret.getObject();
		
		return PageUtil.build(page.getDatalist(), page.getRowcount());
	}
	/**
	 * 小程序订单查询
	 * @param Easyshoporder
	 * @param PageParamDomain
	 */
	@RequestMapping("/queryList")
	@ResponseBody
	public Object queryList(HttpServletRequest request) throws Exception {
		Easyshoporder easyshoporder = FormUtil.request2Domain(request, Easyshoporder.class);
		PageParamDomain pageparam=PageUtil.getPageParam(request);
		
		EasyshoporderQueryDomain easyshoporderquerydomain = new EasyshoporderQueryDomain();
		easyshoporderquerydomain.setEasyshoporder(easyshoporder);
		easyshoporderquerydomain.setPageparam(pageparam);
		
		ReturnValueDomain<PageDomain<Easyshoporder>> ret=EasyshoporderServiceAPProxy.queryList(easyshoporderquerydomain);
		PageDomain<Easyshoporder> page = ret.getObject();
		
		return PageUtil.build(page.getDatalist(), page.getRowcount());
	}
	/**
	 * 小程序我的推广订单查询
	 * @param Easyshoporder
	 * @param PageParamDomain
	 */
	@RequestMapping("/queryLowerList")
	@ResponseBody
	public Object queryLowerList(HttpServletRequest request) throws Exception {
		Easyshoporder easyshoporder = FormUtil.request2Domain(request, Easyshoporder.class);
		PageParamDomain pageparam=PageUtil.getPageParam(request);
		
		EasyshoporderQueryDomain easyshoporderquerydomain = new EasyshoporderQueryDomain();
		easyshoporderquerydomain.setEasyshoporder(easyshoporder);
		easyshoporderquerydomain.setPageparam(pageparam);
		
		ReturnValueDomain<PageDomain<Easyshoporder>> ret=EasyshoporderServiceAPProxy.queryLowerList(easyshoporderquerydomain);
		PageDomain<Easyshoporder> page = ret.getObject();
		
		return PageUtil.build(page.getDatalist(), page.getRowcount());
	}
	
	/**
	 * 订单表按主键查询
	 * @param Easyshoporder
	 * @param PageParamDomain
	 */
	@RequestMapping("/querybyid")
	@ResponseBody
	public Object queryById(HttpServletRequest request) throws Exception {
		Easyshoporder easyshoporder = FormUtil.request2Domain(request, Easyshoporder.class);
		ReturnValueDomain<Easyshoporder> ret = EasyshoporderServiceAPProxy.queryById(easyshoporder);
		return ret;
	}
	
	/**
	 * 订单表新增
	 * @param EasyshoporderListDomain
	 */
	@RequestMapping("/add")
	@ResponseBody
	public Object add(HttpServletRequest request) throws Exception {
		Easyshoporder easyshoporder = FormUtil.request2Domain(request, Easyshoporder.class);
		
		EasyshoporderListDomain easyshoporderlistdomain = new EasyshoporderListDomain();
		List<Easyshoporder> easyshoporderlist=new ArrayList<Easyshoporder>();
		easyshoporderlist.add(easyshoporder);
		easyshoporderlistdomain.setEasyshoporderlist(easyshoporderlist);
	
		ReturnValueDomain<String> ret=EasyshoporderServiceAPProxy.add(easyshoporderlistdomain);
		
		return ret;
	}
	
	/**
	 * 订单表修改
	 * @param EasyshoporderListDomain
	 */
	@RequestMapping("/modify")
	@ResponseBody
	public Object modify(HttpServletRequest request) throws Exception {
		// 传入的领域对象
		Easyshoporder easyshoporder = FormUtil.request2Domain(request, Easyshoporder.class);
		
		EasyshoporderListDomain easyshoporderlistdomain = new EasyshoporderListDomain();
		List<Easyshoporder> easyshoporderlist=new ArrayList<Easyshoporder>();
		easyshoporderlist.add(easyshoporder);
		easyshoporderlistdomain.setEasyshoporderlist(easyshoporderlist);
		
		ReturnValueDomain<String> ret=EasyshoporderServiceAPProxy.update(easyshoporderlistdomain);
		
		return ret;
	}

	/**
	 * 订单表删除
	 * @param EasyshoporderListDomain
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public Object delete(HttpServletRequest request) throws Exception{
		// 传入的领域对象
		List<Easyshoporder> easyshoporderlist=new ArrayList<Easyshoporder>();
		
		String idsstr = request.getParameter("id");
		String[] idarray = idsstr.split(",");
		for(String id : idarray){
			Easyshoporder easyshoporder = new Easyshoporder();
			
			easyshoporder.setOrdercode(id);
			easyshoporderlist.add(easyshoporder);
		}
		EasyshoporderListDomain easyshoporderlistdomain = new EasyshoporderListDomain();
		easyshoporderlistdomain.setEasyshoporderlist(easyshoporderlist);
		
		ReturnValueDomain<String> ret=EasyshoporderServiceAPProxy.delete(easyshoporderlistdomain);
		
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
		
		return EasyshoporderServiceAPProxy.importExcel(entityfile);
	}
	
	/**
	 * 导出
	 */
	@RequestMapping(value="/exportexcel")
	public void exportExcel(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Easyshoporder easyshoporder=FormUtil.request2Domain(request, Easyshoporder.class);
		EasyshoporderQueryDomain easyshoporderquerydomain = new EasyshoporderQueryDomain();
		easyshoporderquerydomain.setEasyshoporder(easyshoporder);

		ReturnValueDomain<SysEntityfile> ret=EasyshoporderServiceAPProxy.exportExcel(easyshoporderquerydomain);
		SysEntityfile entityfile=ret.getObject();
		String filepath=entityfile.getFilepath();
		String filename=entityfile.getFilename();
		
		FileDownloadUtil.filedownload(filename, filepath + File.separator + filename, request, response);
	}
}
