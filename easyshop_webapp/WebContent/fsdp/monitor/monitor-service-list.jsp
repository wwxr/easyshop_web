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
    	<div class="query-title-name">服务请求监控</div>
         
        <div class="query-boxbig">
        	<input class="query-fast-date" type="text" style="width:160px;" id="begintime" name="begintime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
			-
			<input class="query-fast-date" type="text" style="width:160px;" id="endtime" name="endtime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
        	<input type="button" class="query-btn-nextstep" onclick="monitorservice.doQueryFast();" value="查询">  
        </div>       	
   	</div>
  
    <!-- 表格栏  -->
    <table id="datagrid"></table>
</div>
<script type="text/javascript">
var monitorservice={
    initmonitor:function(){
        finedo.getgrid("datagrid",{
            url:"../../finedo/monitor/queryService",
            servorder:true,
            columns: [
                {code:'servicename', title: '服务名称', width: 300},
                {code:'begintime', title: '开始请求时间', width: 150},
                {code:'endtime', title: '结束请求时间', width: 150},
                {code:'cost', title: '请求时长（毫秒）', width: 100, order:true}
            ]
        }).load();
    },
    doQueryFast:function() {
        var param = {begintime: $('#begintime').val(), endtime: $('#endtime').val()};
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
    monitorservice.initmonitor();
});
</script>
</body>
</html>