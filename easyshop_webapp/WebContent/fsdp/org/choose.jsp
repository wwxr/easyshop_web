<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs2.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>组织机构选择</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>
<body>
<ul id="treeid" class="fdtree"></ul>
<script language="javascript">
var chooseorg={
    initorg:function(){
        finedo.getTree('treeid',{
            url:'../../finedo/organization/queryorgtree',
            data:{"id":"0"},
            async:true,
            selecttype:finedo.fn.getParameter("selecttype")
        });
    }
}
</script>
<script type='text/javascript' src='../../resource/js/lazyload.js'></script>
<script language="javascript">
LazyLoad.css([
    '../../resource/themes/default/style.css',
    '../../resource/js/finedoui/dialog/themes/style.css',
    '../../resource/js/finedoui/tree/themes/style.css'
    ]);
LazyLoad.js([
    '../../resource/js/jquery/jquery-1.11.0.js',
    '../../resource/js/jquery/jquery.form.js',
    '../../resource/js/finedoui/base/finedo.core.js',
    '../../resource/js/finedoui/dialog/finedo.dialog.js',
    '../../resource/js/finedoui/tree/finedo.tree.js'
    ], function() {
    chooseorg.initorg();
});
</script>
</body>
</html>