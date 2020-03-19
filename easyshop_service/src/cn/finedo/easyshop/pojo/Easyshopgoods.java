/*
 *商品表
 *
 *@version:1.0
 *@company:finedo.cn
 */
package cn.finedo.easyshop.pojo;

import cn.finedo.common.domain.BaseDomain;

public class Easyshopgoods extends BaseDomain {
	private static final long serialVersionUID = 1L;

	//商品ID
	private String goodsid;

	//现价
	private String presentprice;

	//原价
	private String originalprice;

	//商品名称
	private String goodsname;

	//视频id
	private String videoid;

	//图片ids
	private String imgids;

	//修改时间
	private String opttime;

	//修改时间
	private String opttimebegin;

	//修改时间
	private String opttimeend;

	//是否推荐：Y-是；N-否
	private String isrecommend;

	//添加时间
	private String addtime;

	//添加时间
	private String addtimebegin;

	//添加时间
	private String addtimeend;

	//商品类型id
	private String goodstypeid;

	//物品详情
	private String detail;

	//所需积分
	private String points;

	//支付类型：money-金钱；points-积分；all-金钱+积分
	private String paytype;

	//视频id 名称
	private String videoname;

	//商品类型id 名称
	private String goodstypename;
	
	//商品简介
	private String goodsintroduction;
	//参数详情
	private String paramdetail;
	//订单编号
	private String ordercode;

	//订单物品关联id
	private String ordergoodsid;
	
	//图片路径
	private String imgpath;
	
	//图片缩略图路径
	private String imgthumpath;
	
	//视频路径
	private String videopath;
	
	//商品数量
	private String count;
	
	//下单单价
	private String thenprice;
	

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	public String getThenprice() {
		return thenprice;
	}

	public void setThenprice(String thenprice) {
		this.thenprice = thenprice;
	}

	public String getImgpath() {
		return imgpath;
	}

	public void setImgpath(String imgpath) {
		this.imgpath = imgpath;
	}

	public String getImgthumpath() {
		return imgthumpath;
	}

	public void setImgthumpath(String imgthumpath) {
		this.imgthumpath = imgthumpath;
	}

	public String getVideopath() {
		return videopath;
	}

	public void setVideopath(String videopath) {
		this.videopath = videopath;
	}

	public String getOrdercode() {
		return ordercode;
	}

	public void setOrdercode(String ordercode) {
		this.ordercode = ordercode;
	}

	public String getOrdergoodsid() {
		return ordergoodsid;
	}

	public void setOrdergoodsid(String ordergoodsid) {
		this.ordergoodsid = ordergoodsid;
	}

	public String getParamdetail() {
		return paramdetail;
	}

	public void setParamdetail(String paramdetail) {
		this.paramdetail = paramdetail;
	}

	public String getGoodsintroduction() {
		return goodsintroduction;
	}

	public void setGoodsintroduction(String goodsintroduction) {
		this.goodsintroduction = goodsintroduction;
	}

	public void setGoodsid(String goodsid) {
		this.goodsid = goodsid;
	}

	public String getGoodsid() {
		return this.goodsid;
	}

	public void setPresentprice(String presentprice) {
		this.presentprice = presentprice;
	}

	public String getPresentprice() {
		return this.presentprice;
	}

	public void setOriginalprice(String originalprice) {
		this.originalprice = originalprice;
	}

	public String getOriginalprice() {
		return this.originalprice;
	}

	public void setGoodsname(String goodsname) {
		this.goodsname = goodsname;
	}

	public String getGoodsname() {
		return this.goodsname;
	}

	public void setVideoid(String videoid) {
		this.videoid = videoid;
	}

	public String getVideoid() {
		return this.videoid;
	}

	public void setImgids(String imgids) {
		this.imgids = imgids;
	}

	public String getImgids() {
		return this.imgids;
	}

	public void setOpttime(String opttime) {
		this.opttime = opttime;
	}

	public String getOpttime() {
		return this.opttime;
	}

	public void setOpttimebegin(String opttimebegin) {
		this.opttimebegin = opttimebegin;
	}

	public String getOpttimebegin() {
		return this.opttimebegin;
	}

	public void setOpttimeend(String opttimeend) {
		this.opttimeend = opttimeend;
	}

	public String getOpttimeend() {
		return this.opttimeend;
	}

	public void setIsrecommend(String isrecommend) {
		this.isrecommend = isrecommend;
	}

	public String getIsrecommend() {
		return this.isrecommend;
	}

	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}

	public String getAddtime() {
		return this.addtime;
	}

	public void setAddtimebegin(String addtimebegin) {
		this.addtimebegin = addtimebegin;
	}

	public String getAddtimebegin() {
		return this.addtimebegin;
	}

	public void setAddtimeend(String addtimeend) {
		this.addtimeend = addtimeend;
	}

	public String getAddtimeend() {
		return this.addtimeend;
	}

	public void setGoodstypeid(String goodstypeid) {
		this.goodstypeid = goodstypeid;
	}

	public String getGoodstypeid() {
		return this.goodstypeid;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getDetail() {
		return this.detail;
	}

	public void setPoints(String points) {
		this.points = points;
	}

	public String getPoints() {
		return this.points;
	}

	public void setPaytype(String paytype) {
		this.paytype = paytype;
	}

	public String getPaytype() {
		return this.paytype;
	}

	public void setVideoname(String videoname) {
		this.videoname = videoname;
	}

	public String getVideoname() {
		return this.videoname;
	}

	public void setGoodstypename(String goodstypename) {
		this.goodstypename = goodstypename;
	}

	public String getGoodstypename() {
		return this.goodstypename;
	}

}
