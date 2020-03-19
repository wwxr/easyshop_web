<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs2.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>异常日志查询</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>
<body class="query-body">
<div style="width:100%;">
	<!-- 工具栏  -->
	<div class="query-title">
		<!-- 标题 -->
    	<div class="query-title-name">系统日志查询</div>
         
        <div class="query-boxbig">
        	<input class="query-fast-date" type="text" style="width:160px;" id="opttimebegin" name="opttimebegin" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
			-
			<input class="query-fast-date" type="text" style="width:160px;" id="opttimeend" name="opttimeend" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
        	<input type="button" class="query-btn-nextstep" onclick="initlog.doSearch();" value="查询">  
        </div>       	
   	</div>
  
    <!-- 表格栏  -->
    <table id="datagrid"></table>
</div>
<script language="javascript">
var systemlog={
    initlog:function(){
        finedo.getgrid("datagrid",{
            url:"../../finedo/log/querySystemLog",
            columns: [
                {code:'optsn', title: '业务流水号', width: 110},
                {code:'exceptiontype', title: '异常类型', width: 80},
                {code:'exceptioncontent', title: '异常内容', width: 250},
                {code:'logtime', title: '异常发生时间', width: 100},
                {code:'opttime', title: '操作时间', width: 100}
            ]
        }).load();
    },
    doSearch:function(){  
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
    systemlog.initlog();
});
</script>
</body>
</html>