<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs2.jsp" %>

<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${SYSPARAM_KEY['系统标题'] }</title>
${style_css }
${jquery_js }
${finedo_core_js }

<script>
// 显示、隐藏全部权限视图DIV
function showallview(){
	var displayflag=$('#head-menu').css('display');
	if(displayflag == 'block'){
		$('#head-menu').css('display', 'none');
	}else{
		$('#head-menu').css('display', 'block');
	}
}
	
// 显示全部权限视图DIV
function showviewdiv(){
	$('#head-menu').css('display', 'block');
}
// 隐藏全部权限视图DIV
function hideviewdiv(){
	$('#head-menu').css('display', 'none');
}

// 选中权限视图节点效果
function chooseonenode(object) {
	$(".head-nav").find("a").attr("class", "");
	$(object).attr("class", "head-nav-link");
}

function chooseviewnode(object){
	$(".head-menu").find("a").attr("class", "head-a-link");
	$(object).attr("class", "head-a-hover");
}


// 显示左侧二级权限视图节点
function showsubmenu(nodeid) {
	var submenu_id="submenu_" + nodeid;
	
	// 显示指定节点, 隐藏其他节点
	var submenulist=$("div[id^='submenu_']");
	for(var i=0; i<submenulist.length; i++) {
		var objid=submenulist.eq(i).attr('id');
		if(submenu_id == objid) {
			$("#" + objid).attr("style", "display:block");
			
			// 显示第一个节点
			$('#mainFrame').attr('src', $('#' + objid).find('.menu-submenu-a').eq(0).attr('href'));
		}else {
			$("#" + objid).attr("style", "display:none");
		}
	}
}

function submenu(obj){
	$(".menu-submenu-con").find("a").attr("class","menu-submenu-a");
	$(obj).attr("class","menu-submenu-hover");
}	

//左侧菜单显示隐藏
function hidebottom(){
	var displayflag=$('#menu').css('display');
	if(displayflag == 'block'){
		$('#menu').css('display', 'none');
		$('#icon-openstop').attr('class', 'menu-icon-openstop-hide');
		$('#right').css('width', document.body.scrollWidth);
	}else{
		$('#menu').css('display', 'block');
		$('#icon-openstop').attr('class', 'menu-icon-openstop');
		$('#right').css('width', document.body.scrollWidth-250);
	}
}
function resizehidebottom(){
	var ishide = false;
	if($(window).width() < 935)
		ishide = true;
	else
		ishide = false;
	var displayflag=$('#menu').css('display');
	if(ishide){
		if(displayflag == 'none')
			return;
		$('#menu').css('display', 'none');
		$('#icon-openstop').attr('class', 'menu-icon-openstop-hide');
		$('#right').css('width', document.body.scrollWidth);
		$("#icon-openstop").hide();
	}else{
		if(displayflag == 'block')
			return;
		$('#menu').css('display', 'block');
		$('#icon-openstop').attr('class', 'menu-icon-openstop');
		$('#right').css('width', document.body.scrollWidth-250);
		$("#icon-openstop").show();
	}
}
window.onresize = function(){
	if($('#menu').css('display') == 'block') {
		$('#menu').css('display', 'none');
	}else {
		$('#menu').css('display', 'block');
	}
	resizehidebottom();
};

function menuleft(){
	$("#menu").toggle();
}

$(window).load(function() {
	$("#right").width(document.body.scrollWidth-250);

	resizehidebottom();
});
</script>
</head>

<body style="overflow:hidden;">

