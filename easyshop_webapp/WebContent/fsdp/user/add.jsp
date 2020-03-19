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
    	<div class="add-common-name-add">新建用户信息<br/>
            <ul>
            	<li id="common_add_card" class="add-link-li">普通新建</li> 
            	<li>|</li>
                <li id="excel_add_card">批量导入</li>
            </ul>
        </div>
        <input type="button" class="finedo-button-blue" style="float:right" value="提交" onclick="useradd.doNext();">
    </div>
    
    <form method="post" id="ajaxForm" name="ajaxForm">
    <div id="common_add_div" >
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
		
		<div class="finedo-nav-title">密码设置</div>
		<ul class="finedo-ul">
			<li>
				<span class="finedo-label-title"><font color=red>*</font>登录密码</span>
				<input class="finedo-text" type="password" onfocus="finedo.showhintinfo('loginpasswd');" id="loginpasswd" name="loginpasswd" value="">
                <span for="loginpasswd" class="finedo-hint-info">6-15位字符，必须包含大小写英文字母、数字、特殊符号</span>
                <span for="loginpasswd" class="finedo-hint-error"></span>
                <span for="loginpasswd" class="finedo-hint-right"></span>
			</li>
			
           	<li>
           		<span class="finedo-label-title"><font color=red>*</font>确认密码</span>
           		<input class="finedo-text" type="password" onfocus="finedo.showhintinfo('loginpasswd2');" id="loginpasswd2" name="loginpasswd2" value="">
           		<span for="loginpasswd2" class="finedo-hint-info">再输入一次密码，并请记住该密码</span>
           		<span for="loginpasswd2" class="finedo-hint-error"></span>
           		<span for="loginpasswd2" class="finedo-hint-right"></span>
           	</li>
        </ul> 
		
		<div class="finedo-nav-title">岗位角色设置</div>
		<ul class="finedo-ul">
			<li>
				<span class="finedo-label-title"><font color=red>*</font>基本岗位角色</span>
				<input type="hidden" id="roleid" name="roleid">
				<input class="finedo-text" type="text" onfocus="finedo.showhintinfo('roleid_name');" id="roleid_name" name="roleid_name" value="" onclick="useradd.doChooseJbrole()">
				<span for="roleid_name" class="finedo-hint-info"></span>
				<span for="roleid_name" class="finedo-hint-error"></span>
				<span for="roleid_name" class="finedo-hint-right"></span>
			</li>
           	
           	<li>
           		<span class="finedo-label-title">兼任岗位角色</span>
				<input type="hidden" id="roleids" name="roleids">
				<input class="finedo-text" type="text" onfocus="finedo.showhintinfo('roleids_name');" id="roleids_name" name="roleids_name" value="" onclick="useradd.doChooseJzrole()">
				<span for="roleids_name" class="finedo-hint-info"></span>
				<span for="roleids_name" class="finedo-hint-error"></span>
				<span for="roleids_name" class="finedo-hint-right"></span>
           	</li>
        </ul>
	    	    
	    <ul>
	    	<li class="add-center"><input type="button" class="finedo-button" value="提    交" onClick="useradd.dosubmit()" ></li>
	    </ul>
    </div>
    </form>
    
    <div id="excel_add_div" style="display:none">
    	<form method="post" id="importForm" name="importForm">
	    	<input type="hidden" id="fileid" name="fileid">
	    </form>
	    
   		<div class="finedo-nav-title">导入Excel</div>
		<ul class="finedo-ul">
			<li>
				<input type="text" id="uploaddiv" name="uploaddiv" filter=".xls,.xlsx" multiupload="false">
			</li>
        </ul>
        
		<ul>
    		<li class="add-center"><input type="button" class="finedo-button" value="提    交" onclick="useradd.doimport();"></li>
		</ul>
	    
	    <div id="importresultdiv" style="display:none">
	    	<div class="finedo-nav-title"><font color=red>导入Excel结果</font></div>
		    <div class="query-common-con">
		    	<ul id="importresultul" class="finedo-ul"></ul>
		    </div>
	    </div>
	    
	    <div class="finedo-nav-title">导入Excel格式说明</div>
		<ul class="finedo-ul">
			<li>
				 <span class="finedo-label-title">模板下载</span><span class="finedo-label-info"><a href="javascript:useradd.downloadExcel()" >用户信息批量导入Excel模板 </a></span>
			</li>
			<li>
				<span class="finedo-label-title">第一列：</span><span class="finedo-label-info">用户账号: 必填, 最大30个字符，支持大小写英文、数字、下划线格式</span>
			</li>
			<li>
				<span class="finedo-label-title">第二列：</span><span class="finedo-label-info">姓名: 必填</span>
			</li>
			<li>
				<span class="finedo-label-title">第三列：</span><span class="finedo-label-info">登录密码: 必填,6-15位字符，必须包含大小写英文字母、数字、特殊符号</span>
			</li>
			<li>
				<span class="finedo-label-title">第四列：</span><span class="finedo-label-info">基本岗位名称: 必填,必须设置一个基本岗位角色，基本岗位角色关联组织节点</span>
			</li>
			<li>
				<span class="finedo-label-title">第五列：</span><span class="finedo-label-info">兼任岗位名称</span>
			</li>
			<li>
				<span class="finedo-label-title">第六列：</span><span class="finedo-label-info">性别: 必填,只能填写:男/女</span>
			</li>
			<li>
				<span class="finedo-label-title">第七列：</span><span class="finedo-label-info">手机号码: 必填,11位手机号码，支持移动、电信、联通号码</span>
			</li>
			<li>
				<span class="finedo-label-title">第八列：</span><span class="finedo-label-info">邮箱: xx@域名，如:test@finedo.cn</span>
			</li>
		</ul>
    </div>
