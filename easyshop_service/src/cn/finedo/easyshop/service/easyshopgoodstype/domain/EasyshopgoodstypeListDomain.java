/**
 * 商品类型列表领域对象
 *
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshopgoodstype.domain;

import java.util.List;
import java.util.ArrayList;
import cn.finedo.common.domain.BaseDomain;
import cn.finedo.easyshop.pojo.Easyshopgoodstype;

public class EasyshopgoodstypeListDomain extends BaseDomain {
	private static final long serialVersionUID = 1L;
	
	// 商品类型list
	private List<Easyshopgoodstype> easyshopgoodstypelist=new ArrayList<Easyshopgoodstype>();

	public List<Easyshopgoodstype> getEasyshopgoodstypelist() {
		return easyshopgoodstypelist;
	}

	public void setEasyshopgoodstypelist(List<Easyshopgoodstype> easyshopgoodstypelist) {
		this.easyshopgoodstypelist = easyshopgoodstypelist;
	}
}
