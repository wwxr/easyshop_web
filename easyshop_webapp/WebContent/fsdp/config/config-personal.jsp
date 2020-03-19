<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs2.jsp" %>
<%
	String uuid = java.util.UUID.randomUUID().toString();
	request.setAttribute("sessionid", uuid);
	request.setAttribute("jsessionid", request.getSession().getId());
%>
<!doctype html>
<html>
<head>
${style_css }
${jquery_js }
${jquery_base64_js }
${crypto_aes_js }
${finedo_core_js }
${finedo_commonui_js }
${finedo_dialog_js }
${finedo_date_js }
${finedo_upload_js }

<script>
// 卡片显示与隐藏 
$(document).ready(function() {
    $('#common_add_card').click(function(e) {
    	$('#common_add_div').css('display', 'block');
    	$('#common_add_card').attr('class', 'add-link-li');
    	
    	$('#excel_add_div').css('display', 'none');
		$('#excel_add_card').removeClass();
		finedo.getFileControl('uploaddiv').reset(false);
    });
    
    $('#excel_add_card').click(function(e) {
    	$('#common_add_div').css('display', 'none');
    	$('#common_add_card').removeClass();
    	
    	$('#excel_add_div').css('display', 'block');
		$('#excel_add_card').attr('class', 'add-link-li');
    });
});

// Web组件初始化 
$(document).ready(function() {
    finedo.getFileControl('photofile');
});
 
// 数据验证
function checkdata() {
   /**
 	* 	通用数据验证
 	* 	label  		名称
	*	datatype 	数据类型  string email phone url date datetime time number digits 
	*	minlength 	最小长度
	*	maxlength 	最大长度
	*	required 	是否必填 true/false
	*/
	var result=finedo.validate({
		"phoneno":{label:"手机号码", datatype:"phone", maxlength:30, required:false},
		"email":{label:"邮箱", datatype:"email", maxlength:30, required:false}		
	});
	
	return result;
}

// 普通新建
function dosubmit() {
	if(!checkdata()) 
		return;

	var form = $("#ajaxForm");
	var options = {     
        url:	   form.attr("action"),
        success:   submitcallback,
        type:      'POST',
        dataType:  "json",
	    clearForm: true
    };
	finedo.message.showWaiting();
	form.ajaxSubmit(options);
}

function submitcallback(jsondata){
	finedo.message.hideWaiting();
	finedo.message.info(jsondata.resultdesc, "更新用户信息");
}

function dosavepwd() {

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
		"requestid":$.trim($("#requestid").val()),
		"opcode":'modifypasswd',
		"sessionid":'${sessionid }',
		"verifycode":$.trim($("#verifycode").val())
	};
	var form = $("#ajaxPassWordForm");
	var action = form.attr("action")+"?"+$.param(reqdata);
	finedo.action.doCommand(action,submitcallback);
}
function submitcallback(jsondata){
	finedo.message.hideWaiting();
	finedo.message.info(jsondata.resultdesc, "密码修改");
	$("#verifycodebtn").trigger("click");
}
function changeImage(obj){
	var url = $(obj).attr("src");
	var date = new Date();
	url = replaceUrl(url, "time", date.getTime());
	$(obj).attr("src",url);
}
//Url字符串替换
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
</script>
</head>

