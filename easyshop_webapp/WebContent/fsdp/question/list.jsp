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
    	<div class="query-title-name">上报问题管理</div>
         
        <div class="query-boxbig">
       		<input type="button" class="query-btn-nextstep" onclick="questionlist.showAddDialog();" value="上报问题">
        </div>       	
   	</div>
  
    <!-- 表格栏  -->
    <table id="datagrid"></table>
</div>
<script language="javascript">
var questionlist={
    initquestion:function(){
        finedo.getgrid("datagrid",{
            url:"../../finedo/question/query",
            columns: [
                {code:'title', title: '上报问题标题', width: 300,formatter:questionlist.formatName},
                {code:'initiator', title: '问题上报人', width: 100,formatter:questionlist.formatUser},
                {code:'createtime', title: '问题上报时间', width: 150},
                {code:'happentime', title: '问题发生时间', width: 150},
                {code:'status', title: '状态', width: 50,formatter:questionlist.formatStatus},
                {code:'operation', title: '操作', formatter:questionlist.formatOperation}
            ]
        }).load();
    },
    formatOperation:function(row){
        var operation = '<a href="javascript:questionlist.showModifyDialog(\'' + row.questionid + '\');">[编辑]</a>&nbsp;';
        operation += '<a href="javascript:finedo.action.doDelete(\'datagrid\',\'../../finedo/question/delete\',\'' + row.questionid + '\')">[删除]</a>&nbsp;';
        if(row.status=="待处理"){
            operation += '<a href="javascript:questionlist.showDealDialog(\'' + row.questionid + '\');">[处理]</a>&nbsp;';
        }
        return operation;
    },
    formatName:function(row){
        return '<a href="javascript:questionlist.showDetailDialog(\'' + row.questionid + '\');">' + row.title + '</a>&nbsp;';
    },
    formatStatus:function(row){
        if(row.status=="待处理"){
            return '<font color=red>'+row.status+'</font>';
        }
        return '<font color=blue>'+row.status+'</font>';
    },
    formatUser:function(row){
        return row.initiatorname+'['+row.initiator+']';
    },
    showAddDialog:function() {
        finedo.dialog.show({
            width:950,
            height:550,
            'title':'新增信息',
            'url':'../../finedo/question/addpage'
        });
    },
    showDealDialog:function(id) {
        finedo.dialog.show({
            width:950,
            height:550,
            'title':'修改信息',
            'url':'../../finedo/question/dealpage?questionid=' + id
        });
    },
    showModifyDialog:function(id) {
        finedo.dialog.show({
            width:950,
            height:550,
            'title':'修改信息',
            'url':'../../finedo/question/modifypage?questionid=' + id
        });
    },
    showDetailDialog:function(id) {
        finedo.dialog.show({
            width:950,
            height:550,
            'title':'详情信息',
            'url':'../../finedo/question/detail?questionid=' + id
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
    questionlist.initquestion();
});
</script>
</body>
</html>