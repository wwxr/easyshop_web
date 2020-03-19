<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs2.jsp" %>
<%
    String uuid = java.util.UUID.randomUUID().toString();
    request.setAttribute("sessionid", uuid);
%>
<!doctype html>
<html>
<head>
${x_ua_compatible}
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1.0, maximum-scale=1.0"/>
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta content="telephone=no" name="format-detection">
<meta content="email=no" name="format-detection">
<link rel="shortcut icon" type="images/x-icon" href="${ctx }/platform/favicon.ico"/>
<link rel="bookmark" type="images/x-icon" href="${ctx }/platform/favicon.ico"/>
<title>${SYSPARAM_KEY['系统标题'] }</title>
<link rel="stylesheet" type="text/css" href="${ctx }/platform/themes/platformstyle.css?version=${version }"/>
<script type="text/javascript" src="${ctx }/platform/js/mobile.js"></script>
${jquery_js }
${finedo_core_js }
${finedo_dialog_js }
${finedo_md5_js }
${jquery_base64_js }
${crypto_aes_js }
    
<script type="text/javascript">

function registershowevent(object, defaultval) {
    object.focus(function(){
        if($(this).val() == defaultval)
            $(this).val('');
    });
    
    object.blur(function(){
         if($(this).val() == "")
             $(this).val(defaultval);
    });
}

$(document).ready(function() {
    
    //判断浏览器类型与版本
    checkBrowserAndVer();
    var accountobj=$('#account');
    var passwdobj=$('#passwd');
    var verifycodeobj=$('#verifycode');
    
    registershowevent(accountobj, "登录账号");
    registershowevent(passwdobj, "登录密码");
    registershowevent(verifycodeobj, "验证码");
    
    if(finedo.fn.isnotnon($.cookie("account"))){
        $("#account").attr("value",$.cookie("account"));
        $("#passwd").focus();
    }
    
    //判断是否有登录时密码过期的条件，有则弹出密码修改页面
    var errorcode = "${resultcode}";
    var usercode = "${usercode}";
    if(errorcode == 'ER_LOGIN012'){
        finedo.dialog.show({
            width:900,
            height:500,
            'title':'密码修改',
            'url':'${ctx}/finedo/config/updatepasswd?usercode='+usercode
        });
    }
});

function checkBrowserAndVer(){
    var bv = finedo.fn.getBrowserAndVer();
    if(!bv.browser || !bv.version)
        return;
    var configbv = "${SYSPARAM_KEY['浏览器兼容配置']}";//配置数据格式为：firefox:11;ie:8;
    if(configbv == '')
        return;
    var configary = configbv.split(";");
    var isok = false;
    for(configkey in configary){
        var configval = configary[configkey];
        var browsername = configval.split(":")[0].toLowerCase();
        var version = configval.split(":")[1];
        if(bv.browser.toLowerCase() != browsername)
            continue;
        if(parseFloat(bv.version) >= parseFloat(version)){
            isok = true;
            break;
        }
    }
    if(isok)
        return;
    configbv = configbv.replace(/:/g,"最低版本:");
    configbv = configbv.replace(/;/g,"</br>");
    finedo.message.error("系统对浏览器兼容性要求：</br>"+configbv, "浏览器版本不兼容");
}
function login(){
    if(finedo.fn.ctlisnon("account") || $("#account").val() == "登录账号"){
        finedo.message.error("登录账号不能为空，请录入！");
        return;
    }
    if(finedo.fn.ctlisnon("passwd")){
        finedo.message.error("登录密码不能为空，请录入登陆密码！");
        return;
    }
    if(finedo.fn.ctlisnon("verifycode") || $("#verifycode").val() == "验证码"){
        finedo.message.error("验证码不能为空，请录入验证码！");
        return;
    }
    
    // 记忆登录账号与密码
    $.cookie("account", $("#account").val(), {httponly:true});
    
    var aeskey = CryptoJS.enc.Utf8.parse(aesvikey);
    var aesiv = CryptoJS.enc.Utf8.parse(aesvikey);
    var account = $("#account").val();
    account = CryptoJS.AES.encrypt(account,aeskey,{iv:aesiv,mode:CryptoJS.mode.CBC,padding:CryptoJS.pad.ZeroPadding});
    account = $.base64.btoa(account);
    $("#account").val(account);
    var passwd = $("#passwd").val();
    $("#passwd").val(hex_md5(passwd));
    $("#LoginForm").submit();   
}

