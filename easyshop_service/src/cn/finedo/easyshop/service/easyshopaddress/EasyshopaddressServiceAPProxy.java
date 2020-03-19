/**
 * 服务接口代理
 * <本代码为工具自动生成，不要修改>
 * 
 * @version 1.0
 * @since 2020-01-28
 */
package cn.finedo.easyshop.service.easyshopaddress;

import javax.servlet.http.HttpServletRequest;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import com.alibaba.fastjson.TypeReference;
import cn.finedo.common.non.NonUtil;
import cn.finedo.common.protocol.ServiceCaller;
import cn.finedo.fsdp.server.util.SessionUtil;
import cn.finedo.fsdp.service.login.domain.LoginDomain;
import cn.finedo.easyshop.service.easyshopaddress.domain.EasyshopaddressQueryDomain;
import cn.finedo.common.domain.ReturnValueDomain;
import cn.finedo.common.domain.PageDomain;
import cn.finedo.easyshop.pojo.Easyshopaddress;
import cn.finedo.easyshop.service.easyshopaddress.domain.EasyshopaddressListDomain;
import cn.finedo.common.pojo.SysEntityfile;
import cn.finedo.common.domain.FileImportResultDomain;

public class EasyshopaddressServiceAPProxy {
	private EasyshopaddressServiceAPProxy() {
	}
			
	public static ReturnValueDomain<PageDomain<Easyshopaddress>> query(EasyshopaddressQueryDomain arg) {
		String apuri="service/finedo/easyshopaddress/query";
		
		RequestAttributes qa = RequestContextHolder.getRequestAttributes();
		String token="";
		if(NonUtil.isNotNon(qa)) {
	        HttpServletRequest request = ((ServletRequestAttributes)qa).getRequest();
	        token=getToken(request);
		}
		
		// 跨域调用，网络调用
		ReturnValueDomain<PageDomain<Easyshopaddress>> ret = ServiceCaller.call(apuri + "?token=" + token, arg, new TypeReference<ReturnValueDomain<PageDomain<Easyshopaddress>>>() {});
		return ret;
	}
	
	public static ReturnValueDomain<Easyshopaddress> queryById(Easyshopaddress arg) {
		String apuri="service/finedo/easyshopaddress/querybyid";
		
		RequestAttributes qa = RequestContextHolder.getRequestAttributes();
		String token="";
		if(NonUtil.isNotNon(qa)) {
	        HttpServletRequest request = ((ServletRequestAttributes)qa).getRequest();
	        token=getToken(request);
		}
		
		// 跨域调用，网络调用
		ReturnValueDomain<Easyshopaddress> ret = ServiceCaller.call(apuri + "?token=" + token, arg, new TypeReference<ReturnValueDomain<Easyshopaddress>>() {});
		return ret;
	}
	
	public static ReturnValueDomain<String> add(EasyshopaddressListDomain arg) {
		String apuri="service/finedo/easyshopaddress/add";
		
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
	
	public static ReturnValueDomain<String> update(EasyshopaddressListDomain arg) {
		String apuri="service/finedo/easyshopaddress/update";
		
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
	
	public static ReturnValueDomain<String> delete(EasyshopaddressListDomain arg) {
		String apuri="service/finedo/easyshopaddress/delete";
		
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
		String apuri="service/finedo/easyshopaddress/importexcel";
		
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
	
	public static ReturnValueDomain<SysEntityfile> exportExcel(EasyshopaddressQueryDomain arg) {
		String apuri="service/finedo/easyshopaddress/exportexcel";
		
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
