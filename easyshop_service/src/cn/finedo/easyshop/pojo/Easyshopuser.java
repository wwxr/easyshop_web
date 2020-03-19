/*
 *用户表
 *
 *@version:1.0
 *@company:finedo.cn
 */
package cn.finedo.easyshop.pojo;

import cn.finedo.common.domain.BaseDomain;

public class Easyshopuser extends BaseDomain {
	private static final long serialVersionUID = 1L;

	//主键id
	private String userid;

	//积分
	private Integer points;

	//openid
	private String openid;

	//unionid
	private String unionid;

	//手机号
	private String phone;

	//推广人编码对应二维码
	private String promoter;

	//用户姓名
	private String username;

	//昵称
	private String nickname;

	//头像
	private String avatar;

	//自己的推广码
	private String promocode;

	//注册时间
	private String registtime;

	//注册时间
	private String registtimebegin;

	//注册时间
	private String registtimeend;

	//性别：1-男；0-女
	private String gender;

	//openid 名称
	private String openname;

	//unionid 名称
	private String unionname;
	
	//获取openID的code
	private String code;
	
	//国家，省份，城市
	private String country;
	private String province;
	private String city;
	
	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getUserid() {
		return this.userid;
	}

	public void setPoints(Integer points) {
		this.points = points;
	}

	public Integer getPoints() {
		return this.points;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
	}

	public String getOpenid() {
		return this.openid;
	}

	public void setUnionid(String unionid) {
		this.unionid = unionid;
	}

	public String getUnionid() {
		return this.unionid;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPhone() {
		return this.phone;
	}

	public void setPromoter(String promoter) {
		this.promoter = promoter;
	}

	public String getPromoter() {
		return this.promoter;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getUsername() {
		return this.username;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getNickname() {
		return this.nickname;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public String getAvatar() {
		return this.avatar;
	}

	public void setPromocode(String promocode) {
		this.promocode = promocode;
	}

	public String getPromocode() {
		return this.promocode;
	}

	public void setRegisttime(String registtime) {
		this.registtime = registtime;
	}

	public String getRegisttime() {
		return this.registtime;
	}

	public void setRegisttimebegin(String registtimebegin) {
		this.registtimebegin = registtimebegin;
	}

	public String getRegisttimebegin() {
		return this.registtimebegin;
	}

	public void setRegisttimeend(String registtimeend) {
		this.registtimeend = registtimeend;
	}

	public String getRegisttimeend() {
		return this.registtimeend;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getGender() {
		return this.gender;
	}

	public void setOpenname(String openname) {
		this.openname = openname;
	}

	public String getOpenname() {
		return this.openname;
	}

	public void setUnionname(String unionname) {
		this.unionname = unionname;
	}

	public String getUnionname() {
		return this.unionname;
	}

}
