/**
 * 用户表列表领域对象
 *
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshopuser.domain;

import java.util.List;
import java.util.ArrayList;
import cn.finedo.common.domain.BaseDomain;
import cn.finedo.easyshop.pojo.Easyshopuser;

public class EasyshopuserListDomain extends BaseDomain {
	private static final long serialVersionUID = 1L;
	
	// 用户表list
	private List<Easyshopuser> easyshopuserlist=new ArrayList<Easyshopuser>();

	public List<Easyshopuser> getEasyshopuserlist() {
		return easyshopuserlist;
	}

	public void setEasyshopuserlist(List<Easyshopuser> easyshopuserlist) {
		this.easyshopuserlist = easyshopuserlist;
	}
}
