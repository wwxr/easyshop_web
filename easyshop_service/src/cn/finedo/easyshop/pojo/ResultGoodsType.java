package cn.finedo.easyshop.pojo;

import java.util.List;

import cn.finedo.common.domain.BaseDomain;

public class ResultGoodsType extends BaseDomain{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
//	标识:ABCDEF...
	private String  identify;
//	大类id
	private String typeid;
//	类型名称
	private String typename;
//	小类集合
	private List<Easyshopgoodstype> goodstypes;
	
	public String getTypename() {
		return typename;
	}
	public void setTypename(String typename) {
		this.typename = typename;
	}
	public String getIdentify() {
		return identify;
	}
	public void setIdentify(String identify) {
		this.identify = identify;
	}
	public String getTypeid() {
		return typeid;
	}
	public void setTypeid(String typeid) {
		this.typeid = typeid;
	}
	public List<Easyshopgoodstype> getGoodstypes() {
		return goodstypes;
	}
	public void setGoodstypes(List<Easyshopgoodstype> goodstypes) {
		this.goodstypes = goodstypes;
	}
	
}
