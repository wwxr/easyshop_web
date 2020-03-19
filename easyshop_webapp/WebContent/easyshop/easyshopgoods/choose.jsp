<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs2.jsp" %>

<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>
<body class="scrollcss">
<div class="index">
	<!-- 工具栏  -->
	<div class="table-title">
		<!-- 标题 -->
    	<div class="common-name icon-class-query">选择<br/>
			<ul>
            	<li class="link-li">全部</li>
            </ul>
        </div>
        
        <!-- 快捷查询 -->
        <div style="width:220px" class="query-box">
        	<input type="text" style="width:200px" class="query-box-text" id="goodsid" name="goodsid" value="请输入商品ID" onkeypress="easyshopgoodschoose.doQueryFast(event);">
            <input type="button" class="query-box-magnifier" onclick="easyshopgoodschoose.doQuery();">
        </div>
    </div>
   
    <!-- 表格栏  -->
    <fsdp:grid className="table" id="datagrid" url="${ctx }/finedo/easyshopgoods/query" selecttype="${param.selecttype }">
		<fsdp:field code="presentprice" name="现价" width="100"></fsdp:field>
		<fsdp:field code="originalprice" name="原价" width="100"></fsdp:field>
		<fsdp:field code="goodsname" name="商品名称" width="100"></fsdp:field>
		<fsdp:field code="videoid" name="视频id" width="100"></fsdp:field>
		<fsdp:field code="imgids" name="图片ids" width="100"></fsdp:field>
		<fsdp:field code="opttime" name="修改时间" width="100"></fsdp:field>
		<fsdp:field code="isrecommend" name="是否推荐：Y-是；N-否" width="100"></fsdp:field>
		<fsdp:field code="addtime" name="添加时间" width="100"></fsdp:field>
		<fsdp:field code="goodstypeid" name="商品类型id" width="100"></fsdp:field>
		<fsdp:field code="detail" name="物品详情" width="100"></fsdp:field>
		<fsdp:field code="points" name="所需积分" width="100"></fsdp:field>
		<fsdp:field code="paytype" name="支付类型：money-金钱；points-积分；all-金钱+积分" width="100"></fsdp:field>
	</fsdp:grid>
	<table id="datagrid"></table>
</div>
<script type="text/javascript">
var easyshopgoodschoose={};
/**
 * 初始化待选择的数据
 */
easyshopgoodschoose.initchoose=function(){
	$("#goodsid").blur(function(){
		if(this.value==""){
			this.value="请输入商品ID";
		}
	}); 
	
	$("#goodsid").focus(function(){
		if(this.value=="请输入商品ID"){
			this.value="";
		}
	});
	
	var columnslist = [];
	columnslist.push({code:'presentprice', title: '现价', width: 100});
	columnslist.push({code:'originalprice', title: '原价', width: 100});
	columnslist.push({code:'goodsname', title: '商品名称', width: 100});
	columnslist.push({code:'videoid', title: '视频id', width: 100});
	columnslist.push({code:'imgids', title: '图片ids', width: 100});
	columnslist.push({code:'opttime', title: '修改时间', width: 100});
	columnslist.push({code:'isrecommend', title: '是否推荐：Y-是；N-否', width: 100});
	columnslist.push({code:'addtime', title: '添加时间', width: 100});
	columnslist.push({code:'goodstypeid', title: '商品类型id', width: 100});
	columnslist.push({code:'detail', title: '物品详情', width: 100});
	columnslist.push({code:'points', title: '所需积分', width: 100});
	columnslist.push({code:'paytype', title: '支付类型：money-金钱；points-积分；all-金钱+积分', width: 100});
	finedo.getgrid("datagrid",{
        url:"../../finedo/easyshopgoods/query",
        selecttype: finedo.fn.getParameter("selecttype"),
        columns: columnslist
    }).load();
};
/**
 * 查询按钮触发方法
 */
easyshopgoodschoose.doQuery=function(){
	var text=$('#goodsid').val();
	var param = {goodsid:text};
	finedo.getgrid("datagrid").query(param);
};
/**
 * 快速查询方法
 */
easyshopgoodschoose.doQueryFast=function(event) {
	if(event.keyCode != 13)
		return;
	easyshopgoodschoose.doQuery();
};
</script>
<script type='text/javascript' src='../../resource/js/lazyload.js'></script>
<script language="javascript">
LazyLoad.css([
    '../../resource/themes/default/style.css',
    '../../resource/js/finedoui/dialog/themes/style.css',
    '../../resource/js/finedoui/grid/themes/style.css',
    '../../resource/js/finedoui/upload/themes/style.css'
    ]);
LazyLoad.js([
    '../../resource/js/jquery/jquery-1.11.0.js',
    '../../resource/js/jquery/jquery.form.js',
    '../../resource/js/finedoui/base/finedo.core.js',
    '../../resource/js/finedoui/dialog/finedo.dialog.js',
    '../../resource/js/finedoui/grid/finedo.grid.js'], function() {
    easyshopgoodschoose.initchoose();
});
</script>
</body>
</html>
