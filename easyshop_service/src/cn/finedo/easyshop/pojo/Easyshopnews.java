/*
 *广告表
 *
 *@version:1.0
 *@company:finedo.cn
 */
package cn.finedo.easyshop.pojo;

import cn.finedo.common.domain.BaseDomain;

public class Easyshopnews extends BaseDomain {
	private static final long serialVersionUID = 1L;

	//主键id
	private String newsid;

	//添加时间
	private String addtime;

	//添加时间
	private String addtimebegin;

	//添加时间
	private String addtimeend;

	//修改时间
	private String opttime;

	//修改时间
	private String opttimebegin;

	//修改时间
	private String opttimeend;

	//详情
	private String detail;

	//banner图
	private String imgid;

	//视频id
	private String videoid;

	//广告名称
	private String newsname;

	//banner图 名称
	private String imgname;

	//视频id 名称
	private String videoname;
	
	//广告简介
	private String newsintroduction;
	
	//视频路径
	private String videopath;

	//图片路径
	private String imgpath;
	
	//图片缩略图路径
	private String imgthumpath;

	public String getVideopath() {
		return videopath;
	}

	public void setVideopath(String videopath) {
		this.videopath = videopath;
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

	public String getNewsintroduction() {
		return newsintroduction;
	}

	public void setNewsintroduction(String newsintroduction) {
		this.newsintroduction = newsintroduction;
	}

	public void setNewsid(String newsid) {
		this.newsid = newsid;
	}

	public String getNewsid() {
		return this.newsid;
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

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getDetail() {
		return this.detail;
	}

	public void setImgid(String imgid) {
		this.imgid = imgid;
	}

	public String getImgid() {
		return this.imgid;
	}

	public void setVideoid(String videoid) {
		this.videoid = videoid;
	}

	public String getVideoid() {
		return this.videoid;
	}

	public void setNewsname(String newsname) {
		this.newsname = newsname;
	}

	public String getNewsname() {
		return this.newsname;
	}

	public void setImgname(String imgname) {
		this.imgname = imgname;
	}

	public String getImgname() {
		return this.imgname;
	}

	public void setVideoname(String videoname) {
		this.videoname = videoname;
	}

	public String getVideoname() {
		return this.videoname;
	}

}
