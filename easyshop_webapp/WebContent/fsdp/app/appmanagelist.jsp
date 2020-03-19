<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs2.jsp"%>

<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>

<body class="query-body">
	<div style="width: 100%;">
		<!-- 工具栏  -->
		<div class="query-title">
			<!-- 标题 -->
			<div class="query-title-name">应用列表</div>
		</div>
		<div style="float: left; width: 100%; padding-bottom: 10px; display: inline-block; text-indent: 10px;">
			应用名称：<input class="query-text" id="appname" type="text" value="">&nbsp;
			<input type="button" class="query-btn" onclick="appmanage.queryApp();" value="查  询">&nbsp;
			<input type="button" class="query-btn" onclick="appmanage.addApp();" value="新  增">
		</div>
		<!-- 表格栏  -->
		<table id="datagrid"></table>
	</div>
<script type="text/javascript">
var appmanage={
    initapp:function(){
        finedo.getgrid("datagrid",{
            url:"../../finedo/app/query",
            columns: [
                {code:'appid', title: '应用标识', width: 150, formatter:appmanage.formatAppid},
                {code:'appname', title: '应用名称', width: 200},
                {code:'appdesc', title: '应用描述', width: 200},
                {code:'operation', title: '操作', formatter:appmanage.formatOperation}
            ]
        }).load();
    },
    formatAppid:function(row){
        var operation = '<a href="javascript:appmanage.showModifyDialog(\'' + row.appid+ '\');">' + row.appid+ '</a>';
        return operation;
    },
    formatOperation:function(row) {
        var operation = '<a href="javascript:appmanage.publish(\'' + row.appid + '\');">[发布]</a>&nbsp;';
        operation += '<a href="javascript:appmanage.addGrayObject(\'' + row.appid + '\');">[灰度目标]</a>&nbsp;';
        operation += '<a href="javascript:finedo.action.doDelete(\'datagrid\',\'../../finedo/app/delete\',\'' + row.appid + '\')">[删除]</a>&nbsp;';
        return operation;
    },
    showModifyDialog:function(appid) {
        finedo.dialog.showDialog({
            width:950,
            height:550,
            'title':'应用发布',
            'url':'../../finedo/app/appdetailpage?appid='+appid
        });
    },
    publish:function(appid) {
        finedo.dialog.showDialog({
            width:950,
            height:550,
            'title':'应用发布',
            'url':'../../finedo/app/apppublishpage?appid='+appid
        });
    },
    addGrayObject:function(appid) {
        finedo.dialog.showDialog({
            width:950,
            height:550,
            'title':'应用发布',
            'url':'../../finedo/app/addgraypage?appid='+appid
        });
    },
    queryApp:function() {
        var appname = $('#appname').val();
        var queryparams = {
            "appname" : appname
        };
        finedo.getgrid('datagrid').query(queryparams);
    },
    addApp:function(){
        finedo.dialog.showDialog({
            width:700,
            height:400,
            'title':'应用发布',
            'url':'../../finedo/app/appadd'
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
    appmanage.initapp();
});
</script>
</body>
</html>


