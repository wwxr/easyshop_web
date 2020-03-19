/*
 *物流表
 *
 *@version:1.0
 *@company:finedo.cn
 */
package cn.finedo.easyshop.pojo;

import cn.finedo.common.domain.BaseDomain;

public class Easyshopexpress extends BaseDomain {
	private static final long serialVersionUID = 1L;

	//物流编号
	private String shippercode;

	//物流名称
	private String shippername;
	
	//物流名称
	private String queryname;
	
	//图片路径
	private String imgid;
	
	//图片路径
	private String imgpath;
	
	//图片缩略图路径
	private String imgthumpath;

	public String getQueryname() {
		return queryname;
	}

	public void setQueryname(String queryname) {
		this.queryname = queryname;
	}

	public String getImgid() {
		return imgid;
	}

	public void setImgid(String imgid) {
		this.imgid = imgid;
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

	public void setShippercode(String shippercode) {
		this.shippercode = shippercode;
	}

	public String getShippercode() {
		return this.shippercode;
	}

	public void setShippername(String shippername) {
		this.shippername = shippername;
	}

	public String getShippername() {
		return this.shippername;
	}

}
