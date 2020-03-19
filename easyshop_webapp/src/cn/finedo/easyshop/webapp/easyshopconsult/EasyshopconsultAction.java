/**
 * 咨询表管理Action
 * 
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.webapp.easyshopconsult;

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
import cn.finedo.easyshop.pojo.Easyshopconsult;
import cn.finedo.easyshop.service.easyshopconsult.EasyshopconsultServiceAPProxy;
import cn.finedo.easyshop.service.easyshopconsult.domain.EasyshopconsultListDomain;
import cn.finedo.easyshop.service.easyshopconsult.domain.EasyshopconsultQueryDomain;

@Controller
@Scope("singleton")
@RequestMapping("/finedo/easyshopconsult")
public class EasyshopconsultAction {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/**
	 * 跳转咨询表列表页面
	 */
	@RequestMapping("/list")
	public String list(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopconsult/list.jsp";
	}

	/**
	 * 跳转咨询表增加页面
	 */
	@RequestMapping("/addindex")
	public String addIndex(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopconsult/add.jsp";
	}

	/**
	 * 跳转咨询表修改页面
	 */
	@RequestMapping("/updateindex")
	public String updateIndex(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopconsult/modify.jsp";
	}

	/**
	 * 跳转咨询表详情页面
	 */
	@RequestMapping("/detailindex")
	public String detailIndex(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopconsult/detail.jsp";
	}
	
	/**
	 * 咨询表查询
	 * @param Easyshopconsult
	 * @param PageParamDomain
	 */
	@RequestMapping("/query")
	@ResponseBody
	public Object query(HttpServletRequest request) throws Exception {
		Easyshopconsult easyshopconsult = FormUtil.request2Domain(request, Easyshopconsult.class);
		PageParamDomain pageparam=PageUtil.getPageParam(request);
		
		EasyshopconsultQueryDomain easyshopconsultquerydomain = new EasyshopconsultQueryDomain();
		easyshopconsultquerydomain.setEasyshopconsult(easyshopconsult);
		easyshopconsultquerydomain.setPageparam(pageparam);
		
		ReturnValueDomain<PageDomain<Easyshopconsult>> ret=EasyshopconsultServiceAPProxy.query(easyshopconsultquerydomain);
		PageDomain<Easyshopconsult> page = ret.getObject();
		
		return PageUtil.build(page.getDatalist(), page.getRowcount());
	}
	
	/**
	 * 咨询表按主键查询
	 * @param Easyshopconsult
	 * @param PageParamDomain
	 */
	@RequestMapping("/querybyid")
	@ResponseBody
	public Object queryById(HttpServletRequest request) throws Exception {
		Easyshopconsult easyshopconsult = FormUtil.request2Domain(request, Easyshopconsult.class);
		ReturnValueDomain<Easyshopconsult> ret = EasyshopconsultServiceAPProxy.queryById(easyshopconsult);
		return ret;
	}
	
	/**
	 * 咨询表新增
	 * @param EasyshopconsultListDomain
	 */
	@RequestMapping("/add")
	@ResponseBody
	public Object add(HttpServletRequest request) throws Exception {
		Easyshopconsult easyshopconsult = FormUtil.request2Domain(request, Easyshopconsult.class);
		
		EasyshopconsultListDomain easyshopconsultlistdomain = new EasyshopconsultListDomain();
		List<Easyshopconsult> easyshopconsultlist=new ArrayList<Easyshopconsult>();
		easyshopconsultlist.add(easyshopconsult);
		easyshopconsultlistdomain.setEasyshopconsultlist(easyshopconsultlist);
	
		ReturnValueDomain<String> ret=EasyshopconsultServiceAPProxy.add(easyshopconsultlistdomain);
		
		return ret;
	}
	
	/**
	 * 咨询表修改
	 * @param EasyshopconsultListDomain
	 */
	@RequestMapping("/modify")
	@ResponseBody
	public Object modify(HttpServletRequest request) throws Exception {
		// 传入的领域对象
		Easyshopconsult easyshopconsult = FormUtil.request2Domain(request, Easyshopconsult.class);
		
		EasyshopconsultListDomain easyshopconsultlistdomain = new EasyshopconsultListDomain();
		List<Easyshopconsult> easyshopconsultlist=new ArrayList<Easyshopconsult>();
		easyshopconsultlist.add(easyshopconsult);
		easyshopconsultlistdomain.setEasyshopconsultlist(easyshopconsultlist);
		
		ReturnValueDomain<String> ret=EasyshopconsultServiceAPProxy.update(easyshopconsultlistdomain);
		
		return ret;
	}

	/**
	 * 咨询表删除
	 * @param EasyshopconsultListDomain
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public Object delete(HttpServletRequest request) throws Exception{
		// 传入的领域对象
		List<Easyshopconsult> easyshopconsultlist=new ArrayList<Easyshopconsult>();
		
		String idsstr = request.getParameter("id");
		String[] idarray = idsstr.split(",");
		for(String id : idarray){
			Easyshopconsult easyshopconsult = new Easyshopconsult();
			
			easyshopconsult.setConsultid(id);
			easyshopconsultlist.add(easyshopconsult);
		}
		EasyshopconsultListDomain easyshopconsultlistdomain = new EasyshopconsultListDomain();
		easyshopconsultlistdomain.setEasyshopconsultlist(easyshopconsultlist);
		
		ReturnValueDomain<String> ret=EasyshopconsultServiceAPProxy.delete(easyshopconsultlistdomain);
		
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
		
		return EasyshopconsultServiceAPProxy.importExcel(entityfile);
	}
	
	/**
	 * 导出
	 */
	@RequestMapping(value="/exportexcel")
	public void exportExcel(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Easyshopconsult easyshopconsult=FormUtil.request2Domain(request, Easyshopconsult.class);
		EasyshopconsultQueryDomain easyshopconsultquerydomain = new EasyshopconsultQueryDomain();
		easyshopconsultquerydomain.setEasyshopconsult(easyshopconsult);

		ReturnValueDomain<SysEntityfile> ret=EasyshopconsultServiceAPProxy.exportExcel(easyshopconsultquerydomain);
		SysEntityfile entityfile=ret.getObject();
		String filepath=entityfile.getFilepath();
		String filename=entityfile.getFilename();
		
		FileDownloadUtil.filedownload(filename, filepath + File.separator + filename, request, response);
	}
}
