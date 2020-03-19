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
    	<div class="query-title-name">系统用户管理 </div>
    	
    	<div class="query-boxbig">
	    	<input type="button" class="query-btn-nextstep" onclick="userlist.showAddDialog();" value="新建用户">
	    	<input type="button" class="query-btn-nextstep" onclick="userlist.doExport();" value="批量导出">
       	 	
    		<div class="query-fast">
	        	<input type="text" class="query-fast-text" id="query-box-text" value="">
	            <input type="button" class="query-fast-magnifier" onclick="userlist.doQueryFast();">
	        </div>
	        <input type="button" class="query-btn-nextstep" onclick="userlist.opquerycond();" value="高级搜索">
    	</div>
        
   </div>

	<!-- 高级搜索栏  -->
    <div class="query-advanced-search-con" id="advanced-search-con" style="display:none; ">
    	<div class="query-common-query" id="common-con">
        	<table class="finedo-table">
				<tr>
					<td class="finedo-label-title">用户编号</td>
					<td>
						<input class="finedo-text" type="text" id="usercode" name="usercode">
					</td>
					<td class="finedo-label-title">姓名</td>
					<td>
						<input class="finedo-text" type="text" id="personname" name="personname">
					</td>
				</tr>
				
				<tr>
					<td class="finedo-label-title">状态</td>
					<td>
						<input type="text" id="state"></input>
					</td>
					<td class="finedo-label-title">联系电话</td>
					<td>
						<input class="finedo-text" type="text" id="phoneno" name="phoneno">
					</td>
				</tr>
			</table>
        </div>
        <div class="query-operate">
            <input class="finedo-button-blue" type="button" value="查    询" onclick="userlist.doQuery();">&nbsp;&nbsp;&nbsp;&nbsp;
           	<input class="finedo-button-blue" type="button" value="取    消" onclick="userlist.doQueryCancel();">
        </div>
    </div>
    
    <!-- 表格栏  -->
	<table id="datagrid"></table>
</div>
<iframe id="downiframe" name="downiframe" style="display:none" ></iframe>
<script type="text/javascript">
/************** 表格操作函数定义****************/
// 表格"操作"单元格重载
var userlist = {
    initlist:function(){
        finedo.getgrid("datagrid",{
            url:"../../finedo/user/queryUser",
            expand:userlist.doExpandRow,
            selecttype: "multi",
            columns: [
                {code:'user.usercode', title: '用户编号', width: 100,formatter:userlist.formatUserid},
                {code:'user.personname', title: '姓名', width: 80,formatter:userlist.formatPersonname},
                {code:'stdrole.orgname', title: '所属机构', width: 150},
                {code:'stdrole.rolename', title: '基本角色', width: 120},
                {code:'user.phoneno', title: '联系方式', width: 120},
                {code:'user.email', title: '邮箱', width: 200},
                {code:'user.state', title: '用户状态', width: 60},
                {code:'operation', title: '操作', formatter:userlist.formatOperation}
            ]
        }).load();
        
        finedo.getradio("state", {
            datasource:"用户状态",
            ctx:"../.."
        });
    },
    formatOperation:function(row){
        var operation = '<a href="javascript:userlist.showModifyDialog(\'' + row.user.userid + '\');">[编辑]</a>&nbsp;';
        operation += '<a href="javascript:finedo.action.doDelete(\'datagrid\',\'../../finedo/user/deleteUser\',\''+row.user.userid+'\')">[删除]</a>&nbsp;';
        if("锁定" == row.user.state){
            operation += '<a href="javascript:userlist.doLockUser(\'unlock\',\''+row.user.userid+'\')">[解锁]</a>&nbsp;';
        }else{
            operation += '<a href="javascript:userlist.doLockUser(\'lock\',\''+row.user.userid+'\')">[锁定]</a>&nbsp;';
            
        }
        return operation;
    },
    formatUserid:function(row){
        return '<a href="javascript:userlist.showDetailDialog(\'' + row.user.userid + '\');">'+row.user.usercode+'</a>&nbsp;';
    },
    formatPersonname:function(row){
        return '<a href="javascript:userlist.showDetailDialog(\'' + row.user.userid + '\');">'+row.user.personname+'</a>&nbsp;';
    },
    // 行信息展开
    doExpandRow:function(data){
        return  "<div class='finedo-data'><ul>" +
	        "<li><span class='finedo-data-name'>用户编号</span><span class='finedo-data-con'>" + data.user.userid + "</span></li>" +
	        "<li><span class='finedo-data-name'>姓名</span><span class='finedo-data-con'>" + data.user.personname + "</span></li>" +
	        "<li><span class='finedo-data-name'>状态</span><span class='finedo-data-con'>" + data.user.state + "</span></li>" +
	        "<li><span class='finedo-data-name'>创建时间</span><span class='finedo-data-con'>" + data.user.createtime + "</span></li>" +
	        "<li><span class='finedo-data-name'>失效时间</span><span class='finedo-data-con'>" + data.user.expdate + "</span></li>" +
	        "<li><span class='finedo-data-name'>性别</span><span class='finedo-data-con'>" + data.user.gender + "</span></li>" +
	        "<li><span class='finedo-data-name'>身份证号码</span><span class='finedo-data-con'>" + finedo.fn.replaceNull(data.user.idnumber) + "</span></li>" +
	        "<li><span class='finedo-data-name'>邮箱</span><span class='finedo-data-con'>" +  finedo.fn.replaceNull(data.user.email) + "</span></li>" +
	        "<li><span class='finedo-data-name'>地址</span><span class='finedo-data-con'>" +  finedo.fn.replaceNull(data.user.address) + "</span></li>" +
	        "</ul></div>";
    },
    doQuery:function(){
        userlist.opquerycond();
        var param = {usercode: $('#usercode').val(), personname: $('#personname').val(), state: $('#state').val(), phoneno: $('#phoneno').val()};
        finedo.getgrid("datagrid").query(param);
    },
    doQueryCancel:function(){
        userlist.opquerycond();
    },
    doQueryFast:function(){
        var text=$('#query-box-text').val();
        var param = {personname:text};
        finedo.getgrid("datagrid").query(param);
    },
    doLockUser:function(locktype, userid){
        finedo.action.doCommand("../../finedo/user/lockUser?userid="+userid+"&locktype="+locktype, function(data){
            userlist.doRefresh();
        }, true);
    },
    showAddDialog:function(){
        finedo.dialog.show({
            width:950,
            height:550,
            'title':'新增信息',
            'url':'../../finedo/user/addpage'
        });
    },
    showModifyDialog:function(userid){
        finedo.dialog.show({
            width:950,
            height:550,
            'title':'修改信息',
            'url':'../../finedo/user/modifyindex?userid=' + userid
        });
    },
    showDetailDialog:function(userid){
        finedo.dialog.show({
            width:850,
            height:550,
            'title':'详情信息',
            'url':'../../finedo/user/detailindex?userid=' + userid
        });
    },
    doRefresh:function(){
        $("#datagrid").grid().refresh();
    },
    doExport:function(){
        var param=finedo.getgrid("datagrid").getqueryparams();
        
        $("#downiframe").attr('src', '../../finedo/user/exportUser' + (param ? '?'+$.param(param) : ''));
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
    userlist.initlist();
});
</script>
</body>
</html>
