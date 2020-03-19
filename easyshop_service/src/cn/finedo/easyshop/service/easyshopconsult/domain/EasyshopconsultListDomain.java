/**
 * 咨询表列表领域对象
 *
 * @version 1.0
 * @since 2019-12-24
 */
package cn.finedo.easyshop.service.easyshopconsult.domain;

import java.util.List;
import java.util.ArrayList;
import cn.finedo.common.domain.BaseDomain;
import cn.finedo.easyshop.pojo.Easyshopconsult;

public class EasyshopconsultListDomain extends BaseDomain {
	private static final long serialVersionUID = 1L;
	
	// 咨询表list
	private List<Easyshopconsult> easyshopconsultlist=new ArrayList<Easyshopconsult>();

	public List<Easyshopconsult> getEasyshopconsultlist() {
		return easyshopconsultlist;
	}

	public void setEasyshopconsultlist(List<Easyshopconsult> easyshopconsultlist) {
		this.easyshopconsultlist = easyshopconsultlist;
	}
}
