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
	<span>新增广告信息</span><input type="button" value="" class="back" onClick="(function(){window.parent.$('.finedo-dialog-mask').remove();window.parent.$('.finedo-dialog').remove();})()">
    </div>
    <div class="yledit">
	<table>
    		<tr>
				<td class="ylname1">广告名称：</td>
				<td class="ylname2">
				<input type="text" class="yltext" id="newsname" name="newsname" maxlength="50" placeholder="请输入广告名称"  ><span style="color:red;">*必填项</span></td>
				<td class="ylname1"></td>
				<td class="ylname2">
			</tr>
			<tr>
				<td class="ylname1">广告简介：</td>
				<td>
					<textarea  id="newsintroduction" name="newsintroduction" placeholder="请输入广告简介" maxlength="100"></textarea>
					<span style="color:red;">*必填项</span>
			    </td>
		    </tr>
			<tr>
               <td class="ylname1">图片上传：</td>
               <td colspan="3"><input type="text" id="userfiles1" name="userfiles1" multiupload="false" oninitcomplete="oninitcomplete1" onuploadcomplete="uploadcomplete1" value="" onclick="fileclick1" deletecallback="deleteCallback1" editable="true" filter=".png,.jpg,.JPG,.PNG,.jpeg,.JPEG"></td>
           	</tr>
           	<tr><td></td><td colspan="2"><span style='color:red;'>请上传.png,.jpg,.JPG,.PNG,.jpeg,.JPEG格式文件</span></td></tr>
           	<tr>
               <td class="ylname1">视频上传：</td>
               <td colspan="3"><input type="text" id="userfiles2" name="userfiles2" multiupload="false" oninitcomplete="oninitcomplete2" onuploadcomplete="uploadcomplete2" value="" onclick="fileclick2" deletecallback="deleteCallback2" editable="true" filter=".mp4"></td>
           	</tr>
           	<tr><td></td><td colspan="2"><span style='color:red;'>请上传.MP4格式文件</span></td></tr>
		    <tr>
				<td colspan='3' class="ylname1">广告详情：</td>
			</tr>
		</table>
		    <div class='editorstyle'>
			  <textarea id="detail"></textarea>
		    </div>
	</div>
    <div class="ylsubmit"><input type="button" class="ylbtn" value="提    交" onClick="easyshopnewsadd.dosubmit()" ></div>
</div>

<script language="javascript">
var easyshopnewsadd={};
var up=[];
var upvideo=[];
//图片路径
var uppath=[];
var upthumpath=[];
//视频路径
var upvideopath=[];
/**
 * 增加页面初始化，用于初始化表单
 */
easyshopnewsadd.initadd=function(){
	UE.getEditor('detail',{initialFrameWidth:'100%',initialFrameHeight:400,});
    finedo.getFileControl('userfiles1',{
    	ctx:"../.."
    });
    finedo.getFileControl('userfiles2',{
    	ctx:"../.."
    });
};
easyshopnewsadd.checkdata=function(){
	var result=true;
	if(finedo.fn.isNon($("#newsname").val())){
		finedo.message.info("请输广告名称");
		return;
	}
	if(finedo.fn.isNon($("#newsintroduction").val())){
		finedo.message.info("请输入广告简介");
		return;
	}
	var editor = UE.getEditor('detail');
	var detail = editor.getContent();
	if(finedo.fn.isNon(detail)){
		finedo.message.info("请填写介绍");
		result=false;
		return;
	}
	return result;
};
/**
 * 提交方法
 */
