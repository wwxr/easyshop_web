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
        	<input type="text" style="width:200px" class="query-box-text" id="userid" name="userid" value="请输入主键id" onkeypress="easyshopuserchoose.doQueryFast(event);">
            <input type="button" class="query-box-magnifier" onclick="easyshopuserchoose.doQuery();">
        </div>
    </div>
   
    <!-- 表格栏  -->
    <fsdp:grid className="table" id="datagrid" url="${ctx }/finedo/easyshopuser/query" selecttype="${param.selecttype }">
		<fsdp:field code="points" name="积分" width="100"></fsdp:field>
		<fsdp:field code="openid" name="openid" width="100"></fsdp:field>
		<fsdp:field code="unionid" name="unionid" width="100"></fsdp:field>
		<fsdp:field code="phone" name="手机号" width="100"></fsdp:field>
		<fsdp:field code="promoter" name="推广人编码对应二维码" width="100"></fsdp:field>
		<fsdp:field code="username" name="用户姓名" width="100"></fsdp:field>
		<fsdp:field code="nickname" name="昵称" width="100"></fsdp:field>
		<fsdp:field code="avatar" name="头像" width="100"></fsdp:field>
		<fsdp:field code="promocode" name="自己的推广码" width="100"></fsdp:field>
		<fsdp:field code="registtime" name="注册时间" width="100"></fsdp:field>
		<fsdp:field code="gender" name="性别：1-男；0-女" width="100"></fsdp:field>
	</fsdp:grid>
	<table id="datagrid"></table>
</div>
<script type="text/javascript">
var easyshopuserchoose={};
/**
 * 初始化待选择的数据
 */
easyshopuserchoose.initchoose=function(){
	$("#userid").blur(function(){
		if(this.value==""){
			this.value="请输入主键id";
		}
	}); 
	
	$("#userid").focus(function(){
		if(this.value=="请输入主键id"){
			this.value="";
		}
	});
	
	var columnslist = [];
	columnslist.push({code:'points', title: '积分', width: 100});
	columnslist.push({code:'openid', title: 'openid', width: 100});
	columnslist.push({code:'unionid', title: 'unionid', width: 100});
	columnslist.push({code:'phone', title: '手机号', width: 100});
	columnslist.push({code:'promoter', title: '推广人编码对应二维码', width: 100});
	columnslist.push({code:'username', title: '用户姓名', width: 100});
	columnslist.push({code:'nickname', title: '昵称', width: 100});
	columnslist.push({code:'avatar', title: '头像', width: 100});
	columnslist.push({code:'promocode', title: '自己的推广码', width: 100});
	columnslist.push({code:'registtime', title: '注册时间', width: 100});
	columnslist.push({code:'gender', title: '性别：1-男；0-女', width: 100});
	finedo.getgrid("datagrid",{
        url:"../../finedo/easyshopuser/query",
        selecttype: finedo.fn.getParameter("selecttype"),
        columns: columnslist
    }).load();
};
/**
 * 查询按钮触发方法
 */
easyshopuserchoose.doQuery=function(){
	var text=$('#userid').val();
	var param = {userid:text};
	finedo.getgrid("datagrid").query(param);
};
/**
 * 快速查询方法
 */
easyshopuserchoose.doQueryFast=function(event) {
	if(event.keyCode != 13)
		return;
	easyshopuserchoose.doQuery();
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
    easyshopuserchoose.initchoose();
});
</script>
</body>
</html>
