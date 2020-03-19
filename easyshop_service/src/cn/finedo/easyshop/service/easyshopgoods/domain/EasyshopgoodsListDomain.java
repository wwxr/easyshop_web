/**
 * 商品表列表领域对象
 *
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshopgoods.domain;

import java.util.List;
import java.util.ArrayList;
import cn.finedo.common.domain.BaseDomain;
import cn.finedo.easyshop.pojo.Easyshopgoods;

public class EasyshopgoodsListDomain extends BaseDomain {
	private static final long serialVersionUID = 1L;
	
	// 商品表list
	private List<Easyshopgoods> easyshopgoodslist=new ArrayList<Easyshopgoods>();

	public List<Easyshopgoods> getEasyshopgoodslist() {
		return easyshopgoodslist;
	}

	public void setEasyshopgoodslist(List<Easyshopgoods> easyshopgoodslist) {
		this.easyshopgoodslist = easyshopgoodslist;
	}
}
