<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs2.jsp" %>

<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>

<body>
	<div>
	<div class="ylnav">
	<span>订单信息</span><input type="button" value="" class="back" onClick="(function(){window.parent.$('.finedo-dialog-mask').remove();window.parent.$('.finedo-dialog').remove();})()">
    </div>
    <div class="yledit">
	<table>
    		<tr>
				<td class="ylname1">订单编号：</td>
				<td class="ylname2" id='ordercode'>
				</td>
				<td class="ylname1">用户：</td>
				<td class="ylname2" id='userid'>
				</td>
			</tr>
    		<tr>
				<td class="ylname1">物流单号：</td>
				<td class="ylname2" id='logisticcode'>
				</td>
				<td class="ylname1">订单状态：</td>
				<td class="ylname2" id='orderstate'>
				</td>
			</tr>
    		<tr>
				<td class="ylname1">快递公司：</td>
				<td class="ylname2" id='shippercode'>
				</td>
				<td class="ylname1">是否失效：</td>
				<td class="ylname2" id='isinvalid'>
				</td>
			</tr>
    		<tr>
				<td class="ylname1">所需金额：</td>
				<td class="ylname2" id='ordermoney'>
				</td>
				<td class="ylname1">是否支付：</td>
				<td class="ylname2" id='ispay'>
				</td>
			</tr>
    		<tr>
				<td class="ylname1">创建时间：</td>
				<td class="ylname2" id='createtime'>
				</td>
				<td class="ylname1">支付时间：</td>
				<td class="ylname2" id='paytime'>
				</td>
			</tr>
		</table>
	</div>
</div>
	
<script language="javascript">
var easyshoporderdetail={};
/**
 * 详情页面经初始化，加载数据
 */
easyshoporderdetail.initdetail=function(){
	finedo.action.ajax({
        "url":"../../finedo/easyshoporder/querybyid",
        "data":{"ordercode":finedo.fn.getParameter("ordercode")},
        "callback":function(retdata){
            if(retdata.fail){
                finedo.message.error(retdata.resultdesc);
                return;
            }
            var retobject = retdata.object;
			$("#paytime").html(retobject.paytime);
			$("#createtime").html(retobject.createtime);
			$("#userid").html(retobject.username);
			$("#ordercode").html(retobject.ordercode);
			$("#orderstate").html(retobject.orderstate);
		    $("#shippercode").html(retobject.shippercode);
		    $("#logisticcode").html(retobject.logisticcode);
		    $("#isinvalid").html(retobject.isinvalid);
		    $("#ordermoney").html(retobject.ordermoney);
		    $("#ispay").html(retobject.ispay);
        }
    });
};
</script>
<script type='text/javascript' src='../../resource/js/lazyload.js'></script>
<script language="javascript">
LazyLoad.css([
    '../../resource/themes/default/style.css',
    '../../resource/js/finedoui/commonui/themes/commonui.css',
    '../../resource/js/finedoui/dialog/themes/style.css',
    '../../resource/js/finedoui/upload/themes/style.css',
    '../../resource/js/finedoui/image/viewer.min.css',
    '../../easyshop/style/style.css'
    ]);
LazyLoad.js([
    '../../resource/js/jquery/jquery-1.11.0.js',
    '../../resource/js/jquery/jquery.form.js',
    '../../resource/js/finedoui/base/finedo.core.js',
    '../../resource/js/finedoui/commonui/finedo.commonui.js',
    '../../resource/js/finedoui/dialog/finedo.dialog.js',
    '../../resource/js/finedoui/date/WdatePicker.js',
    '../../resource/js/finedoui/upload/finedo.upload.js',
    '../../resource/js/finedoui/image/viewer.min.js', 
    ], function() {
    easyshoporderdetail.initdetail();
});
</script>
</body>
</html>
