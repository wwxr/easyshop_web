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
		<span>物流信息</span><input type="button" value="" class="back" onClick="(function(){window.parent.$('.finedo-dialog-mask').remove();window.parent.$('.finedo-dialog').remove();})()">
	</div>
	<br/>
	<div class="yledit">
		<table align='center'>
			<tr>
				<td class="ylname1">物流名称：</td>
				<td class='ylname2' id="shippername" >
				</td>
				<td class="ylname1">物流编号：</td>
				<td class='ylname2'  id="shippercode">
				</td>
		    </tr>
		    <tr>
               <td class="ylname1">附件上传：</td>
               <td colspan="3"><input type="text" id="userfiles" name="userfiles" multiupload="false" oninitcomplete="oninitcomplete" onuploadcomplete="uploadcomplete" value="" onclick="fileclick" deletecallback="deleteCallback" editable="false" filter=".avi,.png,.jpg,.JPG,.PNG,.jpeg,.JPEG"></td>
           	</tr>
	    </table>
	</div>
</div>
<script language="javascript">
//上传附件
var up=[];
var easyshopexpressdetail={};
/**
 * 详情页面经初始化，加载数据
 */
easyshopexpressdetail.initdetail=function(){
	finedo.action.ajax({
        "url":"../../finedo/easyshopexpress/querybyid",
        "data":{"shippercode":finedo.fn.getParameter("shippercode")},
        "callback":function(retdata){
            if(retdata.fail){
                finedo.message.error(retdata.resultdesc);
                return;
            }
            var retobject = retdata.object;
			$("#shippername").html(retobject.shippername);
			$("#shippercode").html(retobject.shippercode);
			$("#userfiles").attr("value",retobject.imgid);
		    finedo.getFileControl('userfiles',{
		    	ctx:"../.."
		    });
		    up.push(retobject.imgid);
        }
    });
};
//文件初始化
function oninitcomplete(filelist){
}
//文件上传成功后的回调函数，fileobj为上传文件的json对象
function uploadcomplete(fileobj){
	var multiupload=$("#userfiles").attr("multiupload");
	if(multiupload){
		up=[];
	}
	up.push(fileobj.fileid);
	console.log(up.toString())
	
}
// 文件点击回调函数，fileobj为点击文件的json对象
function fileclick(fileobj){
}
// 文件删除回调函数，filelist为删除的文件json对象数组,filelist[0].fileid为要删除的图片id
function deleteCallback(filelist) {
	/* 数组中删除该图片 */
	up.splice(jQuery.inArray(filelist[0].fileid,up),1);
}
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
    easyshopexpressdetail.initdetail();
});
</script>
</body>
</html>
