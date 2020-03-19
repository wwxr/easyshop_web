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
    	<div class="add-common-name-add">修改用户表<br/>
            <ul>
            	<li id="common_add_card" class="add-link-li">全部</li>
            </ul>
        </div>
        <input type="button" class="finedo-button-blue" style="float:right;" value="提交" onclick="easyshopusermodify.doNext();">
    </div>
        
    <form method="post" id="ajaxForm" name="ajaxForm">
	<input id="userid" name="userid" type="hidden"/>
    <div class="finedo-nav-title">基本信息</div>
		<ul class="finedo-ul">
			<li>
				<span class="finedo-label-title">积分</span>
				<input class="finedo-text" type="text" id="points" name="points" value="">
			</li>
			<li>
				<span class="finedo-label-title">openid</span>
				<input class="finedo-text" type="text" id="openid" name="openid" value="">
			</li>
			<li>
				<span class="finedo-label-title">unionid</span>
				<input class="finedo-text" type="text" id="unionid" name="unionid" value="">
			</li>
			<li>
				<span class="finedo-label-title">手机号</span>
				<input class="finedo-text" type="text" id="phone" name="phone" value="">
			</li>
			<li>
				<span class="finedo-label-title">推广人编码对应二维码</span>
				<input class="finedo-text" type="text" id="promoter" name="promoter" value="">
			</li>
			<li>
				<span class="finedo-label-title">用户姓名</span>
				<input class="finedo-text" type="text" id="username" name="username" value="">
			</li>
			<li>
				<span class="finedo-label-title">昵称</span>
				<input class="finedo-text" type="text" id="nickname" name="nickname" value="">
			</li>
			<li>
				<span class="finedo-label-title">头像</span>
				<input class="finedo-text" type="text" id="avatar" name="avatar" value="">
			</li>
			<li>
				<span class="finedo-label-title">自己的推广码</span>
				<input class="finedo-text" type="text" id="promocode" name="promocode" value="">
			</li>
			<li>
				<span class="finedo-label-title">注册时间</span>
				<input class="finedo-date" type="text" value="" id="registtime" name="registtime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
			</li>
			<li>
				<span class="finedo-label-title">性别：1-男；0-女</span>
				<input class="finedo-text" type="text" id="gender" name="gender" value="">
			</li>
		</ul>
	
		<ul>
	    	<li class="add-center"><input type="button" class="finedo-button" value="提    交" onClick="easyshopusermodify.doSubmit()" ></li>
	    </ul>
	</div>
	</form>
<script language="javascript">
var easyshopusermodify={};
/**
 * 初始化加载要修改的数据
 */
easyshopusermodify.initmodify=function(){
	var keyvalue=finedo.fn.getParameter("userid");
	$("#userid").val(keyvalue);
	finedo.action.ajax({
        "url":"../../finedo/easyshopuser/querybyid",
        "data":{"userid":keyvalue},
        "callback":easyshopusermodify.queryCallback
    });
};
/**
 * 数据查询回调方法
 */
easyshopusermodify.queryCallback=function(ajaxret){
	if(ajaxret.fail){
        finedo.message.error(retdata.resultdesc);
        return;
    }
    var retobject = ajaxret.object;
    $("#points").val(retobject.points);
    $("#openid").val(retobject.openid);
    $("#unionid").val(retobject.unionid);
    $("#phone").val(retobject.phone);
    $("#promoter").val(retobject.promoter);
    $("#username").val(retobject.username);
    $("#nickname").val(retobject.nickname);
    $("#avatar").val(retobject.avatar);
    $("#promocode").val(retobject.promocode);
    $("#registtime").val(retobject.registtime);
    $("#gender").val(retobject.gender);
};
easyshopusermodify.checkdata=function(){
	/**
 	* 	通用数据验证
 	* 	label  		名称
	*	datatype 	数据类型  string email phone url date datetime time number digits 
	*	minlength 	最小长度
	*	maxlength 	最大长度
	*	required 	是否必填 true/false
	*/
	var result=finedo.validate({
		"points":{label:"积分", datatype:"string", required:false},		
		"openid":{label:"openid", datatype:"string", required:false},		
		"unionid":{label:"unionid", datatype:"string", required:false},		
		"phone":{label:"手机号", datatype:"string", required:false},		
		"promoter":{label:"推广人编码对应二维码", datatype:"string", required:false},		
		"username":{label:"用户姓名", datatype:"string", required:false},		
		"nickname":{label:"昵称", datatype:"string", required:false},		
		"avatar":{label:"头像", datatype:"string", required:false},		
		"promocode":{label:"自己的推广码", datatype:"string", required:false},		
		"registtime":{label:"注册时间", datatype:"date", required:false},
		"gender":{label:"性别：1-男；0-女", datatype:"string", required:false},		
	}, true);
	
   	//TODO: 自定义数据验证
	
	return result;
};
/**
 * 数据修改提交
 */
easyshopusermodify.doNext=function() {
	easyshopusermodify.doSubmit();
};
/**
 * 数据修改提交
 */
easyshopusermodify.doSubmit=function() {
	if(!easyshopusermodify.checkdata()) 
		return;
	finedo.action.ajaxForm({
		form:"ajaxForm",
		url:"../../finedo/easyshopuser/modify",
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
    easyshopusermodify.initmodify();
});
</script>
</body>
</html>