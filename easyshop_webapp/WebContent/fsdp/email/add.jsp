<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>发送邮件</title>
${style_css }
${jquery_js }
${easyui_js }
${finedo_js }
${validator_js }
${ueditor_js }
${datepicker_js }
</head>
<body class="easyui-layout">
<div region="center" style="padding:5px;" border="false">
  <div class="easyui-panel" title="当前位置：邮件管理 &gt; 发送邮件" style="width:auto;padding:10px;" fit="true">
	<form method="post" action="${ctx }/finedo/email/addEmail" id="ajaxForm" >
		<input type="hidden" id="attachment" name="attachment"/>	
		<jsp:include page="/fsdp/jsp/email/_common.jsp"></jsp:include>
	</form>
	<form method="post" action="${ctx }/finedo/file/upload" id="uploadForm" name="uploadForm" enctype="multipart/form-data">	
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="input-table">
			<tr>
				<th width="100">附件：</th>
				<td>
					<fsdp:file id="attachment1" name="attachment1"></fsdp:file>
				</td>
			</tr>
			<tr>
				<th>附件：</th>
				<td>
					<fsdp:file id="attachment2" name="attachment2"></fsdp:file>
				</td>
			</tr>
			<tr>
				<th>附件：</th>
				<td>
					<fsdp:file id="attachment3" name="attachment3"></fsdp:file>
				</td>
			</tr>
		</table>
	</form>
  </div>
</div>  
<div data-options="region:'south',border:false" style="text-align:right;padding:5px;">  
    <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="javascript:uploadAttachment()">发送</a>   
</div>
<script type="text/javascript">
var ue = UE.getEditor('editor');
function uploadAttachment(){
	var form = $("#ajaxForm");
	if (Validator.Validate(form[0], 4)) {
		$("#emailcontent").val(UE.getEditor('editor').getContent());
		if($.trim($("#emailcontent").val()) == ''){
			message('提示', '邮件正文不能为空！', 'warning');
			return;
		}
		var options = {
			success: uploadcallback,  
	        type: "post",        
	        dataType: "json"
	    };
		FINEDO.Mode.create();
		$("#uploadForm").ajaxSubmit(options);
	}
}
function uploadcallback(json){
	if(json.resultcode != FINEDO.RESULTCODE.success){
		FINEDO.Mode.destroy();
		message('提示', json.resultdesc, 'error');
		return;
	}
	var flist = "";
	for(var i = 0; i < json.object.faillist.length; i++){
		if(i > 0)
			flist += ",";
		flist += json.object.faillist[i].resultdesc;
	}
	$("#attachment").val(flist);
	save();
}

function save() {
	var form = $("#ajaxForm");
	var options = {
		url : form.attr("action"),
		success : callback,
		type : 'POST',
		dataType : "json",
		clearForm : false
	};
	form.ajaxSubmit(options);
}
function callback(json) {
	FINEDO.Mode.destroy();
	message('提示', json.resultdesc);
	if(json.resultcode == FINEDO.RESULTCODE.success){
		$("#ajaxForm").clearForm();
		$("#uploadForm").clearForm();
	}
}
</script>
</body>
</html>
