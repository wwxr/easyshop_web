/**
 * 快递参数接收实体类
 */
package cn.finedo.easyshop.pojo;
import java.util.List;

import cn.finedo.common.domain.BaseDomain;

/**
* 参数接收
*/
public class AcceptResult extends BaseDomain{
	private static final long serialVersionUID = 1L;
	//	物流运单号
   private String logisticCode;
   //   快递公司编码
   private String shipperCode;
   //   运动轨迹
   private List<Traces> traces;
   //   物流状态：2-在途中,3-签收,4-问题件
   private String state;
   //   用户ID
   private String eBusinessID;
   //   成功与否
   private boolean success;
	//原因
   private String reason;
   //订单编号
   private String orderCode;
   //物流图片
   private String imgpath;
   //查询物流信息
   //物流实体类
   private List<Shipper> shippers;
   //返回原因
   private String code;
   
	public String getImgpath() {
	return imgpath;
}
public void setImgpath(String imgpath) {
	this.imgpath = imgpath;
}
	public List<Shipper> getShippers() {
    return shippers;
    }
    public void setShippers(List<Shipper> shippers) {
        this.shippers = shippers;
    }
    public String getCode() {
    return code;
    }
    public void setCode(String code) {
        this.code = code;
    }
    public String getLogisticCode() {
		return logisticCode;
	}
	public void setLogisticCode(String logisticCode) {
		this.logisticCode = logisticCode;
	}
	public String getShipperCode() {
		return shipperCode;
	}
	public void setShipperCode(String shipperCode) {
		this.shipperCode = shipperCode;
	}
	public List<Traces> getTraces() {
		return traces;
	}
	public void setTraces(List<Traces> traces) {
		this.traces = traces;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String geteBusinessID() {
		return eBusinessID;
	}
	public void seteBusinessID(String eBusinessID) {
		this.eBusinessID = eBusinessID;
	}
	public boolean isSuccess() {
		return success;
	}
	public void setSuccess(boolean success) {
		this.success = success;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getOrderCode() {
		return orderCode;
	}
	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}

}