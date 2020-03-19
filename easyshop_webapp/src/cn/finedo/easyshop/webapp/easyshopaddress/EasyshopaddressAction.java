/**
 * 地址管理Action
 * 
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.webapp.easyshopaddress;

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
import cn.finedo.common.pojo.SysEntityfile;
import cn.finedo.common.protocol.FormUtil;
import cn.finedo.fsdp.webapp.common.utils.PageUtil;
import cn.finedo.easyshop.pojo.Easyshopaddress;
import cn.finedo.easyshop.service.easyshopaddress.EasyshopaddressServiceAPProxy;
import cn.finedo.easyshop.service.easyshopaddress.domain.EasyshopaddressListDomain;
import cn.finedo.easyshop.service.easyshopaddress.domain.EasyshopaddressQueryDomain;

@Controller
@Scope("singleton")
@RequestMapping("/finedo/easyshopaddress")
public class EasyshopaddressAction {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/**
	 * 跳转地址列表页面
	 */
	@RequestMapping("/list")
	public String list(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopaddress/list.jsp";
	}

	/**
	 * 跳转地址增加页面
	 */
	@RequestMapping("/addindex")
	public String addIndex(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopaddress/add.jsp";
	}

	/**
	 * 跳转地址修改页面
	 */
	@RequestMapping("/updateindex")
	public String updateIndex(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopaddress/modify.jsp";
	}

	/**
	 * 跳转地址详情页面
	 */
	@RequestMapping("/detailindex")
	public String detailIndex(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopaddress/detail.jsp";
	}
	
	/**
	 * 地址查询
	 * @param Easyshopaddress
	 * @param PageParamDomain
	 */
	@RequestMapping("/query")
	@ResponseBody
	public Object query(HttpServletRequest request) throws Exception {
		Easyshopaddress easyshopaddress = FormUtil.request2Domain(request, Easyshopaddress.class);
		PageParamDomain pageparam=PageUtil.getPageParam(request);
		
		EasyshopaddressQueryDomain easyshopaddressquerydomain = new EasyshopaddressQueryDomain();
		easyshopaddressquerydomain.setEasyshopaddress(easyshopaddress);
		easyshopaddressquerydomain.setPageparam(pageparam);
		
		ReturnValueDomain<PageDomain<Easyshopaddress>> ret=EasyshopaddressServiceAPProxy.query(easyshopaddressquerydomain);
		PageDomain<Easyshopaddress> page = ret.getObject();
		
		return PageUtil.build(page.getDatalist(), page.getRowcount());
	}
	
	/**
	 * 地址按主键查询
	 * @param Easyshopaddress
	 * @param PageParamDomain
	 */
	@RequestMapping("/querybyid")
	@ResponseBody
	public Object queryById(HttpServletRequest request) throws Exception {
		Easyshopaddress easyshopaddress = FormUtil.request2Domain(request, Easyshopaddress.class);
		ReturnValueDomain<Easyshopaddress> ret = EasyshopaddressServiceAPProxy.queryById(easyshopaddress);
		return ret;
	}
	
	/**
	 * 地址新增
	 * @param EasyshopaddressListDomain
	 */
	@RequestMapping("/add")
	@ResponseBody
	public Object add(HttpServletRequest request) throws Exception {
		Easyshopaddress easyshopaddress = FormUtil.request2Domain(request, Easyshopaddress.class);
		
		EasyshopaddressListDomain easyshopaddresslistdomain = new EasyshopaddressListDomain();
		List<Easyshopaddress> easyshopaddresslist=new ArrayList<Easyshopaddress>();
		easyshopaddresslist.add(easyshopaddress);
		easyshopaddresslistdomain.setEasyshopaddresslist(easyshopaddresslist);
	
		ReturnValueDomain<String> ret=EasyshopaddressServiceAPProxy.add(easyshopaddresslistdomain);
		
		return ret;
	}
	
	/**
	 * 地址修改
	 * @param EasyshopaddressListDomain
	 */
	@RequestMapping("/modify")
	@ResponseBody
	public Object modify(HttpServletRequest request) throws Exception {
		// 传入的领域对象
		Easyshopaddress easyshopaddress = FormUtil.request2Domain(request, Easyshopaddress.class);
		
		EasyshopaddressListDomain easyshopaddresslistdomain = new EasyshopaddressListDomain();
		List<Easyshopaddress> easyshopaddresslist=new ArrayList<Easyshopaddress>();
		easyshopaddresslist.add(easyshopaddress);
		easyshopaddresslistdomain.setEasyshopaddresslist(easyshopaddresslist);
		
		ReturnValueDomain<String> ret=EasyshopaddressServiceAPProxy.update(easyshopaddresslistdomain);
		
		return ret;
	}

	/**
	 * 地址删除
	 * @param EasyshopaddressListDomain
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public Object delete(HttpServletRequest request) throws Exception{
		// 传入的领域对象
		List<Easyshopaddress> easyshopaddresslist=new ArrayList<Easyshopaddress>();
		
		String idsstr = request.getParameter("id");
		String[] idarray = idsstr.split(",");
		for(String id : idarray){
			Easyshopaddress easyshopaddress = new Easyshopaddress();
			
			easyshopaddress.setAddressid(id);
			easyshopaddresslist.add(easyshopaddress);
		}
		EasyshopaddressListDomain easyshopaddresslistdomain = new EasyshopaddressListDomain();
		easyshopaddresslistdomain.setEasyshopaddresslist(easyshopaddresslist);
		
		ReturnValueDomain<String> ret=EasyshopaddressServiceAPProxy.delete(easyshopaddresslistdomain);
		
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
		
		return EasyshopaddressServiceAPProxy.importExcel(entityfile);
	}
	
	/**
	 * 导出
	 */
	@RequestMapping(value="/exportexcel")
	public void exportExcel(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Easyshopaddress easyshopaddress=FormUtil.request2Domain(request, Easyshopaddress.class);
		EasyshopaddressQueryDomain easyshopaddressquerydomain = new EasyshopaddressQueryDomain();
		easyshopaddressquerydomain.setEasyshopaddress(easyshopaddress);

		ReturnValueDomain<SysEntityfile> ret=EasyshopaddressServiceAPProxy.exportExcel(easyshopaddressquerydomain);
		SysEntityfile entityfile=ret.getObject();
		String filepath=entityfile.getFilepath();
		String filename=entityfile.getFilename();
		
		FileDownloadUtil.filedownload(filename, filepath + File.separator + filename, request, response);
	}
}
