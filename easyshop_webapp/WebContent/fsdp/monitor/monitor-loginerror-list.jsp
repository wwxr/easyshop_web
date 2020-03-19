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
    	<div class="query-title-name">异常登录监控信息</div>
        
        <div class="query-boxbig">
        	<input type="button" class="query-btn-nextstep" onclick="monitorerror.doClear();" value="清除全部异常登录锁定账号">
        </div>      	
   	</div>
  	
    <!-- 表格栏  -->
    <table id="datagrid"></table>
</div>
<script language="javascript">
var monitorerror={
    initmonitor:function(){
        finedo.getgrid("datagrid",{
            url:"../../finedo/auth/loginerrornum",
            pagination:false,
            columns: [
                {code:'ipaddr', title: '服务名称', width: 200},
                {code:'errornum', title: '登录失败次数', width: 100}
            ]
        }).load();
    },
    doClear:function(){
        finedo.action.doCommand('../../finedo/auth/clearLoginerrornum', monitorerror.doSearch, true);
    },
    doSearch:function() {
        finedo.getgrid("datagrid").query("");
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
    monitorerror.initmonitor();
});
</script>
</body>
</html>