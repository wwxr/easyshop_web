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
    	<div class="add-common-name-add">修改用户信息<br/>
            <ul>
            	<li id="common_add_card" class="add-link-li">全部</li>
            </ul>
        </div>
        <input type="button" class="finedo-button-blue" style="float:right;" value="提交" onclick="usermodify.doNext();">
    </div>
    
    <form method="post" id="ajaxForm" name="ajaxForm">
    <input type="hidden" id="userid" name="userid" value=""/>
    <input type="hidden" id="personid" name="personid" value=""/>

    <div class="finedo-nav-title">基本信息</div>
	<ul class="finedo-ul">
		<li>
			<span class="finedo-label-title"><font color=red>*</font>用户账号</span>
                <input class="finedo-text" type="text" onfocus="finedo.showhintinfo('usercode');" id="usercode" name="usercode" value="">
                <span for="usercode" class="finedo-hint-info">最大30个字符，支持大小写英文、数字、下划线格式</span>
                <span for="usercode" class="finedo-hint-error"></span>
                <span for="usercode" class="finedo-hint-right"></span>
		</li>
        <li>
            <span class="finedo-label-title"><font color=red>*</font>用户姓名</span>
            <input class="finedo-text" type="text" onfocus="finedo.showhintinfo('personname');" id="personname" name="personname" value="">
            <span for="personname" class="finedo-hint-info"></span>
            <span for="personname" class="finedo-hint-error"></span>
            <span for="personname" class="finedo-hint-right"></span>
        </li>
        	
        <li>
            <span class="finedo-label-title"><font color=red>*</font>生效日期</span>
            <input class="finedo-date" type="text" value="" id="effdate" name="effdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
        </li>
        	
        <li>
            <span class="finedo-label-title"><font color=red>*</font>失效日期</span>
            <input class="finedo-date" type="text" value="" id="expdate" name="expdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
        </li>
          	            	
		<li>
			<span class="finedo-label-title"><font color=red>*</font>性别</span>
            <input type="text" id="gender"></input>
		</li>
			 				
        <li>
            <span class="finedo-label-title"><font color=red>*</font>用户状态</span>
            <input type="text" id="state"></input>
        </li>
		
		<li>
			<span class="finedo-label-title"><font color=red>*</font>手机号码</span>
            <input class="finedo-text" type="text" onfocus="finedo.showhintinfo('phoneno');" id="phoneno" name="phoneno" value="">
            <span for="phoneno" class="finedo-hint-info">11位手机号码，支持移动、电信、联通号码</span>
            <span for="phoneno" class="finedo-hint-error"></span>
            <span for="phoneno" class="finedo-hint-right"></span>
		</li>
          	
        <li>
            <span class="finedo-label-title">邮箱</span>
            <input class="finedo-text" type="text" onfocus="finedo.showhintinfo('email');" id="email" name="email" value="">
            <span for="email" class="finedo-hint-info">格式:xx@域名，如:test@finedo.cn</span>
            <span for="email" class="finedo-hint-error"></span>
            <span for="email" class="finedo-hint-right"></span>
        </li>
          	
        <li>
            <span class="finedo-label-title">地址</span>
            <input class="finedo-text" type="text" onfocus="finedo.showhintinfo('address');" id="address" name="address" value="" style="width:600px">
            <span for="address" class="finedo-hint-info"></span>
            <span for="address" class="finedo-hint-error"></span>
            <span for="address" class="finedo-hint-right"></span>
        </li>
		
		<li>
			<span class="finedo-label-title">备注</span>
            <input class="finedo-text" type="text" onfocus="finedo.showhintinfo('remark');" id="remark" name="remark" value="" style="width:600px">
            <span for="remark" class="finedo-hint-info"></span>
            <span for="remark" class="finedo-hint-error"></span>
            <span for="remark" class="finedo-hint-right"></span>
		</li>
	</ul>
	
	<div class="finedo-nav-title">岗位角色设置</div>			
	<ul class="finedo-ul">
        <li>
                <span class="finedo-label-title"><font color=red>*</font>基本岗位角色</span>
                <input type="hidden" id="roleid" name="roleid">
                <input class="finedo-text" type="text" onfocus="finedo.showhintinfo('roleid_name');" id="roleid_name" name="roleid_name" value="" onclick="usermodify.doChooseJbrole()">
                <span for="roleid_name" class="finedo-hint-info"></span>
                <span for="roleid_name" class="finedo-hint-error"></span>
                <span for="roleid_name" class="finedo-hint-right"></span>
            </li>
            
            <li>
                <span class="finedo-label-title">兼任岗位角色</span>
                <input type="hidden" id="roleids" name="roleids">
                <input class="finedo-text" type="text" onfocus="finedo.showhintinfo('roleids_name');" id="roleids_name" name="roleids_name" value="" onclick="usermodify.doChooseJzrole()">
                <span for="roleids_name" class="finedo-hint-info"></span>
                <span for="roleids_name" class="finedo-hint-error"></span>
                <span for="roleids_name" class="finedo-hint-right"></span>
            </li>
    </ul>
    <ul>
    	<li class="add-center"><input type="button" class="finedo-button" value="提    交" onClick="usermodify.dosubmit()" ></li>
    </ul>
    </form>
