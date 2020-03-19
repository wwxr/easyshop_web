/**
 * 
 */
package cn.finedo.easyshop.pojo;

import cn.finedo.common.domain.BaseDomain;

/**
 * @author 2018026
 * @datetime 12:57:03 PM
 */
public class Easyshopaddress extends BaseDomain{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	//主键
	private String addressid;
	//省
	private String province;
	//市
	private String city;
	//区
	private String area;
	//省
	private String provincenum;
	//市
	private String citynum;
	//区
	private String areanum;
	//详细嫡长子
	private String address;
	//用户id
	private String userid;
	//是否默认
	private String isdefault;
	//添加时间
	private String addtime;
	//昵称
	private String nickname;
	//联系人
	private String username;
	//联系方式
	private String phone;
	
	
	
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getProvincenum() {
		return provincenum;
	}
	public void setProvincenum(String provincenum) {
		this.provincenum = provincenum;
	}
	public String getCitynum() {
		return citynum;
	}
	public void setCitynum(String citynum) {
		this.citynum = citynum;
	}
	public String getAreanum() {
		return areanum;
	}
	public void setAreanum(String areanum) {
		this.areanum = areanum;
	}
	public String getAddressid() {
		return addressid;
	}
	public void setAddressid(String addressid) {
		this.addressid = addressid;
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
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getIsdefault() {
		return isdefault;
	}
	public void setIsdefault(String isdefault) {
		this.isdefault = isdefault;
	}
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	
}
