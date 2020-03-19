<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs2.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>
<body>
<div style=" width: 18%; float: left; border:1px solid #ddd; position: fixed; top:20px; left:10px; bottom:10px; overflow-y:auto; overflow-x:auto;">
	<div class="tree-name">组织结构</div>

	<ul id="treediv" class="fdtree" style=" margin-left:5px;" ></ul>
</div>
<div style=" width: 78%; float: right; margin-top:20px;  margin-right:2%;">
	<div class="query-title">
		<!-- 标题 -->
    	<div class="query-title-name">岗位角色管理 </div>
    	
    	<div class="query-boxbig">
	    	<input type="button" class="query-btn-nextstep" onclick="rolelist.showAddDialog();" value="新建岗位角色">
       	 	
    		<div class="query-fast">
	        	<input type="text" class="query-fast-text" id="query-box-text" value="">
	            <input type="button" class="query-fast-magnifier" onclick="rolelist.doQueryFast();">
	        </div>
    	</div>
   	</div>
    <table id="datagrid"></table>
</div>
<script language="javascript">
var rolelist={
    initrole:function(){
        finedo.getTree('treediv',{
            url:'../../finedo/organization/queryorgtree',
            async:true,
            selecttype:'single',
            onclick:function(data){
                var param = {orgnode:data.id};
                finedo.getgrid("datagrid").query(param);
            }
        });
        
        finedo.getgrid("datagrid",{
            url:"../../finedo/role/queryRole",
            selecttype: "none",
            columns: [
                {code:'rolename', title: '角色名称', width: 200},
                {code:'orgname', title: '组织节点', width: 200},
                {code:'roletype', title: '类型', width: 100},
                {code:'rolelvl', title: '级别', width: 80},
                {code:'usercount', title: '限定人数', width: 80},
                {code:'state', title: '状态', width: 100},
                {code:'operation', title: '操作', formatter:rolelist.formatOperation}
            ]
        }).load();
    },
    formatOperation:function(row){
        var operation = '<a href="javascript:rolelist.showModifyDialog(\'' + row.roleid + '\');">[编辑]</a>&nbsp;';
        operation += '<a href="javascript:finedo.action.doDelete(\'datagrid\',\'../../finedo/role/deleteRole\',\'' + row.roleid + '\')">[删除]</a>&nbsp;';
        return operation;
    },
    showAddDialog:function() {
        finedo.dialog.show({
            width:950,
            height:550,
            'title':'新增信息',
            'url':'../../finedo/role/addpage'
        });
    },
    showModifyDialog:function(roleid) {
        finedo.dialog.show({
            width:950,
            height:550,
            'title':'修改信息',
            'url':'../../finedo/role/modifypage?roleid=' + roleid
        });
    },
    doQueryFast:function() {
        var text=$('#query-box-text').val();
        var param = {rolename:text};
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
    '../../resource/js/finedoui/grid/themes/style.css',
    '../../resource/js/finedoui/tree/themes/style.css'
    ]);
LazyLoad.js([
    '../../resource/js/jquery/jquery-1.11.0.js',
    '../../resource/js/jquery/jquery.form.js',
    '../../resource/js/finedoui/base/finedo.core.js',
    '../../resource/js/finedoui/commonui/finedo.commonui.js',
    '../../resource/js/finedoui/dialog/finedo.dialog.js',
    '../../resource/js/finedoui/grid/finedo.grid.js',
    '../../resource/js/finedoui/tree/finedo.tree.js'
    ], function() {
    rolelist.initrole();
});
</script>
</body>
</html>
