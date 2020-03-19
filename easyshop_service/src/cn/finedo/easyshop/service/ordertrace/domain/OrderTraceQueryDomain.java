/**
 * 订单物品关联表查询领域对象
 *
 * @version 1.0
 * @since 2019-12-23
 */
package cn.finedo.easyshop.service.ordertrace.domain;

import cn.finedo.common.domain.BaseDomain;
import cn.finedo.common.domain.PageParamDomain;
import cn.finedo.easyshop.pojo.AcceptResult;

public class OrderTraceQueryDomain extends BaseDomain {
	private static final long serialVersionUID = 1L;
	
	// 分页信息
	private PageParamDomain pageparam = null;
	
	private AcceptResult acceptResult= null;

	public PageParamDomain getPageparam() {
		return pageparam;
	}

	public void setPageparam(PageParamDomain pageparam) {
		this.pageparam = pageparam;
	}

	public AcceptResult getAcceptResult() {
		return acceptResult;
	}

	public void setAcceptResult(AcceptResult acceptResult) {
		this.acceptResult = acceptResult;
	}

}
