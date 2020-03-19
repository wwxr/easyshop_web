/**
 * 物流表列表领域对象
 *
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshopexpress.domain;

import java.util.List;
import java.util.ArrayList;
import cn.finedo.common.domain.BaseDomain;
import cn.finedo.easyshop.pojo.Easyshopexpress;

public class EasyshopexpressListDomain extends BaseDomain {
	private static final long serialVersionUID = 1L;
	
	// 物流表list
	private List<Easyshopexpress> easyshopexpresslist=new ArrayList<Easyshopexpress>();

	public List<Easyshopexpress> getEasyshopexpresslist() {
		return easyshopexpresslist;
	}

	public void setEasyshopexpresslist(List<Easyshopexpress> easyshopexpresslist) {
		this.easyshopexpresslist = easyshopexpresslist;
	}
}
