<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs2.jsp" %>

<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>

<body class="body">

<div style="width:100%;">
	<div class="ylnav">
		<span>用户列表</span>
	</div>
	<div class="yllist">
		<div class="yllist-infor-left"
			style="margin-top: 0px; margin-bottom: 15px;">
			<a href="#" title="导出" class="export" onclick="easyshopuserlist.doExport();"></a> 
			<!-- <a href="#" class="add" onclick="easyshopuserlist.showAddDialog();" title="添加"></a> -->
		</div>
		<div class="yllist-infor-rig">
			<input type="button" value="&nbsp;" class="ylquery" onclick="easyshopuserlist.doQueryFast();"> 
			<input type="text" placeholder="请输入用户昵称" class="yltext" id="username_que" style="width: 200px; height: 40px; margin-right: 20px;margin-left: 20px;">
		</div>
	</div>
    <!-- 表格栏  -->
	<table id="datagrid"></table>
</div>
<iframe id="downiframe" name="downiframe" style="display:none" ></iframe>
<script type="text/javascript">
var easyshopuserlist={};
/**
 * 初始化列表页面
 */
easyshopuserlist.initlist=function(){
	var columnslist = [];
	columnslist.push({code:'userid', title: '用户编号', width: '15%', formatter:easyshopuserlist.formatPkey, order:true});
	columnslist.push({code:'nickname', title: '昵称', width: '15%'});
	columnslist.push({code:'gender', title: '性别', width: '10%',formatter:easyshopuserlist.formatgender});
	columnslist.push({code:'avatar', title: '头像', width: '15%',formatter:easyshopuserlist.formatavatar});
	columnslist.push({code:'points', title: '积分', width: '15%',edit:true});
	columnslist.push({code:'registtime', title: '注册时间', width: '15%'});
	columnslist.push({code:'operation', title: '操作', formatter:easyshopuserlist.formatOperation});
	finedo.getgrid("datagrid",{
        url:"../../finedo/easyshopuser/query",
        selecttype: "multi",
        columns: columnslist,
        updateurl:"../../finedo/easyshopuser/modify"
    }).load();
};
/**
 * 格式化操作列展示
 */
easyshopuserlist.formatOperation=function(row){
	var operation = '';
		//'<a href="javascript:easyshopuserlist.showModifyDialog(\'' + row.userid + '\');">[编辑]</a>&nbsp;';
	operation += '<a href="javascript:finedo.action.doDelete(\'datagrid\',\'${ctx}/finedo/easyshopuser/delete\',\'' + row.userid + '\')">[删除]</a>&nbsp;';
	return operation;
};
/**
 * 格式化图片展示
 */
 easyshopuserlist.formatavatar=function(row){
	var avatar=row.avatar;
	if(finedo.fn.isNon(avatar)){
		return "无";
	}
	return "<image  style='width:80px;height:80px;' src="+avatar+">"
};
/**
 * 格式化性别
 */
 easyshopuserlist.formatgender=function(row){
	var gender=row.gender;
	if(gender=='1'){
		return "男";
	}else if(gender=='2'){
		return "女";
	}
	return gender;
};
/**
 * 格式化主键展示
 */
easyshopuserlist.formatPkey=function(row){
	return '<a href="#" onclick="easyshopuserlist.showDetailDialog(\'' + row.userid + '\');">' + row.userid + '</a>&nbsp;';
};
/**
 * 显示行详情数据
 */
