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
    	<div class="add-common-name">用户详细信息<br/>
            <ul>
            	<li class="add-link-li">全部</li> 
            </ul>
        </div>
    </div>
    
   	<div class="finedo-nav-title">基本信息</div> 
	<ul class="finedo-ul">
		<li>
			<span class="finedo-label-title">用户账号</span>
			<span class="finedo-label-info" id="usercode"></span>
		</li>
		
       	<li>
            <span class="finedo-label-title">用户姓名</span>
            <span class="finedo-label-info" id="personname"></span>
       	</li>
          	
        <li>
            <span class="finedo-label-title">生效日期</span>
            <span class="finedo-label-info" id="effdate"></span>
		</li>
          	
      	<li>
            <span class="finedo-label-title">失效日期</span>
            <span class="finedo-label-info" id="expdate"></span>
      	</li>
          	
		<li>
            <span class="finedo-label-title">性别</span>
            <span class="finedo-label-info" id="gender"></span>
		</li>
			 				
       	<li>
            <span class="finedo-label-title">用户状态</span>
            <span class="finedo-label-info" id="state"></span>
       	</li>
		
		<li>
            <span class="finedo-label-title">手机号码</span>
            <span class="finedo-label-info" id="phoneno"></span>
		</li>
          	
        <li>
            <span class="finedo-label-title">邮箱</span>
            <span class="finedo-label-info" id="email"></span>
		</li>
          	
       	<li>
            <span class="finedo-label-title">地址</span>
            <span class="finedo-label-info" id="address"></span>
       	</li>
          	
		<li>
            <span class="finedo-label-title">备注</span>
            <span class="finedo-label-info" id="remark"></span>
		</li>
	</ul>
	
	<div class="finedo-nav-title">岗位角色信息</div> 
	<ul class="finedo-ul">
		<li>
            <span class="finedo-label-title">基本岗位角色</span>
            <span class="finedo-label-info" id="rolename"></span>
		</li>
          	
         <li>
            <span class="finedo-label-title">兼任岗位角色</span>
            <span class="finedo-label-info" id="rolenames"></span>
         </li>
	</ul>
</div>
<script language="javascript">
var userdetail={
    initdetail:function(){
        finedo.action.ajax({
            "url":"../../finedo/user/queryuserbyid",
            "data":{"userid":finedo.fn.getParameter("userid")},
            "callback":function(retdata){
                if(retdata.fail){
                    finedo.message.error(retdata.resultdesc);
                    return;
                }
                if(finedo.fn.isnon(retdata.object.datalist)){
                    return;
                }
                var userinfo = retdata.object.datalist[0];
                $("#usercode").html(userinfo.user.usercode);
                $("#personname").html(userinfo.user.personname);
                $("#effdate").html(userinfo.user.effdate);
                $("#expdate").html(userinfo.user.expdate);
                $("#gender").html(userinfo.user.gender);
                $("#state").html(userinfo.user.state);
                $("#phoneno").html(userinfo.user.phoneno);
                $("#email").html(userinfo.user.email);
                $("#address").html(userinfo.user.address);
                $("#remark").html(userinfo.user.remark);
                $("#rolename").html(userinfo.stdrole.rolename);
                var otherrolelist = userinfo.otherrolelist;
                var otherrolenames = "";
                for(var i = 0; i < otherrolelist.length; i++){
                    if(otherrolenames == ""){
                        otherrolenames += ",";
                    }
                    otherrolenames += otherrolelist[i].rolename;
                }
                $("#rolenames").html(otherrolenames);
            }
        });
    }
};
</script>
<script type='text/javascript' src='../../resource/js/lazyload.js'></script>
<script language="javascript">
LazyLoad.css([
    '../../resource/themes/default/style.css',
    '../../resource/js/finedoui/commonui/themes/commonui.css'
    ]);
LazyLoad.js([
    '../../resource/js/jquery/jquery-1.11.0.js',
    '../../resource/js/jquery/jquery.form.js',
    '../../resource/js/finedoui/base/finedo.core.js',
    '../../resource/js/finedoui/commonui/finedo.commonui.js',
    '../../resource/js/finedoui/dialog/finedo.dialog.js'
    ], function() {
    userdetail.initdetail();
});
</script>
</body>
</html>
