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
    	<div class="query-title-name">SQL结果预览 </div>
   </div>
       
    <!-- 表格栏  -->
    <table id="datagrid"></table>
</div>
<script type="text/javascript">
var staticsql={
    initstaticdata:function(){
        var sql = $.trim($("#sqlscript", parent.document).val());
        if(finedo.fn.isnon(sql)){
            finedo.message.warning("请输入要预览的SQL");
            return;
        }
        finedo.getgrid("datagrid",{
            url:"../../finedo/staticdata/querybysql",
            queryparams:{sqlscript:sql},
            pagination:false,
            rownumbers:false,
            columns: [
                {code:'attrname', title: '属性名', width: "48%"},
                {code:'attrvalue', title: '属性值', width: "48%"}
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
    staticsql.initstaticdata();
});
</script>
</body>
</html>