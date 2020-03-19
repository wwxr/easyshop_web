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
    	<div class="add-common-name-add">新建角色信息<br/>
            <ul>
            	<li id="common_add_card" class="add-link-li">基本信息</li> 
            	<li>|</li>
                <li id="excel_add_card">权限信息</li>
            </ul>
        </div>
        <input type="button" class="finedo-button-blue" style="float:right" value="提交" onclick="modifyrole.dosubmit();">
    </div>
    
    <form method="post" id="ajaxForm" name="ajaxForm">
    <input type="hidden" id="roleid" name="roleid" value="">
    <input type="hidden" id="permissionid" name="permissionid">
    <div id="common_add_div" >
    	<div class="finedo-nav-title">基本信息</div>
	   	<table class="finedo-table">
		    <tr>
		        <td class="finedo-label-title">角色类型：</td>
		        <td>
		        	<input type="text" id="roletype"></input>
		        </td>
		        <td class="finedo-label-title">组织节点：</td>
		        <td>
		        	<input type="hidden" value="" name="orgid" id="orgid">
		    		<input class="finedo-text" type="text" id="orgname" name="orgname" onclick="modifyrole.chooseOrg()">
		        </td>
		    </tr>
		    <tr>
		        <td class="finedo-label-title"><font color=red>*</font>角色名称：</td>
		        <td>
		        	<input class="finedo-text" type="text" id="rolename" name="rolename" maxlength="100">
		        </td>
		        <td class="finedo-label-title"><font color=red>*</font>限定人数：</td>
		        <td>
		        	<input class="finedo-text" type="text" id="usercount" name="usercount" maxlength="6" onkeypress="modifyrole.checkInteger(this)" onblur="modifyrole.checkInteger(this)">
		        </td>
		    </tr>
		    <tr>
		        <td class="finedo-label-title"><font color=red>*</font>角色级别：</td>
		        <td>
		        	<input type="text" id="rolelvl"></input>
		        </td>
		        <td class="finedo-label-title"><font color=red>*</font>状态：</td>
		        <td>
		        	<input type="text" id="state"></input>
		        </td>
		    </tr>
		    <tr>
		        <td class="finedo-label-title">职责描述：</td>
		        <td colspan="3">
		        	<input class="finedo-text" type="text" id="dutydesc" name="dutydesc" style="width:90%;">
		        </td>
		    </tr>
		    <tr>
		        <td class="finedo-label-title">备注：</td>
		        <td colspan="3">
		        	<input class="finedo-text" type="text" id="remark" name="remark" style="width:90%;">
		        </td>
		    </tr>
		</table>
	</div>    
    <div id="excel_add_div" style="display:none;width:95%;position: fixed; top:60px;left:10px; bottom:10px; overflow-y:auto; overflow-x:auto;">
   		<ul id="treediv" class="fdtree" style="margin-left:5px;" ></ul>
    </div>
    </form>
