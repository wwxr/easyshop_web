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
		<span>物流信息列表</span>
	</div>
	<div class="yllist">
		<div class="yllist-infor-left"
			style="margin-top: 0px; margin-bottom: 15px;">
			<a href="#" title="导出" class="export" onclick="easyshopexpresslist.doExport();"></a> 
			<a href="#" class="add" onclick="easyshopexpresslist.showAddDialog();" title="添加"></a>
		</div>
		<div class="yllist-infor-rig">
			<input type="button" value="&nbsp;" class="ylquery" onclick="easyshopexpresslist.doQueryFast();"> 
			<input type="text" placeholder="请输入物流名称" class="yltext" id="expressname_que" style="width: 200px; height: 40px; margin-right: 20px;margin-left: 20px;">
			
		</div>
	</div>
    <!-- 表格栏  -->
	<table id="datagrid"></table>
</div>

<iframe id="downiframe" name="downiframe" style="display:none" ></iframe>
<script type="text/javascript">
var easyshopexpresslist={};
/**
 * 初始化列表页面
 */
easyshopexpresslist.initlist=function(){
	var columnslist = [];
	columnslist.push({code:'shippercode', title: '物流编号', width: '40%', formatter:easyshopexpresslist.formatPkey, order:true});
	columnslist.push({code:'shippername', title: '物流名称', width: '40%'});
	columnslist.push({code:'operation', title: '操作', formatter:easyshopexpresslist.formatOperation});
	finedo.getgrid("datagrid",{
        url:"../../finedo/easyshopexpress/query",
        selecttype: "multi",
        expand:easyshopexpresslist.doExpandRow,
        columns: columnslist
    }).load();
};
/**
 * 格式化操作列展示
 */
easyshopexpresslist.formatOperation=function(row){
	var operation = '<a href="javascript:easyshopexpresslist.showModifyDialog(\'' + row.shippercode + '\');">[编辑]</a>&nbsp;';
	operation += '<a href="javascript:finedo.action.doDelete(\'datagrid\',\'${ctx}/finedo/easyshopexpress/delete\',\'' + row.shippercode + '\')">[删除]</a>&nbsp;';
	return operation;
};
/**
 * 格式化主键展示
 */
easyshopexpresslist.formatPkey=function(row){
	return '<a href="#" onclick="easyshopexpresslist.showDetailDialog(\'' + row.shippercode + '\');">' + row.shippercode + '</a>&nbsp;';
};
/**
 * 显示行详情数据
 */
easyshopexpresslist.doExpandRow=function(data){
	var datahtml="<div class='data'><ul>";
	
	datahtml=datahtml + "<li><span class='data-name'>物流编号</span><span class='data-con'>" + finedo.fn.replaceNull(data.shippercode) + "</span></li>";
	datahtml=datahtml + "<li><span class='data-name'>物流名称</span><span class='data-con'>" + finedo.fn.replaceNull(data.shippername) + "</span></li>";
	datahtml=datahtml + "</ul></div>";
	return datahtml;
};
/**
 * 查询按钮触发方法
 */
easyshopexpresslist.doQuery=function(){
	easyshopexpresslist.opquerycond();
	
	
	var param = {shippercode: $('#shippercode').val(), shippername: $('#shippername').val()};
	finedo.getgrid("datagrid").query(param);
};
/**
 * 查询取消
 */
easyshopexpresslist.doQueryCancel=function(){
	easyshopexpresslist.opquerycond();
};
/**
 * 快捷查询按钮
 */
easyshopexpresslist.doQueryFast=function(){
	var expressname_que=$('#expressname_que').val();
	
	var param = {shippername:expressname_que};
	finedo.getgrid("datagrid").query(param);
};
/**
 * 弹出增加对话框
 */
easyshopexpresslist.showAddDialog=function(){
	finedo.dialog.show({
		width:850,
		height:550,
		'title':'新增信息',
		'url':'../../finedo/easyshopexpress/addindex'
	});
};
/**
 * 弹出修改对话框
 */
easyshopexpresslist.showModifyDialog=function(pkeyid){
	finedo.dialog.show({
		width:850,
		height:550,
		'title':'修改信息',
		'url':'../../finedo/easyshopexpress/updateindex?shippercode=' + pkeyid
	});
};
/**
 * 弹出详情对话框
 */
easyshopexpresslist.showDetailDialog=function(pkeyid){
	finedo.dialog.show({
		width:850,
		height:550,
		'title':'修改信息',
		'url':'../../finedo/easyshopexpress/detailindex?shippercode=' + pkeyid
	});
};
/**
 * 导出方法
 */
easyshopexpresslist.doExport=function(){
	var param=finedo.getgrid("datagrid").getqueryparams();
	$("#downiframe").attr('src', '../../finedo/easyshopexpress/exportexcel' + (param ? '?' + $.param(param) : ''));
};
/**
 * 高级查询条件显示与隐藏
 */
easyshopexpresslist.opquerycond=function(){
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
    easyshopexpresslist.initlist();
});
</script>
</body>
</html>

