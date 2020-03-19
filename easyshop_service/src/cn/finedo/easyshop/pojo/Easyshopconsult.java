/*
 *咨询表
 *
 *@version:1.0
 *@company:finedo.cn
 */
package cn.finedo.easyshop.pojo;

import cn.finedo.common.domain.BaseDomain;

public class Easyshopconsult extends BaseDomain {
	private static final long serialVersionUID = 1L;

	//咨询主键
	private String consultid;

	//用户id
	private String userid;

	//商家id
	private String businessid;

	//咨询内容：以json格式存储-{userid:..,time:...,text:...}
	private String detail;

	//创建时间
	private String createtime;

	//创建时间
	private String createtimebegin;

	//创建时间
	private String createtimeend;

	//用户id 名称
	private String username;

	//商家id 名称
	private String businessname;

	public void setConsultid(String consultid) {
		this.consultid = consultid;
	}

	public String getConsultid() {
		return this.consultid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getUserid() {
		return this.userid;
	}

	public void setBusinessid(String businessid) {
		this.businessid = businessid;
	}

	public String getBusinessid() {
		return this.businessid;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getDetail() {
		return this.detail;
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

	public void setUsername(String username) {
		this.username = username;
	}

	public String getUsername() {
		return this.username;
	}

	public void setBusinessname(String businessname) {
		this.businessname = businessname;
	}

	public String getBusinessname() {
		return this.businessname;
	}

}
