/**
 * 订单物品关联表管理Action
 * 
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.webapp.easyshopordergoods;

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
import cn.finedo.easyshop.pojo.Easyshopordergoods;
import cn.finedo.easyshop.service.easyshopordergoods.EasyshopordergoodsServiceAPProxy;
import cn.finedo.easyshop.service.easyshopordergoods.domain.EasyshopordergoodsListDomain;
import cn.finedo.easyshop.service.easyshopordergoods.domain.EasyshopordergoodsQueryDomain;

@Controller
@Scope("singleton")
@RequestMapping("/finedo/easyshopordergoods")
public class EasyshopordergoodsAction {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/**
	 * 跳转订单物品关联表列表页面
	 */
	@RequestMapping("/list")
	public String list(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopordergoods/list.jsp";
	}

	/**
	 * 跳转订单物品关联表增加页面
	 */
	@RequestMapping("/addindex")
	public String addIndex(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopordergoods/add.jsp";
	}

	/**
	 * 跳转订单物品关联表修改页面
	 */
	@RequestMapping("/updateindex")
	public String updateIndex(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopordergoods/modify.jsp";
	}

	/**
	 * 跳转订单物品关联表详情页面
	 */
	@RequestMapping("/detailindex")
	public String detailIndex(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopordergoods/detail.jsp";
	}
	
	/**
	 * 订单物品关联表查询
	 * @param Easyshopordergoods
	 * @param PageParamDomain
	 */
	@RequestMapping("/query")
	@ResponseBody
	public Object query(HttpServletRequest request) throws Exception {
		Easyshopordergoods easyshopordergoods = FormUtil.request2Domain(request, Easyshopordergoods.class);
		PageParamDomain pageparam=PageUtil.getPageParam(request);
		
		EasyshopordergoodsQueryDomain easyshopordergoodsquerydomain = new EasyshopordergoodsQueryDomain();
		easyshopordergoodsquerydomain.setEasyshopordergoods(easyshopordergoods);
		easyshopordergoodsquerydomain.setPageparam(pageparam);
		
		ReturnValueDomain<PageDomain<Easyshopordergoods>> ret=EasyshopordergoodsServiceAPProxy.query(easyshopordergoodsquerydomain);
		PageDomain<Easyshopordergoods> page = ret.getObject();
		
		return PageUtil.build(page.getDatalist(), page.getRowcount());
	}
	
	/**
	 * 订单物品关联表按主键查询
	 * @param Easyshopordergoods
	 * @param PageParamDomain
	 */
	@RequestMapping("/querybyid")
	@ResponseBody
	public Object queryById(HttpServletRequest request) throws Exception {
		Easyshopordergoods easyshopordergoods = FormUtil.request2Domain(request, Easyshopordergoods.class);
		ReturnValueDomain<Easyshopordergoods> ret = EasyshopordergoodsServiceAPProxy.queryById(easyshopordergoods);
		return ret;
	}
	
	/**
	 * 订单物品关联表新增
	 * @param EasyshopordergoodsListDomain
	 */
	@RequestMapping("/add")
	@ResponseBody
	public Object add(HttpServletRequest request) throws Exception {
		Easyshopordergoods easyshopordergoods = FormUtil.request2Domain(request, Easyshopordergoods.class);
		
		EasyshopordergoodsListDomain easyshopordergoodslistdomain = new EasyshopordergoodsListDomain();
		List<Easyshopordergoods> easyshopordergoodslist=new ArrayList<Easyshopordergoods>();
		easyshopordergoodslist.add(easyshopordergoods);
		easyshopordergoodslistdomain.setEasyshopordergoodslist(easyshopordergoodslist);
	
		ReturnValueDomain<String> ret=EasyshopordergoodsServiceAPProxy.add(easyshopordergoodslistdomain);
		
		return ret;
	}
	
	/**
	 * 订单物品关联表修改
	 * @param EasyshopordergoodsListDomain
	 */
	@RequestMapping("/modify")
	@ResponseBody
	public Object modify(HttpServletRequest request) throws Exception {
		// 传入的领域对象
		Easyshopordergoods easyshopordergoods = FormUtil.request2Domain(request, Easyshopordergoods.class);
		
		EasyshopordergoodsListDomain easyshopordergoodslistdomain = new EasyshopordergoodsListDomain();
		List<Easyshopordergoods> easyshopordergoodslist=new ArrayList<Easyshopordergoods>();
		easyshopordergoodslist.add(easyshopordergoods);
		easyshopordergoodslistdomain.setEasyshopordergoodslist(easyshopordergoodslist);
		
		ReturnValueDomain<String> ret=EasyshopordergoodsServiceAPProxy.update(easyshopordergoodslistdomain);
		
		return ret;
	}

	/**
	 * 订单物品关联表删除
	 * @param EasyshopordergoodsListDomain
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public Object delete(HttpServletRequest request) throws Exception{
		// 传入的领域对象
		List<Easyshopordergoods> easyshopordergoodslist=new ArrayList<Easyshopordergoods>();
		
		String idsstr = request.getParameter("id");
		String[] idarray = idsstr.split(",");
		for(String id : idarray){
			Easyshopordergoods easyshopordergoods = new Easyshopordergoods();
			
			easyshopordergoods.setOrdergoodsid(id);
			easyshopordergoodslist.add(easyshopordergoods);
		}
		EasyshopordergoodsListDomain easyshopordergoodslistdomain = new EasyshopordergoodsListDomain();
		easyshopordergoodslistdomain.setEasyshopordergoodslist(easyshopordergoodslist);
		
		ReturnValueDomain<String> ret=EasyshopordergoodsServiceAPProxy.delete(easyshopordergoodslistdomain);
		
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
		
		return EasyshopordergoodsServiceAPProxy.importExcel(entityfile);
	}
	
	/**
	 * 导出
	 */
	@RequestMapping(value="/exportexcel")
	public void exportExcel(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Easyshopordergoods easyshopordergoods=FormUtil.request2Domain(request, Easyshopordergoods.class);
		EasyshopordergoodsQueryDomain easyshopordergoodsquerydomain = new EasyshopordergoodsQueryDomain();
		easyshopordergoodsquerydomain.setEasyshopordergoods(easyshopordergoods);

		ReturnValueDomain<SysEntityfile> ret=EasyshopordergoodsServiceAPProxy.exportExcel(easyshopordergoodsquerydomain);
		SysEntityfile entityfile=ret.getObject();
		String filepath=entityfile.getFilepath();
		String filename=entityfile.getFilename();
		
		FileDownloadUtil.filedownload(filename, filepath + File.separator + filename, request, response);
	}
}
