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
    	<div class="add-common-name-add">修改咨询表<br/>
            <ul>
            	<li id="common_add_card" class="add-link-li">全部</li>
            </ul>
        </div>
        <input type="button" class="finedo-button-blue" style="float:right;" value="提交" onclick="easyshopconsultmodify.doNext();">
    </div>
        
    <form method="post" id="ajaxForm" name="ajaxForm">
	<input id="consultid" name="consultid" type="hidden"/>
    <div class="finedo-nav-title">基本信息</div>
		<ul class="finedo-ul">
			<li>
				<span class="finedo-label-title">用户id</span>
				<input class="finedo-text" type="text" id="userid" name="userid" value="">
			</li>
			<li>
				<span class="finedo-label-title">商家id</span>
				<input class="finedo-text" type="text" id="businessid" name="businessid" value="">
			</li>
			<li>
				<span class="finedo-label-title">咨询内容：以json格式存储-{userid:..,time:...,text:...}</span>
				<input class="finedo-text" type="text" id="detail" name="detail" value="">
			</li>
			<li>
				<span class="finedo-label-title">创建时间</span>
				<input class="finedo-date" type="text" value="" id="createtime" name="createtime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
			</li>
		</ul>
	
		<ul>
	    	<li class="add-center"><input type="button" class="finedo-button" value="提    交" onClick="easyshopconsultmodify.doSubmit()" ></li>
	    </ul>
	</div>
	</form>
<script language="javascript">
var easyshopconsultmodify={};
/**
 * 初始化加载要修改的数据
 */
easyshopconsultmodify.initmodify=function(){
	var keyvalue=finedo.fn.getParameter("consultid");
	$("#consultid").val(keyvalue);
	finedo.action.ajax({
        "url":"../../finedo/easyshopconsult/querybyid",
        "data":{"consultid":keyvalue},
        "callback":easyshopconsultmodify.queryCallback
    });
};
/**
 * 数据查询回调方法
 */
easyshopconsultmodify.queryCallback=function(ajaxret){
	if(ajaxret.fail){
        finedo.message.error(retdata.resultdesc);
        return;
    }
    var retobject = ajaxret.object;
    $("#userid").val(retobject.userid);
    $("#businessid").val(retobject.businessid);
    $("#detail").val(retobject.detail);
    $("#createtime").val(retobject.createtime);
};
easyshopconsultmodify.checkdata=function(){
	/**
 	* 	通用数据验证
 	* 	label  		名称
	*	datatype 	数据类型  string email phone url date datetime time number digits 
	*	minlength 	最小长度
	*	maxlength 	最大长度
	*	required 	是否必填 true/false
	*/
	var result=finedo.validate({
		"userid":{label:"用户id", datatype:"string", required:false},		
		"businessid":{label:"商家id", datatype:"string", required:false},		
		"detail":{label:"咨询内容：以json格式存储-{userid:..,time:...,text:...}", datatype:"string", required:false},		
		"createtime":{label:"创建时间", datatype:"date", required:false},
	}, true);
	
   	//TODO: 自定义数据验证
	
	return result;
};
/**
 * 数据修改提交
 */
easyshopconsultmodify.doNext=function() {
	easyshopconsultmodify.doSubmit();
};
/**
 * 数据修改提交
 */
easyshopconsultmodify.doSubmit=function() {
	if(!easyshopconsultmodify.checkdata()) 
		return;
	finedo.action.ajaxForm({
		form:"ajaxForm",
		url:"../../finedo/easyshopconsult/modify",
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
    easyshopconsultmodify.initmodify();
});
</script>
</body>
</html>