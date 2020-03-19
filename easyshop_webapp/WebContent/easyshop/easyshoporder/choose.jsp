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
        	<input type="text" style="width:200px" class="query-box-text" id="ordercode" name="ordercode" value="请输入主键id" onkeypress="easyshoporderchoose.doQueryFast(event);">
            <input type="button" class="query-box-magnifier" onclick="easyshoporderchoose.doQuery();">
        </div>
    </div>
   
    <!-- 表格栏  -->
    <fsdp:grid className="table" id="datagrid" url="${ctx }/finedo/easyshoporder/query" selecttype="${param.selecttype }">
		<fsdp:field code="userid" name="用户id" width="100"></fsdp:field>
		<fsdp:field code="orderstate" name="订单状态：待付款-nopay;已付款-payed;invalid-已失效" width="100"></fsdp:field>
		<fsdp:field code="shippercode" name="快递公司编码" width="100"></fsdp:field>
		<fsdp:field code="logisticcode" name="物流单号" width="100"></fsdp:field>
		<fsdp:field code="isinvalid" name="是否失效：Y-是；N-否" width="100"></fsdp:field>
		<fsdp:field code="paytime" name="支付时间" width="100"></fsdp:field>
		<fsdp:field code="createtime" name="创建时间" width="100"></fsdp:field>
		<fsdp:field code="ordermoney" name="订单金额" width="100"></fsdp:field>
		<fsdp:field code="ispay" name="是否支付:Y-是；N-否" width="100"></fsdp:field>
	</fsdp:grid>
	<table id="datagrid"></table>
</div>
<script type="text/javascript">
var easyshoporderchoose={};
/**
 * 初始化待选择的数据
 */
easyshoporderchoose.initchoose=function(){
	$("#ordercode").blur(function(){
		if(this.value==""){
			this.value="请输入主键id";
		}
	}); 
	
	$("#ordercode").focus(function(){
		if(this.value=="请输入主键id"){
			this.value="";
		}
	});
	
	var columnslist = [];
	columnslist.push({code:'userid', title: '用户id', width: 100});
	columnslist.push({code:'orderstate', title: '订单状态：待付款-nopay;已付款-payed;invalid-已失效', width: 100});
	columnslist.push({code:'shippercode', title: '快递公司编码', width: 100});
	columnslist.push({code:'logisticcode', title: '物流单号', width: 100});
	columnslist.push({code:'isinvalid', title: '是否失效：Y-是；N-否', width: 100});
	columnslist.push({code:'paytime', title: '支付时间', width: 100});
	columnslist.push({code:'createtime', title: '创建时间', width: 100});
	columnslist.push({code:'ordermoney', title: '订单金额', width: 100});
	columnslist.push({code:'ispay', title: '是否支付:Y-是；N-否', width: 100});
	finedo.getgrid("datagrid",{
        url:"../../finedo/easyshoporder/query",
        selecttype: finedo.fn.getParameter("selecttype"),
        columns: columnslist
    }).load();
};
/**
 * 查询按钮触发方法
 */
easyshoporderchoose.doQuery=function(){
	var text=$('#ordercode').val();
	var param = {ordercode:text};
	finedo.getgrid("datagrid").query(param);
};
/**
 * 快速查询方法
 */
easyshoporderchoose.doQueryFast=function(event) {
	if(event.keyCode != 13)
		return;
	easyshoporderchoose.doQuery();
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
    easyshoporderchoose.initchoose();
});
</script>
</body>
</html>
