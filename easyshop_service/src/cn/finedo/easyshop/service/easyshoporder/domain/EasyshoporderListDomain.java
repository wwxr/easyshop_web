/**
 * 订单表列表领域对象
 *
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshoporder.domain;

import java.util.List;
import java.util.ArrayList;
import cn.finedo.common.domain.BaseDomain;
import cn.finedo.easyshop.pojo.Easyshoporder;

public class EasyshoporderListDomain extends BaseDomain {
	private static final long serialVersionUID = 1L;
	
	// 订单表list
	private List<Easyshoporder> easyshoporderlist=new ArrayList<Easyshoporder>();

	public List<Easyshoporder> getEasyshoporderlist() {
		return easyshoporderlist;
	}

	public void setEasyshoporderlist(List<Easyshoporder> easyshoporderlist) {
		this.easyshoporderlist = easyshoporderlist;
	}
}
