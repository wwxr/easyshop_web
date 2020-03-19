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
	<span>修改订单信息</span><input type="button" value="" class="back" onClick="(function(){window.parent.$('.finedo-dialog-mask').remove();window.parent.$('.finedo-dialog').remove();})()">
    </div>
    <div class="yledit">
    <input hidden='hidden' id='ordercode'>
	<table>
    		<tr>
				<td class="ylname1">物流单号：</td>
				<td class="ylname2">
				<input type="text" class="yltext" id="logisticcode" name="logisticcode" maxlength="50" placeholder="请输入物流单号"  ><span style="color:red;">*必填项</span>
				</td>
				<td class="ylname1">订单状态：</td>
				<td class="ylname2">
					<select class='selectdata' id='orderstate' >
						<option value="">全部状态</option>
						<option value="payed">已支付</option>
						<option value="nopay">未支付</option>
						<option value="invalid">已失效</option>
					</select>
				</td>
			</tr>
    		<tr>
				<td class="ylname1">快递公司：</td>
				<td class="ylname2">
				<select class='selectdata' id='shippercode' >
						<option value=''>全部</option>
						<option value='N'>否</option>
						<option value='Y'>是</option>
				</select>
				</td>
				<td class="ylname1">是否失效：</td>
				<td class="ylname2">
				<select class='selectdata' id='isinvalid' >
						<option value=''>全部</option>
						<option value='Y'>是</option>
						<option value='N'>否</option>
				</select>
				</td>
			</tr>
    		<tr>
				<td class="ylname1">所需金额：</td>
				<td class="ylname2">
				<input type="text" class="yltext" id="ordermoney" name="ordermoney" maxlength="10" placeholder="请输入订单金额"  ><span style="color:red;">*必填项</span>
				</td>
				<td class="ylname1">是否支付：</td>
				<td class="ylname2">
				<select class='selectdata' id='ispay' >
						<option value=''>全部</option>
						<option value='Y'>是</option>
						<option value='N'>否</option>
				</select>
				</td>
			</tr>
		</table>
	</div>
    <div class="ylsubmit"><input type="button" class="ylbtn" value="提    交" onClick="easyshopordermodify.dosubmit()" ></div>
</div>
	
<script language="javascript">
var easyshopordermodify={};
/**
 * 初始化加载要修改的数据
 */
easyshopordermodify.initmodify=function(){
	var keyvalue=finedo.fn.getParameter("ordercode");
	$("#ordercode").val(keyvalue);
	finedo.action.ajax({
        "url":"../../finedo/easyshoporder/querybyid",
        "data":{"ordercode":keyvalue},
        "callback":easyshopordermodify.queryCallback
    });
};
/**
 * 数据查询回调方法
 */
easyshopordermodify.queryCallback=function(ajaxret){
	if(ajaxret.fail){
        finedo.message.error(retdata.resultdesc);
        return;
    }
    var retobject = ajaxret.object;
    $("#orderstate").val(retobject.orderstate);
    $("#shippercode").val(retobject.shippercode);
    $("#logisticcode").val(retobject.logisticcode);
    $("#isinvalid").val(retobject.isinvalid);
    $("#ordermoney").val(retobject.ordermoney);
    $("#ispay").val(retobject.ispay);
};
easyshopordermodify.checkdata=function(){
	var result=true;
	if(finedo.fn.isNon($("#orderstate").val())){
		finedo.message.info("请选择订单状态");
		return;
	}
	if(finedo.fn.isNon($("#shippercode").val())){
		finedo.message.info("请选择快递公司");
		return;
	}
	if(finedo.fn.isNon($("#logisticcode").val())){
		finedo.message.info("请输入物流单号");
		return;
	}
	if(finedo.fn.isNon($("#isinvalid").val())){
		finedo.message.info("请输入是否失效");
		return;
	}
	if(finedo.fn.isNon($("#ordermoney").val())){
		finedo.message.info("请填写订单金额");
		return;
	}
	if(finedo.fn.isNon($("#ispay").val())){
		finedo.message.info("请选择是否支付");
		return;
	}
	return result;
};
easyshopordermodify.dosubmit=function() {
	if(!easyshopordermodify.checkdata()) 
		return;
	finedo.action.ajax({
		url:"../../finedo/easyshoporder/modify",
		data:{
			ordercode:$("#ordercode").val().trim(),
			orderstate:$("#orderstate").val().trim(),
			shippercode:$("#shippercode").val().trim(),
			logisticcode:$("#logisticcode").val(),
			isinvalid:$("#isinvalid").val(),
			ordermoney:$("#ordermoney").val(),
			ispay:$("#ispay").val(),
			},
			callback:function(jsondata){
				if(jsondata.fail){
					finedo.message.error(jsondata.resultdesc);
					return;
				}
				finedo.message.info(jsondata.resultdesc,'提示',function(){
					window.parent.$('#datagrid').grid().refresh();
					window.parent.$(".finedo-dialog-mask").remove();
					window.parent.$(".finedo-dialog").remove();
				});
		}
	});
	
};
//初始化商品类型
easyshopordermodify.initshipper=function() {
	finedo.action.ajax({
		url:"../../finedo/easyshopexpress/query",
		data:{},
		async:false,
		callback:function(jsondata){
			var datalist=jsondata.rows;
			var option='<option  value="">全部</option>';
			if(finedo.fn.isNotNon(datalist)){
				for(var i=0;i<datalist.length;i++){
					option+='<option value="'+datalist[i].shippercode+'">'+datalist[i].shippername+'</option>'
				}
			}
			$("#shippercode").html(option);
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
    '../../resource/js/finedoui/image/viewer.min.js',     ], function() {
    easyshopordermodify.initshipper();
    easyshopordermodify.initmodify();
});
</script>
</body>
</html>