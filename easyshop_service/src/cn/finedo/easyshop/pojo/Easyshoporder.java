/*
 *订单表
 *
 *@version:1.0
 *@company:finedo.cn
 */
package cn.finedo.easyshop.pojo;

import java.util.List;

import cn.finedo.common.domain.BaseDomain;

public class Easyshoporder extends BaseDomain {
	private static final long serialVersionUID = 1L;

	//主键id
	private String ordercode;

	//用户id
	private String userid;

	//订单状态：待付款-nopay;已付款-payed;invalid-已失效
	private String orderstate;

	//快递公司编码
	private String shippercode;

	//物流单号
	private String logisticcode;

	//是否失效：Y-是；N-否
	private String isinvalid;

	//支付时间
	private String paytime;

	//支付时间
	private String paytimebegin;

	//支付时间
	private String paytimeend;

	//创建时间
	private String createtime;

	//创建时间
	private String createtimebegin;

	//创建时间
	private String createtimeend;

	//订单金额
	private String ordermoney;

	//是否支付:Y-是；N-否
	private String ispay;

	//用户id 名称
	private String username;

	//是否失效：Y-是；N-否 名称
	private String isinvalname;
	
	//微信单号
	private String wxpayid;
	
	//openID上
	private String openid;
	
	//商品列表
	private List<Easyshopgoods> goodslist;
	//
	private String goodsinfo;
	//商品名称
	private String goodsname;
	//商品名称
	private String goodsnum;
	//商品当时价格
	private String thenprice;
	//图片路径
	private String imgpath;
	//图片路径
	private String imgthumpath;
	//商品id
	private String goodsid;
	//订单地址
	private String addressall;
	//地址用户
	private String addressuser;
	//地址联系方式
	private String addressphone;
	
	public String getAddressuser() {
		return addressuser;
	}

	public void setAddressuser(String addressuser) {
		this.addressuser = addressuser;
	}

	public String getAddressphone() {
		return addressphone;
	}

	public void setAddressphone(String addressphone) {
		this.addressphone = addressphone;
	}

	public String getAddressall() {
		return addressall;
	}

	public void setAddressall(String addressall) {
		this.addressall = addressall;
	}

	public String getGoodsid() {
		return goodsid;
	}

	public void setGoodsid(String goodsid) {
		this.goodsid = goodsid;
	}

	public String getImgthumpath() {
		return imgthumpath;
	}

	public void setImgthumpath(String imgthumpath) {
		this.imgthumpath = imgthumpath;
	}

	public String getImgpath() {
		return imgpath;
	}

	public void setImgpath(String imgpath) {
		this.imgpath = imgpath;
	}

	public String getGoodsnum() {
		return goodsnum;
	}

	public void setGoodsnum(String goodsnum) {
		this.goodsnum = goodsnum;
	}

	public String getThenprice() {
		return thenprice;
	}

	public void setThenprice(String thenprice) {
		this.thenprice = thenprice;
	}

	public String getGoodsname() {
		return goodsname;
	}

	public void setGoodsname(String goodsname) {
		this.goodsname = goodsname;
	}

	public String getGoodsinfo() {
		return goodsinfo;
	}

	public void setGoodsinfo(String goodsinfo) {
		this.goodsinfo = goodsinfo;
	}

	public List<Easyshopgoods> getGoodslist() {
		return goodslist;
	}

	public void setGoodslist(List<Easyshopgoods> goodslist) {
		this.goodslist = goodslist;
	}

	public String getOpenid() {
		return openid;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
	}

	public String getWxpayid() {
		return wxpayid;
	}

	public void setWxpayid(String wxpayid) {
		this.wxpayid = wxpayid;
	}

	public void setOrdercode(String ordercode) {
		this.ordercode = ordercode;
	}

	public String getOrdercode() {
		return this.ordercode;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getUserid() {
		return this.userid;
	}

	public void setOrderstate(String orderstate) {
		this.orderstate = orderstate;
	}

	public String getOrderstate() {
		return this.orderstate;
	}

	public void setShippercode(String shippercode) {
		this.shippercode = shippercode;
	}

	public String getShippercode() {
		return this.shippercode;
	}

	public void setLogisticcode(String logisticcode) {
		this.logisticcode = logisticcode;
	}

	public String getLogisticcode() {
		return this.logisticcode;
	}

	public void setIsinvalid(String isinvalid) {
		this.isinvalid = isinvalid;
	}

	public String getIsinvalid() {
		return this.isinvalid;
	}

	public void setPaytime(String paytime) {
		this.paytime = paytime;
	}

	public String getPaytime() {
		return this.paytime;
	}

	public void setPaytimebegin(String paytimebegin) {
		this.paytimebegin = paytimebegin;
	}

	public String getPaytimebegin() {
		return this.paytimebegin;
	}

	public void setPaytimeend(String paytimeend) {
		this.paytimeend = paytimeend;
	}

	public String getPaytimeend() {
		return this.paytimeend;
	}

	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}

	public String getCreatetime() {
		return this.createtime;
	}

	public void setCreatetimebegin(String createtimebegin) {
		this.createtimebegin = createtimebegin;
	}

	public String getCreatetimebegin() {
		return this.createtimebegin;
	}

	public void setCreatetimeend(String createtimeend) {
		this.createtimeend = createtimeend;
	}

	public String getCreatetimeend() {
		return this.createtimeend;
	}

	public void setOrdermoney(String ordermoney) {
		this.ordermoney = ordermoney;
	}

	public String getOrdermoney() {
		return this.ordermoney;
	}

	public void setIspay(String ispay) {
		this.ispay = ispay;
	}

	public String getIspay() {
		return this.ispay;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getUsername() {
		return this.username;
	}

	public void setIsinvalname(String isinvalname) {
		this.isinvalname = isinvalname;
	}

	public String getIsinvalname() {
		return this.isinvalname;
	}

}
