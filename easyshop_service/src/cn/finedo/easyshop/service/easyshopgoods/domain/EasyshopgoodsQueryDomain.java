/**
 * 商品表查询领域对象
 *
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshopgoods.domain;

import cn.finedo.common.domain.BaseDomain;
import cn.finedo.common.domain.PageParamDomain;
import cn.finedo.easyshop.pojo.Easyshopgoods;

public class EasyshopgoodsQueryDomain extends BaseDomain {
	private static final long serialVersionUID = 1L;
	
	// 分页信息
	private PageParamDomain pageparam = null;
	
	private Easyshopgoods easyshopgoods = null;

	public PageParamDomain getPageparam() {
		return pageparam;
	}

	public void setPageparam(PageParamDomain pageparam) {
		this.pageparam = pageparam;
	}

	public Easyshopgoods getEasyshopgoods() {
		return easyshopgoods;
	}

	public void setEasyshopgoods(Easyshopgoods easyshopgoods) {
		this.easyshopgoods = easyshopgoods;
	}
}
