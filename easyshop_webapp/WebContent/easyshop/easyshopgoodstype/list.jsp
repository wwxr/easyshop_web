<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs2.jsp" %>

<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>

<body class="body">

<div style="width:100%;">
	<div class="ylnav">
		<span>商品类型管理</span>
	</div>
	<div class="yllist">
		<div class="yllist-infor-left"
			style="margin-top: 0px; margin-bottom: 15px;">
			<a href="#" title="导出" class="export" onclick="easyshopgoodstypelist.doExport();"></a> <a
				href="#" class="add" onclick="easyshopgoodstypelist.showAddDialog();" title="添加"></a>
		</div>
		<div class="yllist-infor-rig">
			<input type="button" value="&nbsp;" class="ylquery" onclick="easyshopgoodstypelist.doQueryFast();"> 
			<input type="text" placeholder="请输入类型名称" class="yltext" id="typename_que" style="width: 200px; height: 40px; margin-right: 20px;margin-left: 20px;">
		</div>
	</div>
    <!-- 表格栏  -->
	<table id="datagrid"></table>
</div>

<iframe id="downiframe" name="downiframe" style="display:none" ></iframe>
<script type="text/javascript">
var easyshopgoodstypelist={};
/**
 * 初始化列表页面
 */
easyshopgoodstypelist.initlist=function(){
	var columnslist = [];
	columnslist.push({code:'goodstypeid', title: '商品类型编号', width:'15%', formatter:easyshopgoodstypelist.formatPkey, order:true});
	columnslist.push({code:'goodstypename', title: '类型名称', width: '15%'});
	columnslist.push({code:'parentname', title: '父类型', width: '15%'});
	columnslist.push({code:'imgid', title: '图片', width: '30%',formatter:easyshopgoodstypelist.formatPicture});
	columnslist.push({code:'operation', title: '操作', formatter:easyshopgoodstypelist.formatOperation});
	finedo.getgrid("datagrid",{
        url:"../../finedo/easyshopgoodstype/query",
        selecttype: "multi",
        columns: columnslist
    }).load();
};
/**
 * 格式化操作列展示
 */
easyshopgoodstypelist.formatOperation=function(row){
	var operation = '<a href="javascript:easyshopgoodstypelist.showModifyDialog(\'' + row.goodstypeid + '\');">[编辑]</a>&nbsp;';
	operation += '<a href="javascript:finedo.action.doDelete(\'datagrid\',\'${ctx}/finedo/easyshopgoodstype/delete\',\'' + row.goodstypeid + '\')">[删除]</a>&nbsp;';
	return operation;
};
/**
 * 格式化主键展示
 */
easyshopgoodstypelist.formatPkey=function(row){
	return '<a href="#" onclick="easyshopgoodstypelist.showDetailDialog(\'' + row.goodstypeid + '\');">' + row.goodstypeid + '</a>&nbsp;';
};
/**
 * 格式化图片展示
 */
easyshopgoodstypelist.formatPicture=function(row){
	var imgid=row.imgid;
	if(finedo.fn.isNon(imgid)){
		return "无";
	}
	return "<image onclick='easyshopgoodstypelist.preview(\"" + imgid + "\")' style='width:80px;height:80px;' src='${SYSPARAM_KEY['thumbnailimageip'] }"+imgid+"'>"
};
/**
 * 预览
 */
 easyshopgoodstypelist.preview = function(imgid){
     var imgindex=0;
 	var previewhtml = '<div>';
	previewhtml+='<img alt="" data-original="${SYSPARAM_KEY["imageip"] }'+imgid+'"" src="${SYSPARAM_KEY["thumbnailimageip"] }'+imgid+'"></img>';
 	previewhtml += '</div>';
 	$(previewhtml).viewer({"url":"data-original","imgindex":imgindex}).viewer("show");
 };
/**
 * 快捷查询按钮
 */
easyshopgoodstypelist.doQueryFast=function(){
	var typename_que=$('#typename_que').val();
	
	var param = {goodstypename:typename_que};
	finedo.getgrid("datagrid").query(param);
};
/**
 * 弹出增加对话框
 */
easyshopgoodstypelist.showAddDialog=function(){
	finedo.dialog.show({
		width:850,
		height:550,
		'title':'新增信息',
		'url':'../../finedo/easyshopgoodstype/addindex'
	});
};
/**
 * 弹出修改对话框
 */
easyshopgoodstypelist.showModifyDialog=function(pkeyid){
	finedo.dialog.show({
		width:850,
		height:550,
		'title':'修改信息',
		'url':'../../finedo/easyshopgoodstype/updateindex?goodstypeid=' + pkeyid
	});
};
/**
 * 弹出详情对话框
 */
easyshopgoodstypelist.showDetailDialog=function(pkeyid){
	finedo.dialog.show({
		width:850,
		height:550,
		'title':'修改信息',
		'url':'../../finedo/easyshopgoodstype/detailindex?goodstypeid=' + pkeyid
	});
};
/**
 * 导出方法
 */
easyshopgoodstypelist.doExport=function(){
	var param=finedo.getgrid("datagrid").getqueryparams();
	$("#downiframe").attr('src', '../../finedo/easyshopgoodstype/exportexcel' + (param ? '?' + $.param(param) : ''));
};
</script>
<script type='text/javascript' src='../../resource/js/lazyload.js'></script>
<script language="javascript">
LazyLoad.css([
    '../../resource/themes/default/style.css',
    '../../resource/js/finedoui/commonui/themes/commonui.css',
    '../../resource/js/finedoui/dialog/themes/style.css',
    '../../resource/js/finedoui/grid/themes/style.css',
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
    '../../resource/js/finedoui/grid/finedo.grid.js',
    '../../resource/js/finedoui/upload/finedo.upload.js',
    '../../resource/js/finedoui/image/viewer.min.js',
    ], function() {
    easyshopgoodstypelist.initlist();
});
</script>
</body>
</html>

