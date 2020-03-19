<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs2.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Token生成</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>
<body>
<div>
	<div class="add-common-head">
    	<div class="add-common-name-add">Token生成<br/>
            <ul>
            	<li id="common_add_card" class="add-link-li">普通新建</li> 
            </ul>
        </div>
        <input type="button" class="finedo-button-blue" style="float:right" value="提交" onclick="addtoken.dosubmit();">
    </div>
    
    <form method="post" id="ajaxForm" name="ajaxForm">
    <div id="common_add_div" >
	   	<ul class="finedo-ul">
			<li>
				<span class="finedo-label-title"><font color=red>*</font>关联用户</span>
				<select id="userid" name="userid" style="width:255px;"></select>
			</li>
			<li>
				<span class="finedo-label-title"><font color=red>*</font>Token类型</span>
				<input type="text" id="tokentype"></input>
			</li>
			<li>
				<span class="finedo-label-title">IP限制</span>
				<input class="finedo-text" type="text" id="iplimit" name="iplimit" value="" maxlength="1000">
			</li>
			<li>
				<span class="finedo-label-title">访问URL</span>
				<input class="finedo-text" type="text" id="url" name="url" value="" maxlength="500">
			</li>
		</ul>
	    <ul>
	    	<li class="add-center"><input type="button" class="finedo-button" value="提    交" onClick="addtoken.dosubmit()" ></li>
	    </ul>
    </div>
    </form>
</div>
<script language="javascript">
var addtoken={
    initorg:function(){
        finedo.getradio("tokentype", {
            data:[
                {"code":"一次性", "value":"一次性"},
                {"code":"时效性", "value":"时效性"},
                {"code":"永久性", "value":"永久性"}
            ],
            ctx:"../.."
        });
        
        var select2options = {
                "componentname":"userid",
                "tipmsg":"请输入用户名或用户编码",
                "action":"../../finedo/user/querybyselect",
                "datafunc":function(params){
                    return {
                        usercode: params.term,
                        state: "有效"
                    };
                },
                "idname":"userid",
                "textname":"personname",
                "inputlength":2,
                "textshow":"idtext"
            };
            finedo.select2(select2options);
    },
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
             "userid":{label:"关联用户", datatype:"string", maxlength:100, required:true},
             "tokentype":{label:"Token类型", datatype:"string", maxlength:20, required:true}
         }, true);
         return result;
     },
     dosubmit:function() {
         if(!addtoken.checkdata()) 
             return;
         finedo.action.ajaxForm({
             form:"ajaxForm",
             url:"../../finedo/token/add",
             callback:function(jsondata){
                 if(jsondata.fail){
                     finedo.message.error(jsondata.resultdesc);
                     return;
                 }
                 finedo.message.tip(jsondata.resultdesc, function(){
                     finedo.dialog.closeDialog()
                 });
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
    '../../resource/js/finedoui/dialog/themes/style.css',
    '../../resource/js/select2/css/select2.min.css'
    ]);
LazyLoad.js([
    '../../resource/js/jquery/jquery-1.11.0.js',
    '../../resource/js/jquery/jquery.form.js',
    '../../resource/js/finedoui/base/finedo.core.js',
    '../../resource/js/finedoui/commonui/finedo.commonui.js',
    '../../resource/js/finedoui/dialog/finedo.dialog.js',
    '../../resource/js/select2/js/select2.full.min.js',
    '../../resource/js/select2/js/i18n/zh-CN.js'
    ], function() {
    addtoken.initorg();
});
</script>
</body>
</html>
