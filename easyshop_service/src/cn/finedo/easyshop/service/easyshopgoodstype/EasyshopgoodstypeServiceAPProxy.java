/**
 * 服务接口代理
 * <本代码为工具自动生成，不要修改>
 * 
 * @version 1.0
 * @since 2020-01-08
 */
package cn.finedo.easyshop.service.easyshopgoodstype;

import javax.servlet.http.HttpServletRequest;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import com.alibaba.fastjson.TypeReference;
import cn.finedo.common.non.NonUtil;
import cn.finedo.common.protocol.ServiceCaller;
import cn.finedo.fsdp.server.util.SessionUtil;
import cn.finedo.fsdp.service.login.domain.LoginDomain;
import cn.finedo.easyshop.service.easyshopgoodstype.domain.EasyshopgoodstypeQueryDomain;
import cn.finedo.common.domain.ReturnValueDomain;
import cn.finedo.common.domain.PageDomain;
import cn.finedo.easyshop.pojo.Easyshopgoodstype;
import java.util.List;
import cn.finedo.easyshop.pojo.ResultGoodsType;
import cn.finedo.easyshop.service.easyshopgoodstype.domain.EasyshopgoodstypeListDomain;
import cn.finedo.common.pojo.SysEntityfile;
import cn.finedo.common.domain.FileImportResultDomain;

public class EasyshopgoodstypeServiceAPProxy {
	private EasyshopgoodstypeServiceAPProxy() {
	}
			
	public static ReturnValueDomain<PageDomain<Easyshopgoodstype>> query(EasyshopgoodstypeQueryDomain arg) {
		String apuri="service/finedo/easyshopgoodstype/query";
		
		RequestAttributes qa = RequestContextHolder.getRequestAttributes();
		String token="";
		if(NonUtil.isNotNon(qa)) {
	        HttpServletRequest request = ((ServletRequestAttributes)qa).getRequest();
	        token=getToken(request);
		}
		
		// 跨域调用，网络调用
		ReturnValueDomain<PageDomain<Easyshopgoodstype>> ret = ServiceCaller.call(apuri + "?token=" + token, arg, new TypeReference<ReturnValueDomain<PageDomain<Easyshopgoodstype>>>() {});
		return ret;
	}
	
	public static ReturnValueDomain<List<ResultGoodsType>> querygoodstypes(Easyshopgoodstype arg) {
		String apuri="service/finedo/easyshopgoodstype/querygoodstypes";
		
		RequestAttributes qa = RequestContextHolder.getRequestAttributes();
		String token="";
		if(NonUtil.isNotNon(qa)) {
	        HttpServletRequest request = ((ServletRequestAttributes)qa).getRequest();
	        token=getToken(request);
		}
		
		// 跨域调用，网络调用
		ReturnValueDomain<List<ResultGoodsType>> ret = ServiceCaller.call(apuri + "?token=" + token, arg, new TypeReference<ReturnValueDomain<List<ResultGoodsType>>>() {});
		return ret;
	}
	
	public static ReturnValueDomain<List<Easyshopgoodstype>> querygoodstypelist(Easyshopgoodstype arg) {
		String apuri="service/finedo/easyshopgoodstype/querygoodstypelist";
		
		RequestAttributes qa = RequestContextHolder.getRequestAttributes();
		String token="";
		if(NonUtil.isNotNon(qa)) {
	        HttpServletRequest request = ((ServletRequestAttributes)qa).getRequest();
	        token=getToken(request);
		}
		
		// 跨域调用，网络调用
		ReturnValueDomain<List<Easyshopgoodstype>> ret = ServiceCaller.call(apuri + "?token=" + token, arg, new TypeReference<ReturnValueDomain<List<Easyshopgoodstype>>>() {});
		return ret;
	}
	
	public static ReturnValueDomain<Easyshopgoodstype> queryById(Easyshopgoodstype arg) {
		String apuri="service/finedo/easyshopgoodstype/querybyid";
		
		RequestAttributes qa = RequestContextHolder.getRequestAttributes();
		String token="";
		if(NonUtil.isNotNon(qa)) {
	        HttpServletRequest request = ((ServletRequestAttributes)qa).getRequest();
	        token=getToken(request);
		}
		
		// 跨域调用，网络调用
		ReturnValueDomain<Easyshopgoodstype> ret = ServiceCaller.call(apuri + "?token=" + token, arg, new TypeReference<ReturnValueDomain<Easyshopgoodstype>>() {});
		return ret;
	}
	
	public static ReturnValueDomain<String> add(EasyshopgoodstypeListDomain arg) {
		String apuri="service/finedo/easyshopgoodstype/add";
		
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
	
	public static ReturnValueDomain<String> update(EasyshopgoodstypeListDomain arg) {
		String apuri="service/finedo/easyshopgoodstype/update";
		
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
	
	public static ReturnValueDomain<String> delete(EasyshopgoodstypeListDomain arg) {
		String apuri="service/finedo/easyshopgoodstype/delete";
		
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
		String apuri="service/finedo/easyshopgoodstype/importexcel";
		
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
	
	public static ReturnValueDomain<SysEntityfile> exportExcel(EasyshopgoodstypeQueryDomain arg) {
		String apuri="service/finedo/easyshopgoodstype/exportexcel";
		
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
