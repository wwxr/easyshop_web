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
    	<div class="query-title-name">定时器执行日志</div>
   	</div>
  
    <!-- 表格栏  -->
    <table id="datagrid"></table>
</div>
<script language="javascript">
var timerlog={
    initlog:function(){
        finedo.getgrid("datagrid",{
            url:"../../finedo/timer/querylog?id="+finedo.fn.getParameter("id"),
            columns: [
                {code:'exectime', title: '执行时间', width: 200},
                {code:'state', title: '执行结果状态', width: 150},
                {code:'retmsg', title: '执行结果描述', width: 300}
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
    timerlog.initlog();
});
</script>
</body>
</html>