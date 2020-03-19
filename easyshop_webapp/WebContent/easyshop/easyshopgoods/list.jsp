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
		<span>商品列表</span>
	</div>
	<div class="yllist">
		<div class="yllist-infor-left"
			style="margin-top: 0px; margin-bottom: 15px;">
			<a href="#" title="导出" class="export" onclick="easyshopgoodslist.doExport();"></a> 
			<a href="#" class="add" onclick="easyshopgoodslist.showAddDialog();" title="添加"></a>
		</div>
		<div class="yllist-infor-rig">
			<input type="button" value="&nbsp;" class="ylquery" onclick="easyshopgoodslist.doQueryFast();"> 
			<input type="text" placeholder="请输入商品名称" class="yltext" id="goodsname_que" style="width: 200px; height: 40px; margin-right: 20px;margin-left: 20px;">
			
		</div>
	</div>
    <!-- 表格栏  -->
	<table id="datagrid"></table>
</div>

<iframe id="downiframe" name="downiframe" style="display:none" ></iframe>
<script type="text/javascript">
var easyshopgoodslist={};
/**
 * 初始化列表页面
 */
easyshopgoodslist.initlist=function(){
	var columnslist = [];
	columnslist.push({code:'goodsid', title: '商品编号', width: '10%', formatter:easyshopgoodslist.formatPkey, order:true});
	columnslist.push({code:'goodsname', title: '商品名称', width: '10%'});
	columnslist.push({code:'goodstypename', title: '商品类型', width: '10%'});
	columnslist.push({code:'presentprice', title: '现价', width: '5%'});
	columnslist.push({code:'originalprice', title: '原价', width: '5%'});
	columnslist.push({code:'isrecommend', title: '是否推荐', width: '5%', formatter:easyshopgoodslist.formatisrecommend});
	columnslist.push({code:'addtime', title: '添加时间', width: '10%'});
	columnslist.push({code:'opttime', title: '修改时间', width: '10%'});
/* 	columnslist.push({code:'points', title: '所需积分', width: '10%'});
	columnslist.push({code:'paytype', title: '支付类型', width: '10%'}); */
	columnslist.push({code:'operation', title: '操作', formatter:easyshopgoodslist.formatOperation});
	finedo.getgrid("datagrid",{
        url:"../../finedo/easyshopgoods/query",
        selecttype: "multi",
        columns: columnslist
    }).load();
};
/**
 * 格式化操作列展示
 */
easyshopgoodslist.formatisrecommend=function(row){
	var isrecommend=row.isrecommend;
	if(isrecommend=='Y'){
		isrecommend='推荐'
	}else if(isrecommend='N'){
		isrecommend='不推荐'
	}
	return isrecommend;
};
/**
 * 格式化操作列展示
 */
easyshopgoodslist.formatOperation=function(row){
	var operation = '<a href="javascript:easyshopgoodslist.showModifyDialog(\'' + row.goodsid + '\');">[编辑]</a>&nbsp;';
	operation += '<a href="javascript:finedo.action.doDelete(\'datagrid\',\'${ctx}/finedo/easyshopgoods/delete\',\'' + row.goodsid + '\')">[删除]</a>&nbsp;';
	return operation;
};
/**
 * 格式化主键展示
 */
easyshopgoodslist.formatPkey=function(row){
	return '<a href="#" onclick="easyshopgoodslist.showDetailDialog(\'' + row.goodsid + '\');">' + row.goodsid + '</a>&nbsp;';
};
/**
 * 快捷查询按钮
 */
easyshopgoodslist.doQueryFast=function(){
	var goodsname_que=$('#goodsname_que').val();
	
	var param = {goodsname:goodsname_que};
	finedo.getgrid("datagrid").query(param);
};
/**
 * 弹出增加对话框
 */
easyshopgoodslist.showAddDialog=function(){
	finedo.dialog.show({
		width:850,
		height:550,
		'title':'新增信息',
		'url':'../../finedo/easyshopgoods/addindex'
	});
};
/**
 * 弹出修改对话框
 */
easyshopgoodslist.showModifyDialog=function(pkeyid){
	finedo.dialog.show({
		width:850,
		height:550,
		'title':'修改信息',
		'url':'../../finedo/easyshopgoods/updateindex?goodsid=' + pkeyid
	});
};
/**
 * 弹出详情对话框
 */
easyshopgoodslist.showDetailDialog=function(pkeyid){
	finedo.dialog.show({
		width:850,
		height:550,
		'title':'修改信息',
		'url':'../../finedo/easyshopgoods/detailindex?goodsid=' + pkeyid
	});
};
/**
 * 导出方法
 */
easyshopgoodslist.doExport=function(){
	var param=finedo.getgrid("datagrid").getqueryparams();
	$("#downiframe").attr('src', '../../finedo/easyshopgoods/exportexcel' + (param ? '?' + $.param(param) : ''));
};
/**
 * 高级查询条件显示与隐藏
 */
easyshopgoodslist.opquerycond=function(){
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
    easyshopgoodslist.initlist();
});
</script>
</body>
</html>

