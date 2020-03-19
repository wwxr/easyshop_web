/*
 *商品类型
 *
 *@version:1.0
 *@company:finedo.cn
 */
package cn.finedo.easyshop.pojo;

import cn.finedo.common.domain.BaseDomain;

public class Easyshopgoodstype extends BaseDomain {
	private static final long serialVersionUID = 1L;

	//商品类型id
	private String goodstypeid;

	//类型名称
	private String goodstypename;

	//父类id
	private String parentid;

	//banner图id
	private String imgid;
	
	//banner图id
	private String parentimgid;

	//父类id 名称
	private String parentname;

	//banner图id 名称
	private String imgname;
	
	//父子类型：big，small
	private String type;
	
	//图片路径
	private String imgpath;
	
	//图片缩略图路径
	private String imgthumpath;
	
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

	public String getParentimgid() {
		return parentimgid;
	}

	public void setParentimgid(String parentimgid) {
		this.parentimgid = parentimgid;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public void setGoodstypeid(String goodstypeid) {
		this.goodstypeid = goodstypeid;
	}

	public String getGoodstypeid() {
		return this.goodstypeid;
	}

	public void setGoodstypename(String goodstypename) {
		this.goodstypename = goodstypename;
	}

	public String getGoodstypename() {
		return this.goodstypename;
	}

	public void setParentid(String parentid) {
		this.parentid = parentid;
	}

	public String getParentid() {
		return this.parentid;
	}

	public void setImgid(String imgid) {
		this.imgid = imgid;
	}

	public String getImgid() {
		return this.imgid;
	}

	public void setParentname(String parentname) {
		this.parentname = parentname;
	}

	public String getParentname() {
		return this.parentname;
	}

	public void setImgname(String imgname) {
		this.imgname = imgname;
	}

	public String getImgname() {
		return this.imgname;
	}

}
