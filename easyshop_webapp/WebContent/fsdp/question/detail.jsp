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
    	<div class="add-common-name">上报问题详情<br/></div>
    </div>
    
    <div id="common_add_div" >
    	<div class="finedo-nav-title">基本信息</div>
	   	<ul class="finedo-ul">
			
			<li>
				<span class="finedo-label-title"><font color=red>*</font>问题标题</span>
				<span class="finedo-label-info" id="title"></span>
			</li>

           	<li>
           		<span class="finedo-label-title"><font color=red>*</font>问题上报人</span>
           		<span class="finedo-label-info" id="initiator"></span>
           	</li>

           	<li>
           		<span class="finedo-label-title"><font color=red>*</font>问题发生时间</span>
           		<span class="finedo-label-info" id="happentime"></span>
           	</li>

           	<li>
           		<span class="finedo-label-title"><font color=red>*</font>问题上报时间</span>
           		<span class="finedo-label-info" id="createtime"></span>
           	</li>
           	
           	<li>
           		<span class="finedo-label-title"><font color=red>*</font>问题描述</span>
           		<span class="finedo-label-info" id="questiondesc"></span>
           	</li>
           	
           	<li>
           		<span class="finedo-label-title"><font color=red>*</font>状态</span>
           		<span class="finedo-label-info" id="status"></span>
           	</li>
           	
           	<li>
           		<span class="finedo-label-title"><font color=red>*</font>问题处理人</span>
           		<span class="finedo-label-info" id="dealman"></span>
           	</li>
           	
           	<li>
           		<span class="finedo-label-title"><font color=red>*</font>问题处理时间</span>
           		<span class="finedo-label-info" id="dealtime"></span>
           	</li>
           	
           	<li>
           		<span class="finedo-label-title"><font color=red>*</font>问题处理描述</span>
           		<span class="finedo-label-info" id="dealdesc"></span>
           	</li>
           	<li>
        		<span class="finedo-label-title">附件</span>
				<input type="text" id="uploaddiv" name="uploaddiv" value="" editable="false">
			</li>
		</ul>
    </div>
</div>
<script language="javascript">
var questiondetail={
    initquestion:function(){
        finedo.action.ajax({
            "url":"../../finedo/question/querybyid",
            "data":{"questionid":finedo.fn.getParameter("questionid")},
            "callback":function(retdata){
                if(retdata.fail){
                    finedo.message.error(retdata.resultdesc);
                    return;
                }
                var retobject = retdata.object;
                $("#title").html(retobject.title);
                $("#initiator").html(retobject.initiatorname+"["+retobject.initiator+"]");
                $("#happentime").html(retobject.happentime);
                $("#createtime").html(retobject.createtime);
                $("#questiondesc").html(retobject.questiondesc);
                $("#status").html(retobject.status);
                if(finedo.fn.isnotnon(retobject.dealman)){
                    $("#dealman").html(retobject.dealmanname+"["+retobject.dealman+"]");
                }
                $("#dealtime").html(retobject.dealtime);
                $("#dealdesc").html(retobject.dealdesc);
                $("#uploaddiv").val(retobject.attachment);
                finedo.getFileControl('uploaddiv', {
                    ctx:"../..",
                    "value":retobject.attachment
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
    '../../resource/js/finedoui/image/viewer.min.css',
    '../../resource/js/finedoui/upload/themes/style.css'
    ]);
LazyLoad.js([
    '../../resource/js/jquery/jquery-1.11.0.js',
    '../../resource/js/jquery/jquery.form.js',
    '../../resource/js/finedoui/base/finedo.core.js',
    '../../resource/js/finedoui/commonui/finedo.commonui.js',
    '../../resource/js/finedoui/dialog/finedo.dialog.js',
    '../../resource/js/finedoui/image/viewer.min.js',
    '../../resource/js/finedoui/upload/finedo.upload.js'
    ], function() {
    questiondetail.initquestion();
});
</script>
</body>
</html>
