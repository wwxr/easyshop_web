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
        	<input type="text" style="width:200px" class="query-box-text" id="consultid" name="consultid" value="请输入咨询主键" onkeypress="easyshopconsultchoose.doQueryFast(event);">
            <input type="button" class="query-box-magnifier" onclick="easyshopconsultchoose.doQuery();">
        </div>
    </div>
   
    <!-- 表格栏  -->
    <fsdp:grid className="table" id="datagrid" url="${ctx }/finedo/easyshopconsult/query" selecttype="${param.selecttype }">
		<fsdp:field code="userid" name="用户id" width="100"></fsdp:field>
		<fsdp:field code="businessid" name="商家id" width="100"></fsdp:field>
		<fsdp:field code="detail" name="咨询内容：以json格式存储-{userid:..,time:...,text:...}" width="100"></fsdp:field>
		<fsdp:field code="createtime" name="创建时间" width="100"></fsdp:field>
	</fsdp:grid>
	<table id="datagrid"></table>
</div>
<script type="text/javascript">
var easyshopconsultchoose={};
/**
 * 初始化待选择的数据
 */
easyshopconsultchoose.initchoose=function(){
	$("#consultid").blur(function(){
		if(this.value==""){
			this.value="请输入咨询主键";
		}
	}); 
	
	$("#consultid").focus(function(){
		if(this.value=="请输入咨询主键"){
			this.value="";
		}
	});
	
	var columnslist = [];
	columnslist.push({code:'userid', title: '用户id', width: 100});
	columnslist.push({code:'businessid', title: '商家id', width: 100});
	columnslist.push({code:'detail', title: '咨询内容：以json格式存储-{userid:..,time:...,text:...}', width: 100});
	columnslist.push({code:'createtime', title: '创建时间', width: 100});
	finedo.getgrid("datagrid",{
        url:"../../finedo/easyshopconsult/query",
        selecttype: finedo.fn.getParameter("selecttype"),
        columns: columnslist
    }).load();
};
/**
 * 查询按钮触发方法
 */
easyshopconsultchoose.doQuery=function(){
	var text=$('#consultid').val();
	var param = {consultid:text};
	finedo.getgrid("datagrid").query(param);
};
/**
 * 快速查询方法
 */
easyshopconsultchoose.doQueryFast=function(event) {
	if(event.keyCode != 13)
		return;
	easyshopconsultchoose.doQuery();
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
    easyshopconsultchoose.initchoose();
});
</script>
</body>
</html>
