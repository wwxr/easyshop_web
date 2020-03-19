/**
 * 广告表查询领域对象
 *
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshopnews.domain;

import cn.finedo.common.domain.BaseDomain;
import cn.finedo.common.domain.PageParamDomain;
import cn.finedo.easyshop.pojo.Easyshopnews;

public class EasyshopnewsQueryDomain extends BaseDomain {
	private static final long serialVersionUID = 1L;
	
	// 分页信息
	private PageParamDomain pageparam = null;
	
	private Easyshopnews easyshopnews = null;

	public PageParamDomain getPageparam() {
		return pageparam;
	}

	public void setPageparam(PageParamDomain pageparam) {
		this.pageparam = pageparam;
	}

	public Easyshopnews getEasyshopnews() {
		return easyshopnews;
	}

	public void setEasyshopnews(Easyshopnews easyshopnews) {
		this.easyshopnews = easyshopnews;
	}
}
