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
    	<div class="query-title-name">静态数据管理 </div>
    	
    	<div class="query-boxbig">
    		<input type="button" class="query-btn-nextstep" onclick="staticdatalist.showAddDialog();" value="新建静态数据">
    		
    		<div class="query-box">
	        	<input type="text" class="query-box-text" id="typename" value="">
	            <input type="button" class="query-box-magnifier" onclick="staticdatalist.doQueryFast();">
	        </div>
            <input type="button" class="query-btn-nextstep" onclick="staticdatalist.doQueryFast();" value="查询">  
    	</div>
        
   </div>
       
    <!-- 表格栏  -->
    <table id="datagrid"></table>
</div>
<script type="text/javascript">
var staticdatalist={
    initstaticdata:function(){
        finedo.getgrid("datagrid",{
            url:"../../finedo/staticdata/queryStaticdata",
            columns: [
                {code:'typename', title: '类型名称', width: 150,formatter:staticdatalist.formatTypename},
                {code:'datatype', title: '数据类型', width: 100},
                {code:'configtype', title: '配置类型', width: 100},
                {code:'lvl', title: '级别', width: 150},
                {code:'remark', title: '数据项', width: 150},
                {code:'operation', title: '操作', formatter:staticdatalist.formatOperation}
            ]
        }).load();
    },
    formatOperation:function(row){
        var operation = '<a href="javascript:staticdatalist.showDetailDialog(\'' + row.typeid + '\');">[编辑]</a>&nbsp;';
        operation += '<a href="javascript:finedo.action.doDelete(\'datagrid\',\'../../finedo/staticdata/deleteStaticdata\',\''+row.typeid+'\')">[删除]</a>&nbsp;';
        return operation;
    },
    formatTypename:function(row){
        var operation = '<a href="javascript:staticdatalist.showDetailDialog(\'' + row.typeid + '\');">' + row.typename + '</a>&nbsp;';
        return operation;
    },
    doQueryFast:function() {
        var param = {typename: $('#typename').val()};
        finedo.getgrid("datagrid").query(param);
    },
    showAddDialog:function() {
        finedo.dialog.show({
            width:950,
            height:550,
            'title':'静态数据信息',
            'url':'../../finedo/staticdata/addpage'
        });
    },
    showDetailDialog:function(typeid) {
        finedo.dialog.show({
            width:850,
            height:550,
            'title':'静态数据信息',
            'url':'../../finedo/staticdata/modifyindex?typeid=' + typeid
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
    staticdatalist.initstaticdata();
});
</script>
</body>
</html>