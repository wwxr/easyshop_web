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
    	<div class="query-title-name">定时器管理</div>
         
        <div class="query-boxbig">
       		<input type="button" class="query-btn-nextstep" onclick="timerlist.showAddDialog();" value="新建定时器">
        </div>       	
   	</div>
  
    <!-- 表格栏  -->
    <table id="datagrid"></table>
</div>
<script language="javascript">
var timerlist={
    inittimer:function(){
        finedo.getgrid("datagrid",{
            url:"../../finedo/timer/query",
            columns: [
                {code:'name', title: '定时任务名称', width: 200,formatter:timerlist.formatName},
                {code:'beanname', title: 'Bean类名', width: 150},
                {code:'method', title: 'Bean类方法名', width: 150},
                {code:'cron', title: 'CRON', width: 200},
                {code:'optdate', title: '创建时间', width: 150},
                {code:'operation', title: '操作', formatter:timerlist.formatOperation}
            ]
        }).load();
    },
    formatOperation:function(row){
        var operation = '<a href="javascript:timerlist.showModifyDialog(\'' + row.id + '\');">[编辑]</a>&nbsp;';
        operation += '<a href="javascript:finedo.action.doDelete(\'datagrid\',\'../../finedo/timer/delete\',\'' + row.id + '\')">[删除]</a>&nbsp;';
        operation += '<a href="javascript:timerlist.showLogDialog(\'' + row.id + '\');">[查看执行日志]</a>&nbsp;';
        return operation;
    },
    formatName:function(row){
        return '<a href="javascript:timerlist.showDetailDialog(\'' + row.id + '\');">' + row.name + '</a>&nbsp;';
    },
    showAddDialog:function() {
        finedo.dialog.show({
            width:950,
            height:550,
            'title':'新增信息',
            'url':'../../finedo/timer/addpage'
        });
    },
    showModifyDialog:function(id) {
        finedo.dialog.show({
            width:950,
            height:550,
            'title':'修改信息',
            'url':'../../finedo/timer/modifypage?id=' + id
        });
    },
    showDetailDialog:function(id) {
        finedo.dialog.show({
            width:950,
            height:550,
            'title':'详情信息',
            'url':'../../finedo/timer/detail?id=' + id
        });
    },
    showLogDialog:function(id) {
        finedo.dialog.show({
            width:950,
            height:550,
            'title':'详情信息',
            'url':'../../finedo/timer/timelogpage?id=' + id
        });
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
    timerlist.inittimer();
});
</script>
</body>
</html>