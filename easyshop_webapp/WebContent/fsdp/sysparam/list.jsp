<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs2.jsp" %>

<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>

<body class="query-body">

<div>
	<!-- 工具栏  -->
	<div class="query-title">
		<!-- 标题 -->
    	<div class="query-title-name">系统参数管理 </div>
    	
    	<div class="query-boxbig">
    		<input type="button" class="query-btn-nextstep" onclick="sysparamlist.showAddDialog();" value="新建系统参数">
    		
    		<div class="query-box">
	        	<input type="text" class="query-box-text" id="paramname" value="">
	            <input type="button" class="query-box-magnifier" onclick="sysparamlist.doQueryFast();">
	        </div>
            <input type="button" class="query-btn-nextstep" onclick="sysparamlist.doQueryFast();" value="查询">  
    	</div>
   </div>
       
    <!-- 表格栏  -->
    <table id="datagrid"></table>
</div>
<script type="text/javascript">
var sysparamlist={
    initsysparam:function(){
        finedo.getgrid("datagrid",{
            url:"../../finedo/sysparam/querysysparam",
            columns: [
                {code:'configtypename', title: '参数类型', width: 100},
                {code:'paramname', title: '参数名称', width: 100,formatter:sysparamlist.formatParamname},
                {code:'paramvalue', title: '参数值', width: 500},
                {code:'datatype', title: '数据类型', width: 80},
                {code:'operation', title: '操作', formatter:sysparamlist.formatOperation}
            ]
        }).load();
    },
    formatOperation:function(row){
        var operation = '<a href="javascript:sysparamlist.showDetailDialog(\'' + row.paramid + '\');">[编辑]</a>&nbsp;';
        operation += '<a href="javascript:finedo.action.doDelete(\'datagrid\',\'../../finedo/sysparam/deleteSysParam\',\'' + row.paramid + '\')">[删除]</a>&nbsp;';
        return operation;
    },
    formatParamname:function(row){
        var operation = '<a href="javascript:sysparamlist.showDetailDialog(\'' + row.paramid + '\');">'+row.paramname+'</a>&nbsp;';
        return operation;
    },
    doQueryFast:function() {
        var param = {paramname: $('#paramname').val()};
        finedo.getgrid("datagrid").query(param);
    },
    showAddDialog:function() {
        finedo.dialog.show({
            width:600,
            height:400,
            'title':'系统参数信息',
            'url':'../../finedo/sysparam/addpage'
        });
    },
    showDetailDialog:function(paramid) {
        finedo.dialog.show({
            width:600,
            height:400,
            'title':'系统参数信息',
            'url':'../../finedo/sysparam/modifyindex?paramid=' + paramid
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
    sysparamlist.initsysparam();
});
</script>
</body>
</html>