</div>
<script language="javascript">
var modifyrole={
    initrole:function(){
        var roleid = finedo.fn.getParameter("roleid");
        $("#roleid").val(roleid);
        $('#common_add_card').click(function(e) {
            $('#common_add_div').css('display', 'block');
            $('#common_add_card').attr('class', 'add-link-li');
            
            $('#excel_add_div').css('display', 'none');
            $('#excel_add_card').removeClass();
        });
        
        $('#excel_add_card').click(function(e) {
            $('#common_add_div').css('display', 'none');
            $('#common_add_card').removeClass();
            
            $('#excel_add_div').css('display', 'block');
            $('#excel_add_card').attr('class', 'add-link-li');
        });
        
        $('label[for="roletype"]').click(function(e) {
            var roletypeval = $(this).attr('value');
            if(roletypeval == '组织岗位角色'){
                $("#orgname").attr("disabled",false);
            }else{
                $("#orgid").val('');
                $("#orgname").val('');
                $("#orgname").attr("disabled",true);
            }
        });
        //初始化角色权限树
        finedo.action.ajax({
            url:"../../finedo/permission/getpermissiontree",
            data:{'roleid':roleid},
            callback:function(jsondata){
                if(jsondata.fail){
                    finedo.message.error(jsondata.resultdesc);
                    return;
                }
                finedo.getTree('treediv',{
                    simple:true,
                    selecttype:'multi',
                    nodes:jsondata.object
                });
            }
        });
        //查询角色基本信息
        finedo.action.ajax({
            url:"../../finedo/role/queryId",
            data:{'roleid':roleid},
            callback:function(jsondata){
	            if(jsondata.fail){
	                finedo.message.error(jsondata.resultdesc);
	                return;
	            }
	            var roledata = jsondata.object;
	            $("#rolename").val(roledata.rolename);
	            $("#orgid").val(roledata.orgid);
	            $("#orgname").val(roledata.orgname);
	            $("#usercount").val(roledata.usercount);
	            $("#dutydesc").val(roledata.dutydesc);
	            $("#dutydesc").val(roledata.dutydesc);
	
	            finedo.getradio("roletype", {
	                datasource:"岗位角色类型",
	                value:roledata.roletype,
	                ctx:"../.."
	            });
	            finedo.getradio("rolelvl", {
	                datasource:"岗位角色级别",
	                value:roledata.rolelvl,
	                ctx:"../.."
	            });
	            finedo.getradio("state", {
	                datasource:"岗位角色状态",
	                value:roledata.state,
	                ctx:"../.."
	            });
            }
        });
    },
    checkdata:function() {
        /**
         *   通用数据验证
         *   label       名称
         *   datatype    数据类型  string email phone url date datetime time number digits 
         *   minlength   最小长度
         *   maxlength   最大长度
         *   required    是否必填 true/false
         */
         if($("#roletype").val() == '组织岗位角色'){
             if($("#orgid").val() == '请选择组织机构!'){
                 finedo.message.warning();
                 return false;
             }
         }
         var result=finedo.validate({
             "rolename":{label:"角色名称", datatype:"string", maxlength:100, required:true},
             "usercount":{label:"限定人数", datatype:"number", required:true}
         }, true);
         if(!result){
             return result;
         }
         var selecteditems = finedo.getTree('treediv').getselecteditems();
         var s = '';
         for(var i=0; i<selecteditems.length; i++){
             if(!selecteditems[i].orgnode){
                 continue;
             }
             if (s != '') s += ',';
             s += selecteditems[i].orgnode;
         }
         $("#permissionid").val(s);
         return result;
     },
     dosubmit:function() {
         if(!modifyrole.checkdata()) 
             return;
         var form = $("#ajaxForm");
         var options = {     
             url:       "../../finedo/role/modifyRole",
             success:   modifyrole.submitcallback,
             type:      'POST',
             dataType:  "json",
             clearForm: false
         };
         finedo.message.showWaiting();
         form.ajaxSubmit(options);
     },
     submitcallback:function(jsondata){
         finedo.message.hideWaiting();
         finedo.message.info(jsondata.resultdesc);
     },
     checkInteger:function(input){
         var obj = $(input);
         obj.val(obj.val().replace(/[^\d.]/g,""));//清除“数字”和“.”以外的字符   
         obj.val(obj.val().replace(/^\./g,""));//验证第一个字符是数字而不是.   
         obj.val(obj.val().replace(/\.{2,}/g,"."));//只保留第一个. 清除多余的.  
         obj.val(obj.val().replace(".","$#$").replace(/\./g,"").replace("$#$","."));
     },
     chooseOrg:function(){
         finedo.dialog.show({'selecttype':'single',
             width:300,
             'title':'双击选择',
             'loadtype':'iframe',
             'url':'../../fsdp/org/choose.jsp?selecttype=single',
             callback:function(data){
                 $("#orgid").val(data.id);
                 $("#orgname").val(data.name);
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
    '../../resource/js/finedoui/tree/themes/style.css'
    ]);
LazyLoad.js([
    '../../resource/js/jquery/jquery-1.11.0.js',
    '../../resource/js/jquery/jquery.form.js',
    '../../resource/js/finedoui/base/finedo.core.js',
    '../../resource/js/finedoui/commonui/finedo.commonui.js',
    '../../resource/js/finedoui/dialog/finedo.dialog.js',
    '../../resource/js/finedoui/tree/finedo.tree.js'
    ], function() {
    modifyrole.initrole();
});
</script>
</body>
</html>
