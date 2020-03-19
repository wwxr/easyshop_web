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
	<div class="ylnav">
		<span>用户信息</span><input type="button" value="" class="back" onClick="(function(){window.parent.$('.finedo-dialog-mask').remove();window.parent.$('.finedo-dialog').remove();})()">
	</div>
	<br/>
	<div class="yledit">
		<input id="goodstypeid" hidden> 
		<table align='center'>
			<tr>
				<td class="ylname1">用户编号：</td>
				<td class='ylname2' id="userid">
				</td>
				<td class="ylname1">用户昵称：</td>
				<td class='ylname2' id='nickname'>
				</td>
		    </tr>
			<tr>
				<td class="ylname1">用户积分：</td>
				<td class='ylname2' id="points">
				</td>
				<td class="ylname1">微信编号：</td>
				<td class='ylname2' id='openid'>
				</td>
		    </tr>
			<tr>
				<td class="ylname1">性别：</td>
				<td class='ylname2' id="gender">
				</td>
				<td class="ylname1">注册时间：</td>
				<td class='ylname2' id='registtime'>
				</td>
		    </tr>
		    <tr>
               <td class="ylname1">头像：</td>
               <td colspan="3">
               <img alt="头像"  title='头像' id='avatar' src="">
               </td>
           	</tr>
	    </table>
	</div>
</div>


<script language="javascript">
var easyshopuserdetail={};
/**
 * 详情页面经初始化，加载数据
 */
easyshopuserdetail.initdetail=function(){
	finedo.action.ajax({
        "url":"../../finedo/easyshopuser/querybyid",
        "data":{"userid":finedo.fn.getParameter("userid")},
        "callback":function(retdata){
            if(retdata.fail){
                finedo.message.error(retdata.resultdesc);
                return;
            }
            var retobject = retdata.object;
			$("#userid").html(retobject.userid);
			$("#points").html(retobject.points);
			$("#openid").html(retobject.openid);
			$("#nickname").html(retobject.nickname);
			$("#avatar").attr("src",retobject.avatar);
			$("#registtime").html(retobject.registtime);
			$("#gender").html(retobject.gender=='1'?'男':'女');
        }
    });
};
</script>
<script type='text/javascript' src='../../resource/js/lazyload.js'></script>
<script language="javascript">
LazyLoad.css([
    '../../resource/themes/default/style.css',
    '../../resource/js/finedoui/commonui/themes/commonui.css',
    '../../resource/js/finedoui/dialog/themes/style.css',
    '../../resource/js/finedoui/upload/themes/style.css',
    '../../resource/js/finedoui/image/viewer.min.css',
    '../../easyshop/style/style.css'
    ]);
LazyLoad.js([
    '../../resource/js/jquery/jquery-1.11.0.js',
    '../../resource/js/jquery/jquery.form.js',
    '../../resource/js/finedoui/base/finedo.core.js',
    '../../resource/js/finedoui/commonui/finedo.commonui.js',
    '../../resource/js/finedoui/dialog/finedo.dialog.js',
    '../../resource/js/finedoui/date/WdatePicker.js',
    '../../resource/js/finedoui/upload/finedo.upload.js',
    '../../resource/js/finedoui/image/viewer.min.js',
    ], function() {
    easyshopuserdetail.initdetail();
});
</script>
</body>
</html>
