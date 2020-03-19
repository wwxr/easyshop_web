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
    	<div class="add-common-name-add">新建用户表<br/>
            <ul>
            	<li id="common_add_card" class="add-link-li">普通新建</li> 
            	<li>|</li>
                <li id="excel_add_card">批量导入</li>
            </ul>
        </div>
        <input type="button" class="finedo-button-blue" style="float:right" value="提交" onclick="easyshopuseradd.doNext();">
    </div>
        
    <form method="post" id="ajaxForm" name="ajaxForm">
    <div id="common_add_div" >
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
	    		<li class="add-center"><input type="button" class="finedo-button" value="提    交" onClick="easyshopuseradd.doSubmit()" ></li>
	   		</ul>
		</div>
    </form>
    
    <div id="excel_add_div" style="display:none"> 
   		<form method="post" id="importForm" name="importForm">
   			<input type="hidden" id="fileid" name="fileid">
   		</form>
   		
   		<div class="finedo-nav-title">导入Excel</div>
		<ul class="finedo-ul">
			<li>
				<input type="text" id="uploaddiv" name="uploaddiv" filter=".xls,.xlsx" multiupload="false">
			</li>
        </ul>
        
        <ul>
    		<li class="add-center"><input type="button" class="finedo-button" value="提    交" onclick="easyshopuseradd.doImport();"></li>
		</ul>
   		
   		<div id="importresultdiv" style="display:none">
	    	<div class="finedo-nav-title"><font color=red>导入Excel结果</font></div>
		    <div class="query-common-con">
		    	<ul id="importresultul" class="finedo-ul"></ul>
		    </div>
	    </div>
	    
	    <div class="finedo-nav-title">导入Excel格式说明</div>
		<ul class="finedo-ul">
			<li>
				<span class="finedo-label-title">模板下载</span><span class="finedo-label-info"><a href="../../easyshop/easyshopuser/import.xlsx" >用户表信息批量导入Excel模板 </a></span>
			</li>
			
			<li>
				<span class="finedo-label-title">第1列：</span><span class="finedo-label-info">积分</span>
			</li>
			<li>
				<span class="finedo-label-title">第2列：</span><span class="finedo-label-info">openid</span>
			</li>
			<li>
				<span class="finedo-label-title">第3列：</span><span class="finedo-label-info">unionid</span>
			</li>
			<li>
				<span class="finedo-label-title">第4列：</span><span class="finedo-label-info">手机号</span>
			</li>
			<li>
				<span class="finedo-label-title">第5列：</span><span class="finedo-label-info">推广人编码对应二维码</span>
			</li>
			<li>
				<span class="finedo-label-title">第6列：</span><span class="finedo-label-info">用户姓名</span>
			</li>
			<li>
				<span class="finedo-label-title">第7列：</span><span class="finedo-label-info">昵称</span>
			</li>
			<li>
				<span class="finedo-label-title">第8列：</span><span class="finedo-label-info">头像</span>
			</li>
			<li>
				<span class="finedo-label-title">第9列：</span><span class="finedo-label-info">自己的推广码</span>
			</li>
			<li>
				<span class="finedo-label-title">第10列：</span><span class="finedo-label-info">注册时间</span>
			</li>
			<li>
				<span class="finedo-label-title">第11列：</span><span class="finedo-label-info">性别：1-男；0-女</span>
			</li>
		</ul>
	</div>
</div>
<script language="javascript">
var easyshopuseradd={};
/**
 * 增加页面初始化，用于初始化表单
 */
easyshopuseradd.initadd=function(){
	$('#common_add_card').click(function(e) {
    	$('#common_add_div').css('display', 'block');
    	$('#common_add_card').attr('class', 'add-link-li');
    	
    	$('#excel_add_div').css('display', 'none');
		$('#excel_add_card').removeClass();
		finedo.getFileControl('uploaddiv').reset(false);
    });
    
    $('#excel_add_card').click(function(e) {
    	$('#common_add_div').css('display', 'none');
    	$('#common_add_card').removeClass();
    	
    	$('#excel_add_div').css('display', 'block');
		$('#excel_add_card').attr('class', 'add-link-li');
    });
    finedo.getFileControl('uploaddiv',{
    	ctx:"../.."
    });
};
easyshopuseradd.checkdata=function(){
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
 * 提交方法
 */
easyshopuseradd.doNext=function() {
	if($('#common_add_div').css('display') == 'block') {
		easyshopuseradd.doSubmit();
	}else {
		easyshopuseradd.doImport();
	}
};
/**
 * 提交方法
 */
easyshopuseradd.doSubmit=function() {
	if(!easyshopuseradd.checkdata()) 
		return;
	finedo.action.ajaxForm({
		form:"ajaxForm",
		url:"../../finedo/easyshopuser/add",
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
/**
 * 批量导入
 */
easyshopuseradd.doImport=function() {
	var fileControl=finedo.getFileControl('uploaddiv');
	var filearr=fileControl.getFileList();
	if(filearr.length != 1) {
		finedo.message.error("未上传Excel文件");
		return;
	}
	$('#fileid').val(filearr[0].fileid);
	
	finedo.action.ajaxForm({
		form:"importForm",
		url:"../../finedo/easyshopuser/importexcel",
		callback:easyshopuseradd.importCallback,
		clearForm:false
	});
};
/**
 * 批量导入回调函数
 */
easyshopuseradd.importCallback=function(ajaxret){
	$('#importresultdiv').css('display', 'block');
	var resulthtml="<li><span class='finedo-label-title'>导入情况</span><span class='finedo-label-info'><font color=red>" + ajaxret.resultdesc + "   总记录数: " + ajaxret.object.rowcount + " &nbsp;&nbsp; 成功记录数: " + ajaxret.object.successcount + "&nbsp;&nbsp; 失败记录数: " + ajaxret.object.failcount + "</font></span></li>";
	var faillist=eval(ajaxret.object.faillist);
	for(var i=0; i<faillist.length; i++)  {
		resulthtml += "<li><span class='finedo-label-title'>失败明细</span><span class='finedo-label-info'>" + faillist[i].resultdesc + "</span></li>";
	}
	
	$('#importresultul').html(resulthtml);
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
    easyshopuseradd.initadd();
});
</script>
</body>
</html>
