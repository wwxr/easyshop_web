<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>静态数据管理</title>
${style_css }
${jquery_js }
${easyui_js }
${finedo_js }
${validator_js }
</head>
<body class="easyui-layout">
<div region="center" style="padding:5px;" border="false">
  <div class="easyui-panel" title="当前位置：系统功能 &gt; 静态数据管理 &gt; 导入静态数据" style="width:auto;padding:10px;" fit="true">
	<form method="post" action="${ctx }/finedo/staticdata/importStaticdata" id="ajaxForm" name="ajaxForm" enctype="multipart/form-data">	
		<table width="80%" border="0" cellpadding="0" cellspacing="0" class="input-table">
		  <tr align=left>
		    <th width="20%" class="require">* 选择文件：</th>
		    <td>
		    	<fsdp:file id="userfile" name="userfile" datatype="Require" msg="导入文件不能为空" ></fsdp:file>
		    </td>
		  </tr>
		  <tr>
		  	<th  width="20%">Excel模板文件下载：</th>
		  	<td>
		  		<a href="${ctx}/finedo/file/download?fileid=STATICDATA_IMPORT" >静态数据批量导入Excel模板 </a>
		  	</td>
		  </tr>
		</table>
	</form>
  </div>
</div>  
<div data-options="region:'south',border:false" style="text-align:right;padding:5px;">  
    <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="javascript:importuser()">提交</a>  
   <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="window.history.go(-1)">取消</a>  
</div>

<script type="text/javascript">
function importuser(){
	var form = $("#ajaxForm");
	if(Validator.Validate(form[0], 4)){
		form.submit();
	}
}
</script>
</body>
</html>
