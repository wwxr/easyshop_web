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
	<div class="add-common-head">
    	<div class="add-common-name-add">修改订单物品关联表<br/>
            <ul>
            	<li id="common_add_card" class="add-link-li">全部</li>
            </ul>
        </div>
        <input type="button" class="finedo-button-blue" style="float:right;" value="提交" onclick="easyshopordergoodsmodify.doNext();">
    </div>
        
    <form method="post" id="ajaxForm" name="ajaxForm">
	<input id="ordergoodsid" name="ordergoodsid" type="hidden"/>
    <div class="finedo-nav-title">基本信息</div>
		<ul class="finedo-ul">
			<li>
				<span class="finedo-label-title">订单编号</span>
				<input class="finedo-text" type="text" id="ordercode" name="ordercode" value="">
			</li>
			<li>
				<span class="finedo-label-title">物品id</span>
				<input class="finedo-text" type="text" id="goodsid" name="goodsid" value="">
			</li>
		</ul>
	
		<ul>
	    	<li class="add-center"><input type="button" class="finedo-button" value="提    交" onClick="easyshopordergoodsmodify.doSubmit()" ></li>
	    </ul>
	</div>
	</form>
<script language="javascript">
var easyshopordergoodsmodify={};
/**
 * 初始化加载要修改的数据
 */
easyshopordergoodsmodify.initmodify=function(){
	var keyvalue=finedo.fn.getParameter("ordergoodsid");
	$("#ordergoodsid").val(keyvalue);
	finedo.action.ajax({
        "url":"../../finedo/easyshopordergoods/querybyid",
        "data":{"ordergoodsid":keyvalue},
        "callback":easyshopordergoodsmodify.queryCallback
    });
};
/**
 * 数据查询回调方法
 */
easyshopordergoodsmodify.queryCallback=function(ajaxret){
	if(ajaxret.fail){
        finedo.message.error(retdata.resultdesc);
        return;
    }
    var retobject = ajaxret.object;
    $("#ordercode").val(retobject.ordercode);
    $("#goodsid").val(retobject.goodsid);
};
easyshopordergoodsmodify.checkdata=function(){
	/**
 	* 	通用数据验证
 	* 	label  		名称
	*	datatype 	数据类型  string email phone url date datetime time number digits 
	*	minlength 	最小长度
	*	maxlength 	最大长度
	*	required 	是否必填 true/false
	*/
	var result=finedo.validate({
		"ordercode":{label:"订单编号", datatype:"string", required:false},		
		"goodsid":{label:"物品id", datatype:"string", required:false},		
	}, true);
	
   	//TODO: 自定义数据验证
	
	return result;
};
/**
 * 数据修改提交
 */
easyshopordergoodsmodify.doNext=function() {
	easyshopordergoodsmodify.doSubmit();
};
/**
 * 数据修改提交
 */
easyshopordergoodsmodify.doSubmit=function() {
	if(!easyshopordergoodsmodify.checkdata()) 
		return;
	finedo.action.ajaxForm({
		form:"ajaxForm",
		url:"../../finedo/easyshopordergoods/modify",
		callback:function(jsondata){
			if(jsondata.fail){
				finedo.message.error(jsondata.resultdesc);
				return;
			}
			finedo.message.info(jsondata.resultdesc);
		},
		clearForm:false
	});
};
</script>
<script type='text/javascript' src='../../resource/js/lazyload.js'></script>
<script language="javascript">
LazyLoad.css([
    '../../resource/themes/default/style.css',
    '../../resource/js/finedoui/commonui/themes/commonui.css',
    '../../resource/js/finedoui/dialog/themes/style.css',
    '../../resource/js/finedoui/upload/themes/style.css'
    ]);
LazyLoad.js([
    '../../resource/js/jquery/jquery-1.11.0.js',
    '../../resource/js/jquery/jquery.form.js',
    '../../resource/js/finedoui/base/finedo.core.js',
    '../../resource/js/finedoui/commonui/finedo.commonui.js',
    '../../resource/js/finedoui/dialog/finedo.dialog.js',
    '../../resource/js/finedoui/date/WdatePicker.js',
    '../../resource/js/finedoui/upload/finedo.upload.js'    ], function() {
    easyshopordergoodsmodify.initmodify();
});
</script>
</body>
</html>