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
		<span>广告列表</span>
	</div>
	<div class="yllist">
		<div class="yllist-infor-left"
			style="margin-top: 0px; margin-bottom: 15px;">
			<a href="#" title="导出" class="export" onclick="easyshopnewslist.doExport();"></a> 
			<a href="#" class="add" onclick="easyshopnewslist.showAddDialog();" title="添加"></a>
		</div>
		<div class="yllist-infor-rig">
			<input type="button" value="&nbsp;" class="ylquery" onclick="easyshopnewslist.doQueryFast();"> 
			<input type="text" placeholder="请输入广告名称" class="yltext" id="goodsname_que" style="width: 200px; height: 40px; margin-right: 20px;margin-left: 20px;">
			
		</div>
	</div>
    <!-- 表格栏  -->
	<table id="datagrid"></table>
</div>

<iframe id="downiframe" name="downiframe" style="display:none" ></iframe>
<script type="text/javascript">
var easyshopnewslist={};
/**
 * 初始化列表页面
 */
easyshopnewslist.initlist=function(){
	var columnslist = [];
	columnslist.push({code:'newsid', title: '广告编号', width: '15%', formatter:easyshopnewslist.formatPkey, order:true});
	columnslist.push({code:'newsname', title: '广告名称', width: '15%'});
	columnslist.push({code:'addtime', title: '添加时间', width: '15%'});
	columnslist.push({code:'opttime', title: '修改时间', width: '15%'});
	columnslist.push({code:'newsintroduction', title: '广告简介', width: '30%', formatter:easyshopnewslist.formatintroduction});
	columnslist.push({code:'operation', title: '操作', formatter:easyshopnewslist.formatOperation});
	finedo.getgrid("datagrid",{
        url:"../../finedo/easyshopnews/query",
        selecttype: "multi",
        columns: columnslist
    }).load();
};
/**
 * 格式化操作列展示
 */
easyshopnewslist.formatOperation=function(row){
	var operation = '<a href="javascript:easyshopnewslist.showModifyDialog(\'' + row.newsid + '\');">[编辑]</a>&nbsp;';
	operation += '<a href="javascript:finedo.action.doDelete(\'datagrid\',\'${ctx}/finedo/easyshopnews/delete\',\'' + row.newsid + '\')">[删除]</a>&nbsp;';
	return operation;
};
easyshopnewslist.formatintroduction=function(row){
	var newsintroduction=row.newsintroduction;
	if(finedo.fn.isNotNon(newsintroduction)){
		if(newsintroduction.length>=30){
			newsintroduction=newsintroduction.substr(0,29)+'...'
		}
	}
	return newsintroduction;
}
/**
 * 格式化主键展示
 */
easyshopnewslist.formatPkey=function(row){
	return '<a href="#" onclick="easyshopnewslist.showDetailDialog(\'' + row.newsid + '\');">' + row.newsid + '</a>&nbsp;';
};
/**
 * 快捷查询按钮
 */
easyshopnewslist.doQueryFast=function(){
	var text=$('#query-box-text').val();
	
	var param = {newsid:text};
	finedo.getgrid("datagrid").query(param);
};
/**
 * 弹出增加对话框
 */
easyshopnewslist.showAddDialog=function(){
	finedo.dialog.show({
		width:850,
		height:550,
		'title':'新增信息',
		'url':'../../finedo/easyshopnews/addindex'
	});
};
/**
 * 弹出修改对话框
 */
easyshopnewslist.showModifyDialog=function(pkeyid){
	finedo.dialog.show({
		width:850,
		height:550,
		'title':'修改信息',
		'url':'../../finedo/easyshopnews/updateindex?newsid=' + pkeyid
	});
};
/**
 * 弹出详情对话框
 */
easyshopnewslist.showDetailDialog=function(pkeyid){
	finedo.dialog.show({
		width:850,
		height:550,
		'title':'修改信息',
		'url':'../../finedo/easyshopnews/detailindex?newsid=' + pkeyid
	});
};
/**
 * 导出方法
 */
easyshopnewslist.doExport=function(){
	var param=finedo.getgrid("datagrid").getqueryparams();
	$("#downiframe").attr('src', '../../finedo/easyshopnews/exportexcel' + (param ? '?' + $.param(param) : ''));
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
    easyshopnewslist.initlist();
});
</script>
</body>
</html>

