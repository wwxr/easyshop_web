/*
 *订单物品关联表
 *
 *@version:1.0
 *@company:finedo.cn
 */
package cn.finedo.easyshop.pojo;

import cn.finedo.common.domain.BaseDomain;

public class Easyshopordergoods extends BaseDomain {
	private static final long serialVersionUID = 1L;

	//订单物品关联主键id
	private String ordergoodsid;

	//订单编号
	private String ordercode;

	//物品id
	private String goodsid;

	//物品id 名称
	private String goodsname;

	public void setOrdergoodsid(String ordergoodsid) {
		this.ordergoodsid = ordergoodsid;
	}

	public String getOrdergoodsid() {
		return this.ordergoodsid;
	}

	public void setOrdercode(String ordercode) {
		this.ordercode = ordercode;
	}

	public String getOrdercode() {
		return this.ordercode;
	}

	public void setGoodsid(String goodsid) {
		this.goodsid = goodsid;
	}

	public String getGoodsid() {
		return this.goodsid;
	}

	public void setGoodsname(String goodsname) {
		this.goodsname = goodsname;
	}

	public String getGoodsname() {
		return this.goodsname;
	}

}
