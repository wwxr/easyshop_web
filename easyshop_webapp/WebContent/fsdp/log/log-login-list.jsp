<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs2.jsp" %>

<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>

<body class="query-body">
<div style="width:100%;">
	<!-- 工具栏  -->
	<div class="query-title">
		<!-- 标题 -->
    	<div class="query-title-name">登录日志查询</div>
         
        <div class="query-boxbig">
        	<input class="query-fast-date" type="text" style="width:160px;" id="logindatebegin" name="logindatebegin" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
			-
			<input class="query-fast-date" type="text" style="width:160px;" id="logindateend" name="logindateend" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
        	<input type="button" class="query-btn-nextstep" onclick="loginlog.doQueryFast();" value="查询">  
        </div>       	
   	</div>
  
    <!-- 表格栏  -->
    <table id="datagrid"></table>
</div>
<script type="text/javascript">
var loginlog={
    initlog:function(){
        finedo.getgrid("datagrid",{
            url:"../../finedo/log/queryLoginLog",
            columns: [
                {code:'userid', title: '用户ID', width: 60},
                {code:'username', title: '用户名称', width: 80},
                {code:'state', title: '状态', width: 60},
                {code:'ipaddr', title: 'IP地址', width: 120},
                {code:'logindate', title: '登录时间', width: 100},
                {code:'logoutdate', title: '退出时间', width: 100},
                {code:'token', title: 'TOKEN', width: 100}
            ]
        }).load();
    },
    doQueryFast:function(){  
        var param = {logindatebegin: $("#logindatebegin").val(),logindateend: $("#logindateend").val()};
        finedo.getgrid("datagrid").query(param);
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
    '../../resource/js/finedoui/grid/finedo.grid.js',
    '../../resource/js/finedoui/date/WdatePicker.js'
    ], function() {
    loginlog.initlog();
});
</script>
</body>
</html>