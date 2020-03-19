<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
${style_css }
${jquery_js }
${easyui_js }
</head>
<body class="easyui-layout">
<div region="center" style="padding:5px;" border="false">
  <div class="easyui-panel" title="当前位置：用户与权限 &gt; 组织机构管理 &gt; 导入组织机构" style="width:auto;padding:10px;" fit="true">
		<table width="60%" border="0" cellpadding="0" cellspacing="0" class="listtable">
			<tr>
				<td>
					总记录数：${importresult.rowcount}
				</td>
			</tr>
			<tr>
				<td>
					成功记录数：${importresult.successcount}
				</td>
			</tr>
			<tr>
				<td>
					失败记录数：${importresult.failcount}
				</td>
			</tr>
		</table>
		
		<table width="60%" border="0" cellpadding="0" cellspacing="0" style="text-align:left; border:1px solid #aaa; background:white">
		 	<c:forEach items="${importresult.faillist}" var="result">
		 	<tr>
		 		<td>${result.resultdesc}</td>
		 	</tr>
		 	</c:forEach>
		</table>
  </div>
</div>  

<div data-options="region:'south',border:false" style="text-align:right;padding:5px;">   
   <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="window.history.go(-1)">返回</a>  
</div>

</body>
</html>

