<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs2.jsp" %>

<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>
<body>
<div>
<div class="add-common-head">
    	<div class="add-common-name-add">问题上报修改<br/></div>
        <input type="button" class="finedo-button-blue" style="float:right" value="提交" onclick="questiondeal.doNext();">
    </div>
    <div id="common_add_div" >
    	<div class="finedo-nav-title">基本信息</div>
	   	<ul class="finedo-ul">
    	<form method="post" id="ajaxForm" name="ajaxForm">
    		<input type="hidden" id="questionid" name="questionid">
			<li>
				<span class="finedo-label-title"><font color=red>*</font>问题处理人</span>
                <input type="hidden" id="dealmanname" name="dealmanname" value="">
                <select id="dealman" name="dealman" style="width:80%;"></select>
			</li>

           <li>
           		<span class="finedo-label-title"><font color=red>*</font>问题处理时间</span>
           		<input class="finedo-date" type="text" value="" id="dealtime" name="dealtime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width:80%;">
           	</li>

           	<li>
           		<span class="finedo-label-title"><font color=red>*</font>问题处理描述</span>
           		<textarea class="finedo-textarea" id="dealdesc" name="dealdesc" style="width:80%;"></textarea>
           	</li>
    	</form>
        </ul>
        <ul>
	    	<li class="add-center"><input type="button" class="finedo-button" value="提    交" onClick="questiondeal.dosubmit()" ></li>
	    </ul>
    </div>
</div>
<script language="javascript">
var questiondeal={
    initquestion:function(){
        var questionid = finedo.fn.getParameter("questionid");
        $("#questionid").val(questionid);
        var select2options = {
            "componentname":"dealman",
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
            "textshow":"text"
        };
        finedo.select2(select2options);
    },
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
             "dealman":{label:"问题处理人", datatype:"string", required:true},
             "dealtime":{label:"问题处理时间", datatype:"datetime", required:true},
             "dealdesc":{label:"问题处理描述", datatype:"string", required:true}
         });
         return result;
     },
     doNext:function() {
         questiondeal.dosubmit();
     },
     dosubmit:function() {
         if(!questiondeal.checkdata()) 
             return;
         var userlist = $("#dealman").select2('data');
         $("#dealmanname").val(userlist[0].text);
         finedo.action.ajaxForm({
             form:"ajaxForm",
             url:"../../finedo/question/deal",
             callback:function(jsondata){
                 if(jsondata.fail){
                     finedo.message.error(jsondata.resultdesc);
                     return;
                 }
                 finedo.message.info(jsondata.resultdesc);
             }
         });
     }
}
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
    '../../resource/js/finedoui/date/WdatePicker.js',
    '../../resource/js/select2/js/select2.full.min.js',
    '../../resource/js/select2/js/i18n/zh-CN.js'
    ], function() {
    questiondeal.initquestion();
});
</script>
</body>
</html>