<!-------- 头部 -------->
<div class="head">
	<div class="head-logo">${SYSPARAM_KEY['系统标题'] }<span class="head-version">${SYSPARAM_KEY['版本号'] }</span></div>
    
    <!-- 显示前6个一级权限视图节点 -->
    <div class="head-nav">
        <ul>
	        <c:set var="nodecount" value="0"></c:set>
	        <c:forEach var="userright" items="${sessionScope.LOGINDOMAIN_KEY.userrightlist}" >
		        <c:if test="${userright.parentnodeid eq '0' and userright.isnavigation eq '是' and nodecount < 8 }">
		       		<c:set var="nodecount" value="${nodecount + 1 }"></c:set>
		       		
		       		<c:if test="${nodecount eq 1 }">
		       		<script>
			       		// 加载第一个节点的子节点
			       		window.onload=function(){
			       			showsubmenu("${userright.nodeid }");
			       		}
		       		</script>
		       		</c:if>
		       		
					<li><a href="#" onclick="chooseonenode(this); showsubmenu('${userright.nodeid}')" id="${userright.nodeid}">${userright.nodename }</a></li>
				</c:if>
	        </c:forEach>
        </ul>
    </div>
    
    <!-------- 显示所有一级权限视图节点 -------->
    <div class="head-operate" onMouseOut="hideviewdiv()" >
    	<input class="head-more" type="button" value="" onClick="showallview()" >
        <div class="head-menu" id="head-menu" onMouseOver="showviewdiv()" style=" display:none;" >
            <c:forEach var="userright" items="${sessionScope.LOGINDOMAIN_KEY.userrightlist}" >
            	<c:if test="${userright.parentnodeid eq '0' and userright.isnavigation eq '是'}">
            		<a href="#" onclick="chooseviewnode(this); showsubmenu('${userright.nodeid}')" class="head-a-link">${fsdp:substr(userright.nodename, 4)}</a>
            	</c:if>
            </c:forEach>
        </div>
    </div>
    <div class="menu-left" ><input type="button" onClick="menuleft()" class="head-menu-btn" value=""></div>
    <div class="head-right"><input type="button" class="head-close" value="" title="退出" onClick="window.location.href='${ctx }/finedo/auth/logout'"></div>
</div>

<!-------- 左侧二级权限视图节点 -------->
<div class="menu" id="menu" style=" display:block; height:100%; ">
    <div class="menu-infor"><span class="menu-font13">${LOGINDOMAIN_KEY.sysuser.personname}</span>&nbsp;&nbsp;&nbsp;&nbsp;<span title="${LOGINDOMAIN_KEY.sysorg.orgname}">${fsdp:substr(LOGINDOMAIN_KEY.sysorg.orgname, 12)}</span></div>
    
    <c:forEach var="userright1" items="${sessionScope.LOGINDOMAIN_KEY.userrightlist}" >
    	<c:if test="${userright1.parentnodeid eq '0' and userright1.isnavigation eq '是'}">
    	<div class="menu-submenu" id="submenu_${userright1.nodeid }" style="display:none">
		    <div class="menu-submenu-name menu-font13">${userright1.nodename }</div>
		    	
	    	<div class="menu-submenu-con">
			    <ul>
		    	<c:forEach var="userright2" items="${sessionScope.LOGINDOMAIN_KEY.userrightlist}" >
			        <c:if test="${userright2.parentnodeid eq userright1.nodeid and userright2.isnavigation eq '是'}">
			        	<li><a class="menu-submenu-a" onClick="submenu(this)" href="${ctx }${userright2.rightentry }" target="mainFrame"><span class="menu-icon"></span>${userright2.nodename }</a></li>
			        </c:if>
			    </c:forEach>
			    </ul>
		    </div>
		</div>
		</c:if>
    </c:forEach>
    
    <div class="menu-bottom">
    	<ul>
        	<li title="设置"><a class="menu-icon-shortcut" href="${ctx}/finedo/config/configpage" target="mainFrame"></a></li>
            <li class="menu-icon-shortcut menu-icon-password" title="密码修改" ></a></li>
            <li class="menu-icon-shortcut menu-icon-skin-peeler" title="换肤"></li>
            <li class="menu-icon-shortcut menu-icon-news" title="消息"></li>
        </ul>
    </div>
</div>

<input class="menu-icon-openstop" id="icon-openstop" type="button" value="" onClick="hidebottom()">
<div id="right" style="float:right; position:fixed; right:0; bottom:0; z-index:-100; +height:650px; +overflow-y:auto;" class="main-right">
<iframe src="#" height="100%" width="100%" frameborder="0" scrolling="yes" id="mainFrame" name="mainFrame" ></iframe> 
</div>
</body>
</html>
