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
        <div class="add-common-name-add">应用新增<br/></div>
        <input type="button" class="finedo-button-blue" style="float:right" value="提交" onclick="appadd.add();">
    </div>
    <div id="common_add_div" >
        <div class="finedo-nav-title">基本信息</div>
        <ul class="finedo-ul">
        <form method="post" id="ajaxForm" name="ajaxForm">
            <li>
                <span class="finedo-label-title" style="width:20%;"><font color=red>*</font>应用名称：</span>
                <input class="finedo-text" type="text" id="appname" name="appname" value="" style="width:80%;">
            </li>

            <li>
                <span class="finedo-label-title" style="width:20%;">应用描述：</span>
                <textarea class="finedo-textarea" id="appdesc" name="appdesc" style="width:80%;"></textarea>
            </li>
            <li class="add-center">
                <input type="button" class="finedo-button" value="提    交" onClick="appadd.add()" >
            </li>
        </form>
        </ul>
    </div>
</div>
<script language="javascript">
var appadd={};
appadd.add=function(){
    var appname = $.trim($('#appname').val());
    if(finedo.fn.isnon(appname)){
        finedo.message.warning("应用名称不能为空", '提示');
        return;
    }
    finedo.action.ajaxForm({
        form:"ajaxForm",
        url:"../../finedo/app/add",
        callback:function(jsondata){
            if(jsondata.fail){
                finedo.message.error(jsondata.resultdesc);
                return;
            }
            finedo.message.info(jsondata.resultdesc);
        }
    });
};
</script>
<script type='text/javascript' src='../../resource/js/lazyload.js'></script>
<script language="javascript">
LazyLoad.css([
    '../../resource/themes/default/style.css',
    '../../resource/js/finedoui/commonui/themes/commonui.css',
    '../../resource/js/finedoui/dialog/themes/style.css'
    ]);
LazyLoad.js([
    '../../resource/js/jquery/jquery-1.11.0.js',
    '../../resource/js/jquery/jquery.form.js',
    '../../resource/js/finedoui/base/finedo.core.js',
    '../../resource/js/finedoui/commonui/finedo.commonui.js',
    '../../resource/js/finedoui/dialog/finedo.dialog.js'
    ], function() {
    
});
</script>
</body>
</html>


