<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs2.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>新增密码规则</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<style>
.finedo-ul li span{width:14%;}
</style>
</head>
<body>
<div>
    <div class="add-common-head">
        <div class="add-common-name-add">新建密码规则<br/>
        </div>
        <input type="button" class="finedo-button-blue" style="float:right" value="提交" onclick="securityadd.dosubmit();">
    </div>
    
    <form method="post" id="ajaxForm" name="ajaxForm">
    <div id="common_add_div" >
        <ul class="finedo-ul">
            <li>
                <span class="finedo-label-title"><font color=red>*</font>密码类型</span>
                <input class="finedo-text" type="text" id="passwdtype" name="passwdtype" value="" title="请输入[密码类型](备注：登陆密码、交易密码)" maxlength="50">
            </li>
            <li>
                <span class="finedo-label-title"><font color=red>*</font>有效天数</span>
                <input class="finedo-text" type="text" id="validday" name="validday" value="" title="请输入[有效天数] 纯数字型" maxlength="10">
            </li>
            <li>
                <span class="finedo-label-title"><font color=red>*</font>密码最小长度</span>
                <input class="finedo-text" type="text" id="minlength" name="minlength" value="" title="请输入[密码最小长度] 纯数字型"  maxlength="10">
            </li>
            <li>
                <span class="finedo-label-title"><font color=red>*</font>密码最大长度</span>
                <input class="finedo-text" type="text" id="maxlength" name="maxlength" value="" title="请输入[密码最大长度] 纯数字型" maxlength="10">
            </li>
            <li>
                <span class="finedo-label-title"><font color=red>*</font>特殊字符最小数量</span>
                <input class="finedo-text" type="text" id="specialnum" name="specialnum" value="" title="请输入[特殊字符最小数量] 纯数字型" maxlength="10">
            </li>
            <li>
                <span class="finedo-label-title"><font color=red>*</font>大写字母最小数量</span>
                <input class="finedo-text" type="text" id="capitalnum" name="capitalnum" value="" title="请输入[大写字母最小数量] 纯数字型" maxlength="10">
            </li>
            <li>
                <span class="finedo-label-title"><font color=red>*</font>小写字母最小数量</span>
                <input class="finedo-text" type="text" id="lowercasenum" name="lowercasenum" value="" title="请输入[小写字母最小数量] 纯数字型" maxlength="10">
            </li>
            <li>
                <span class="finedo-label-title"><font color=red>*</font>数字最小数量</span>
                <input class="finedo-text" type="text" id="digitalnum" name="digitalnum" value="" title="请输入[数字最小数量] 纯数字型" maxlength="10">
            </li>
            <li>
                <span class="finedo-label-title">备注</span>
                <input class="finedo-text" type="text" id="remark" name="remark" value="" maxlength="500">
            </li>
        </ul>
        <ul>
            <li class="add-center"><input type="button" class="finedo-button" value="提    交" onClick="securityadd.dosubmit()" ></li>
        </ul>
    </div>
    </form>
</div>
<script language="javascript">
var securityadd={
    //数据验证
    checkdata:function() {
        /**
         *   通用数据验证
         *   label       名称
         *   datatype    数据类型  string email phone url date datetime time number digits 
         *   minlength   最小长度
         *   maxlength   最大长度
         *   required    是否必填 true/false
         */
         var result=finedo.validate({
             "passwdtype":{label:"密码类型", datatype:"string", maxlength:50, required:true},
             "validday":{label:"有效天数", datatype:"number", maxlength:10, required:true},
             "minlength":{label:"密码最小长度", datatype:"number", maxlength:10, required:true},
             "maxlength":{label:"密码最大长度", datatype:"number", maxlength:10, required:true},
             "specialnum":{label:"特殊字符最小数量", datatype:"number", maxlength:10, required:true},
             "capitalnum":{label:"大写字母最小数量", datatype:"number", maxlength:10, required:true},
             "lowercasenum":{label:"小写字母最小数量", datatype:"number", maxlength:10, required:true},
             "digitalnum":{label:"数字最小数量", datatype:"number", maxlength:10, required:true},
             "remark":{label:"备注", datatype:"string", maxlength:500, required:false}
         }, true);
         return result;
     },
     dosubmit:function() {
         if(!securityadd.checkdata()) 
             return;
         finedo.action.ajaxForm({
             form:"ajaxForm",
             url:"../../finedo/securityconf/insertSecurityconf",
             callback:function(jsondata){
                 if(jsondata.fail){
                     finedo.message.error(jsondata.resultdesc);
                     return;
                 }
                 finedo.message.info(jsondata.resultdesc);
             }
         });
     }
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
