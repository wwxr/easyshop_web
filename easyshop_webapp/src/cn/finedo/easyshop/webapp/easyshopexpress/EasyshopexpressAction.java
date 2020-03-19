/**
 * 物流表管理Action
 * 
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.webapp.easyshopexpress;

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
import cn.finedo.easyshop.pojo.Easyshopexpress;
import cn.finedo.easyshop.service.easyshopexpress.EasyshopexpressServiceAPProxy;
import cn.finedo.easyshop.service.easyshopexpress.domain.EasyshopexpressListDomain;
import cn.finedo.easyshop.service.easyshopexpress.domain.EasyshopexpressQueryDomain;

@Controller
@Scope("singleton")
@RequestMapping("/finedo/easyshopexpress")
public class EasyshopexpressAction {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/**
	 * 跳转物流表列表页面
	 */
	@RequestMapping("/list")
	public String list(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopexpress/list.jsp";
	}

	/**
	 * 跳转物流表增加页面
	 */
	@RequestMapping("/addindex")
	public String addIndex(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopexpress/add.jsp";
	}

	/**
	 * 跳转物流表修改页面
	 */
	@RequestMapping("/updateindex")
	public String updateIndex(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopexpress/modify.jsp";
	}

	/**
	 * 跳转物流表详情页面
	 */
	@RequestMapping("/detailindex")
	public String detailIndex(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopexpress/detail.jsp";
	}
	
	/**
	 * 物流表查询
	 * @param Easyshopexpress
	 * @param PageParamDomain
	 */
	@RequestMapping("/query")
	@ResponseBody
	public Object query(HttpServletRequest request) throws Exception {
		Easyshopexpress easyshopexpress = FormUtil.request2Domain(request, Easyshopexpress.class);
		PageParamDomain pageparam=PageUtil.getPageParam(request);
		
		EasyshopexpressQueryDomain easyshopexpressquerydomain = new EasyshopexpressQueryDomain();
		easyshopexpressquerydomain.setEasyshopexpress(easyshopexpress);
		easyshopexpressquerydomain.setPageparam(pageparam);
		
		ReturnValueDomain<PageDomain<Easyshopexpress>> ret=EasyshopexpressServiceAPProxy.query(easyshopexpressquerydomain);
		PageDomain<Easyshopexpress> page = ret.getObject();
		
		return PageUtil.build(page.getDatalist(), page.getRowcount());
	}
	
	/**
	 * 物流表按主键查询
	 * @param Easyshopexpress
	 * @param PageParamDomain
	 */
	@RequestMapping("/querybyid")
	@ResponseBody
	public Object queryById(HttpServletRequest request) throws Exception {
		Easyshopexpress easyshopexpress = FormUtil.request2Domain(request, Easyshopexpress.class);
		ReturnValueDomain<Easyshopexpress> ret = EasyshopexpressServiceAPProxy.queryById(easyshopexpress);
		return ret;
	}
	
	/**
	 * 物流表新增
	 * @param EasyshopexpressListDomain
	 */
	@RequestMapping("/add")
	@ResponseBody
	public Object add(HttpServletRequest request) throws Exception {
		Easyshopexpress easyshopexpress = FormUtil.request2Domain(request, Easyshopexpress.class);
		
		EasyshopexpressListDomain easyshopexpresslistdomain = new EasyshopexpressListDomain();
		List<Easyshopexpress> easyshopexpresslist=new ArrayList<Easyshopexpress>();
		easyshopexpresslist.add(easyshopexpress);
		easyshopexpresslistdomain.setEasyshopexpresslist(easyshopexpresslist);
	
		ReturnValueDomain<String> ret=EasyshopexpressServiceAPProxy.add(easyshopexpresslistdomain);
		
		return ret;
	}
	
	/**
	 * 物流表修改
	 * @param EasyshopexpressListDomain
	 */
	@RequestMapping("/modify")
	@ResponseBody
	public Object modify(HttpServletRequest request) throws Exception {
		// 传入的领域对象
		Easyshopexpress easyshopexpress = FormUtil.request2Domain(request, Easyshopexpress.class);
		
		EasyshopexpressListDomain easyshopexpresslistdomain = new EasyshopexpressListDomain();
		List<Easyshopexpress> easyshopexpresslist=new ArrayList<Easyshopexpress>();
		easyshopexpresslist.add(easyshopexpress);
		easyshopexpresslistdomain.setEasyshopexpresslist(easyshopexpresslist);
		
		ReturnValueDomain<String> ret=EasyshopexpressServiceAPProxy.update(easyshopexpresslistdomain);
		
		return ret;
	}

	/**
	 * 物流表删除
	 * @param EasyshopexpressListDomain
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public Object delete(HttpServletRequest request) throws Exception{
		// 传入的领域对象
		List<Easyshopexpress> easyshopexpresslist=new ArrayList<Easyshopexpress>();
		
		String idsstr = request.getParameter("id");
		String[] idarray = idsstr.split(",");
		for(String id : idarray){
			Easyshopexpress easyshopexpress = new Easyshopexpress();
			
			easyshopexpress.setShippercode(id);
			easyshopexpresslist.add(easyshopexpress);
		}
		EasyshopexpressListDomain easyshopexpresslistdomain = new EasyshopexpressListDomain();
		easyshopexpresslistdomain.setEasyshopexpresslist(easyshopexpresslist);
		
		ReturnValueDomain<String> ret=EasyshopexpressServiceAPProxy.delete(easyshopexpresslistdomain);
		
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
		
		return EasyshopexpressServiceAPProxy.importExcel(entityfile);
	}
	
	/**
	 * 导出
	 */
	@RequestMapping(value="/exportexcel")
	public void exportExcel(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Easyshopexpress easyshopexpress=FormUtil.request2Domain(request, Easyshopexpress.class);
		EasyshopexpressQueryDomain easyshopexpressquerydomain = new EasyshopexpressQueryDomain();
		easyshopexpressquerydomain.setEasyshopexpress(easyshopexpress);

		ReturnValueDomain<SysEntityfile> ret=EasyshopexpressServiceAPProxy.exportExcel(easyshopexpressquerydomain);
		SysEntityfile entityfile=ret.getObject();
		String filepath=entityfile.getFilepath();
		String filename=entityfile.getFilename();
		
		FileDownloadUtil.filedownload(filename, filepath + File.separator + filename, request, response);
	}
}
