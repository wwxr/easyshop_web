/**
 * 商品类型查询领域对象
 *
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshopgoodstype.domain;

import cn.finedo.common.domain.BaseDomain;
import cn.finedo.common.domain.PageParamDomain;
import cn.finedo.easyshop.pojo.Easyshopgoodstype;

public class EasyshopgoodstypeQueryDomain extends BaseDomain {
	private static final long serialVersionUID = 1L;
	
	// 分页信息
	private PageParamDomain pageparam = null;
	
	private Easyshopgoodstype easyshopgoodstype = null;

	public PageParamDomain getPageparam() {
		return pageparam;
	}

	public void setPageparam(PageParamDomain pageparam) {
		this.pageparam = pageparam;
	}

	public Easyshopgoodstype getEasyshopgoodstype() {
		return easyshopgoodstype;
	}

	public void setEasyshopgoodstype(Easyshopgoodstype easyshopgoodstype) {
		this.easyshopgoodstype = easyshopgoodstype;
	}
}
