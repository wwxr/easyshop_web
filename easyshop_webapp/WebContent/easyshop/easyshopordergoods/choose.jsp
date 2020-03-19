<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs2.jsp" %>

<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>
<body class="scrollcss">
<div class="index">
	<!-- 工具栏  -->
	<div class="table-title">
		<!-- 标题 -->
    	<div class="common-name icon-class-query">选择<br/>
			<ul>
            	<li class="link-li">全部</li>
            </ul>
        </div>
        
        <!-- 快捷查询 -->
        <div style="width:220px" class="query-box">
        	<input type="text" style="width:200px" class="query-box-text" id="ordergoodsid" name="ordergoodsid" value="请输入订单物品关联主键id" onkeypress="easyshopordergoodschoose.doQueryFast(event);">
            <input type="button" class="query-box-magnifier" onclick="easyshopordergoodschoose.doQuery();">
        </div>
    </div>
   
    <!-- 表格栏  -->
    <fsdp:grid className="table" id="datagrid" url="${ctx }/finedo/easyshopordergoods/query" selecttype="${param.selecttype }">
		<fsdp:field code="ordercode" name="订单编号" width="100"></fsdp:field>
		<fsdp:field code="goodsid" name="物品id" width="100"></fsdp:field>
	</fsdp:grid>
	<table id="datagrid"></table>
</div>
<script type="text/javascript">
var easyshopordergoodschoose={};
/**
 * 初始化待选择的数据
 */
easyshopordergoodschoose.initchoose=function(){
	$("#ordergoodsid").blur(function(){
		if(this.value==""){
			this.value="请输入订单物品关联主键id";
		}
	}); 
	
	$("#ordergoodsid").focus(function(){
		if(this.value=="请输入订单物品关联主键id"){
			this.value="";
		}
	});
	
	var columnslist = [];
	columnslist.push({code:'ordercode', title: '订单编号', width: 100});
	columnslist.push({code:'goodsid', title: '物品id', width: 100});
	finedo.getgrid("datagrid",{
        url:"../../finedo/easyshopordergoods/query",
        selecttype: finedo.fn.getParameter("selecttype"),
        columns: columnslist
    }).load();
};
/**
 * 查询按钮触发方法
 */
easyshopordergoodschoose.doQuery=function(){
	var text=$('#ordergoodsid').val();
	var param = {ordergoodsid:text};
	finedo.getgrid("datagrid").query(param);
};
/**
 * 快速查询方法
 */
easyshopordergoodschoose.doQueryFast=function(event) {
	if(event.keyCode != 13)
		return;
	easyshopordergoodschoose.doQuery();
};
</script>
<script type='text/javascript' src='../../resource/js/lazyload.js'></script>
<script language="javascript">
LazyLoad.css([
    '../../resource/themes/default/style.css',
    '../../resource/js/finedoui/dialog/themes/style.css',
    '../../resource/js/finedoui/grid/themes/style.css',
    '../../resource/js/finedoui/upload/themes/style.css'
    ]);
LazyLoad.js([
    '../../resource/js/jquery/jquery-1.11.0.js',
    '../../resource/js/jquery/jquery.form.js',
    '../../resource/js/finedoui/base/finedo.core.js',
    '../../resource/js/finedoui/dialog/finedo.dialog.js',
    '../../resource/js/finedoui/grid/finedo.grid.js'], function() {
    easyshopordergoodschoose.initchoose();
});
</script>
</body>
</html>