</div>
<script>
var usermodify={
    inituser:function(){
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
                $("#userid").val(userinfo.user.userid);
                $("#personid").val(userinfo.user.personid);
                $("#usercode").val(userinfo.user.usercode);
                $("#personname").val(userinfo.user.personname);
                $("#effdate").val(userinfo.user.effdate);
                $("#expdate").val(userinfo.user.expdate);
                finedo.getradio("gender", {
                    datasource:"性别",
                    value:userinfo.user.gender,
                    ctx:"../.."
                });
                
                finedo.getradio("state", {
                    datasource:"用户状态",
                    value:userinfo.user.state,
                    ctx:"../.."
                });
                $("#phoneno").val(userinfo.user.phoneno);
                $("#email").val(userinfo.user.email);
                $("#address").val(userinfo.user.address);
                $("#remark").val(userinfo.user.remark);
                $("#roleid_name").val(userinfo.stdrole.rolename);
                $("#roleid").val(userinfo.stdrole.roleid);
                
                var otherrolelist = userinfo.otherrolelist;
                var otherrolenames = "";
                var otherroleids = "";
                for(var i = 0; i < otherrolelist.length; i++){
                    if(otherrolenames == ""){
                        otherrolenames += ",";
                        otherroleids += ",";
                    }
                    otherrolenames += otherrolelist[i].rolename;
                    otherroleids += otherrolelist[i].roleid;
                }
                $("#roleids_name").val(otherrolenames);
                $("#roleids").val(otherroleids);
            }
        });
    },
    checkdata:function(){
        /**
         *   通用数据验证
         *   label       名称
         *   datatype    数据类型  string email phone url date datetime time number digits 
         *   minlength   最小长度
         *   maxlength   最大长度
         *   required    是否必填 true/false
         */
         var result=finedo.validate({
             "usercode":{label:"用户账号", datatype:"string", maxlength:30, required:true},
             "personname":{label:"用户姓名", datatype:"string", maxlength:50, required:true},
             "effdate":{label:"生效日期", datatype:"date", required:true},
             "expdate":{label:"失效日期", datatype:"date", required:true},
             "phoneno":{label:"手机号码", datatype:"phone", required:true},
             "email":{label:"邮箱", datatype:"email", required:false},
             "address":{label:"地址", datatype:"string", maxlength:200, required:false},
             "remark":{label:"备注", datatype:"string", maxlength:200, required:false},
                     
             "roleid":{label:"基本岗位角色", datatype:"string", required:true},
             "roleids":{label:"兼任岗位角色", datatype:"string", required:false}
         });
         
         // 自定义数据验证
         var effdate=$('#effdate').val();
         var expdate=$('#expdate').val();
         if(expdate < effdate) {
             finedo.showhinterror('expdate', '失效日期不能小于生效日期');
             result=false;
         }
             
         // 兼任岗位角色不能包含基本岗位角色
         var roleid=$('#roleid').val();
         var roleids=$('#roleids').val();
         if(roleids.length > 0) {
             if(roleids.indexOf(roleid) >= 0) {
                 finedo.showhinterror('roleids', '兼任岗位角色不能包含基本岗位角色');
                 result=false;
             }
         }
         
         return result;
    },
    doNext:function(){
        usermodify.dosubmit();
    },
    dosubmit:function(){
        if(!usermodify.checkdata()) 
            return;

        var aeskey = CryptoJS.enc.Utf8.parse(aesvikey);
        var aesiv = CryptoJS.enc.Utf8.parse(aesvikey);
        var phonenoval = $("#phoneno").val();
        if(phonenoval){
            phonenoval = CryptoJS.AES.encrypt(phonenoval,aeskey,{iv:aesiv,mode:CryptoJS.mode.CBC,padding:CryptoJS.pad.ZeroPadding});
            $("#phoneno").val($.base64.btoa(phonenoval));
        }
        var emailval = $("#email").val();
        if(phonenoval){
            emailval = CryptoJS.AES.encrypt(emailval,aeskey,{iv:aesiv,mode:CryptoJS.mode.CBC,padding:CryptoJS.pad.ZeroPadding});
            $("#email").val($.base64.btoa(emailval));
        }
        var form = $("#ajaxForm");
        var options = {     
            url:       '../../finedo/user/modifyUser',
            success:   usermodify.submitcallback,
            type:      'POST',
            dataType:  "json",
            clearForm: false
        };
        finedo.message.showWaiting();
        form.ajaxSubmit(options);
    },
    submitcallback:function(jsondata){
        finedo.message.hideWaiting();
        finedo.message.info(jsondata.resultdesc, "修改用户信息");
    },
    doChooseJbrole:function(){
        finedo.dialog.show({'selecttype':'single',
            width:1000,height:600,
            'title':'选择岗位角色（双击表格行）',
            'loadtype':'iframe',
            'url':'../../fsdp/role/choose.jsp?selecttype=single',
            callback:function(data){
                $("#roleid").val(data[0].roleid);
                $("#roleid_name").val(data[0].rolename);
            }
        });
    },
    doChooseJzrole:function(){
        finedo.dialog.show({'selecttype':'multi',
            width:1000,height:600,
            'title':'选择角色',
            'loadtype':'iframe',
            'url':'../../fsdp/role/choose.jsp?selecttype=multi',
            callback:function(data){
                var roleids='',roleidsname='';
                for(var i = 0; i < data.length; i++){
                    if(i > 0){
                        roleids += ",";
                        roleidsname += ",";
                    }
                    roleids += data[i].roleid;
                    roleidsname += data[i].rolename;
                }
                $("#roleids").val(roleids);
                $("#roleids_name").val(roleidsname);
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
    '../../resource/js/finedoui/dialog/finedo.dialog.js',
    '../../resource/js/finedoui/date/WdatePicker.js',
    '../../resource/js/jquery/jquery.base64.js',
    '../../resource/js/crypto/aes.js',
    '../../resource/js/crypto/pad-zeropadding.js'
    ], function() {
    usermodify.inituser();
});
</script>
</body>
</html>
