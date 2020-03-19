<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs2.jsp" %>

<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>

<body class="scrollcss">

<div style="width:100%;">
	<!-- 工具栏  -->
	<div class="query-title">
		<!-- 标题 -->
    	<div class="query-title-name">订单物品关联表管理 </div>
    	
    	<div class="query-boxbig">
	    	<input type="button" class="query-btn-nextstep" onclick="easyshopordergoodslist.showAddDialog();" value="新建订单物品关联表">
	    	<input type="button" class="query-btn-nextstep" onclick="easyshopordergoodslist.doExport();" value="批量导出">
       	 	
    		<div class="query-fast">
	        	<input type="text" class="query-fast-text" id="query-box-text" value="">
	            <input type="button" class="query-fast-magnifier" onclick="easyshopordergoodslist.doQueryFast();">
	        </div>
	        <input type="button" class="query-btn-nextstep" onclick="easyshopordergoodslist.opquerycond();" value="高级搜索">
    	</div>
	</div>
	
	<!-- 高级搜索栏  -->
    <div class="query-advanced-search-con" id="advanced-search-con" style="display:none; ">
    	<div class="query-common-query" id="common-con">
        	<ul class="finedo-ul">
				<li>
					<span class="finedo-label-title">订单物品关联主键id</span>
					<input class="finedo-text" type="text" id="ordergoodsid" name="ordergoodsid" value="">
				</li>
				<li>
					<span class="finedo-label-title">订单编号</span>
					<input class="finedo-text" type="text" id="ordercode" name="ordercode" value="">
				</li>
				<li>
					<span class="finedo-label-title">物品id</span>
					<input class="finedo-text" type="text" id="goodsid" name="goodsid" value="">
				</li>
			</ul>
        </div>
        <div class="query-operate">
            <input class="finedo-button-blue" type="button" value="查    询" onclick="easyshopordergoodslist.doQuery();">&nbsp;&nbsp;&nbsp;&nbsp;
           	<input class="finedo-button-blue" type="button" value="取    消" onclick="easyshopordergoodslist.doQueryCancel();">
        </div>
    </div>
    
    <!-- 表格栏  -->
	<table id="datagrid"></table>
</div>
<iframe id="downiframe" name="downiframe" style="display:none" ></iframe>
<script type="text/javascript">
var easyshopordergoodslist={};
/**
 * 初始化列表页面
 */
easyshopordergoodslist.initlist=function(){
	var columnslist = [];
	columnslist.push({code:'ordergoodsid', title: '订单物品关联主键id', width: 100, formatter:easyshopordergoodslist.formatPkey, order:true});
	columnslist.push({code:'ordercode', title: '订单编号', width: 100});
	columnslist.push({code:'goodsid', title: '物品id', width: 100});
	columnslist.push({code:'operation', title: '操作', formatter:easyshopordergoodslist.formatOperation});
	finedo.getgrid("datagrid",{
        url:"../../finedo/easyshopordergoods/query",
        selecttype: "multi",
        expand:easyshopordergoodslist.doExpandRow,
        columns: columnslist
    }).load();
};
/**
 * 格式化操作列展示
 */
easyshopordergoodslist.formatOperation=function(row){
	var operation = '<a href="javascript:easyshopordergoodslist.showModifyDialog(\'' + row.ordergoodsid + '\');">[编辑]</a>&nbsp;';
	operation += '<a href="javascript:finedo.action.doDelete(\'datagrid\',\'${ctx}/finedo/easyshopordergoods/delete\',\'' + row.ordergoodsid + '\')">[删除]</a>&nbsp;';
	return operation;
};
/**
 * 格式化主键展示
 */
easyshopordergoodslist.formatPkey=function(row){
	return '<a href="#" onclick="easyshopordergoodslist.showDetailDialog(\'' + row.ordergoodsid + '\');">' + row.ordergoodsid + '</a>&nbsp;';
};
/**
 * 显示行详情数据
 */
easyshopordergoodslist.doExpandRow=function(data){
	var datahtml="<div class='data'><ul>";
	
	datahtml=datahtml + "<li><span class='data-name'>订单物品关联主键id</span><span class='data-con'>" + finedo.fn.replaceNull(data.ordergoodsid) + "</span></li>";
	datahtml=datahtml + "<li><span class='data-name'>订单编号</span><span class='data-con'>" + finedo.fn.replaceNull(data.ordercode) + "</span></li>";
	datahtml=datahtml + "<li><span class='data-name'>物品id</span><span class='data-con'>" + finedo.fn.replaceNull(data.goodsid) + "</span></li>";
	datahtml=datahtml + "</ul></div>";
	return datahtml;
};
/**
 * 查询按钮触发方法
 */
easyshopordergoodslist.doQuery=function(){
	easyshopordergoodslist.opquerycond();
	
	
	var param = {ordergoodsid: $('#ordergoodsid').val(), ordercode: $('#ordercode').val(), goodsid: $('#goodsid').val()};
	finedo.getgrid("datagrid").query(param);
};
/**
 * 查询取消
 */
easyshopordergoodslist.doQueryCancel=function(){
	easyshopordergoodslist.opquerycond();
};
/**
 * 快捷查询按钮
 */
easyshopordergoodslist.doQueryFast=function(){
	var text=$('#query-box-text').val();
	
	var param = {ordergoodsid:text};
	finedo.getgrid("datagrid").query(param);
};
/**
 * 弹出增加对话框
 */
easyshopordergoodslist.showAddDialog=function(){
	finedo.dialog.show({
		width:850,
		height:550,
		'title':'新增信息',
		'url':'../../finedo/easyshopordergoods/addindex'
	});
};
/**
 * 弹出修改对话框
 */
easyshopordergoodslist.showModifyDialog=function(pkeyid){
	finedo.dialog.show({
		width:850,
		height:550,
		'title':'修改信息',
		'url':'../../finedo/easyshopordergoods/updateindex?ordergoodsid=' + pkeyid
	});
};
/**
 * 弹出详情对话框
 */
easyshopordergoodslist.showDetailDialog=function(pkeyid){
	finedo.dialog.show({
		width:850,
		height:550,
		'title':'修改信息',
		'url':'../../finedo/easyshopordergoods/detailindex?ordergoodsid=' + pkeyid
	});
};
/**
 * 导出方法
 */
easyshopordergoodslist.doExport=function(){
	var param=finedo.getgrid("datagrid").getqueryparams();
	$("#downiframe").attr('src', '../../finedo/easyshopordergoods/exportexcel' + (param ? '?' + $.param(param) : ''));
};
/**
 * 高级查询条件显示与隐藏
 */
easyshopordergoodslist.opquerycond=function(){
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
    '../../resource/js/finedoui/grid/themes/style.css'
    ]);
LazyLoad.js([
    '../../resource/js/jquery/jquery-1.11.0.js',
    '../../resource/js/jquery/jquery.form.js',
    '../../resource/js/finedoui/base/finedo.core.js',
    '../../resource/js/finedoui/commonui/finedo.commonui.js',
    '../../resource/js/finedoui/dialog/finedo.dialog.js',
    '../../resource/js/finedoui/grid/finedo.grid.js'
    ], function() {
    easyshopordergoodslist.initlist();
});
</script>
</body>
</html>

