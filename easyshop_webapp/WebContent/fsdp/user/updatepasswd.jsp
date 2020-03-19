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
   	<form method="post" id="ajaxPassWordForm" name="ajaxPassWordForm">
   	<input type="hidden" id="usercode" name="usercode" value="">
  		<div class="finedo-nav-title">密码设置</div>
		<ul class="finedo-ul">
		<li>
			<span class="finedo-label-title"><font color=red>*</font>原密码</span>
			<input class="finedo-text" type="password" onfocus="finedo.showhintinfo('lastbptime');" id="lastbptime" name="lastbptime" value="">
			<span for="lastbptime" class="finedo-hint-info">输入原密码</span>
			<span for="lastbptime" class="finedo-hint-error"></span>
			<span for="lastbptime" class="finedo-hint-right"></span>
		</li>			
			  
		<li>
			<span class="finedo-label-title"><font color=red>*</font>新密码</span>
			<input class="finedo-text" type="password" onfocus="finedo.showhintinfo('lastlptime');" id="lastlptime" name="lastlptime" value="">
			<span for="lastlptime" class="finedo-hint-info">至少 8位字符，必须包含大小写英文字母、数字、特殊符号</span>
			<span for="lastlptime" class="finedo-hint-error"></span>
			<span for="lastlptime" class="finedo-hint-right"></span>
		</li>
		
		<li>
			<span class="finedo-label-title"><font color=red>*</font>确认密码</span>
			<input class="finedo-text" type="password" onfocus="finedo.showhintinfo('loginpasswd');" id="loginpasswd" name="loginpasswd" value="">
			<span for="loginpasswd" class="finedo-hint-info">再输入一次密码，并请记住该密码</span>
			<span for="loginpasswd" class="finedo-hint-error"></span>
			<span for="loginpasswd" class="finedo-hint-right"></span>
		</li>
		
		<li>
			<span class="finedo-label-title">密码修改原因</span>
			<input class="finedo-text" type="text" onfocus="finedo.showhintinfo('remark');" id="remark" name="remark" value="">
			<span for="remark" class="finedo-hint-info"></span>
			<span for="remark" class="finedo-hint-error"></span>
			<span for="remark" class="finedo-hint-right"></span>
		</li>
		<li>
			<span class="finedo-label-title"><font color=red>*</font>验证码</span>
			<input class="finedo-text" type="text" onfocus="finedo.showhintinfo('verifycode');" id="verifycode" name="verifycode" value="">
			<span for="verifycode" class="finedo-hint-info"></span>
			<span for="verifycode" class="finedo-hint-error"></span>
			<span for="verifycode" class="finedo-hint-right"></span>
	        <img src="" id="verifycodebtn" onclick="updatepasswd.changeImage(this)" title="点击刷新验证码" width="100" height="22" style="vertical-align: middle;margin-left:2px;cursor: pointer;"/>
		</li>
       </ul>
       </form>
	<ul>
   		<li class="add-center"><input type="button" class="finedo-button" value="提    交" onclick="updatepasswd.dosavepwd();"></li>
	</ul>
   </div>
<script language="javascript">
var updatepasswd={
    uuid:"",
    initupdatepwd:function(){
        updatepasswd.uuid = Math.uuid();
        var usercode = finedo.fn.getParameter("usercode");
        $("#usercode").val(usercode);
        $("#verifycodebtn").attr("src", "../../finedo/oper/graphicscode?opcode=modifypasswd&sessionid="+updatepasswd.uuid);
    },
    dosavepwd:function(){
        var result=finedo.validate({
            "lastbptime":{label:"原密码", datatype:"string", maxlength:30, required:true},
            "lastlptime":{label:"新密码", datatype:"string", maxlength:30, required:true},
            "loginpasswd":{label:"确认密码", datatype:"string", maxlength:30, required:true}
        });
        if(!result) {
            return;
        }
        
        // 密码必须由 4-16位字母、数字、特殊符号线组成
        var lastlptime=$('#lastlptime').val();
        var reg = /^(?![a-zA-z]+$)(?!\d+$)(?![!@#$%^&*]+$)(?![a-zA-z\d]+$)(?![a-zA-z!@#$%^&*]+$)(?![\d!@#$%^&*]+$)[a-zA-Z\d!@#$%^&*]+$/;
        if(!reg.test(lastlptime) || lastlptime.length < 8) {
            finedo.showhinterror('lastlptime', '登录密码必须由至少 8位字母、数字、特殊符号线组成');
            return;
        }
        
        var loginpasswd=$('#loginpasswd').val();
        if(lastlptime != loginpasswd) {
            finedo.showhinterror('loginpasswd', '确认密码输入不正确，请重新输入');
            return;
        }
        var aeskey = CryptoJS.enc.Utf8.parse(aesvikey);
        var aesiv = CryptoJS.enc.Utf8.parse(aesvikey);
        var usercodeval = $("#usercode").val();
        usercodeval = CryptoJS.AES.encrypt(usercodeval,aeskey,{iv:aesiv,mode:CryptoJS.mode.CBC,padding:CryptoJS.pad.ZeroPadding});
        var lastbptimeval = $("#lastbptime").val();
        lastbptimeval = CryptoJS.AES.encrypt(lastbptimeval,aeskey,{iv:aesiv,mode:CryptoJS.mode.CBC,padding:CryptoJS.pad.ZeroPadding});
        var lastlptimeval = $("#lastlptime").val();
        lastlptimeval = CryptoJS.AES.encrypt(lastlptimeval,aeskey,{iv:aesiv,mode:CryptoJS.mode.CBC,padding:CryptoJS.pad.ZeroPadding});
        var loginpasswdval = $("#loginpasswd").val();
        loginpasswdval = CryptoJS.AES.encrypt(loginpasswdval,aeskey,{iv:aesiv,mode:CryptoJS.mode.CBC,padding:CryptoJS.pad.ZeroPadding});
        var reqdata={
            "usercode":$.base64.btoa(usercodeval),
            "lastbptime":$.base64.btoa(lastbptimeval),
            "lastlptime":$.base64.btoa(lastlptimeval),
            "loginpasswd":$.base64.btoa(loginpasswdval),
            "remark":$.trim($("#remark").val()),
            "opcode":'modifypasswd',
            "sessionid":updatepasswd.uuid,
            "verifycode":$.trim($("#verifycode").val())
        };
        var form = $("#ajaxPassWordForm");
        var action = "../../finedo/config/modifypassword?"+$.param(reqdata);
        finedo.action.doCommand(action,updatepasswd.submitcallback);
    },
    submitcallback:function(jsondata){
        finedo.message.hideWaiting();
        finedo.message.info(jsondata.resultdesc, "密码修改");
        $("#verifycodebtn").trigger("click");
    },
    changeImage:function(obj){
        var url = $(obj).attr("src");
        var date = new Date();
        url = finedo.fn.replaceUrl(url, "time", date.getTime());
        $(obj).attr("src",url);
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
    '../../resource/js/jquery/uuid.js',
    '../../resource/js/finedoui/base/finedo.core.js',
    '../../resource/js/finedoui/commonui/finedo.commonui.js',
    '../../resource/js/finedoui/dialog/finedo.dialog.js',
    '../../resource/js/jquery/jquery.base64.js',
    '../../resource/js/crypto/aes.js',
    '../../resource/js/crypto/pad-zeropadding.js'
    ], function() {
    updatepasswd.initupdatepwd();
});
</script>
</body>
</html>