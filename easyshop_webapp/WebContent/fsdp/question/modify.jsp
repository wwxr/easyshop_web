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
        <input type="button" class="finedo-button-blue" style="float:right" value="提交" onclick="questionmodify.doNext();">
    </div>
    <div id="common_add_div" >
    	<div class="finedo-nav-title">基本信息</div>
	   	<ul class="finedo-ul">
    	<form method="post" id="ajaxForm" name="ajaxForm">
    		<input type="hidden" id="questionid" name="questionid" value="">
    		<input type="hidden" id="attachment" name="attachment" value="">
    		<input type="hidden" id="status" name="status" value="">
			<li>
				<span class="finedo-label-title"><font color=red>*</font>问题标题</span>
				<input class="finedo-text" type="text" id="title" name="title" value="" style="width:80%;">
			</li>

           <li>
           		<span class="finedo-label-title"><font color=red>*</font>问题上报人</span>
           		<input type="hidden" id="initiatorname" name="initiatorname" value="">
                <select id="initiator" name="initiator" style="width:80%;"></select>
           	</li>

           <li>
           		<span class="finedo-label-title"><font color=red>*</font>问题发生时间</span>
           		<input class="finedo-date" type="text" value="" id="happentime" name="happentime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width:80%;">
           	</li>

           	<li>
           		<span class="finedo-label-title"><font color=red>*</font>问题描述</span>
           		<textarea class="finedo-textarea" id="questiondesc" name="questiondesc" style="width:80%;"></textarea>
           	</li>
    	</form>
        	<li>
        		<span class="finedo-label-title">附件</span>
				<input type="text" id="uploaddiv" name="uploaddiv" valueid="attachment" value="" multiupload="true" maxfilenum="5">
			</li>
        </ul>
        <ul>
	    	<li class="add-center"><input type="button" class="finedo-button" value="提    交" onClick="questionmodify.dosubmit()" ></li>
	    </ul>
    </div>
</div>
<script language="javascript">
var questionmodify={
    initquestion:function(){
        var questionid = finedo.fn.getParameter("questionid");
        $("#questionid").val(questionid);
        finedo.action.ajax({
            url:"${ctx}/finedo/question/querybyid",
            data:{"questionid":questionid},
            callback:function(retdata){
                if(retdata.fail){
                    finedo.message.error(retdata.resultdesc);
                    return;
                }
                var retobject = retdata.object;
                $("#title").val(retobject.title);
                $("#initiator").val(retobject.initiator);
                $("#initiatorname").val(retobject.initiatorname);
                $("#happentime").val(retobject.happentime);
                $("#questiondesc").val(retobject.questiondesc);
                $("#uploaddiv").val(retobject.attachment);
                $("#status").val(retobject.status);
                finedo.getFileControl('uploaddiv', {
                    ctx:"../..",
                    "value":retobject.attachment
                });
                
                var select2options = {
                    "componentname":"initiator",
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
                    "textshow":"text",
                    "defaultValue":retobject.initiator,
                    "defaultText":retobject.initiatorname
                };
                finedo.select2(select2options);
            }
        });
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
             "title":{label:"问题标题", datatype:"string", required:true},
             "happentime":{label:"问题发生时间", datatype:"datetime", required:true},
             "questiondesc":{label:"问题描述", datatype:"string", required:true}
         });
         return result;
     },
     doNext:function() {
         questionmodify.dosubmit();
     },
     dosubmit:function() {
         if(!questionmodify.checkdata()) 
             return;

         var userlist = $("#initiator").select2('data');
         $("#initiatorname").val(userlist[0].text);
         finedo.action.ajaxForm({
             form:"ajaxForm",
             url:"../../finedo/question/modify",
             callback:function(jsondata){
                 if(jsondata.fail){
                     finedo.message.error(jsondata.resultdesc);
                     return;
                 }
                 finedo.message.info(jsondata.resultdesc);
             },
             clearForm:false
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
    '../../resource/js/finedoui/image/viewer.min.css',
    '../../resource/js/finedoui/upload/themes/style.css',
    '../../resource/js/select2/css/select2.min.css'
    ]);
LazyLoad.js([
    '../../resource/js/jquery/jquery-1.11.0.js',
    '../../resource/js/jquery/jquery.form.js',
    '../../resource/js/finedoui/base/finedo.core.js',
    '../../resource/js/finedoui/commonui/finedo.commonui.js',
    '../../resource/js/finedoui/dialog/finedo.dialog.js',
    '../../resource/js/finedoui/date/WdatePicker.js',
    '../../resource/js/finedoui/image/viewer.min.js',
    '../../resource/js/finedoui/upload/finedo.upload.js',
    '../../resource/js/select2/js/select2.full.min.js',
    '../../resource/js/select2/js/i18n/zh-CN.js'
    ], function() {
    questionmodify.initquestion();
});
</script>
</body>
</html>
