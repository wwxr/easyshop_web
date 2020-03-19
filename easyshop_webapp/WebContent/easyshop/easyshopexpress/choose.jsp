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
        	<input type="text" style="width:200px" class="query-box-text" id="shippercode" name="shippercode" value="请输入物流编号" onkeypress="easyshopexpresschoose.doQueryFast(event);">
            <input type="button" class="query-box-magnifier" onclick="easyshopexpresschoose.doQuery();">
        </div>
    </div>
   
    <!-- 表格栏  -->
    <fsdp:grid className="table" id="datagrid" url="${ctx }/finedo/easyshopexpress/query" selecttype="${param.selecttype }">
		<fsdp:field code="shippername" name="物流名称" width="100"></fsdp:field>
	</fsdp:grid>
	<table id="datagrid"></table>
</div>
<script type="text/javascript">
var easyshopexpresschoose={};
/**
 * 初始化待选择的数据
 */
easyshopexpresschoose.initchoose=function(){
	$("#shippercode").blur(function(){
		if(this.value==""){
			this.value="请输入物流编号";
		}
	}); 
	
	$("#shippercode").focus(function(){
		if(this.value=="请输入物流编号"){
			this.value="";
		}
	});
	
	var columnslist = [];
	columnslist.push({code:'shippername', title: '物流名称', width: 100});
	finedo.getgrid("datagrid",{
        url:"../../finedo/easyshopexpress/query",
        selecttype: finedo.fn.getParameter("selecttype"),
        columns: columnslist
    }).load();
};
/**
 * 查询按钮触发方法
 */
easyshopexpresschoose.doQuery=function(){
	var text=$('#shippercode').val();
	var param = {shippercode:text};
	finedo.getgrid("datagrid").query(param);
};
/**
 * 快速查询方法
 */
easyshopexpresschoose.doQueryFast=function(event) {
	if(event.keyCode != 13)
		return;
	easyshopexpresschoose.doQuery();
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
    easyshopexpresschoose.initchoose();
});
</script>
</body>
</html>
