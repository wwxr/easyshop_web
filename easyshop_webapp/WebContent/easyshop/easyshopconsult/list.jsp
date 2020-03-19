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
		<span>咨询记录列表</span>
	</div>
    <!-- 表格栏  -->
	<table id="datagrid"></table>
</div>

<iframe id="downiframe" name="downiframe" style="display:none" ></iframe>
<script type="text/javascript">
var easyshopconsultlist={};
/**
 * 初始化列表页面
 */
easyshopconsultlist.initlist=function(){
	var columnslist = [];
	columnslist.push({code:'consultid', title: '咨询主键', width: '15%', formatter:easyshopconsultlist.formatPkey, order:true});
	columnslist.push({code:'userid', title: '用户id', width: '15%'});
	columnslist.push({code:'businessid', title: '商家id', width: '15%'});
	columnslist.push({code:'detail', title: '咨询内容：', width: '30%'});
	columnslist.push({code:'createtime', title: '创建时间', width: '15%'});
	columnslist.push({code:'operation', title: '操作', formatter:easyshopconsultlist.formatOperation});
	finedo.getgrid("datagrid",{
        url:"../../finedo/easyshopconsult/query",
        selecttype: "multi",
        columns: columnslist
    }).load();
};
/**
 * 格式化操作列展示
 */
easyshopconsultlist.formatOperation=function(row){
	var operation = '<a href="javascript:easyshopconsultlist.showModifyDialog(\'' + row.consultid + '\');">[编辑]</a>&nbsp;';
	operation += '<a href="javascript:finedo.action.doDelete(\'datagrid\',\'${ctx}/finedo/easyshopconsult/delete\',\'' + row.consultid + '\')">[删除]</a>&nbsp;';
	return operation;
};
/**
 * 格式化主键展示
 */
easyshopconsultlist.formatPkey=function(row){
	return '<a href="#" onclick="easyshopconsultlist.showDetailDialog(\'' + row.consultid + '\');">' + row.consultid + '</a>&nbsp;';
};
/**
 * 显示行详情数据
 */
easyshopconsultlist.doExpandRow=function(data){
	var datahtml="<div class='data'><ul>";
	
	datahtml=datahtml + "<li><span class='data-name'>咨询主键</span><span class='data-con'>" + finedo.fn.replaceNull(data.consultid) + "</span></li>";
	datahtml=datahtml + "<li><span class='data-name'>用户id</span><span class='data-con'>" + finedo.fn.replaceNull(data.userid) + "</span></li>";
	datahtml=datahtml + "<li><span class='data-name'>商家id</span><span class='data-con'>" + finedo.fn.replaceNull(data.businessid) + "</span></li>";
	datahtml=datahtml + "<li><span class='data-name'>咨询内容：以json格式存储-{userid:..,time:...,text:...}</span><span class='data-con'>" + finedo.fn.replaceNull(data.detail) + "</span></li>";
	datahtml=datahtml + "<li><span class='data-name'>创建时间</span><span class='data-con'>" + finedo.fn.replaceNull(data.createtime) + "</span></li>";
	datahtml=datahtml + "</ul></div>";
	return datahtml;
};
/**
 * 查询按钮触发方法
 */
easyshopconsultlist.doQuery=function(){
	easyshopconsultlist.opquerycond();
	
	
	var param = {consultid: $('#consultid').val(), userid: $('#userid').val(), businessid: $('#businessid').val(), detail: $('#detail').val(), createtimebegin: $('#createtimebegin').val(), createtimeend: $('#createtimeend').val()};
	finedo.getgrid("datagrid").query(param);
};
/**
 * 查询取消
 */
easyshopconsultlist.doQueryCancel=function(){
	easyshopconsultlist.opquerycond();
};
/**
 * 快捷查询按钮
 */
easyshopconsultlist.doQueryFast=function(){
	var text=$('#query-box-text').val();
	
	var param = {consultid:text};
	finedo.getgrid("datagrid").query(param);
};
/**
 * 弹出增加对话框
 */
easyshopconsultlist.showAddDialog=function(){
	finedo.dialog.show({
		width:850,
		height:550,
		'title':'新增信息',
		'url':'../../finedo/easyshopconsult/addindex'
	});
};
/**
 * 弹出修改对话框
 */
easyshopconsultlist.showModifyDialog=function(pkeyid){
	finedo.dialog.show({
		width:850,
		height:550,
		'title':'修改信息',
		'url':'../../finedo/easyshopconsult/updateindex?consultid=' + pkeyid
	});
};
/**
 * 弹出详情对话框
 */
easyshopconsultlist.showDetailDialog=function(pkeyid){
	finedo.dialog.show({
		width:850,
		height:550,
		'title':'修改信息',
		'url':'../../finedo/easyshopconsult/detailindex?consultid=' + pkeyid
	});
};
/**
 * 导出方法
 */
easyshopconsultlist.doExport=function(){
	var param=finedo.getgrid("datagrid").getqueryparams();
	$("#downiframe").attr('src', '../../finedo/easyshopconsult/exportexcel' + (param ? '?' + $.param(param) : ''));
};
/**
 * 高级查询条件显示与隐藏
 */
easyshopconsultlist.opquerycond=function(){
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
    easyshopconsultlist.initlist();
});
</script>
</body>
</html>

