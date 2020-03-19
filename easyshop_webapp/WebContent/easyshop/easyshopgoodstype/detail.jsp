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
				<td class='ylname2' id="goodstypename">
				</td>
				<td class="ylname1">父级类型：</td>
				<td class='ylname2' >
					<select class='selectdata' id='parentid' >
					</select>
				</td>
		    </tr>
		    <tr>
               <td class="ylname1">图片：</td>
               <td colspan="3"><input type="text" id="userfiles" name="userfiles" multiupload="false" oninitcomplete="oninitcomplete" onuploadcomplete="uploadcomplete" value="" onclick="fileclick" deletecallback="deleteCallback" editable="false" filter=".mp4,.avi,.png,.jpg,.JPG,.PNG,.jpeg,.JPEG"></td>
           	</tr>
	    </table>
	</div>
</div>
<script language="javascript">
var easyshopgoodstypedetail={};
//上传附件
var up=[];
/**
 * 初始化加载要修改的数据
 */
easyshopgoodstypedetail.initmodify=function(){
	easyshopgoodstypedetail.inittype();
	
	var keyvalue=finedo.fn.getParameter("goodstypeid");
	finedo.action.ajax({
        "url":"../../finedo/easyshopgoodstype/querybyid",
        "data":{"goodstypeid":keyvalue},
        "callback":easyshopgoodstypedetail.queryCallback
    });
};
/**
 * 数据查询回调方法
 */
easyshopgoodstypedetail.queryCallback=function(ajaxret){
	if(ajaxret.fail){
        finedo.message.error(retdata.resultdesc);
        return;
    }
    var retobject = ajaxret.object;
    $("#goodstypename").text(retobject.goodstypename);
    $("#parentid").val(retobject.parentid);
   	$("#parentid").attr("disabled","disabled");
    $("#userfiles").attr("value",retobject.imgid);
    finedo.getFileControl('userfiles',{
    	ctx:"../.."
    });
    up.push(retobject.imgid);
};
//查询父类
easyshopgoodstypedetail.inittype=function() {
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
	easyshopgoodstypedetail.initmodify();
    
});
</script>
</body>
</html>