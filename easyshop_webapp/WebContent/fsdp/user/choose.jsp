<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs2.jsp" %>

<!--  HTML5 标记 -->
<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>
<body class="scrollcss">
<div class="index">
	<!-- 工具栏  -->
	<div class="table-title">
		<!-- 标题 -->
    	<div class="common-name icon-class-query">选择用户<br/>
			<ul>
            	<li class="link-li">全部</li>
            </ul>
        </div>
        
        <!-- 快捷查询 -->
        <div style="width:220px" class="query-box">
        	<input type="text" style="width:200px" class="query-box-text" id="personname" name="personname" value="请输入姓名" onkeypress="chooseuser.doQueryFast(event);">
            <input type="button" class="query-box-magnifier" onclick="chooseuser.doQuery();">
        </div>
    </div>
    <!-- 表格栏  -->
    <table id="datagrid"></table>
</div>
<script type="text/javascript">
var chooseuser={
    initchooseuser:function(){
        $("#personname").blur(function(){
            if(this.value==""){
                this.value="请输入姓名";
            }
        }); 
        
        $("#personname").focus(function(){
            if(this.value=="请输入姓名"){
                this.value="";
            }
        }); 
        finedo.getgrid("datagrid",{
            url:"../../finedo/user/queryUser",
            selecttype: finedo.fn.getParameter("selecttype"),
            columns: [
                {code:'user.usercode', title: '用户编号', width: 100},
                {code:'user.personname', title: '姓名', width: 80},
                {code:'stdrole.orgname', title: '所属机构', width: 150},
                {code:'stdrole.rolename', title: '基本角色', width: 120},
                {code:'user.phoneno', title: '联系方式', width: 120},
                {code:'user.email', title: '邮箱', width: 200},
                {code:'user.state', title: '用户状态', width: 80}
            ]
        }).load();
    },
    doQuery:function(){
        var text=$('#personname').val();
        var param = {personname:text};
        finedo.action.doSearch('datagrid', param);
    },
    doQueryFast:function(){
        if(event.keyCode != 13)
            return;
        chooseuser.doQuery();
    }
};
</script>
<script type='text/javascript' src='../../resource/js/lazyload.js'></script>
<script language="javascript">
LazyLoad.css([
    '../../resource/themes/default/style.css',
    '../../resource/js/finedoui/dialog/themes/style.css',
    '../../resource/js/finedoui/grid/themes/style.css',
    '../../resource/js/finedoui/upload/themes/style.css'
    ]);
LazyLoad.js([
    '../../resource/js/jquery/jquery-1.11.0.js',
    '../../resource/js/jquery/jquery.form.js',
    '../../resource/js/finedoui/base/finedo.core.js',
    '../../resource/js/finedoui/dialog/finedo.dialog.js',
    '../../resource/js/finedoui/grid/finedo.grid.js'], function() {
    chooseuser.initchooseuser();
});
</script>
</body>
</html>
