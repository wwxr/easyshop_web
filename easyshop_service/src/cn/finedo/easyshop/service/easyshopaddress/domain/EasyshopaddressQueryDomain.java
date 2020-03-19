/**
 * 咨询表查询领域对象
 *
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshopaddress.domain;

import cn.finedo.common.domain.BaseDomain;
import cn.finedo.common.domain.PageParamDomain;
import cn.finedo.easyshop.pojo.Easyshopaddress;

public class EasyshopaddressQueryDomain extends BaseDomain {
	private static final long serialVersionUID = 1L;
	
	// 分页信息
	private PageParamDomain pageparam = null;
	
	private Easyshopaddress easyshopaddress = null;

	public PageParamDomain getPageparam() {
		return pageparam;
	}

	public void setPageparam(PageParamDomain pageparam) {
		this.pageparam = pageparam;
	}

	public Easyshopaddress getEasyshopaddress() {
		return easyshopaddress;
	}

	public void setEasyshopaddress(Easyshopaddress easyshopaddress) {
		this.easyshopaddress = easyshopaddress;
	}
}
