/**
 * 服务接口代理
 * <本代码为工具自动生成，不要修改>
 * 
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshopordergoods;

import javax.servlet.http.HttpServletRequest;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import com.alibaba.fastjson.TypeReference;
import cn.finedo.common.non.NonUtil;
import cn.finedo.common.protocol.ServiceCaller;
import cn.finedo.fsdp.server.util.SessionUtil;
import cn.finedo.fsdp.service.login.domain.LoginDomain;
import cn.finedo.easyshop.service.easyshopordergoods.domain.EasyshopordergoodsQueryDomain;
import cn.finedo.common.domain.ReturnValueDomain;
import cn.finedo.common.domain.PageDomain;
import cn.finedo.easyshop.pojo.Easyshopordergoods;
import cn.finedo.easyshop.service.easyshopordergoods.domain.EasyshopordergoodsListDomain;
import cn.finedo.common.pojo.SysEntityfile;
import cn.finedo.common.domain.FileImportResultDomain;

public class EasyshopordergoodsServiceAPProxy {
	private EasyshopordergoodsServiceAPProxy() {
	}
			
	public static ReturnValueDomain<PageDomain<Easyshopordergoods>> query(EasyshopordergoodsQueryDomain arg) {
		String apuri="service/finedo/easyshopordergoods/query";
		
		RequestAttributes qa = RequestContextHolder.getRequestAttributes();
		String token="";
		if(NonUtil.isNotNon(qa)) {
	        HttpServletRequest request = ((ServletRequestAttributes)qa).getRequest();
	        token=getToken(request);
		}
		
		// 跨域调用，网络调用
		ReturnValueDomain<PageDomain<Easyshopordergoods>> ret = ServiceCaller.call(apuri + "?token=" + token, arg, new TypeReference<ReturnValueDomain<PageDomain<Easyshopordergoods>>>() {});
		return ret;
	}
	
	public static ReturnValueDomain<Easyshopordergoods> queryById(Easyshopordergoods arg) {
		String apuri="service/finedo/easyshopordergoods/querybyid";
		
		RequestAttributes qa = RequestContextHolder.getRequestAttributes();
		String token="";
		if(NonUtil.isNotNon(qa)) {
	        HttpServletRequest request = ((ServletRequestAttributes)qa).getRequest();
	        token=getToken(request);
		}
		
		// 跨域调用，网络调用
		ReturnValueDomain<Easyshopordergoods> ret = ServiceCaller.call(apuri + "?token=" + token, arg, new TypeReference<ReturnValueDomain<Easyshopordergoods>>() {});
		return ret;
	}
	
	public static ReturnValueDomain<String> add(EasyshopordergoodsListDomain arg) {
		String apuri="service/finedo/easyshopordergoods/add";
		
		RequestAttributes qa = RequestContextHolder.getRequestAttributes();
		String token="";
		if(NonUtil.isNotNon(qa)) {
	        HttpServletRequest request = ((ServletRequestAttributes)qa).getRequest();
	        token=getToken(request);
		}
		
		// 跨域调用，网络调用
		ReturnValueDomain<String> ret = ServiceCaller.call(apuri + "?token=" + token, arg, new TypeReference<ReturnValueDomain<String>>() {});
		return ret;
	}
	
	public static ReturnValueDomain<String> update(EasyshopordergoodsListDomain arg) {
		String apuri="service/finedo/easyshopordergoods/update";
		
		RequestAttributes qa = RequestContextHolder.getRequestAttributes();
		String token="";
		if(NonUtil.isNotNon(qa)) {
	        HttpServletRequest request = ((ServletRequestAttributes)qa).getRequest();
	        token=getToken(request);
		}
		
		// 跨域调用，网络调用
		ReturnValueDomain<String> ret = ServiceCaller.call(apuri + "?token=" + token, arg, new TypeReference<ReturnValueDomain<String>>() {});
		return ret;
	}
	
	public static ReturnValueDomain<String> delete(EasyshopordergoodsListDomain arg) {
		String apuri="service/finedo/easyshopordergoods/delete";
		
		RequestAttributes qa = RequestContextHolder.getRequestAttributes();
		String token="";
		if(NonUtil.isNotNon(qa)) {
	        HttpServletRequest request = ((ServletRequestAttributes)qa).getRequest();
	        token=getToken(request);
		}
		
		// 跨域调用，网络调用
		ReturnValueDomain<String> ret = ServiceCaller.call(apuri + "?token=" + token, arg, new TypeReference<ReturnValueDomain<String>>() {});
		return ret;
	}
	
	public static ReturnValueDomain<FileImportResultDomain> importExcel(SysEntityfile arg) {
		String apuri="service/finedo/easyshopordergoods/importexcel";
		
		RequestAttributes qa = RequestContextHolder.getRequestAttributes();
		String token="";
		if(NonUtil.isNotNon(qa)) {
	        HttpServletRequest request = ((ServletRequestAttributes)qa).getRequest();
	        token=getToken(request);
		}
		
		// 跨域调用，网络调用
		ReturnValueDomain<FileImportResultDomain> ret = ServiceCaller.call(apuri + "?token=" + token, arg, new TypeReference<ReturnValueDomain<FileImportResultDomain>>() {});
		return ret;
	}
	
	public static ReturnValueDomain<SysEntityfile> exportExcel(EasyshopordergoodsQueryDomain arg) {
		String apuri="service/finedo/easyshopordergoods/exportexcel";
		
		RequestAttributes qa = RequestContextHolder.getRequestAttributes();
		String token="";
		if(NonUtil.isNotNon(qa)) {
	        HttpServletRequest request = ((ServletRequestAttributes)qa).getRequest();
	        token=getToken(request);
		}
		
		// 跨域调用，网络调用
		ReturnValueDomain<SysEntityfile> ret = ServiceCaller.call(apuri + "?token=" + token, arg, new TypeReference<ReturnValueDomain<SysEntityfile>>() {});
		return ret;
	}
	
	private static String getToken(HttpServletRequest request) {
		String token;
		LoginDomain logindomain = SessionUtil.getLoginDomain(request);
		if(NonUtil.isNotNon(logindomain)) {
			token=logindomain.getToken();
		}else {
			token="";
		}
		
		return token;
	}
}
