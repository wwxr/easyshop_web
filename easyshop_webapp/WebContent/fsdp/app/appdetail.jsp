<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs2.jsp"%>

<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>

<body>
<div>
    <div class="add-common-head">
        <div class="add-common-name-add">应用修改<br/></div>
    </div>
    <div id="common_add_div" >
        <div class="finedo-nav-title">基本信息</div>
        <ul class="finedo-ul">
        <form method="post" id="ajaxForm" name="ajaxForm">
            <input type="hidden" id="appid" name="appid">
            <li>
                <span class="finedo-label-title" style="width:20%;"><font color=red>*</font>应用名称：</span>
                <input class="finedo-text" type="text" id="appname" name="appname" value="" style="width:80%;">
            </li>

            <li>
                <span class="finedo-label-title" style="width:20%;">应用描述：</span>
                <textarea class="finedo-textarea" id="appdesc" name="appdesc" style="width:80%;"></textarea>
            </li>
            <li class="add-center">
                <input type="button" class="finedo-button" value="修    改" onClick="appdetail.doSubmit()" >
            </li>
        </form>
        </ul>
        <div class="finedo-nav-title">应用版本信息</div>
        <!-- 表格栏  -->
        <table id="datagrid"></table>
    </div>
</div>
<script language="javascript">
var appdetail={};
appdetail.initapp=function(){
    var appid = finedo.fn.getParameter("appid");
    $("#appid").val(appid);
    
    finedo.action.ajax({
        url:"../../finedo/app/querybyid",
        data:{appid:appid},
        iswait:false,
        callback:function(queryret){
            if(queryret.fail){
                finedo.message.error(queryret.resultdesc);
                return;
            }
            var appobj = queryret.object;
            $("#appname").val(appobj.appname);
            $("#appdesc").val(appobj.appdesc);
        }
    });
    
    finedo.getgrid("datagrid",{
        url:"../../finedo/app/queryappversion?appid="+appid,
        rownumbers:false,
        columns: [
            {code:'version', title: '版本号', width: 60},
            {code:'fileid', title: '升级包', width: 80, formatter:appdetail.formatFileid},
            {code:'publishtime', title: '发布时间', width: 100},
            {code:'demand', title: '升级要求', width: 80},
            {code:'versiontype', title: '版本类型', width: 80},
            {code:'uptype', title: '升级类型', width: 80},
            {code:'platform', title: '平台', width: 80},
            {code:'content', title: '更新描述', width: 200}
        ]
    }).load();
};
appdetail.formatFileid=function(row){
    var operation = '<a href="../../finedo/file/download?fileid='+row.fileid+'" target=_black>' + row.fileid+ '</a>';
    return operation;
};
appdetail.doSubmit=function(){
    var appname = $.trim($('#appname').val());
    if(finedo.fn.isnon(appname)){
        finedo.message.warning("应用名称不能为空", '提示');
        return;
    }
    finedo.action.ajaxForm({
        form:"ajaxForm",
        url:"../../finedo/app/update",
        callback:function(jsondata){
            if(jsondata.fail){
                finedo.message.error(jsondata.resultdesc);
                return;
            }
            finedo.message.info(jsondata.resultdesc);
        },
        clearForm:false
    });
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
    appdetail.initapp();
});
</script>
</body>
</html>