easyshopnewsadd.dosubmit=function() {
	if(!easyshopnewsadd.checkdata()) 
		return;
	//图片id
	var upstr='';
	if(finedo.fn.isNotNon(up)){
		upstr=up.toString();
	}
	//图片路径
	var upstr1='';
	if(finedo.fn.isNotNon(uppath)){
		upstr1=uppath.toString();
	}
	//图片缩略图路径
	var upstr2='';
	if(finedo.fn.isNotNon(upthumpath)){
		upstr2=upthumpath.toString();
	}
	//视频id
	var upvideostr='';
	if(finedo.fn.isNotNon(upvideo)){
		upvideostr=upvideo.toString();
	}
	//视频路径
	var upvideostr1='';
	if(finedo.fn.isNotNon(upvideopath)){
		upvideostr1=upvideopath.toString();
	}
	var editor = UE.getEditor('detail');
	var detail = editor.getContent();
	finedo.action.ajax({
		url:"../../finedo/easyshopnews/add",
		data:{
			newsname:$("#newsname").val().trim(),//老师名称
			newsintroduction:$("#newsintroduction").val().trim(),//专业名称
			detail:detail,//详情
			imgid:upstr,//图片
			videoid:upvideostr,//视频id
			imgpath:upstr1,//图片路径
			imgthumpath:upstr2,//图片缩略图路径
			videopath:upvideostr1,//视频路径
			},
			callback:function(jsondata){
				if(jsondata.fail){
					finedo.message.error(jsondata.resultdesc);
					return;
				}
				finedo.message.info(jsondata.resultdesc,'提示',function(){
					window.parent.$('#datagrid').grid().refresh();
					window.parent.$(".finedo-dialog-mask").remove();
					window.parent.$(".finedo-dialog").remove();
				});
		}
	});
	
};
//文件初始化
function oninitcomplete1(filelist){
}
//文件上传成功后的回调函数，fileobj为上传文件的json对象
function uploadcomplete1(fileobj){
	console.log(fileobj);
	
	var multiupload=$("#userfiles1").attr("multiupload");
	if(multiupload=='false'){
		up=[];
		uppath=[];
		upthumpath=[];
	}
	up.push(fileobj.fileid);
	uppath.push(fileobj.filepath+'/'+fileobj.fileid+fileobj.filetype)
	upthumpath.push(fileobj.filepath+'/'+fileobj.fileid+'.80'+fileobj.filetype)
	
}
// 文件点击回调函数，fileobj为点击文件的json对象
function fileclick1(fileobj){
}
// 文件删除回调函数，filelist为删除的文件json对象数组,filelist[0].fileid为要删除的图片id
function deleteCallback1(filelist) {
	/* 数组中删除该图片 */
	up.splice(jQuery.inArray(filelist[0].fileid,up),1);
	uppath.splice(jQuery.inArray(filelist[0].filepath+'/'+filelist[0].fileid+filelist[0].filetype,uppath),1);
	upthumpath.splice(jQuery.inArray(filelist[0].filepath+'/'+filelist[0].fileid+'.80'+filelist[0].filetype,upthumpath),1);
}


//文件初始化
function oninitcomplete2(filelist){
}
//文件上传成功后的回调函数，fileobj为上传文件的json对象
function uploadcomplete2(fileobj){
	var multiupload=$("#userfiles2").attr("multiupload");
	if(multiupload=='false'){
		upvideo=[];
		upvideopath=[];
	}
	upvideo.push(fileobj.fileid);
	upvideopath.push(fileobj.filepath+'/'+fileobj.fileid+fileobj.filetype)
	
}
// 文件点击回调函数，fileobj为点击文件的json对象
function fileclick2(fileobj){
}
// 文件删除回调函数，filelist为删除的文件json对象数组,filelist[0].fileid为要删除的图片id
function deleteCallback2(filelist) {
	/* 数组中删除该图片 */
	upvideo.splice(jQuery.inArray(filelist[0].fileid,upvideo),1);
	upvideopath.splice(jQuery.inArray(filelist[0].filepath+'/'+filelist[0].fileid+filelist[0].filetype,upvideopath),1);
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
    '../../resource/js/finedoui/image/viewer.min.js',   ], function() {
    easyshopnewsadd.initadd();
});
</script>
</body>
</html>
