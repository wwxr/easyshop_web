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
    	<div class="add-common-name-add">新建订单表<br/>
            <ul>
            	<li id="common_add_card" class="add-link-li">普通新建</li> 
            	<li>|</li>
                <li id="excel_add_card">批量导入</li>
            </ul>
        </div>
        <input type="button" class="finedo-button-blue" style="float:right" value="提交" onclick="easyshoporderadd.doNext();">
    </div>
        
    <form method="post" id="ajaxForm" name="ajaxForm">
    <div id="common_add_div" >
    	<div class="finedo-nav-title">基本信息</div>
	   	<ul class="finedo-ul">
				<li>
					<span class="finedo-label-title">用户id</span>
					<input class="finedo-text" type="text" id="userid" name="userid" value="">
				</li>
				<li>
					<span class="finedo-label-title">订单状态：待付款-nopay;已付款-payed;invalid-已失效</span>
					<input class="finedo-text" type="text" id="orderstate" name="orderstate" value="">
				</li>
				<li>
					<span class="finedo-label-title">快递公司编码</span>
					<input class="finedo-text" type="text" id="shippercode" name="shippercode" value="">
				</li>
				<li>
					<span class="finedo-label-title">物流单号</span>
					<input class="finedo-text" type="text" id="logisticcode" name="logisticcode" value="">
				</li>
				<li>
					<span class="finedo-label-title">是否失效：Y-是；N-否</span>
					<input class="finedo-text" type="text" id="isinvalid" name="isinvalid" value="">
				</li>
				<li>
					<span class="finedo-label-title">支付时间</span>
					<input class="finedo-date" type="text" value="" id="paytime" name="paytime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
				</li>
				<li>
					<span class="finedo-label-title">创建时间</span>
					<input class="finedo-date" type="text" value="" id="createtime" name="createtime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
				</li>
				<li>
					<span class="finedo-label-title">订单金额</span>
					<input class="finedo-text" type="text" id="ordermoney" name="ordermoney" value="">
				</li>
				<li>
					<span class="finedo-label-title">是否支付:Y-是；N-否</span>
					<input class="finedo-text" type="text" id="ispay" name="ispay" value="">
				</li>
			</ul>
			
			<ul>
	    		<li class="add-center"><input type="button" class="finedo-button" value="提    交" onClick="easyshoporderadd.doSubmit()" ></li>
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
    		<li class="add-center"><input type="button" class="finedo-button" value="提    交" onclick="easyshoporderadd.doImport();"></li>
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
				<span class="finedo-label-title">模板下载</span><span class="finedo-label-info"><a href="../../easyshop/easyshoporder/import.xlsx" >订单表信息批量导入Excel模板 </a></span>
			</li>
			
			<li>
				<span class="finedo-label-title">第1列：</span><span class="finedo-label-info">用户id</span>
			</li>
			<li>
				<span class="finedo-label-title">第2列：</span><span class="finedo-label-info">订单状态：待付款-nopay;已付款-payed;invalid-已失效</span>
			</li>
			<li>
				<span class="finedo-label-title">第3列：</span><span class="finedo-label-info">快递公司编码</span>
			</li>
			<li>
				<span class="finedo-label-title">第4列：</span><span class="finedo-label-info">物流单号</span>
			</li>
			<li>
				<span class="finedo-label-title">第5列：</span><span class="finedo-label-info">是否失效：Y-是；N-否</span>
			</li>
			<li>
				<span class="finedo-label-title">第6列：</span><span class="finedo-label-info">支付时间</span>
			</li>
			<li>
				<span class="finedo-label-title">第7列：</span><span class="finedo-label-info">创建时间</span>
			</li>
			<li>
				<span class="finedo-label-title">第8列：</span><span class="finedo-label-info">订单金额</span>
			</li>
			<li>
				<span class="finedo-label-title">第9列：</span><span class="finedo-label-info">是否支付:Y-是；N-否</span>
			</li>
		</ul>
	</div>
</div>
<script language="javascript">
var easyshoporderadd={};
/**
 * 增加页面初始化，用于初始化表单
 */
easyshoporderadd.initadd=function(){
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
easyshoporderadd.checkdata=function(){
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
		"orderstate":{label:"订单状态：待付款-nopay;已付款-payed;invalid-已失效", datatype:"string", required:false},		
		"shippercode":{label:"快递公司编码", datatype:"string", required:false},		
		"logisticcode":{label:"物流单号", datatype:"string", required:false},		
		"isinvalid":{label:"是否失效：Y-是；N-否", datatype:"string", required:false},		
		"paytime":{label:"支付时间", datatype:"date", required:false},
		"createtime":{label:"创建时间", datatype:"date", required:false},
		"ordermoney":{label:"订单金额", datatype:"string", required:false},		
		"ispay":{label:"是否支付:Y-是；N-否", datatype:"string", required:false},		
	}, true);
	
   	//TODO: 自定义数据验证
	
	return result;
};
/**
 * 提交方法
 */
easyshoporderadd.doNext=function() {
	if($('#common_add_div').css('display') == 'block') {
		easyshoporderadd.doSubmit();
	}else {
		easyshoporderadd.doImport();
	}
};
/**
 * 提交方法
 */
easyshoporderadd.doSubmit=function() {
	if(!easyshoporderadd.checkdata()) 
		return;
	finedo.action.ajaxForm({
		form:"ajaxForm",
		url:"../../finedo/easyshoporder/add",
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
easyshoporderadd.doImport=function() {
	var fileControl=finedo.getFileControl('uploaddiv');
	var filearr=fileControl.getFileList();
	if(filearr.length != 1) {
		finedo.message.error("未上传Excel文件");
		return;
	}
	$('#fileid').val(filearr[0].fileid);
	
	finedo.action.ajaxForm({
		form:"importForm",
		url:"../../finedo/easyshoporder/importexcel",
		callback:easyshoporderadd.importCallback,
		clearForm:false
	});
};
/**
 * 批量导入回调函数
 */
easyshoporderadd.importCallback=function(ajaxret){
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
    easyshoporderadd.initadd();
});
</script>
</body>
</html>
