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
	<div class="query-title">
		<!-- 标题 -->
    	<div class="query-title-name">密码规则管理</div>
   	</div>
  
	<!-- 表格栏  -->
    <table id="datagrid"></table>
</div>
<script language="javascript">
var securitylist={
    initsec:function(){
        finedo.getgrid("datagrid",{
            url:"../../finedo/securityconf/querySecurityconf",
            selecttype: "none",
            columns: [
                {code:'passwdtype', title: '密码类型', width: 80,formatter:securitylist.formatPasswdtype},
                {code:'validday', title: '有效天数', width: 60},
                {code:'minlength', title: '密码最小长度', width: 90},
                {code:'maxlength', title: '密码最大长度', width: 90},
                {code:'specialnum', title: '特殊字符最小数量', width: 100},
                {code:'capitalnum', title: '大写字母最小数量', width: 100},
                {code:'lowercasenum', title: '小写字母最小数量', width: 100},
                {code:'digitalnum', title: '数字最小数量', width: 100},
                {code:'operation', title: '操作', formatter:securitylist.formatOperation}
            ]
        }).load();
    },
    formatOperation:function(row){
        var operation = '<a href="javascript:securitylist.showDialog(\'' + row.passwdtype + '\');">[修改]</a>&nbsp;';
        return operation;
    },
    formatPasswdtype:function(row){
        var operation = '<a href="javascript:securitylist.showDialog(\'' + row.passwdtype + '\');">' + row.passwdtype + '</a>&nbsp;';
        return operation;
    },
    showDialog:function(passwdtype) {
        finedo.dialog.show({
            width:950,
            height:550,
            'title':'静态数据信息',
            'url':'../../finedo/securityconf/editindex?passwdtype=' + passwdtype
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
    securitylist.initsec();
});
</script>
</body>
</html>