easyshopuserlist.doExpandRow=function(data){
	var datahtml="<div class='data'><ul>";
	
	datahtml=datahtml + "<li><span class='data-name'>主键id</span><span class='data-con'>" + finedo.fn.replaceNull(data.userid) + "</span></li>";
	datahtml=datahtml + "<li><span class='data-name'>积分</span><span class='data-con'>" + finedo.fn.replaceNull(data.points) + "</span></li>";
	datahtml=datahtml + "<li><span class='data-name'>openid</span><span class='data-con'>" + finedo.fn.replaceNull(data.openid) + "</span></li>";
	datahtml=datahtml + "<li><span class='data-name'>unionid</span><span class='data-con'>" + finedo.fn.replaceNull(data.unionid) + "</span></li>";
	datahtml=datahtml + "<li><span class='data-name'>手机号</span><span class='data-con'>" + finedo.fn.replaceNull(data.phone) + "</span></li>";
	datahtml=datahtml + "<li><span class='data-name'>推广人编码对应二维码</span><span class='data-con'>" + finedo.fn.replaceNull(data.promoter) + "</span></li>";
	datahtml=datahtml + "<li><span class='data-name'>用户姓名</span><span class='data-con'>" + finedo.fn.replaceNull(data.username) + "</span></li>";
	datahtml=datahtml + "<li><span class='data-name'>昵称</span><span class='data-con'>" + finedo.fn.replaceNull(data.nickname) + "</span></li>";
	datahtml=datahtml + "<li><span class='data-name'>头像</span><span class='data-con'>" + finedo.fn.replaceNull(data.avatar) + "</span></li>";
	datahtml=datahtml + "<li><span class='data-name'>自己的推广码</span><span class='data-con'>" + finedo.fn.replaceNull(data.promocode) + "</span></li>";
	datahtml=datahtml + "<li><span class='data-name'>注册时间</span><span class='data-con'>" + finedo.fn.replaceNull(data.registtime) + "</span></li>";
	datahtml=datahtml + "<li><span class='data-name'>性别：1-男；0-女</span><span class='data-con'>" + finedo.fn.replaceNull(data.gender) + "</span></li>";
	datahtml=datahtml + "</ul></div>";
	return datahtml;
};
/**
 * 查询按钮触发方法
 */
easyshopuserlist.doQuery=function(){
	easyshopuserlist.opquerycond();
	
	
	var param = {userid: $('#userid').val(), points: $('#points').val(), openid: $('#openid').val(), unionid: $('#unionid').val(), phone: $('#phone').val(), promoter: $('#promoter').val(), username: $('#username').val(), nickname: $('#nickname').val(), avatar: $('#avatar').val(), promocode: $('#promocode').val(), registtimebegin: $('#registtimebegin').val(), registtimeend: $('#registtimeend').val(), gender: $('#gender').val()};
	finedo.getgrid("datagrid").query(param);
};
/**
 * 查询取消
 */
easyshopuserlist.doQueryCancel=function(){
	easyshopuserlist.opquerycond();
};
/**
 * 快捷查询按钮
 */
easyshopuserlist.doQueryFast=function(){
	var username_que=$('#username_que').val();
	
	var param = {username:username_que};
	finedo.getgrid("datagrid").query(param);
};
/**
 * 弹出增加对话框
 */
easyshopuserlist.showAddDialog=function(){
	finedo.dialog.show({
		width:850,
		height:550,
		'title':'新增信息',
		'url':'../../finedo/easyshopuser/addindex'
	});
};
/**
 * 弹出修改对话框
 */
easyshopuserlist.showModifyDialog=function(pkeyid){
	finedo.dialog.show({
		width:850,
		height:550,
		'title':'修改信息',
		'url':'../../finedo/easyshopuser/updateindex?userid=' + pkeyid
	});
};
/**
 * 弹出详情对话框
 */
easyshopuserlist.showDetailDialog=function(pkeyid){
	finedo.dialog.show({
		width:850,
		height:550,
		'title':'修改信息',
		'url':'../../finedo/easyshopuser/detailindex?userid=' + pkeyid
	});
};
/**
 * 导出方法
 */
easyshopuserlist.doExport=function(){
	var param=finedo.getgrid("datagrid").getqueryparams();
	$("#downiframe").attr('src', '../../finedo/easyshopuser/exportexcel' + (param ? '?' + $.param(param) : ''));
};
/**
 * 高级查询条件显示与隐藏
 */
easyshopuserlist.opquerycond=function(){
	var divdisplay=$('#advanced-search-con').css('display');
	
	if(divdisplay == 'block'){
		$('#advanced-search-con').css('display', 'none');
		$('#advanced-search').attr('class', 'query-as-link');
	
	}else{
		$('#advanced-search-con').css('display', 'block');
		$('#advanced-search').attr('class', 'query-as-hover');
	}
};
</script>
<script type='text/javascript' src='../../resource/js/lazyload.js'></script>
<script language="javascript">
LazyLoad.css([
    '../../resource/themes/default/style.css',
    '../../resource/js/finedoui/commonui/themes/commonui.css',
    '../../resource/js/finedoui/dialog/themes/style.css',
    '../../resource/js/finedoui/grid/themes/style.css',
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
    '../../resource/js/finedoui/grid/finedo.grid.js',
    '../../resource/js/finedoui/upload/finedo.upload.js',
    '../../resource/js/finedoui/image/viewer.min.js',
    ], function() {
    easyshopuserlist.initlist();
});
</script>
</body>
</html>

