<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" session="false" %>
<%@ include file="/common/taglibs2.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>403</title>
<style>
*{ margin:0; padding:0; }
.prompy{ width:100%; height:200px; position:absolute; top:50%; text-align:center; margin-top:-100px; font-size:13px; font-family:Microsoft Yahei, SimSun; }
.prompy .img{ display:inline-block; padding-right:35px; border-right:1px solid #ececec; }
.prompy-con{ color:#727272; display:inline-block; vertical-align:top; padding-left:35px; }
.prompy-con a{ color:#0581e9; text-decoration:none;  }
.prompy-con a:hover{ text-decoration:underline; }
.prompy-con p{ line-height:25px; }
@media (max-width:768px){
	.prompy{ width:100%; text-align:center; position:absolute; left:0; top:50%; margin-left:0; margin-top:-125px; }
	.prompy .img{ float:none; height:auto; width:100%; text-align:center; padding-right:0; box-sizing:border-box; }
	.prompy .img img{ width:170px; }
	.prompy-con{ padding-top:10px; padding-left:0; }
}
</style>
</head>
<body>
<div class="prompy">
	<div class="img"><img src="${ctx }/resource/themes/common/images/403.jpg" /></div>
    <div class="prompy-con">
    	<p>您可能没有权限用您提供的凭据查看此目录或网页</p>
        <p>请联系系统管理员</p>
        <p>>><a href="${ctx }/">返回系统首页</a></p>
    </div>
</div>
<div></div>
</body>
</html>
