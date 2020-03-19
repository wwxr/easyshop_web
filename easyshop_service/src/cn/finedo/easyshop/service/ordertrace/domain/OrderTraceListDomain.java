/**
 * 订单物品关联表列表领域对象
 *
 * @version 1.0
 * @since 2019-12-23
 */
package cn.finedo.easyshop.service.ordertrace.domain;

import java.util.List;
import java.util.ArrayList;
import cn.finedo.common.domain.BaseDomain;
import cn.finedo.easyshop.pojo.AcceptResult;

public class OrderTraceListDomain extends BaseDomain {
	private static final long serialVersionUID = 1L;
	
	// 订单物品关联表list
	private List<AcceptResult> acceptResults=new ArrayList<AcceptResult>();

	public List<AcceptResult> getAcceptResults() {
		return acceptResults;
	}

	public void setAcceptResults(List<AcceptResult> acceptResults) {
		this.acceptResults = acceptResults;
	}

}
