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
   	    <input type="hidden" name="userid" id="userid">
   	    <input type="hidden" name="usercode" id="usercode">
        <input type="hidden" name="loginpasswd" id="loginpasswd">
        <input type="hidden" name="busipasswd" id="busipasswd">
  		<div class="finedo-nav-title">密码设置</div>
		<ul class="finedo-ul">
			<li>
				<span class="finedo-label-title"><font color=red>*</font>密码重置用户</span>
				<input class="finedo-text" type="text" id="username" name="username" value="" readonly onclick="javascript:resetpasswd.doSelectUser()">
			</li>
            <li>
                <span class="finedo-label-title"><font color=red>*</font>密码类型</span>
                <input type="text" id="passwdtype">
            </li>
        </ul>
		<ul>
	   		<li class="add-center"><input type="button" class="finedo-button" value="提    交" onclick="resetpasswd.dosavepwd();"></li>
		</ul>
    </form>
</div>
<script language="javascript">
var resetpasswd={
    initreset:function(){
        var options={
            data:[
                {"code":"loginpasswd", "value":"登录密码"},
                {"code":"busipasswd", "value":"交易密码"}
            ],
            value:"loginpasswd"
        };
        finedo.getradio("passwdtype", options);
    },
    dosavepwd:function(){
        if(finedo.fn.isnon($("#userid").val())){
            finedo.message.error("请选择要重置密码的用户");
            return;
        }
        var passwdtype = finedo.getradio("passwdtype").getvalue();
        if(finedo.fn.isnon(passwdtype)){
            finedo.message.error("请选择要重置的密码类型");
            return;
        }
        $("#"+passwdtype).val(passwdtype);
        finedo.action.ajaxForm({
            "form":"ajaxPassWordForm",
            "url":'../../finedo/user/password',
            "clearForm":true,
            callback:function(retdata){
                if(retdata.fail){
                    finedo.message.error(retdata.resultdesc);
                    return;
                }
                finedo.message.info(retdata.resultdesc);
            }
        });
    },
    doSelectUser:function(){
        finedo.dialog.showDialog({
            url:"../../finedo/user/chooseuser",
            width:900,
            height:600,
            callback:function(retdata){
                if(finedo.fn.isnon(retdata)){
                    return;
                }
                var userids = '';
                var usercodes='';
                var usernames='';
                for(var index = 0; index < retdata.length; index++){
                    var userobj = retdata[index];
                    if(index != 0){
                        userids += ",";
                        usercodes += ",";
                        usernames += ",";
                    }
                    userids += userobj.userid;
                    usercodes += userobj.usercode;
                    usernames += userobj.personname;
                    $("#userid").val(userids);
                    $("#usercode").val(usercodes);
                    $("#username").val(usernames);
                    
                }
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
    resetpasswd.initreset();
});
</script>
</body>
</html>