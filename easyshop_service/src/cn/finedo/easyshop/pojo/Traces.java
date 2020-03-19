/**
 * 路径实体类
 */
package cn.finedo.easyshop.pojo;
import java.util.Date;

/**
* 物流轨迹
*/
public class Traces {
	//	描述
   private String acceptStation;
   //   时间
   private Date acceptTime;
   //备注
   private String remark;
	public String getAcceptStation() {
		return acceptStation;
	}
	public void setAcceptStation(String acceptStation) {
		this.acceptStation = acceptStation;
	}
	public Date getAcceptTime() {
		return acceptTime;
	}
	public void setAcceptTime(Date acceptTime) {
		this.acceptTime = acceptTime;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
   
   

}