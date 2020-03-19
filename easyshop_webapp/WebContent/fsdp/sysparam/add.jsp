<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs2.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>新增系统参数</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>
<body>
<div>
    <div class="add-common-head">
        <div class="add-common-name-add">新建系统参数<br/>
        </div>
        <input type="button" class="finedo-button-blue" style="float:right" value="提交" onclick="sysparamadd.dosubmit();">
    </div>
    
    <form method="post" id="ajaxForm" name="ajaxForm">
    <div id="common_add_div" >
        <ul class="finedo-ul">
            <li>
                <span class="finedo-label-title"><font color=red>*</font>参数类型</span>
                <input class="finedo-text" type="text" id="configtypeid" name="configtypeid" value="" title="参数类型不能为空，请填写【参数类型】" maxlength="50">
            </li>
            <li>
                <span class="finedo-label-title"><font color=red>*</font>参数名称</span>
                <input class="finedo-text" type="text" id="paramname" name="paramname" value="" title="参数名称不能为空，请填写【参数名称】" maxlength="200">
            </li>
            <li>
                <span class="finedo-label-title"><font color=red>*</font>参数值</span>
                <input class="finedo-text" type="text" id="paramvalue" name="paramvalue" value="" title="参数值不能为空，请填写【参数值】">
            </li>
            <li>
                <span class="finedo-label-title"><font color=red>*</font>数据类型</span>
                <input class="finedo-text" type="text" id="datatype" name="datatype" value="" title="数据类型不能为空，请填写【数据类型】" maxlength="50">
            </li>
        </ul>
        <ul>
            <li class="add-center"><input type="button" class="finedo-button" value="提    交" onClick="sysparamadd.dosubmit()" ></li>
        </ul>
    </div>
    </form>
</div>
<script language="javascript">
var sysparamadd={
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
             "configtypeid":{label:"参数类型", datatype:"string", maxlength:50, required:true},
             "paramname":{label:"参数名称", datatype:"string", maxlength:200, required:true},
             "paramvalue":{label:"参数值", datatype:"string", required:true},
             "datatype":{label:"数据类型", datatype:"string", maxlength:50, required:true}
         }, true);
         return result;
     },
     dosubmit:function() {
         if(!sysparamadd.checkdata()) 
             return;
         finedo.action.ajaxForm({
             form:"ajaxForm",
             url:"../../finedo/sysparam/addSysParam",
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
