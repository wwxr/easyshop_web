<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/common/taglibs2.jsp" %>

<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
    <meta name="format-detection" content="telephone=no"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black"/>
    <meta name="format-detection" content="telephone=no">
    <meta name="format-detection" content="email=no">
    <meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1.0, maximum-scale=1.0"/>
    <link rel="shortcut icon" type="images/x-icon" href="../../platform/favicon.ico"/>
    <link rel="bookmark" type="images/x-icon" href="../../platform/favicon.ico"/>
    <title>${SYSPARAM_KEY['系统标题'] }</title>
</head>
<body>
<%-- 头部 --%>
<div class="basic-frame-top">
    <div class="base-menu active">
        <img src="../../platform/themes/images/menu_ico1.png">
    </div>
    <div class="logo"><img src="../../platform/themes/images/logo.png">${SYSPARAM_KEY['系统标题'] }</div>
    <div class="base-top-right">
        <!-- 开发环境打开账号切换，正式使用请删除下面的账号切换代码 切换用户开始-->
        <!-- <div class="switch-cons">
            <input class="accout" type="text" placeholder="请输入账号" id="accountuser" name="accountuser"/>
            <input class="deter" type="button" value="切换" onclick="index.switchLogin()"/>
            <input class="cancel" type="button" value="关闭"/>
        </div>
        <input type="button" value="切换用户" class="switchbtn"/> -->
        <!-- 切换用户结束 -->
        <div class="userinfo" id="userinfo"></div>
        <div class="close">
            <img src="../../platform/themes/images/close.png" onClick="window.location.href='../../finedo/auth/logout'">
        </div>
    </div>
</div>
<%-- 左侧菜单栏 --%>
<div class="basic-left">
    <%-- 一级/二级菜单 --%>
    <div class="basic-left-menu">
        <dl id="leftmenu"></dl>
        <%--<div class="version">${SYSPARAM_KEY['版本号'] }</div>--%>
    </div>
</div>
<%--多级菜单展示区--%>
<div class="moremenu">
    <div id="moremenu-tits" class="moremenu-tits">
        <img src="../../platform/themes/images/back.png">
        <span id="moremenu-title"></span>
    </div>
    <div id="moremenulist" class="moremenulist"></div>
</div>
<div class="blackbg"></div>
<%--主要内容--%>
<div id="right" class="main-iframebox">
    <iframe src="" style="width: 100%; height: 100%;" frameborder="0" class="mainiframe" id="mainFrame" name="mainFrame"></iframe>
</div>
<script type='text/javascript' src='../../resource/js/lazyload.js'></script>
<script language="javascript">
    LazyLoad.css([
        '../../platform/themes/platformstyle.css',
        '../../resource/js/finedoui/commonui/themes/commonui.css',
        '../../resource/js/finedoui/tree/themes/style.css',
        '../../resource/js/finedoui/dialog/themes/style.css'
    ]);
    LazyLoad.js([
        '../../resource/js/jquery/jquery-1.11.0.js',
        '../../resource/js/jquery/jquery.form.js',
        '../../resource/js/jquery/jquery.cookie.js',
        '../../resource/js/finedoui/base/finedo.core.js',
        '../../resource/js/finedoui/dialog/finedo.dialog.js',
        '../../platform/js/mobile.js',
        '../../platform/js/index.js'
    ], function () {
        appindex.initapp();
    });
</script>
<script language="javascript">
    var appindex = {
        userpermissionlist: [],
        initapp: function () {
            finedo.action.ajax({
                url: "../../finedo/auth/gettoken",
                iswait: false,
                callback: function (retdata) {
                    var sysuser = retdata.object.sysuser;
                    var sysorg = retdata.object.sysorg;
                    var orgname = sysorg.orgname;
                    orgname = orgname.length > 12 ? orgname.substring(0, 12) : orgname;
                    $("#userinfo").html(sysuser.personname + '<span>(' + orgname + ')</span>');
                    var permissionlist = retdata.object.userpermissionlist;
                    var firstnode = "";
                    for (var pindex = 0; pindex < permissionlist.length; pindex++) {
                        var permissionitem = permissionlist[pindex];
                        if (permissionitem.isnavigation != "是") {
                            continue;
                        }
                        permissionitem.id = permissionitem.nodeid;
                        permissionitem.pid = permissionitem.parentnodeid;
                        permissionitem.name = permissionitem.nodename;
                        appindex.userpermissionlist.push(permissionitem);
                        if (finedo.fn.isnon(firstnode) && permissionitem.parentnodeid != "0") {
                            firstnode = permissionitem;
                        }
                    }
                    appindex.userpermissionlist = index.formatData(appindex.userpermissionlist);
                    index.initMenu();
                    $("#" + firstnode.pid).click();
                    $("#" + firstnode.id).click();
                }
            });
        },
    };
</script>
</body>
</html>