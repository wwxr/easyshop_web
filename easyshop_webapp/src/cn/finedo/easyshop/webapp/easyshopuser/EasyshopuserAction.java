/**
 * 用户表管理Action
 * 
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.webapp.easyshopuser;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
import cn.finedo.easyshop.pojo.Easyshopuser;
import cn.finedo.easyshop.service.easyshopuser.EasyshopuserServiceAPProxy;
import cn.finedo.easyshop.service.easyshopuser.domain.EasyshopuserListDomain;
import cn.finedo.easyshop.service.easyshopuser.domain.EasyshopuserQueryDomain;
import cn.finedo.easyshop.webapp.util.WxChat;

@Controller
@Scope("singleton")
@RequestMapping("/finedo/easyshopuser")
public class EasyshopuserAction {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/**
	 * 跳转用户表列表页面
	 */
	@RequestMapping("/list")
	public String list(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopuser/list.jsp";
	}

	/**
	 * 跳转用户表增加页面
	 */
	@RequestMapping("/addindex")
	public String addIndex(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopuser/add.jsp";
	}

	/**
	 * 跳转用户表修改页面
	 */
	@RequestMapping("/updateindex")
	public String updateIndex(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopuser/modify.jsp";
	}

	/**
	 * 跳转用户表详情页面
	 */
	@RequestMapping("/detailindex")
	public String detailIndex(HttpServletRequest request) throws Exception {
		return "/easyshop/easyshopuser/detail.jsp";
	}
	
	/**
	 * 用户表查询
	 * @param Easyshopuser
	 * @param PageParamDomain
	 */
	@RequestMapping("/query")
	@ResponseBody
	public Object query(HttpServletRequest request) throws Exception {
		Easyshopuser easyshopuser = FormUtil.request2Domain(request, Easyshopuser.class);
		PageParamDomain pageparam=PageUtil.getPageParam(request);
		
		EasyshopuserQueryDomain easyshopuserquerydomain = new EasyshopuserQueryDomain();
		easyshopuserquerydomain.setEasyshopuser(easyshopuser);
		easyshopuserquerydomain.setPageparam(pageparam);
		
		ReturnValueDomain<PageDomain<Easyshopuser>> ret=EasyshopuserServiceAPProxy.query(easyshopuserquerydomain);
		PageDomain<Easyshopuser> page = ret.getObject();
		
		return PageUtil.build(page.getDatalist(), page.getRowcount());
	}
	/**
	 * 用户登录
	 * @param Easyshopuser
	 * @param PageParamDomain
	 */
	@RequestMapping("/userlogin")
	@ResponseBody
	public Object userlogin(HttpServletRequest request) throws Exception {
		ReturnValueDomain<Easyshopuser> returnValueDomain=new ReturnValueDomain<Easyshopuser>();
		Easyshopuser easyshopuser = FormUtil.request2Domain(request, Easyshopuser.class);
		//昵称乱码
//		String nickname=easyshopuser.getNickname();
//		nickname=URLEncoder.encode(nickname, "utf-8");
//		easyshopuser.setNickname(nickname);
		Easyshopuser user=new Easyshopuser();
		
		String code=easyshopuser.getCode();
		Map< String, String> map=WxChat.getOpenid(code);
		String openid =map.get("openid");
		user.setOpenid(openid);
		easyshopuser.setOpenid(openid);
		ReturnValueDomain<Easyshopuser> ret = EasyshopuserServiceAPProxy.queryById(user);
		if(NonUtil.isNon(ret.getObject())) {
			returnValueDomain=EasyshopuserServiceAPProxy.addloginuser(easyshopuser);
		}else{
			returnValueDomain.setObject(ret.getObject());
		};
		return returnValueDomain;
	}
	
	/**
	 * 用户表按主键查询
	 * @param Easyshopuser
	 * @param PageParamDomain
	 */
	@RequestMapping("/querybyid")
	@ResponseBody
	public Object queryById(HttpServletRequest request) throws Exception {
		Easyshopuser easyshopuser = FormUtil.request2Domain(request, Easyshopuser.class);
		ReturnValueDomain<Easyshopuser> ret = EasyshopuserServiceAPProxy.queryById(easyshopuser);
		return ret;
	}
	
	/**
	 * 用户表新增
	 * @param EasyshopuserListDomain
	 */
	@RequestMapping("/add")
	@ResponseBody
	public Object add(HttpServletRequest request) throws Exception {
		Easyshopuser easyshopuser = FormUtil.request2Domain(request, Easyshopuser.class);
		
		EasyshopuserListDomain easyshopuserlistdomain = new EasyshopuserListDomain();
		List<Easyshopuser> easyshopuserlist=new ArrayList<Easyshopuser>();
		easyshopuserlist.add(easyshopuser);
		easyshopuserlistdomain.setEasyshopuserlist(easyshopuserlist);
	
		ReturnValueDomain<String> ret=EasyshopuserServiceAPProxy.add(easyshopuserlistdomain);
		
		return ret;
	}
	
	/**
	 * 用户表修改
	 * @param EasyshopuserListDomain
	 */
	@RequestMapping("/modify")
	@ResponseBody
	public Object modify(HttpServletRequest request) throws Exception {
		// 传入的领域对象
		Easyshopuser easyshopuser = FormUtil.request2Domain(request, Easyshopuser.class);
		
		EasyshopuserListDomain easyshopuserlistdomain = new EasyshopuserListDomain();
		List<Easyshopuser> easyshopuserlist=new ArrayList<Easyshopuser>();
		easyshopuserlist.add(easyshopuser);
		easyshopuserlistdomain.setEasyshopuserlist(easyshopuserlist);
		
		ReturnValueDomain<String> ret=EasyshopuserServiceAPProxy.update(easyshopuserlistdomain);
		
		return ret;
	}

	/**
	 * 用户表删除
	 * @param EasyshopuserListDomain
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public Object delete(HttpServletRequest request) throws Exception{
		// 传入的领域对象
		List<Easyshopuser> easyshopuserlist=new ArrayList<Easyshopuser>();
		
		String idsstr = request.getParameter("id");
		String[] idarray = idsstr.split(",");
		for(String id : idarray){
			Easyshopuser easyshopuser = new Easyshopuser();
			
			easyshopuser.setUserid(id);
			easyshopuserlist.add(easyshopuser);
		}
		EasyshopuserListDomain easyshopuserlistdomain = new EasyshopuserListDomain();
		easyshopuserlistdomain.setEasyshopuserlist(easyshopuserlist);
		
		ReturnValueDomain<String> ret=EasyshopuserServiceAPProxy.delete(easyshopuserlistdomain);
		
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
		
		return EasyshopuserServiceAPProxy.importExcel(entityfile);
	}
	
	/**
	 * 导出
	 */
	@RequestMapping(value="/exportexcel")
	public void exportExcel(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Easyshopuser easyshopuser=FormUtil.request2Domain(request, Easyshopuser.class);
		EasyshopuserQueryDomain easyshopuserquerydomain = new EasyshopuserQueryDomain();
		easyshopuserquerydomain.setEasyshopuser(easyshopuser);

		ReturnValueDomain<SysEntityfile> ret=EasyshopuserServiceAPProxy.exportExcel(easyshopuserquerydomain);
		SysEntityfile entityfile=ret.getObject();
		String filepath=entityfile.getFilepath();
		String filename=entityfile.getFilename();
		
		FileDownloadUtil.filedownload(filename, filepath + File.separator + filename, request, response);
	}
}
