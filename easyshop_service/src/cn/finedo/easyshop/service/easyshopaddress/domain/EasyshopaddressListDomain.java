/**
 * 咨询表列表领域对象
 *
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshopaddress.domain;

import java.util.List;
import java.util.ArrayList;
import cn.finedo.common.domain.BaseDomain;
import cn.finedo.easyshop.pojo.Easyshopaddress;

public class EasyshopaddressListDomain extends BaseDomain {
	private static final long serialVersionUID = 1L;
	
	// 咨询表list
	private List<Easyshopaddress> easyshopaddresslist=new ArrayList<Easyshopaddress>();

	public List<Easyshopaddress> getEasyshopaddresslist() {
		return easyshopaddresslist;
	}

	public void setEasyshopaddresslist(List<Easyshopaddress> easyshopaddresslist) {
		this.easyshopaddresslist = easyshopaddresslist;
	}
}