</div>
<script>
var useradd={
    initadd:function(){
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

        finedo.getFileControl('uploaddiv', {
            ctx:"../.."
        });
        
        finedo.getradio("gender", {
            datasource:"性别",
            value:"男",
            ctx:"../.."
        });
        finedo.getradio("state", {
            datasource:"用户状态",
            value:"有效",
            ctx:"../.."
        });
    },
    // 数据验证
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
             
             "loginpasswd":{label:"登录密码", datatype:"string", minlength:6, maxlength:15, required:true},
             "loginpasswd2":{label:"确认密码", datatype:"string", minlength:6, maxlength:15, required:true},
             
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
         
         // 密码必须由 4-16位字母、数字、特殊符号线组成
         var loginpasswd=$('#loginpasswd').val();
         var reg = new RegExp('(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).{6,15}');
         if(!reg.test(loginpasswd)) {
             finedo.showhinterror('loginpasswd', '登录密码必须由 6-15位字母、数字、特殊符号线组成');
             result=false;
         }
         
         var loginpasswd2=$('#loginpasswd2').val();
         if(loginpasswd != loginpasswd2) {
             finedo.showhinterror('loginpasswd2', '确认密码输入不正确，请重新输入');
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
        if($('#common_add_div').css('display') == 'block') {
            useradd.dosubmit();
        }else {
            useradd.doimport();
        }
    },
    // 普通新建
    dosubmit:function(){
        if(!useradd.checkdata()) 
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
        var loginpasswdval = $("#loginpasswd").val();
        if(loginpasswdval){
            loginpasswdval = CryptoJS.AES.encrypt(loginpasswdval,aeskey,{iv:aesiv,mode:CryptoJS.mode.CBC,padding:CryptoJS.pad.ZeroPadding});
            $("#loginpasswd").val($.base64.btoa(loginpasswdval));
        }
        var form = $("#ajaxForm");
        var options = {     
            url:       '../../finedo/user/addUser',
            success:   useradd.submitcallback,
            type:      'POST',
            dataType:  "json",
            clearForm: false
        };
        finedo.message.showWaiting();
        form.ajaxSubmit(options);
    },
    submitcallback:function(jsondata){
        finedo.message.hideWaiting();
        finedo.message.info(jsondata.resultdesc, "新建用户信息");
    },
    downloadExcel:function(){
        window.open('../../fsdp/user/import.xlsx');
    },
    //批量导入
    doimport:function(){
        var fileControl=finedo.getFileControl('uploaddiv');
        var filearr=fileControl.getFileList();
        if(filearr.length != 1) {
            finedo.message.error("未上传Excel文件");
            return;
        }
        $('#fileid').val(filearr[0].fileid);
        
        var form = $("#importForm");
        var options = {     
            url:       '../../finedo/user/importUser',
            success:   useradd.importcallback,
            type:      'POST',
            dataType:  "json",
            clearForm: false
        };
        finedo.message.showWaiting();
        form.ajaxSubmit(options);
    },
    importcallback:function(jsondata){
        finedo.message.hideWaiting();

        $('#importresultdiv').css('display', 'block');
        var resulthtml="<li><span class='finedo-label-title'>导入情况</span><span class='finedo-label-info'><font color=red>" + jsondata.resultdesc + "   总记录数: " + jsondata.object.rowcount + " &nbsp;&nbsp; 成功记录数: " + jsondata.object.successcount + "&nbsp;&nbsp; 失败记录数: " + jsondata.object.failcount + "</font></span></li>";
        var faillist=eval(jsondata.object.faillist);
        for(var i=0; i<faillist.length; i++)  {
            resulthtml += "<li><span class='finedo-label-title'>失败明细</span><span class='finedo-label-info'>" + faillist[i].resultdesc + "</span></li>";
        }
        
        $('#importresultul').html(resulthtml);
    },
    //组织岗位选择
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
    //兼职岗位选择
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
    '../../resource/js/finedoui/dialog/themes/style.css',
    '../../resource/js/finedoui/upload/themes/style.css'
    ]);
LazyLoad.js([
    '../../resource/js/jquery/jquery-1.11.0.js',
    '../../resource/js/jquery/jquery.form.js',
    '../../resource/js/finedoui/base/finedo.core.js',
    '../../resource/js/finedoui/commonui/finedo.commonui.js',
    '../../resource/js/finedoui/dialog/finedo.dialog.js',
    '../../resource/js/finedoui/date/WdatePicker.js',
    '../../resource/js/finedoui/upload/finedo.upload.js',
    '../../resource/js/jquery/jquery.base64.js',
    '../../resource/js/crypto/aes.js',
    '../../resource/js/crypto/pad-zeropadding.js'
    ], function() {
    useradd.initadd();
});
</script>
</body>
</html>
