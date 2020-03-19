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
		<span>地址列表</span>
	</div>
	<div class="yllist">
		<div class="yllist-infor-left"
			style="margin-top: 0px; margin-bottom: 15px;">
			<a href="#" title="导出" class="export" onclick="easyshopaddresslist.doExport();"></a> 
			<a href="#" class="add" onclick="easyshopaddresslist.showAddDialog();" title="添加"></a>
		</div>
		<div class="yllist-infor-rig">
			<input type="button" value="&nbsp;" class="ylquery" onclick="easyshopaddresslist.doQueryFast();"> 
			<input type="text" placeholder="请输入地址名称" class="yltext" id="goodsname_que" style="width: 200px; height: 40px; margin-right: 20px;margin-left: 20px;">
			
		</div>
	</div>
    <!-- 表格栏  -->
	<table id="datagrid"></table>
</div>

<iframe id="downiframe" name="downiframe" style="display:none" ></iframe>
<script type="text/javascript">
var easyshopaddresslist={};
/**
 * 初始化列表页面
 */
easyshopaddresslist.initlist=function(){
	var columnslist = [];
	columnslist.push({code:'addressid', title: '地址编号', width: '15%', formatter:easyshopaddresslist.formatPkey, order:true});
	columnslist.push({code:'nickname', title: '用户姓名', width: '7%', formatter:easyshopaddresslist.formatuserid});
	columnslist.push({code:'province', title: '省份', width: '7%'});
	columnslist.push({code:'city', title: '市', width: '7%'});
	columnslist.push({code:'area', title: '区/县', width: '7%'});
	columnslist.push({code:'username', title: '联系人', width: '10%'});
	columnslist.push({code:'phone', title: '联系方式', width: '10%'});
	columnslist.push({code:'address', title: '地址详情', width: '15%', formatter:easyshopaddresslist.formatintroduction});
	columnslist.push({code:'isdefault', title: '是否默认', width: '5%', formatter:easyshopaddresslist.formatisdefault});
	columnslist.push({code:'addtime', title: '添加时间', width: '7%'});
	columnslist.push({code:'operation', title: '操作', formatter:easyshopaddresslist.formatOperation});
	finedo.getgrid("datagrid",{
        url:"../../finedo/easyshopaddress/query",
        selecttype: "multi",
        columns: columnslist
    }).load();
};
/**
 * 格式化操作列展示
 */
easyshopaddresslist.formatOperation=function(row){
	var operation = '<a href="javascript:easyshopaddresslist.showModifyDialog(\'' + row.addressid + '\');">[编辑]</a>&nbsp;';
	operation += '<a href="javascript:finedo.action.doDelete(\'datagrid\',\'${ctx}/finedo/easyshopaddress/delete\',\'' + row.addressid + '\')">[删除]</a>&nbsp;';
	return operation;
};
easyshopaddresslist.formatintroduction=function(row){
	var address=row.address;
	if(finedo.fn.isNotNon(address)){
		if(address.length>=30){
			address=address.substr(0,29)+'...'
		}
	}
	return address;
}
easyshopaddresslist.formatisdefault=function(row){
	var isdefault=row.isdefault;
	if(finedo.fn.isNotNon(isdefault)){
		if(isdefault=='Y'){
			isdefault= '是';
		}else{
			isdefault= '否';
		}
	}
	return isdefault;
}
/**
 * 格式化主键展示
 */
easyshopaddresslist.formatPkey=function(row){
	return '<a href="#" onclick="easyshopaddresslist.showDetailDialog(\'' + row.addressid + '\');">' + row.addressid + '</a>&nbsp;';
};
/**
 * 快捷查询按钮
 */
easyshopaddresslist.doQueryFast=function(){
	var text=$('#query-box-text').val();
	
	var param = {addressid:text};
	finedo.getgrid("datagrid").query(param);
};
/**
 * 弹出增加对话框
 */
easyshopaddresslist.showAddDialog=function(){
	finedo.dialog.show({
		width:950,
		height:650,
		'title':'新增信息',
		'url':'../../finedo/easyshopaddress/addindex'
	});
};
/**
 * 弹出修改对话框
 */
easyshopaddresslist.showModifyDialog=function(pkeyid){
	finedo.dialog.show({
		width:950,
		height:650,
		'title':'修改信息',
		'url':'../../finedo/easyshopaddress/updateindex?addressid=' + pkeyid
	});
};
/**
 * 弹出详情对话框
 */
easyshopaddresslist.showDetailDialog=function(pkeyid){
	finedo.dialog.show({
		width:950,
		height:650,
		'title':'修改信息',
		'url':'../../finedo/easyshopaddress/detailindex?addressid=' + pkeyid
	});
};
/**
 * 导出方法
 */
easyshopaddresslist.doExport=function(){
	var param=finedo.getgrid("datagrid").getqueryparams();
	$("#downiframe").attr('src', '../../finedo/easyshopaddress/exportexcel' + (param ? '?' + $.param(param) : ''));
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
    easyshopaddresslist.initlist();
});
</script>
</body>
</html>

