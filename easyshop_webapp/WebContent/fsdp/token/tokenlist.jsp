<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs2.jsp" %>

<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>
<body class="query-body">
<div style="width:100%;">
	<!-- 工具栏  -->
	<div class="query-title">
		<!-- 标题 -->
    	<div class="query-title-name">Token管理 </div>
    	
    	<div class="query-boxbig">
	    	<input type="button" class="query-btn-nextstep" onclick="tokenlist.showAddDialog();" value="生成Token">
       	 	
    		<div class="query-fast">
	        	<input type="text" class="query-fast-text" id="query-box-text" value="">
	            <input type="button" class="query-fast-magnifier" onclick="tokenlist.doQueryFast();">
	        </div>
	        <input type="button" class="query-btn-nextstep" onclick="tokenlist.opquerycond();" value="高级搜索">
    	</div>
        
   </div>

	<!-- 高级搜索栏  -->
    <div class="query-advanced-search-con" id="advanced-search-con" style="display:none; ">
    	<div class="query-common-query" id="common-con">
        	<table class="finedo-table">
				<tr>
					<td class="finedo-label-title">Token值</td>
					<td>
						<input class="finedo-text" type="text" id="tokenid" name="tokenid">
					</td>
					<td class="finedo-label-title">用户工号</td>
					<td>
						<input class="finedo-text" type="text" id="userid" name="userid">
					</td>
				</tr>
				
				<tr>
					<td class="finedo-label-title">Token类型</td>
					<td colspan="3">
						<input type="text" id="tokentype"></input>
					</td>
				</tr>
			</table>
        </div>
        <div class="query-operate">
            <input class="finedo-button-blue" type="button" value="查    询" onclick="tokenlist.doQuery();">&nbsp;&nbsp;&nbsp;&nbsp;
           	<input class="finedo-button-blue" type="button" value="取    消" onclick="tokenlist.doQueryCancel();">
        </div>
    </div>
    
    <!-- 表格栏  -->
	<table id="datagrid"></table>
</div>
<script type="text/javascript">
/************** 表格操作函数定义****************/
// 表格"操作"单元格重载
var tokenlist = {
    initlist:function(){
        finedo.getgrid("datagrid",{
            url:"../../finedo/token/query",
            columns: [
                {code:'token', title: 'Token', width: 300},
                {code:'expdate', title: '失效时间', width: 120},
                {code:'iplimit', title: 'IP限制', width: 100},
                {code:'userid', title: '用户标识', width: 80},
                {code:'url', title: '访问地址', width: 200},
                {code:'createtime', title: '创建时间', width: 120},
                {code:'tokentype', title: 'Token类型', width: 60},
                {code:'operation', title: '操作', formatter:tokenlist.formatOperation}
            ]
        }).load();
        
        finedo.getradio("tokentype", {
            data:[
                {"code":"一次性", "value":"一次性"},
                {"code":"时效性", "value":"时效性"},
                {"code":"永久性", "value":"永久性"}
            ],
            ctx:"../.."
        });
    },
    formatOperation:function(row){
        var operation = '<a href="javascript:finedo.action.doDelete(\'datagrid\',\'../../finedo/token/delete\',\''+row.token+'\')">[删除]</a>&nbsp;';
        operation += '<a href="javascript:tokenlist.refreshToken(\''+row.token+'\')">[刷新]</a>&nbsp;';
        return operation;
    },
    doQuery:function(){
        tokenlist.opquerycond();
        var param = {tokenid: $('#tokenid').val(), userid: $('#userid').val(), tokentype: $('#tokentype').val()};
        finedo.getgrid("datagrid").query(param);
    },
    doQueryCancel:function(){
        tokenlist.opquerycond();
    },
    doQueryFast:function(){
        var text=$('#query-box-text').val();
        var param = {tokenid:text};
        finedo.getgrid("datagrid").query(param);
    },
    refreshToken:function(tokenid){
        finedo.action.doCommand("../../finedo/token/refresh?tokenid="+tokenid, function(data){
            tokenlist.doRefresh();
        }, true);
    },
    showAddDialog:function(){
        finedo.dialog.showDialog({
            width:650,
            height:450,
            'title':'新增信息',
            'url':'../../finedo/token/addindex',
            callback:function(data){
                tokenlist.doRefresh();
            }
        });
    },
    doRefresh:function(){
        $("#datagrid").grid().refresh();
    },
    opquerycond:function(){
        var divdisplay=$('#advanced-search-con').css('display');
        
        if(divdisplay == 'block'){
            $('#advanced-search-con').css('display', 'none');
            $('#advanced-search').attr('class', 'query-as-link');
        
        }else{
            $('#advanced-search-con').css('display', 'block');
            $('#advanced-search').attr('class', 'query-as-hover');
        }
    }
};
</script>
<script type='text/javascript' src='../../resource/js/lazyload.js'></script>
<script language="javascript">
LazyLoad.css([
    '../../resource/themes/default/style.css',
    '../../resource/js/finedoui/commonui/themes/commonui.css',
    '../../resource/js/finedoui/dialog/themes/style.css',
    '../../resource/js/finedoui/grid/themes/style.css'
    ]);
LazyLoad.js([
    '../../resource/js/jquery/jquery-1.11.0.js',
    '../../resource/js/jquery/jquery.form.js',
    '../../resource/js/finedoui/base/finedo.core.js',
    '../../resource/js/finedoui/commonui/finedo.commonui.js',
    '../../resource/js/finedoui/dialog/finedo.dialog.js',
    '../../resource/js/finedoui/grid/finedo.grid.js'
    ], function() {
    tokenlist.initlist();
});
</script>
</body>
</html>
