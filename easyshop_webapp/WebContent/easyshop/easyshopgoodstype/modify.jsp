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
		<span>修改类型信息</span><input type="button" value="" class="back" onClick="(function(){window.parent.$('.finedo-dialog-mask').remove();window.parent.$('.finedo-dialog').remove();})()">
	</div>
	<br/>
	<div class="yledit">
		<input id="goodstypeid" hidden> 
		<table align='center'>
			<tr>
				<td class="ylname1">类型名称：</td>
				<td class='ylname2'>
					<input type="text" class="yltext" id="goodstypename" placeholder="请输入类型名称" maxlength='50' >
					<span style="color:red;">*必填项</span>
				</td>
				<td class="ylname1">父级类型：</td>
				<td>
					<select class='selectdata' id='parentid' >
					</select>
				</td>
		    </tr>
		    <tr>
               <td class="ylname1">附件上传：</td>
               <td colspan="3"><input type="text" id="userfiles" name="userfiles" multiupload="false" oninitcomplete="oninitcomplete" onuploadcomplete="uploadcomplete" value="" onclick="fileclick" deletecallback="deleteCallback" editable="true" filter=".mp4,.avi,.png,.jpg,.JPG,.PNG,.jpeg,.JPEG"></td>
           	</tr>
           	<tr><td></td><td colspan="2"><span style='color:red;'>请上传.png,.jpg,.JPG,.PNG,.jpeg,.JPEG格式文件</span></td></tr>
	    </table>
	</div>
	<div class="ylsubmit">
		<input type="button" value="提交" class="ylbtn" onClick="easyshopgoodstypemodify.dosubmit()">
	</div>  
</div>
<script language="javascript">
var easyshopgoodstypemodify={};
//上传附件
var up=[];
//图片路径
var uppath=[];
var upthumpath=[];
/**
 * 初始化加载要修改的数据
 */
easyshopgoodstypemodify.initmodify=function(){
	easyshopgoodstypemodify.inittype();
	
	var keyvalue=finedo.fn.getParameter("goodstypeid");
	$("#goodstypeid").val(keyvalue);
	finedo.action.ajax({
        "url":"../../finedo/easyshopgoodstype/querybyid",
        "data":{"goodstypeid":keyvalue},
        "callback":easyshopgoodstypemodify.queryCallback
    });
};
/**
 * 数据查询回调方法
 */
easyshopgoodstypemodify.queryCallback=function(ajaxret){
	if(ajaxret.fail){
        finedo.message.error(retdata.resultdesc);
        return;
    }
    var retobject = ajaxret.object;
    $("#goodstypename").val(retobject.goodstypename);
    if(finedo.fn.isNon(retobject.parentid)){
    	$("#parentid").attr("disabled","disabled");
    }else{
	    $("#parentid").val(retobject.parentid);
    }
    $("#userfiles").attr("value",retobject.imgid);
    finedo.getFileControl('userfiles',{
    	ctx:"../.."
    });
    if(finedo.fn.isNotNon(retobject.imgid)){
    	var imgs=retobject.imgid.split(",");
    	for(var i=0;i<imgs.length;i++){
		    up.push(imgs[i]);
    	}
    }
    if(finedo.fn.isNotNon(retobject.imgthumpath)){
    	var imgthumpaths=retobject.imgthumpath.split(",");
    	for(var i=0;i<imgthumpaths.length;i++){
    		upthumpath.push(imgthumpaths[i]);
    	}
    }
    if(finedo.fn.isNotNon(retobject.imgpath)){
    	var uppaths=retobject.imgpath.split(",");
    	for(var i=0;i<uppaths.length;i++){
    		uppath.push(uppaths[i]);
    	}
    }
};
easyshopgoodstypemodify.checkdata=function(){
	var result=true;
	if(finedo.fn.isNon($("#goodstypename").val())){
		finedo.message.info("请填写类型名称");
		result=false;
		return;
	}
	return result;
};
//查询父类
easyshopgoodstypemodify.inittype=function() {
	finedo.action.ajax({
		url:"../../finedo/easyshopgoodstype/query",
		data:{type:'big'},
		async: false ,
		callback:function(jsondata){
			var datalist=jsondata.rows;
			var option='<option  value="">请选择</option>';
			if(finedo.fn.isNotNon(datalist)){
				for(var i=0;i<datalist.length;i++){
					option+='<option value="'+datalist[i].goodstypeid+'">'+datalist[i].goodstypename+'</option>'
				}
			}
			$("#parentid").html(option);
		}
	});
};
/**
 * 数据修改提交
 */
easyshopgoodstypemodify.dosubmit=function() {
	if(!easyshopgoodstypemodify.checkdata()) 
		return;
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
	finedo.action.ajax({
		url:"../../finedo/easyshopgoodstype/modify",
		data:{
			goodstypeid:$("#goodstypeid").val(),//类型名称
			goodstypename:$("#goodstypename").val().trim(),//类型名称
			parentid:$("#parentid").val(),//父类
			imgid:upstr,//图片id
			imgpath:upstr1,//图片路径
			imgthumpath:upstr2,//图片缩略图路径
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
function oninitcomplete(filelist){
}
//文件上传成功后的回调函数，fileobj为上传文件的json对象
function uploadcomplete(fileobj){
	var multiupload=$("#userfiles").attr("multiupload");
	if(multiupload=='false'){
		up=[];
		uppath=[];
		upthumpath=[];
	}
	up.push(fileobj.fileid);
	uppath.push(fileobj.filepath+'/'+fileobj.fileid+fileobj.filetype)
	upthumpath.push(fileobj.filepath+'/'+fileobj.fileid+'.80'+fileobj.filetype)
	
}
//文件点击回调函数，fileobj为点击文件的json对象
function fileclick(fileobj){
}
//文件删除回调函数，filelist为删除的文件json对象数组,filelist[0].fileid为要删除的图片id
function deleteCallback(filelist) {
	/* 数组中删除该图片 */
	up.splice(jQuery.inArray(filelist[0].fileid,up),1);
	uppath.splice(jQuery.inArray(filelist[0].filepath+'/'+filelist[0].fileid+filelist[0].filetype,uppath),1);
	upthumpath.splice(jQuery.inArray(filelist[0].filepath+'/'+filelist[0].fileid+'.80'+filelist[0].filetype,upthumpath),1);
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
	easyshopgoodstypemodify.initmodify();
    
});
</script>
</body>
</html>