<body>
<div>
	<div class="add-common-head">
    	<div class="add-common-name-add">个人信息<br/>
            <ul>
            	<li id="common_add_card" class="add-link-li">用户信息设置</li> 
            	<li>|</li>
                <li id="excel_add_card">密码设置</li>
            </ul>
        </div>
    </div>
    
    <form method="post" action="${ctx }/finedo/config/modifyproperty" id="ajaxForm" name="ajaxForm">
    <div id="common_add_div" >
    	<div class="finedo-nav-title">基本信息(不可编辑)</div>
    	
	   	<ul class="finedo-ul">
			<li>
				<span class="finedo-label-title">用户账号</span>
				<span class="finedo-label-info">${sessionScope.LOGINDOMAIN_KEY.sysuser.usercode}</span>
			</li>
			
			<li>
				<span class="finedo-label-title">用户姓名</span>
				<span class="finedo-label-info">${sessionScope.LOGINDOMAIN_KEY.sysuser.personname}</span>
			</li>
			
			<li>
				<span class="finedo-label-title">生效日期</span>
				<span class="finedo-label-info">${sessionScope.LOGINDOMAIN_KEY.sysuser.effdate}</span>
			</li>
			<li>
				<span class="finedo-label-title">失效日期</span>
				<span class="finedo-label-info">${sessionScope.LOGINDOMAIN_KEY.sysuser.expdate}</span>
			</li>
			<li>
				<span class="finedo-label-title">基本岗位角色</span>
				<span class="finedo-label-info">${sessionScope.LOGINDOMAIN_KEY.stdrole.rolename }</span>
			</li>
			
			<c:set value="" var="rolenames"></c:set>
		    <c:forEach items="${sessionScope.LOGINDOMAIN_KEY.otherrolelist}" var="rolell">
		   		<c:if test="${!empty rolenames}"><c:set value="${rolenames},${rolell.rolename }" var="rolenames"></c:set></c:if>
		    	<c:if test="${empty rolenames}"><c:set value="${rolell.rolename }" var="rolenames"></c:set></c:if>
		    </c:forEach>

			<li>
				<span class="finedo-label-title">兼任岗位角色</span>
				<span class="finedo-label-info">${rolenames }</span>
			</li>
			<li>
				<span class="finedo-label-title">状态</span>
				<span class="finedo-label-info">${sessionScope.LOGINDOMAIN_KEY.sysuser.state}</span>
			</li>
		</ul>
		
		<div class="finedo-nav-title">个性化信息(可编辑)</div>
		<ul class="finedo-ul">
			<li>
				<span class="finedo-label-title">性别</span>
				
				<c:set value="男" var="gender"></c:set>
		    	<c:if test="${!empty sessionScope.LOGINDOMAIN_KEY.sysuser.gender}">
		    		<c:set value="${sessionScope.LOGINDOMAIN_KEY.sysuser.gender}" var="gender"></c:set>
		    	</c:if>
				<fsdp:radio datasource="性别" id="gender" selectedvalue="${gender}"></fsdp:radio>
			</li>
			
			<li>
				<span class="finedo-label-title">手机号码</span>
				<fsdp:text id="phoneno" value="${sessionScope.LOGINDOMAIN_KEY.sysuser.phoneno}"></fsdp:text>
			</li>
			
			<li>
				<span class="finedo-label-title">邮箱</span>
				<fsdp:text id="email" value="${sessionScope.LOGINDOMAIN_KEY.sysuser.email}"></fsdp:text></td>
			</li>
			
			<li>
				<span class="finedo-label-title">邮编</span>
				<fsdp:text id="postcode" value="${sessionScope.LOGINDOMAIN_KEY.sysuser.postcode}"></fsdp:text>
			</li>
			
			<li>
				<span class="finedo-label-title">地址</span>
				<fsdp:textarea id="address">${sessionScope.LOGINDOMAIN_KEY.sysuser.address}</fsdp:textarea>				
			</li>
        </ul>
        
        <div class="finedo-nav-title">上传头像(.img,.png,.gif,.jpg,.jpeg)</div>
       	<ul class="finedo-ul">
			<li>
				<input type="text" id="photofile" name="photofile" filter=".img,.png,.gif,.jpg,.jpeg" multiupload="false" value="${sessionScope.LOGINDOMAIN_KEY.sysuser.photofile}">
			</li>
		</ul>
		
	    <ul>
	    	<li class="add-center"><input type="button" class="finedo-button" value="提    交" onClick="dosubmit()" ></li>
	    </ul>
    </div>
    </form>
    
    <div id="excel_add_div" style="display:none">
    	<form method="post" action="${ctx }/finedo/config/modifypassword" id="ajaxPassWordForm" name="ajaxPassWordForm">
    	<input type="hidden" id="requestid" name="requestid" value="${jsessionid }">
   		<div class="finedo-nav-title">密码设置</div>
		<ul class="finedo-ul">
			<li>
				<span class="finedo-label-title"><font color=red>*</font>原密码</span>
				<fsdp:password id="lastbptime" hint="输入原密码"></fsdp:password>
			</li>			
				  
			<li>
				<span class="finedo-label-title"><font color=red>*</font>新密码</span>
				<fsdp:password id="lastlptime" hint="至少 8位字符，必须包含大小写英文字母、数字、特殊符号"></fsdp:password>
			</li>
			
			<li>
				<span class="finedo-label-title"><font color=red>*</font>确认密码</span>
				<fsdp:password id="loginpasswd" hint="再输入一次密码，并请记住该密码"></fsdp:password>
			</li>
		<li>
			<span class="finedo-label-title"><font color=red>*</font>验证码</span>
			<fsdp:text id="verifycode"></fsdp:text>
	        <img src="${ctx}/finedo/oper/graphicscode?opcode=modifypasswd&sessionid=${sessionid }" id="verifycodebtn" onclick="changeImage(this)" title="点击刷新验证码" width="100" height="22" style="vertical-align: middle;margin-left:2px;cursor: pointer;"/>
		</li>
        </ul>
        </form>
        
		<ul>
    		<li class="add-center"><input type="button" class="finedo-button" value="提    交" onclick="dosavepwd();"></li>
		</ul>
    </div>
</div>
</body>
</html>