function button_onkeypress(event) {
    if(event.keyCode == 13)
        login();
}

// Url字符串替换
function replaceUrl(url, name, value) {
    var reg = new RegExp("(^|)"+ name +"=([^&]*)(|$)"); 
    var tmp = name + "=" + value; 
    if(url.match(reg) != null) { 
        return url.replace(eval(reg),tmp); 
    } else { 
        if(url.match("[\?]")) { 
            return url + "&" + tmp; 
        } else { 
            return url + "?" + tmp; 
        }
    }
}

function changeImage(obj){
    var url = $(obj).attr("src");
    var date = new Date();
    url = replaceUrl(url, "time", date.getTime());
    $(obj).attr("src",url);
}

// 重新加载登录页面，避免首页部分iframe页面失败后局部加载到登录页问题
function loadUrlToTopWin() {
    if(window.top != window)
        window.top.location.href=window.location.href;
};
loadUrlToTopWin();
</script>
</head>

<body class="loginbody">
    <img src="${ctx }/platform/themes/images/login_leftico.png" class="leftico">
    <img src="${ctx }/platform/themes/images/login_bottombg.png" class="bottomico">
    <form id="LoginForm" name="LoginForm" method="post" action="${ctx}/finedo/auth/login">
        <input type="hidden" name="portalpage" id="portalpage" value="fsdpportalpage" />
        <input type="hidden" name="loginpage" id="loginpage" value="fsdploginpage" />
        <input type="hidden" name="sessionid" id="sessionid" value="${sessionid }"/>
        <div class="login-main">
            <img src="${ctx }/platform/themes/images/login_leftbg.png" class="loginleftbg">
            <div class="login-box">
                <div class="login-logo">
                    <div class="logoname">${SYSPARAM_KEY['系统标题'] }</div>
                </div>
                <div class="login-info">
                    <div class="title">用户登录</div>
                    <ul>
                        <li>
                            <img src="${ctx }/platform/themes/images/login_userapp.png" class="text">
                            <input type="text" class="login-user" value="登录账号" id="account" name="account" />
                        </li>
                        <li>
                            <img src="${ctx }/platform/themes/images/login_passwordapp.png" class="password">
                            <input type="password" class="login-pwd" value="登录密码" id="passwd" name="passwd" autocomplete="off"/>
                        </li>
                        <li>
                            <img src="${ctx }/platform/themes/images/login-codeapp.png" class="code">
                            <input type="text" class="login-code" value="验证码" id="verifycode" name="verifycode" onkeypress="button_onkeypress(event)"/>
                            <div class="codecons">
                                <div class="codedetail">
                                    <img src="${ctx}/finedo/oper/graphicscode?opcode=login&sessionid=${sessionid }" onclick="changeImage(this)" title="点击刷新验证码" width="90%" height="100%" style="vertical-align: middle;cursor: pointer;"/>
                                </div>
                            </div>
                        </li>
                    </ul>
                    <p><font color="red">${resultdesc }</font></p>
                    <input class="login-btn" value="登录" type="button" onclick="login()">
                </div>
            </div>
        </div>
    </form>

    <div class="login-foot">
        <a target='_blank' href="http://finedo.cn">关于非度</a><span>|</span>
        <a target='_blank' href="http://finedo.cn">官方网站</a><span>|</span>
        <a href="#">官方微博</a><span>|</span>
        <a href="#">官方微信</a>
        <div class="copyright">版权所有©2008-2015非度信息技术有限公司</div>
    </div>
    
    <form method="post" action="${ctx }/finedo/auth/developerlogin" id="developerForm" name="developerForm">
        <input type="hidden" id="account" name="account">
        <input type="hidden" id="passwd" name="passwd">
    </form>
</body>
</html>