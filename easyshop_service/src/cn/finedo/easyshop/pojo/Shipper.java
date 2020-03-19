package cn.finedo.easyshop.pojo;
/**
 * 接口返回物流信息
 *
 */

public class Shipper {
    //    物流编号
    private String shipperCode;
    //    物流名称
    private String shipperName;
    public String getShipperCode() {
        return shipperCode;
    }
    public void setShipperCode(String shipperCode) {
        this.shipperCode = shipperCode;
    }
    public String getShipperName() {
        return shipperName;
    }
    public void setShipperName(String shipperName) {
        this.shipperName = shipperName;
    }

}
