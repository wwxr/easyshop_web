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
		<span>订单列表</span>
	</div>
	<div class="yllist">
		<div class="yllist-infor-left"
			style="margin-top: 0px; margin-bottom: 15px;">
			<a href="#" title="导出" class="export" onclick="easyshoporderlist.doExport();"></a> 
			<!-- <a href="#" class="add" onclick="easyshoporderlist.showAddDialog();" title="添加"></a> -->
		</div>
		<div class="yllist-infor-rig">
			<input type="button" value="&nbsp;" class="ylquery" onclick="easyshoporderlist.doQueryFast();"> 
			<input type="text" placeholder="请输入订单编号" class="yltext" id="ordercode_que" style="width: 200px; height: 40px; margin-right: 20px;margin-left: 20px;">
			<select class='selectdata' id="orderstateque"  onchange='easyshoporderlist.doQueryFast();'>
						<option value="">全部订单</option>
						<option value="payed">已支付</option>
						<option value="nopay">未支付</option>
						<option value="invalid">已失效</option>
			</select>
		</div>
	</div>
    <!-- 表格栏  -->
	<table id="datagrid"></table>
</div>
<iframe id="downiframe" name="downiframe" style="display:none" ></iframe>
<script type="text/javascript">
var easyshoporderlist={};
/**
 * 初始化列表页面
 */
easyshoporderlist.initlist=function(){
	var columnslist = [];
	columnslist.push({code:'ordercode', title: '订单编号', width: '10%', formatter:easyshoporderlist.formatPkey, order:true});
	columnslist.push({code:'nickname', title: '用户昵称', width: '7%'});
	columnslist.push({code:'orderstate', title: '订单状态', width: '8%', formatter:easyshoporderlist.formatorderstate});
	columnslist.push({code:'shippercode', title: '快递公司编码', width: '10%'});
	columnslist.push({code:'logisticcode', title: '物流单号', width: '10%'});
	columnslist.push({code:'ordermoney', title: '订单金额', width: '8%'});
	columnslist.push({code:'createtime', title: '创建时间', width: '8%'});
	columnslist.push({code:'ispay', title: '是否支付', width: '8%', formatter:easyshoporderlist.formatispay});
	columnslist.push({code:'paytime', title: '支付时间', width: '8%'});
	columnslist.push({code:'isinvalid', title: '是否失效', width: '10%', formatter:easyshoporderlist.formatisinvalid});
	columnslist.push({code:'operation', title: '操作', formatter:easyshoporderlist.formatOperation});
	finedo.getgrid("datagrid",{
        url:"../../finedo/easyshoporder/query",
        selecttype: "multi",
        columns: columnslist
    }).load();
};

easyshoporderlist.formatorderstate=function(row){
	var orderstate=row.orderstate;
	if(orderstate=='nopay'){
		orderstate='未支付'
	}else if(orderstate='payed'){
		orderstate='已支付'
	}else if(orderstate='invalid'){
		orderstate='已失效'
	}else{
		orderstate=''
	}
	return orderstate;
};
easyshoporderlist.formatisinvalid=function(row){
	var isinvalid=row.isinvalid;
	if(isinvalid=='Y'){
		isinvalid='已失效'
	}else if(isinvalid='N'){
		isinvalid='未失效'
	}
	return isinvalid;
};
easyshoporderlist.formatispay=function(row){
	var ispay=row.ispay;
	if(ispay=='Y'){
		ispay='已支付'
	}else if(ispay='N'){
		ispay='未支付'
	}
	return ispay;
};

/**
 * 格式化操作列展示
 */
easyshoporderlist.formatOperation=function(row){
	var operation = '<a href="javascript:easyshoporderlist.showModifyDialog(\'' + row.ordercode + '\');">[编辑]</a>&nbsp;';
	operation += '<a href="javascript:finedo.action.doDelete(\'datagrid\',\'${ctx}/finedo/easyshoporder/delete\',\'' + row.ordercode + '\')">[删除]</a>&nbsp;';
	return operation;
};
/**
 * 格式化主键展示
 */
easyshoporderlist.formatPkey=function(row){
	return '<a href="#" onclick="easyshoporderlist.showDetailDialog(\'' + row.ordercode + '\');">' + row.ordercode + '</a>&nbsp;';
};
/**
 * 快捷查询按钮
 */
easyshoporderlist.doQueryFast=function(){
	var ordercode_que=$('#ordercode_que').val();
	var orderstateque=$('#orderstateque').val();
	
	var param = {ordercode:ordercode_que,orderstate:orderstateque};
	finedo.getgrid("datagrid").query(param);
};
/**
 * 弹出增加对话框
 */
easyshoporderlist.showAddDialog=function(){
	finedo.dialog.show({
		width:850,
		height:550,
		'title':'新增信息',
		'url':'../../finedo/easyshoporder/addindex'
	});
};
/**
 * 弹出修改对话框
 */
easyshoporderlist.showModifyDialog=function(pkeyid){
	finedo.dialog.show({
		width:850,
		height:550,
		'title':'修改信息',
		'url':'../../finedo/easyshoporder/updateindex?ordercode=' + pkeyid
	});
};
/**
 * 弹出详情对话框
 */
easyshoporderlist.showDetailDialog=function(pkeyid){
	finedo.dialog.show({
		width:850,
		height:550,
		'title':'修改信息',
		'url':'../../finedo/easyshoporder/detailindex?ordercode=' + pkeyid
	});
};
/**
 * 导出方法
 */
easyshoporderlist.doExport=function(){
	var param=finedo.getgrid("datagrid").getqueryparams();
	$("#downiframe").attr('src', '../../finedo/easyshoporder/exportexcel' + (param ? '?' + $.param(param) : ''));
};
/**
 * 高级查询条件显示与隐藏
 */
easyshoporderlist.opquerycond=function(){
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
    easyshoporderlist.initlist();
});
</script>
</body>
</html>

