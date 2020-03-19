/**
 * 订单物品关联表查询领域对象
 *
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshopordergoods.domain;

import cn.finedo.common.domain.BaseDomain;
import cn.finedo.common.domain.PageParamDomain;
import cn.finedo.easyshop.pojo.Easyshopordergoods;

public class EasyshopordergoodsQueryDomain extends BaseDomain {
	private static final long serialVersionUID = 1L;
	
	// 分页信息
	private PageParamDomain pageparam = null;
	
	private Easyshopordergoods easyshopordergoods = null;

	public PageParamDomain getPageparam() {
		return pageparam;
	}

	public void setPageparam(PageParamDomain pageparam) {
		this.pageparam = pageparam;
	}

	public Easyshopordergoods getEasyshopordergoods() {
		return easyshopordergoods;
	}

	public void setEasyshopordergoods(Easyshopordergoods easyshopordergoods) {
		this.easyshopordergoods = easyshopordergoods;
	}
}
