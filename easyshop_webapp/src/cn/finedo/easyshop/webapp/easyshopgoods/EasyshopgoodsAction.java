/**
 * 商品表管理Action
 * 
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.webapp.easyshopgoods;

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
import cn.finedo.easyshop.pojo.Easyshopgoods;
import cn.finedo.easyshop.service.easyshopgoods.EasyshopgoodsServiceAPProxy;
import cn.finedo.easyshop.service.easyshopgoods.domain.EasyshopgoodsListDomain;
import cn.finedo.easyshop.service.easyshopgoods.domain.EasyshopgoodsQueryDomain;

@Controller
@Scope("singleton")
@RequestMapping("/finedo/easyshopgoods")
public class EasyshopgoodsAction {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/**
	 * 跳转商品表列表页面
	 */
	@RequestMapping("/list")
	public String list(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopgoods/list.jsp";
	}

	/**
	 * 跳转商品表增加页面
	 */
	@RequestMapping("/addindex")
	public String addIndex(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopgoods/add.jsp";
	}

	/**
	 * 跳转商品表修改页面
	 */
	@RequestMapping("/updateindex")
	public String updateIndex(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopgoods/modify.jsp";
	}

	/**
	 * 跳转商品表详情页面
	 */
	@RequestMapping("/detailindex")
	public String detailIndex(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopgoods/detail.jsp";
	}
	
	/**
	 * 商品表查询
	 * @param Easyshopgoods
	 * @param PageParamDomain
	 */
	@RequestMapping("/query")
	@ResponseBody
	public Object query(HttpServletRequest request) throws Exception {
		Easyshopgoods easyshopgoods = FormUtil.request2Domain(request, Easyshopgoods.class);
		PageParamDomain pageparam=PageUtil.getPageParam(request);
		
		EasyshopgoodsQueryDomain easyshopgoodsquerydomain = new EasyshopgoodsQueryDomain();
		easyshopgoodsquerydomain.setEasyshopgoods(easyshopgoods);
		easyshopgoodsquerydomain.setPageparam(pageparam);
		
		ReturnValueDomain<PageDomain<Easyshopgoods>> ret=EasyshopgoodsServiceAPProxy.query(easyshopgoodsquerydomain);
		PageDomain<Easyshopgoods> page = ret.getObject();
		
		return PageUtil.build(page.getDatalist(), page.getRowcount());
	}
	
	/**
	 * 商品表按主键查询
	 * @param Easyshopgoods
	 * @param PageParamDomain
	 */
	@RequestMapping("/querybyid")
	@ResponseBody
	public Object queryById(HttpServletRequest request) throws Exception {
		Easyshopgoods easyshopgoods = FormUtil.request2Domain(request, Easyshopgoods.class);
		ReturnValueDomain<Easyshopgoods> ret = EasyshopgoodsServiceAPProxy.queryById(easyshopgoods);
		return ret;
	}
	
	/**
	 * 商品表新增
	 * @param EasyshopgoodsListDomain
	 */
	@RequestMapping("/add")
	@ResponseBody
	public Object add(HttpServletRequest request) throws Exception {
		Easyshopgoods easyshopgoods = FormUtil.request2Domain(request, Easyshopgoods.class);
		
		EasyshopgoodsListDomain easyshopgoodslistdomain = new EasyshopgoodsListDomain();
		List<Easyshopgoods> easyshopgoodslist=new ArrayList<Easyshopgoods>();
		easyshopgoodslist.add(easyshopgoods);
		easyshopgoodslistdomain.setEasyshopgoodslist(easyshopgoodslist);
	
		ReturnValueDomain<String> ret=EasyshopgoodsServiceAPProxy.add(easyshopgoodslistdomain);
		
		return ret;
	}
	
	/**
	 * 商品表修改
	 * @param EasyshopgoodsListDomain
	 */
	@RequestMapping("/modify")
	@ResponseBody
	public Object modify(HttpServletRequest request) throws Exception {
		// 传入的领域对象
		Easyshopgoods easyshopgoods = FormUtil.request2Domain(request, Easyshopgoods.class);
		
		EasyshopgoodsListDomain easyshopgoodslistdomain = new EasyshopgoodsListDomain();
		List<Easyshopgoods> easyshopgoodslist=new ArrayList<Easyshopgoods>();
		easyshopgoodslist.add(easyshopgoods);
		easyshopgoodslistdomain.setEasyshopgoodslist(easyshopgoodslist);
		
		ReturnValueDomain<String> ret=EasyshopgoodsServiceAPProxy.update(easyshopgoodslistdomain);
		
		return ret;
	}

	/**
	 * 商品表删除
	 * @param EasyshopgoodsListDomain
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public Object delete(HttpServletRequest request) throws Exception{
		// 传入的领域对象
		List<Easyshopgoods> easyshopgoodslist=new ArrayList<Easyshopgoods>();
		
		String idsstr = request.getParameter("id");
		String[] idarray = idsstr.split(",");
		for(String id : idarray){
			Easyshopgoods easyshopgoods = new Easyshopgoods();
			
			easyshopgoods.setGoodsid(id);
			easyshopgoodslist.add(easyshopgoods);
		}
		EasyshopgoodsListDomain easyshopgoodslistdomain = new EasyshopgoodsListDomain();
		easyshopgoodslistdomain.setEasyshopgoodslist(easyshopgoodslist);
		
		ReturnValueDomain<String> ret=EasyshopgoodsServiceAPProxy.delete(easyshopgoodslistdomain);
		
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
		
		return EasyshopgoodsServiceAPProxy.importExcel(entityfile);
	}
	
	/**
	 * 导出
	 */
	@RequestMapping(value="/exportexcel")
	public void exportExcel(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Easyshopgoods easyshopgoods=FormUtil.request2Domain(request, Easyshopgoods.class);
		EasyshopgoodsQueryDomain easyshopgoodsquerydomain = new EasyshopgoodsQueryDomain();
		easyshopgoodsquerydomain.setEasyshopgoods(easyshopgoods);

		ReturnValueDomain<SysEntityfile> ret=EasyshopgoodsServiceAPProxy.exportExcel(easyshopgoodsquerydomain);
		SysEntityfile entityfile=ret.getObject();
		String filepath=entityfile.getFilepath();
		String filename=entityfile.getFilename();
		
		FileDownloadUtil.filedownload(filename, filepath + File.separator + filename, request, response);
	}
}
