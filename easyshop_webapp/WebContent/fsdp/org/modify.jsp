<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs2.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>修改组织机构</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>
<body>
<div>
	<div class="add-common-head">
    	<div class="add-common-name-add">修改组织机构信息<br/>
            <ul>
            	<li id="common_add_card" class="add-link-li">全部</li>
            </ul>
        </div>
        <input type="button" class="finedo-button-blue" style="float:right" value="提交" onclick="orgmodify.dosubmit();">
    </div>
    
    <form method="post" id="ajaxForm" name="ajaxForm">
    <input type="hidden" id="orgid" name="orgid">
    <div id="common_add_div" >
    	<div class="finedo-nav-title">基本信息</div>
	   	<ul class="finedo-ul">
			<li>
				<input type="hidden" value="" name="parentorgid" id="parentorgid">
				<span class="finedo-label-title"><font color=red>*</font>上级组织</span>
				<input class="finedo-text" type="text" id="parentorgname" name="parentorgname" value="" onclick="orgmodify.chooseParentOrg()">
			</li>
			<li>
				<span class="finedo-label-title"><font color=red>*</font>机构类型</span>
				<input type="text" id="orgtype"></input>
			</li>
			<li>
				<span class="finedo-label-title"><font color=red>*</font>机构名称</span>
				<input class="finedo-text" type="text" id="orgname" name="orgname" value="" maxlength="100">
			</li>
			<li>
				<span class="finedo-label-title">联系人</span>
				<input class="finedo-text" type="text" id="linkman" name="linkman" value="" maxlength="50">
			</li>
			<li>
				<span class="finedo-label-title">联系电话</span>
				<input class="finedo-text" type="text" id="phoneno" name="phoneno" value="" maxlength="20">
			</li>
			<li>
				<span class="finedo-label-title">联系地址</span>
				<input class="finedo-text" type="text" id="address" name="address" value="" maxlength="500">
			</li>
			<li>
				<span class="finedo-label-title">机构介绍</span>
				<input class="finedo-text" type="text" id="orgdesc" name="orgdesc" value="" maxlength="500">
			</li>
			<li>
				<span class="finedo-label-title">备注</span>
				<input class="finedo-text" type="text" id="remark" name="remark" value="" maxlength="500">
			</li>
		</ul>
	    <ul>
	    	<li class="add-center"><input type="button" class="finedo-button" value="提    交" onClick="orgmodify.dosubmit()" ></li>
	    </ul>
    </div>
    </form>
</div>
<script language="javascript">
var orgmodify={
    orgid:"",
    initorg:function(){
        orgmodify.orgid = finedo.fn.getParameter("orgid");
        $("#orgid").val(orgmodify.orgid);
        finedo.action.ajax({
            url:'../../finedo/organization/queryOrgById?orgid='+orgmodify.orgid,
            callback:function(jsondata){
                if(jsondata.fail){
                    finedo.message.error(jsondata.resultdesc);
                    return;
                }
                var orgobj = jsondata.object;
                $("#parentorgid").val(orgobj.parentorgid);
                $("#parentorgname").val(orgobj.parentorgname);
                $("#orgname").val(orgobj.orgname);
                $("#linkman").val(orgobj.linkman);
                $("#phoneno").val(orgobj.phoneno);
                $("#address").val(orgobj.address);
                $("#orgdesc").val(orgobj.orgdesc);
                $("#remark").val(orgobj.remark);
                $("#orgtype_name").html(orgobj.orgtype);
                finedo.getselect("orgtype", {
                    datasource:"组织机构类型",
                    value:orgobj.orgtype,
                    ctx:"../.."
                });
            }
        });
    },
    chooseParentOrg:function(){
        finedo.dialog.show({'selecttype':'single',
            width:300,
            'title':'双击选择',
            'loadtype':'iframe',
            'url':'../../fsdp/org/choose.jsp?selecttype=single',
            callback:function(data){
                $("#parentorgid").val(data.id);
                $("#parentorgname").val(data.name);
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
         var result=finedo.validate({
             "parentorgname":{label:"上级组织", datatype:"string", maxlength:100, required:true},
             "orgtype":{label:"机构类型", datatype:"string", maxlength:20, required:true},
             "orgname":{label:"机构名称", datatype:"string", maxlength:100, required:true},
             "linkman":{label:"联系人", datatype:"string", maxlength:50, required:false},
             "phoneno":{label:"联系电话", datatype:"phone", maxlength:20, required:false},
             "address":{label:"联系地址", datatype:"string", maxlength:500, required:false},
             "orgdesc":{label:"机构介绍", datatype:"string", maxlength:500, required:false},
             "remark":{label:"备注", datatype:"string", maxlength:500, required:false}
         }, true);
         return result;
     },
     dosubmit:function() {
         if(!orgmodify.checkdata()) 
             return;
         finedo.action.ajaxForm({
             form:"ajaxForm",
             url:"../../finedo/organization/modifyOrg",
             callback:function(jsondata){
                 if(jsondata.fail){
                     finedo.message.error(jsondata.resultdesc);
                     return;
                 }
                 finedo.message.tip(jsondata.resultdesc, function(){
                     finedo.dialog.closeDialog()
                 });
             }
         });
     }
}
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
    '../../resource/js/finedoui/date/WdatePicker.js'
    ], function() {
    orgmodify.initorg();
});
</script>
</body>
</html>
