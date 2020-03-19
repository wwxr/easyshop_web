<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs2.jsp" %>

<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>
${finedo_htmleditor_js }
<body>
<div>
	<div class="ylnav">
	<span>广告信息详情</span><input type="button" value="" class="back" onClick="(function(){window.parent.$('.finedo-dialog-mask').remove();window.parent.$('.finedo-dialog').remove();})()">
    </div>
    <div class="yledit">
    <input hidden='hidden' id='newsid'>
	<table>
    		<tr>
				<td class="ylname1">广告编号：</td>
				<td class="ylname2" id="newsid"></td>
				<td class="ylname1">广告名称：</td>
				<td class="ylname2" id="newsname">
			</tr>
    		<tr>
				<td class="ylname1">添加时间：</td>
				<td class="ylname2" id="addtime"></td>
				<td class="ylname1">修改时间：</td>
				<td class="ylname2" id="opttime">
			</tr>
			<tr>
				<td class="ylname1" >广告简介：</td>
				<td>
					<textarea  id="newsintroduction" name="newsintroduction" readonly placeholder="请输入广告简介" maxlength="100"></textarea>
			    </td>
		    </tr>
		    <tr>
               <td class="ylname1">视频：</td>
               <td colspan="3">
               <video id='videoid' controls src="" style='width:50%;'></video>
               </td>
           	</tr>
			<tr>
               <td class="ylname1">图片上传：</td>
               <td colspan="3"><input type="text" id="userfiles1" name="userfiles1" multiupload="false" oninitcomplete="oninitcomplete1" onuploadcomplete="uploadcomplete1" value="" onclick="fileclick1" deletecallback="deleteCallback1" editable="false" filter=".png,.jpg,.JPG,.PNG,.jpeg,.JPEG"></td>
           	</tr>
           	<tr>
               <td class="ylname1">视频上传：</td>
               <td colspan="3"><input type="text" id="userfiles2" name="userfiles2" multiupload="false" oninitcomplete="oninitcomplete2" onuploadcomplete="uploadcomplete2" value="" onclick="fileclick2" deletecallback="deleteCallback2" editable="false" filter=".mp4"></td>
           	</tr>
		    <tr>
				<td colspan='3' class="ylname1">广告详情：</td>
			</tr>
		</table>
		    <div class='editorstyle'>
			  <textarea id="detail"></textarea>
		    </div>
	</div>
</div>
<script language="javascript">
var easyshopnewsdetail={};
/**
 * 详情页面经初始化，加载数据
 */
easyshopnewsdetail.initdetail=function(){
	finedo.action.ajax({
        "url":"../../finedo/easyshopnews/querybyid",
        "data":{"newsid":finedo.fn.getParameter("newsid")},
        "callback":function(retdata){
            if(retdata.fail){
                finedo.message.error(retdata.resultdesc);
                return;
            }
            var retobject = retdata.object;
			$("#addtime").html(retobject.addtime);
			$("#opttime").html(retobject.opttime);
			$("#detail").html(retobject.detail);
			$("#newsname").html(retobject.newsname);
			$("#videoid").attr("src","${SYSPARAM_KEY['imageip'] }"+retobject.videoid);
			UE.getEditor('detail',{initialFrameWidth:'100%',initialFrameHeight:400,});
			var detail = UE.getEditor("detail");
			detail.ready(function(){
				detail.setContent(retobject.detail);
				detail.setDisabled();
		 	});
            $("#userfiles1").attr("value",retobject.imgid);
            finedo.getFileControl('userfiles1',{
            	ctx:"../.."
            });
            $("#userfiles2").attr("value",retobject.videoid);
            finedo.getFileControl('userfiles2',{
            	ctx:"../.."
            });
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
    easyshopnewsdetail.initdetail();
});
</script>
</body>
</html>
