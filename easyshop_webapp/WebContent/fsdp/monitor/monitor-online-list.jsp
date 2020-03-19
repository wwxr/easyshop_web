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
    	<div class="query-title-name">在线用户监控</div> 	
   	</div>
  	
    <!-- 表格栏  -->
    <table id="datagrid"></table>
</div>
<script language="javascript">
var monitoruser={
    initmonitor:function(){
        finedo.getgrid("datagrid",{
            url:"../../finedo/monitor/queryOnline",
            servorder:true,
            columns: [
                {code:'usercode', title: '用户账号', width: 100},
                {code:'username', title: '用户名称', width: 150},
                {code:'logintime', title: '登录时间', width: 150, order:true},
                {code:'token', title: 'TOKEN', width: 300}
            ]
        }).load();
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
    monitoruser.initmonitor();
});
</script>
</body>
</html>