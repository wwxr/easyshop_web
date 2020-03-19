<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs2.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>
<body>
<div style="width:200px;" id="treediv">
<ul id="treeid" class="fdtree"></ul>
</div>
<input type="hidden" id="orgid" name="orgid"/>
<div style="margin-left:200px;" id="tablediv">
	<table id="datagrid"></table>
</div>
<script language="javascript">
var userchoose={
    inituser:function(){
        
        var selecttype = finedo.fn.getParameter("selecttype");
        var roletype = "组织岗位角色";
        if(selecttype == "multi"){
            roletype = "标准岗位角色";
            $("#treediv").width("0px");
            $("#tablediv").css("margin-left", "0px");
        }else{
            finedo.getTree('treeid',{
                url:'../../finedo/organization/queryorgtree',
                data:{"id":"0"},
                async:true,
                onclick:userchoose.clickTree
            });
        }
        finedo.getgrid('datagrid',{
            queryparams:{'roletype':roletype},
            url:"../../finedo/role/queryRole",
            selecttype: selecttype,
            columns: [
                {code:'rolename', title: '角色名称', width: 80},
                {code:'orgname', title: '组织节点', width: 80},
                {code:'roletype', title: '类型', width: 50},
                {code:'rolelvl', title: '级别', width: 50},
                {code:'usercount', title: '限定人数', width: 50},
                {code:'state', title: '状态', width: 50}
            ]
        }).load();
    },
    doSearch:function(){  
        var param = {roletype: $('#roletype').val(), rolename: $('#rolename').val(), 
                orgid: $('#orgid').val()};
        finedo.getgrid("datagrid").query(param);
    },
    clickTree:function(node){
        if (node){
            var s = node.id;
            $("#orgid").val(s);
            userchoose.doSearch();
        }
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
    userchoose.inituser();
});
</script>
</body>
</html>