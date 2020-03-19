/**
 * 广告表列表领域对象
 *
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshopnews.domain;

import java.util.List;
import java.util.ArrayList;
import cn.finedo.common.domain.BaseDomain;
import cn.finedo.easyshop.pojo.Easyshopnews;

public class EasyshopnewsListDomain extends BaseDomain {
	private static final long serialVersionUID = 1L;
	
	// 广告表list
	private List<Easyshopnews> easyshopnewslist=new ArrayList<Easyshopnews>();

	public List<Easyshopnews> getEasyshopnewslist() {
		return easyshopnewslist;
	}

	public void setEasyshopnewslist(List<Easyshopnews> easyshopnewslist) {
		this.easyshopnewslist = easyshopnewslist;
	}
}
