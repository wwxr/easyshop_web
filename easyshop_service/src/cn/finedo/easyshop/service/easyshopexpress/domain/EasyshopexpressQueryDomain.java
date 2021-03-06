/**
 * 物流表查询领域对象
 *
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshopexpress.domain;

import cn.finedo.common.domain.BaseDomain;
import cn.finedo.common.domain.PageParamDomain;
import cn.finedo.easyshop.pojo.Easyshopexpress;

public class EasyshopexpressQueryDomain extends BaseDomain {
	private static final long serialVersionUID = 1L;
	
	// 分页信息
	private PageParamDomain pageparam = null;
	
	private Easyshopexpress easyshopexpress = null;

	public PageParamDomain getPageparam() {
		return pageparam;
	}

	public void setPageparam(PageParamDomain pageparam) {
		this.pageparam = pageparam;
	}

	public Easyshopexpress getEasyshopexpress() {
		return easyshopexpress;
	}

	public void setEasyshopexpress(Easyshopexpress easyshopexpress) {
		this.easyshopexpress = easyshopexpress;
	}
}
