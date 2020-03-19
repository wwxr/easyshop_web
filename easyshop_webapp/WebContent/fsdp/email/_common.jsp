<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs.jsp"%>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="input-table">
	<tr>
		<th class="require" width="100">* 收件人：</th>
		<td>
			<fsdp:text value="${email.emailaddr}" maxlength="200" id="emailaddr" name="emailaddr" datatype="Require" msg="收件人不能为空，请填写【收件人】"></fsdp:text>
		</td>
	</tr>
	<tr>
		<th>抄送：</th>
		<td>
			<fsdp:text value="${email.ccemailaddr}" maxlength="200" id="ccemailaddr" name="ccemailaddr"></fsdp:text>
		</td>
	</tr>
	<tr>
		<th class="require">* 主题：</th>
		<td>
			<fsdp:text value="${email.subject}" maxlength="100" id="subject" name="subject" datatype="Require" msg="主题不能为空，请填写【主题】"></fsdp:text>
		</td>
	</tr>
	<tr>
		<th class="require" valign=top>* 正文：</th>
		<td>
			<input type="hidden" id="emailcontent" name="emailcontent"/>
			<fsdp:htmleditor id="editor" name="editor" style="width:100%;height:150px;"></fsdp:htmleditor>
		</td>
	</tr>
	
	<tr>
		<th>定时发送时间：</th>
		<td>
			<fsdp:date id="effdate" name="effdate" onfocus="WdatePicker({minDate:'%y-%M-%d %H:%m:%s',dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width:150px"></fsdp:date>
		</td>
	</tr>
</table>
