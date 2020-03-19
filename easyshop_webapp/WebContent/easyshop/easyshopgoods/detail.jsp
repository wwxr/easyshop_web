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
	<span>新增商品信息</span><input type="button" value="" class="back" onClick="(function(){window.parent.$('.finedo-dialog-mask').remove();window.parent.$('.finedo-dialog').remove();})()">
    </div>
    <div class="yledit">
    <input hidden='hidden' id='goodsid'>
	<table>
    		<tr>
				<td class="ylname1">商品名称：</td>
				<td class="ylname2" id="goodsname">
				</td>
				<td class="ylname1">商品类型：</td>
				<td class="ylname2" id='goodstypeid'>
					<select class='selectdata' id='goodstypeid' >
						<option value=''>全部</option>
					</select>
				</td>
			</tr>
    		<tr>
				<td class="ylname1">商品原价：</td>
				<td class="ylname2" id="originalprice" >
				</td>
				<td class="ylname1">商品现价：</td>
				<td class="ylname2" id="presentprice">
				</td>
			</tr>
    		<tr>
				<td class="ylname1">是否推荐：</td>
				<td class="ylname2">
				<select class='selectdata' id='isrecommend' >
						<option value=''>全部</option>
						<option value='N'>否</option>
						<option value='Y'>是</option>
				</select>
				</td>
				<td class="ylname1">支付类型：</td>
				<td class="ylname2">
				<select class='selectdata' id='paytype' >
						<option value=''>全部</option>
						<option value='money'>金额</option>
						<option value='points'>积分</option>
						<option value='all'>金额+积分</option>
				</select>
				</td>
			</tr>
			<tr>
				<td class="ylname1">添加时间：</td>
				<td class="ylname2" id="addtime" >
				</td>
				<td class="ylname1">修改时间：</td>
				<td class="ylname2" id="opttime">
				</td>
			</tr>
    		<tr>
				<td class="ylname1">所需积分：</td>
				<td class="ylname2" id="points">
				</td>
			</tr>
			<tr>
				<td class="ylname1">商品简介：</td>
				<td>
					<textarea  id="goodsintroduction" name="goodsintroduction" placeholder="请输入商品简介" maxlength="100"></textarea>
					<span style="color:red;">*必填项</span>
			    </td>
		    </tr>
			<tr>
               <td class="ylname1">图片：</td>
               <td colspan="3"><input type="text" id="userfiles1" name="userfiles1" multiupload="true" oninitcomplete="oninitcomplete1" onuploadcomplete="uploadcomplete1" value="" onclick="fileclick1" deletecallback="deleteCallback1" editable="false" filter=".png,.jpg,.JPG,.PNG,.jpeg,.JPEG"></td>
           	</tr>
           	<tr>
               <td class="ylname1">视频：</td>
               <td colspan="3">
               <video id='videoid' controls src="" style='width:50%;'></video>
               <input type="text" id="userfiles2" name="userfiles2" multiupload="false" oninitcomplete="oninitcomplete2" onuploadcomplete="uploadcomplete2" value="" onclick="fileclick2" deletecallback="deleteCallback2" editable="false" filter=".mp4">
               </td>
           	</tr>
		    <tr>
				<td colspan='3' class="ylname1">商品详情：</td>
			</tr>
		</table>
	    <div class='editorstyle'>
		  <textarea id="detail"></textarea>
	    </div>
		<table>
		<tr>
				<td class="ylname1"></td>
				<td class="ylname2">
				</td>
				<td class="ylname1"></td>
				<td class="ylname2">
				</td>
		</tr>
		<tr>
			<td colspan='3' class="ylname1">参数详情：</td>
		</tr>
		</table>
	    <div class='editorstyle'>
		  <textarea id="paramdetail"></textarea>
	    </div>
	</div>
</div>

<script language="javascript">
var easyshopgoodsdetail={};
/**
 * 详情页面经初始化，加载数据
 */
easyshopgoodsdetail.initdetail=function(){
	finedo.action.ajax({
        "url":"../../finedo/easyshopgoods/querybyid",
        "data":{"goodsid":finedo.fn.getParameter("goodsid")},
        "callback":function(retdata){
            if(retdata.fail){
                finedo.message.error(retdata.resultdesc);
                return;
            }
			easyshopgoodsdetail.initgoodstype();
            var retobject = retdata.object;
			$("#presentprice").html(retobject.presentprice);
			$("#originalprice").html(retobject.originalprice);
			$("#goodsname").html(retobject.goodsname);
			$("#opttime").html(retobject.opttime);
			$("#isrecommend").val(retobject.isrecommend);
			$("#goodsintroduction").val(retobject.goodsintroduction);
			$("#addtime").html(retobject.addtime);
			$("#goodstypeid").html(retobject.goodstypeid);
			$("#detail").html(retobject.detail);
			$("#points").html(retobject.points);
			$("#paytype").val(retobject.paytype);
			$("#videoid").attr("src","${SYSPARAM_KEY['imageip'] }"+retobject.videoid);
			UE.getEditor('detail',{initialFrameWidth:'100%',initialFrameHeight:400,});
			UE.getEditor('paramdetail',{initialFrameWidth:'100%',initialFrameHeight:400,});
			var detail = UE.getEditor("detail");
			detail.ready(function(){
				detail.setContent(retobject.detail);
		 	});
			var paramdetail = UE.getEditor("paramdetail");
			paramdetail.ready(function(){
				paramdetail.setContent(retobject.paramdetail);
		 	});
            $("#userfiles1").attr("value",retobject.imgids);
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
//初始化商品类型
easyshopgoodsdetail.initgoodstype=function() {
	finedo.action.ajax({
		url:"../../finedo/easyshopgoodstype/query",
		data:{'type':'small'},
		async:false,
		callback:function(jsondata){
			var datalist=jsondata.rows;
			var option='<option  value="">全部</option>';
			if(finedo.fn.isNotNon(datalist)){
				for(var i=0;i<datalist.length;i++){
					option+='<option value="'+datalist[i].goodstypeid+'">'+datalist[i].goodstypename+'</option>'
				}
			}
			$("#goodstypeid").html(option);
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
    easyshopgoodsdetail.initdetail();
});
</script>
</body>
</html>
