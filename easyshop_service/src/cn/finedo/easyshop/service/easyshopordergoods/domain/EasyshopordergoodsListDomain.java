/**
 * 订单物品关联表列表领域对象
 *
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshopordergoods.domain;

import java.util.List;
import java.util.ArrayList;
import cn.finedo.common.domain.BaseDomain;
import cn.finedo.easyshop.pojo.Easyshopordergoods;

public class EasyshopordergoodsListDomain extends BaseDomain {
	private static final long serialVersionUID = 1L;
	
	// 订单物品关联表list
	private List<Easyshopordergoods> easyshopordergoodslist=new ArrayList<Easyshopordergoods>();

	public List<Easyshopordergoods> getEasyshopordergoodslist() {
		return easyshopordergoodslist;
	}

	public void setEasyshopordergoodslist(List<Easyshopordergoods> easyshopordergoodslist) {
		this.easyshopordergoodslist = easyshopordergoodslist;
	}
}
