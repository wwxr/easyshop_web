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
	<span>地址信息详情</span><input type="button" value="" class="back" onClick="(function(){window.parent.$('.finedo-dialog-mask').remove();window.parent.$('.finedo-dialog').remove();})()">
    </div>
    <div class="yledit">
	<table>
		<tr>
		</tr>
			<td class="ylname1">
			省 / 市 / 区：
			</td>
			<td class="ylname2" id='place'>
			</td>
			<td class="ylname1">地址编号：</td>
			<td class="ylname2" id='addressid'>
			</td>
		<tr>
			<td class="ylname1">联系人姓名：</td>
			<td class="ylname2" id='username'>
			</td>
			<td class="ylname1">联系人号码：</td>
			<td class="ylname2" id='phone'>
			</td>
		</tr>
		<tr>
			<td class="ylname1">是否默认：</td>
			<td class="ylname2" id='isdefault'>
			</td>
			<td class="ylname1">添加时间：</td>
			<td class="ylname2" id='addtime'>
			</td>
	    </tr>
	    <tr>
			<td class="ylname1">地址详情：</td>
			<td  id='address'>
		    </td>
		</tr>
		</table>	
	</div>
</div>
<script language="javascript">
var easyshopaddressdetail={};
/**
 * 详情页面经初始化，加载数据
 */
easyshopaddressdetail.initdetail=function(){
	finedo.action.ajax({
        "url":"../../finedo/easyshopaddress/querybyid",
        "data":{"addressid":finedo.fn.getParameter("addressid")},
        "callback":function(retdata){
            if(retdata.fail){
                finedo.message.error(retdata.resultdesc);
                return;
            }
            var retobject = retdata.object;
			$("#addtime").html(retobject.addtime);
			$("#addressid").html(retobject.addressid);
			$("#place").html(retobject.province+'/'+retobject.city+'/'+retobject.area);
			$("#username").html(retobject.username);
			$("#phone").html(retobject.phone);
			$("#isdefault").html(retobject.isdefault);
			$("#address").html(retobject.address);
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
    '../../resource/js/city-picker.css',
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
    '../../resource/js/cityPicker-1.0.0.js?v=1',
    '../../resource/js/citydata.js',
    '../../resource/js/finedoui/image/viewer.min.js', 
    ], function() {
    easyshopaddressdetail.initdetail();
});
</script>
</body>
</html>
