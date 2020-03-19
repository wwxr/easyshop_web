<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs2.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>
<body>
<div>
	<div class="add-common-head">
    	<div class="add-common-name-add">模块权限视图管理<br/>
            <ul>
            	<li id="module_card" class="add-link-li">功能模块管理</li> 
            	<li>|</li>
                <li id="permissionview_card">权限视图管理</li>
            </ul>
        </div>
    </div>
    <div id="module_div" >
		<form id="moduleform" name="moduleform" method="post">
    	<div style=" width:18%; float: left; border:1px solid #ddd; position: fixed; top:60px; left:5px; bottom:10px; overflow-y:auto; overflow-x:auto;">
			<div class="tree-name">功能模块</div>
			<ul id="moduletree" class="fdtree" style="margin-left:5px;"></ul>
		</div>
		<div style="width:78%; float:right; margin-top:20px; margin-right:2%;">
			<div class="add-common-head">
		    	<div class="add-common-name-add">模块信息<br/>
			    	<ul>
		            	<li id="modifymodule_card" class="add-link-li">修改模块信息</li> 
		            	<li>|</li>
		                <li id="addmodule_card">增加模块信息</li>
		            	<li>|</li>
		                <li id="modulepermission_card">模块权限信息</li>
		            </ul>
	            </div>
			</div>
			<div id="module_info_div" >
				<div class="finedo-nav-title">基本信息</div>
				<table class="finedo-table">
		    		<input type="hidden" id="moduleid" name="moduleid">
		    		<input type="hidden" id="state" name="state" value="有效">
		    		<input type="hidden" id="version" name="version" value="1">
				    <tr>
				        <td class="finedo-label-title"><font color=red>*</font>功能模块包：</td>
				        <td>
				        	<input type="text" id="packageid">
				        </td>
				        <td class="finedo-label-title"><font color=red>*</font>功能模块名称：</td>
				        <td>
				    		<input class="finedo-text" type="text" id="modulename" name="modulename" maxlength="200">
				        </td>
				    </tr>
				    <tr>
				        <td class="finedo-label-title">功能模块描述：</td>
				        <td colspan="3">
				        	<input class="finedo-text" type="text" id="moduledesc" name="moduledesc" style="width:90%;">
				        </td>
				    </tr>
				</table>
				<ul>
			    	<li class="add-center">
			    		<input type="button" class="finedo-button" value="提    交" onClick="moduleview.doSaveModule()" >&nbsp;&nbsp;&nbsp;
			    		<input type="button" class="finedo-button" id="moduledeletebtn" value="删    除" onClick="moduleview.doDeleteModule()" >
			    	</li>
			    </ul>
			</div>
			<div id="modulepermission_info_div" style="display:none;">
				<div class="finedo-nav-title" id="modulepermissiontitle">权限信息</div>
				<table class="finedo-table">
				    <tr>
				        <td class="finedo-label-title"><font color=red>*</font>权限ID：</td>
				        <td>
				        	<input class="finedo-text" type="text" id="modulepermissionid" name="modulepermissionid" maxlength="50">
				        </td>
				        <td class="finedo-label-title"><font color=red>*</font>权限名称：</td>
				        <td>
				    		<input class="finedo-text" type="text" id="permissionname" name="permissionname" maxlength="200">
				        </td>
				    </tr>
				</table>
				<ul>
			    	<li class="add-center">
			    		<input type="button" class="finedo-button" id="modulepermissionaddbtn" value="新    增" onClick="moduleview.doSaveModulePermission('permissionadd')" >&nbsp;&nbsp;&nbsp;&nbsp;
			    		<input type="button" class="finedo-button" id="modulepermissionupdatebtn" style="display:none" value="修    改" onClick="moduleview.doSaveModulePermission('permissionupdate')" >
			    	</li>
			    </ul>
				<table id="modulepermissiongrid" ></table>
			</div>
		</div>
		</form>
    </div>
    <div id="permissionview_div" style="display:none;">
		<form id="permissionviewform" name="permissionviewform" method="post">
		<div style=" width:18%; float: left; border:1px solid #ddd; position: fixed; top:60px; left:5px; bottom:10px; overflow-y:auto; overflow-x:auto;">
			<div class="tree-name">权限视图</div>
			<ul id="permissionviewtree" class="fdtree" style="margin-left:5px;"></ul>
		</div>
		<div style="width:78%; float:right; margin-top:20px; margin-right:2%;">
			<div class="add-common-head">
		    	<div class="add-common-name-add">视图信息<br/>
			    	<ul>
		            	<li id="modifyviewtree_card" class="add-link-li">修改视图信息</li>
		            	<li>|</li>
		                <li id="addviewtree_card">增加下级视图信息</li>
		            	<li>|</li>
		                <li id="addoneviewtree_card">增加一级视图信息</li>
		            </ul>
	            </div>
			</div>
	    	<table class="finedo-table">
	    		<input type="hidden" id="parentnodeid" name="parentnodeid">
	    		<input type="hidden" id="orderseq" name="orderseq">
			    <tr>
			        <td class="finedo-label-title"><font color=red>*</font>权限视图：</td>
			        <td colspan="3">
			        	<input type="text" id="viewid">
			        </td>
			    </tr>
			    <tr>
			        <td class="finedo-label-title"><font color=red>*</font>节点ID：</td>
			        <td>
			        	<input type="text" class="finedo-text" id="nodeid" name="nodeid" maxlength="50">
			        </td>
			        <td class="finedo-label-title"><font color=red>*</font>节点名称：</td>
			        <td>
			    		<input class="finedo-text" type="text" id="nodename" name="nodename" maxlength="200">
			        </td>
			    </tr>
			    <tr>
			        <td class="finedo-label-title">功能权限：</td>
			        <td style="padding-left:5px;">
			        	<select name="permissionid" id="permissionid" style="width:250px"></select>
			        </td>
			        <td class="finedo-label-title"><font color=red>*</font>导航菜单：</td>
			        <td>
			        	<input type="text" id="isnavigation"></input>
			        </td>
			    </tr>
			    <tr>
			        <td class="finedo-label-title">导航菜单URL：</td>
			        <td colspan="3">
			        	<input class="finedo-text" type="text" id="permissionentry" name="permissionentry" style="width:90%;" maxlength="500">
			        </td>
			    </tr>
			    <tr>
			        <td class="finedo-label-title">备注：</td>
			        <td colspan="3">
			        	<input class="finedo-text" type="text" id="remark" name="remark" style="width:90%;">
			        </td>
			    </tr>
			</table>
			<ul>
		    	<li class="add-center">
		    		<input type="button" class="finedo-button" value="提    交" onClick="moduleRight.doSaveViewtree()" >&nbsp;&nbsp;&nbsp;
		    		<input type="button" id="deleteviewtreebtn" style="display:none" class="finedo-button" value="删    除" onClick="moduleRight.doDeleteViewtree()" >
		    	</li>
		    </ul>
	   	</div>
		</form>
	</div>
</div>
<script language="javascript">
var modulepermission={
    currentRightView:{},
    permissionViewOptype:"modify",
    viewtreelist:[],
    currentModule:undefined,
    moduleOptype:"modify",
    modulepermissionData:[],
    init:function(){
        /************** 功能模块管理****************/
        $('#modifymodule_card').click(function(e) {
            $('#module_info_div').css('display', 'block');
            $('#modifymodule_card').attr('class', 'add-link-li');
            
            $('#modulepermission_info_div').css('display', 'none');
            $('#addmodule_card').removeClass();
            $('#modulepermission_card').removeClass();
            
            modulepermission.moduleOptype="modify";
            moduleview.showModule();
            $("#moduledeletebtn").show();
        });
        $('#addmodule_card').click(function(e) {
            $('#module_info_div').css('display', 'block');
            $('#addmodule_card').attr('class', 'add-link-li');
            
            $('#modulepermission_info_div').css('display', 'none');
            $('#modifymodule_card').removeClass();
            $('#modulepermission_card').removeClass();
            
            modulepermission.moduleOptype="add";
            moduleview.clearModule();
            $("#moduledeletebtn").hide();
        });
        $('#modulepermission_card').click(function(e) {
            $('#modulepermission_info_div').css('display', 'block');
            $('#modulepermission_card').attr('class', 'add-link-li');
            
            $('#module_info_div').css('display', 'none');
            $('#modifymodule_card').removeClass();
            $('#addmodule_card').removeClass();
        });
        moduleview.loadModuleTree(true);
        moduleview.initPackage();
        moduleview.loadModulePermission();
        moduleview.initModulePermissionGrid();
        /************** 功能模块管理 END****************/
        
        $('#permissionview_card').click(function(e) {
            $('#permissionview_div').css('display', 'block');
            $('#permissionview_card').attr('class', 'add-link-li');
            
            $('#module_div').css('display', 'none');
            $('#module_card').removeClass();
        });
        
        $('#module_card').click(function(e) {
            $('#permissionview_div').css('display', 'none');
            $('#permissionview_card').removeClass();
            
            $('#module_div').css('display', 'block');
            $('#module_card').attr('class', 'add-link-li');
        });
        
        $('#modifyviewtree_card').click(function(e) {
            $('#modifyviewtree_card').attr('class', 'add-link-li');
            $('#addviewtree_card').removeClass();
            $('#addoneviewtree_card').removeClass();
            modulepermission.permissionViewOptype = "modify";
            moduleRight.showRightView();
            $("#deleteviewtreebtn").show();
        });
        $('#addviewtree_card').click(function(e) {
            $('#addviewtree_card').attr('class', 'add-link-li');
            $('#modifyviewtree_card').removeClass();
            $('#addoneviewtree_card').removeClass();
            modulepermission.permissionViewOptype = "add";
            //增加权限视图数据，清空信息
            moduleRight.clearRightViewCtl();
            $("#deleteviewtreebtn").hide();
        });
        $('#addoneviewtree_card').click(function(e){
            $('#addoneviewtree_card').attr('class', 'add-link-li');
            $('#modifyviewtree_card').removeClass();
            $('#addviewtree_card').removeClass();
            modulepermission.permissionViewOptype = "add";
            moduleRight.clearRightViewCtl();
            $("#parentnodeid").val("0");
            $("#deleteviewtreebtn").hide();
        });
        //初始化权限视图
        moduleRight.loadViewtree(true);
        //初始化是否为导航菜单
        var options={
            data:[
                {"code":"是", "value":"是"},
                {"code":"否", "value":"否"}
            ],
            value:"否"   /*当前值*/
        };
        finedo.getradio("isnavigation", options);
        moduleRight.initView();
    }
};
var moduleview={
    loadModuleTree:function(isinit){
        finedo.action.ajax({
            url:"../../finedo/module/query?page=1&rows=100000000",
            callback:function(jsondata){
	            var modulelist = [];
	            modulelist.push({"id":"modulerootnode", "pid":"0", "name":"功能模块", "open":true});
	            for(var i = 0; i < jsondata.rows.length; i++){
	                var curmodule = jsondata.rows[i];
	                curmodule.id = curmodule.moduleid;
	                curmodule.pid = "modulerootnode";
	                curmodule.name = curmodule.modulename;
	                curmodule.open = true;
	                modulelist.push(curmodule);
	            }
	            if(isinit){
	                finedo.getTree('moduletree',{
	                    simple:true,
	                    nodes:modulelist,
	                    onclick:moduleview.moduleTreeClick
	                });
	                return;
	            }
	            finedo.getTree('moduletree').loaddata(modulelist);
            }
        });
    },
    moduleTreeClick:function(treenode){
        if(treenode.id == 'modulerootnode'){
            return;
        }
        modulepermission.currentModule = treenode;
        $('#modifymodule_card').trigger("click");
        moduleview.showModule();
        moduleview.loadModulePermissionGrid();
    },
    doSaveModule:function(){
        var result=finedo.validate({
            "packageid":{label:"功能模块包", datatype:"string", maxlength:50, required:true},
            "modulename":{label:"功能模块名称", datatype:"string", maxlength:200, required:true}
        }, true);
        if(!result){
            return;
        }
        var action = "";
        if(modulepermission.moduleOptype == "modify"){
            action = '../../finedo/module/modify';
        }else if(modulepermission.moduleOptype == "add"){
            action = '../../finedo/module/add';
            $("#state").val("有效");
            $("#version").val("1");
        }
        var form = $("#moduleform");
        var options = {     
            url:       action,
            success:   function(jsondata){
                finedo.message.hideWaiting();
                if(jsondata.fail){
                    finedo.message.error(jsondata.resultdesc);
                    return;
                }
                finedo.message.tip(jsondata.resultdesc);
                moduleview.loadModuleTree(false);
            },
            type:      'POST',
            dataType:  "json"
        };
        finedo.message.showWaiting();
        form.ajaxSubmit(options);
    },
    doDeleteModule:function(){
        if(!modulepermission.currentModule && !modulepermission.currentModule.moduleid){
            return;
        }
        finedo.message.question("模块删除将同时删除对应功能权限数据，您确定删除该功能模块吗？", null, function(which){  
            if (which){
                finedo.action.ajax({
                    url:"../../finedo/module/delete",
                    data:{id:modulepermission.currentModule.moduleid},
                    callback:function(jsondata){
	                    if(jsondata.fail){
	                        finedo.message.error(jsondata.resultdesc);
	                        return;
	                    }
	                    finedo.message.tip(jsondata.resultdesc);
	                    moduleview.clearModule(true);
	                    modulepermission.currentModule = undefined;
	                    moduleview.loadModuleTree(false);
	                    moduleview.loadModulePermission(true);
                    }
                });
            }
        });
    },
    showModule:function(){
        if(!modulepermission.currentModule){
            return;
        }
        $("#moduleid").val(modulepermission.currentModule.moduleid);
        $("#state").val(modulepermission.currentModule.state);
        $("#version").val(modulepermission.currentModule.version);
        $("#modulename").val(modulepermission.currentModule.modulename);
        $("#moduledesc").val(modulepermission.currentModule.moduledesc);
        finedo.getselect("packageid").setvalue(modulepermission.currentModule.packageid);
    },
    clearModule:function(isdelete){
        $("#state").val("");
        $("#version").val("");
        if(isdelete){
            $("#moduleid").val("");
            $("#modulename").val("");
            $("#moduledesc").val("");
        }
        finedo.getselect("packageid").setvalue("");
    },
    initPackage:function(){
        finedo.action.ajax({
            url:"../../finedo/module/querypackage",
            callback:function(jsondata){
	            if(jsondata.fail){
	                finedo.message.error(jsondata.resultdesc);
	                return;
	            }
	            var packagelist = [];
	            for(var i = 0; i < jsondata.object.length; i++){
	                packagelist.push({"code":jsondata.object[i].packageid, "value":jsondata.object[i].packagename});
	            }
	            var options={
	                type:"single",
	                data:packagelist
	            };
	            finedo.getselect("packageid", options);
            }
        });
    },
    loadModulePermission:function(isreload){
        finedo.action.ajax({
            url:"../../finedo/permission/querymodulepermission?page=1&rows=100000000",
            callback:function(jsondata){
	            if(!jsondata.rows){
	                return;
	            }
	            modulepermission.modulepermissionData = jsondata.rows;
	            moduleview.loadModulePermissionGrid();
	            moduleRight.initModulePermission(isreload);
            }
        });
    },
    initModulePermissionGrid:function(){
        var tableOptions = {    
            pagination: false,
            columns: [
                { code: 'permissionid', title: '权限ID', width: 100},
                { code: 'permissionname', title: '权限名称', width: 200},
                { code: 'moduleid', title: '功能模块ID', width: 100},
                { code: 'modulename', title: '功能模块名称', width: 200},
                { code: 'operation', title: '操作', formatter:moduleview.formatOperation}
            ]
        } ;
        finedo.getgrid("modulepermissiongrid",tableOptions);
    },
    loadModulePermissionGrid:function(){
        if(!modulepermission.currentModule){
            finedo.getgrid("modulepermissiongrid").load([]);
            return;
        }
        var modulepermissionlist = [];
        for(var i = 0; i < modulepermission.modulepermissionData.length; i++){
            if(modulepermission.currentModule.moduleid == modulepermission.modulepermissionData[i].moduleid){
                modulepermissionlist.push(modulepermission.modulepermissionData[i]);
            }
        }
        finedo.getgrid("modulepermissiongrid").load(modulepermissionlist);
    },
    formatOperation:function(row){
        var operation = '<a href="javascript:moduleview.showModulePermission(\'' + row.permissionid + '\',\'' + row.permissionname + '\');">[编辑]</a>&nbsp;';
        operation += '<a href="javascript:moduleview.doDeleteModulePermission(\'' + row.permissionid + '\')">[删除]</a>';
        return operation;
    },
    showModulePermission:function(permissionid, permissionname){
        $("#modulepermissionid").val(permissionid);
        $("#permissionname").val(permissionname);
        $("#modulepermissionaddbtn").show();
        $("#modulepermissionupdatebtn").show();
    },
    doSaveModulePermission:function(permissionoptype){
        var result=finedo.validate({
            "moduleid":{label:"功能模块ID", datatype:"string", maxlength:50, required:true},
            "modulepermissionid":{label:"权限ID", datatype:"string", maxlength:50, required:true},
            "permissionname":{label:"权限名称", datatype:"string", maxlength:200, required:true}
        }, true);
        if(!result){
            return;
        }
        var action = "";
        if(permissionoptype == "permissionadd"){
            action = "../../finedo/permission/add";
        }else if(permissionoptype == "permissionupdate"){
            action = "../../finedo/permission/modify";
        }
        var modulepermissionid = $.trim($("#modulepermissionid").val());
        var form = $("#moduleform");
        var options = {     
            url:       action+'?permissionid='+modulepermissionid,
            success:   function(jsondata){
                finedo.message.hideWaiting();
                if(jsondata.fail){
                    finedo.message.error(jsondata.resultdesc);
                    return;
                }
                finedo.message.tip(jsondata.resultdesc);
                $("#modulepermissionid").val("");
                $("#permissionname").val("");
                $("#modulepermissionaddbtn").show();
                $("#modulepermissionupdatebtn").hide();
                moduleview.loadModulePermission(true);
            },
            type:      'POST',
            dataType:  "json"
        };
        finedo.message.showWaiting();
        form.ajaxSubmit(options);
    },
    doDeleteModulePermission:function(permissionid){
        finedo.message.question("您确定删除该权限信息吗？", null, function(which){  
            if (which){ 
                finedo.action.ajax({
                    url:"../../finedo/permission/delete",
                    data:{id:permissionid},
                    callback:function(jsondata){
	                    if(jsondata.fail){
	                        finedo.message.error(jsondata.resultdesc);
	                        return;
	                    }
	                    finedo.message.tip(jsondata.resultdesc);
	                    moduleview.loadModulePermission(true);
                    }
                });
            }
        });
    }
};

moduleRight={
    initModulePermission:function(isreload){
        var modulepermissionlist = [];
        for(var i = 0; i < modulepermission.modulepermissionData.length; i++){
            modulepermissionlist.push({"id":modulepermission.modulepermissionData[i].permissionid, "text":modulepermission.modulepermissionData[i].permissionid+":"+modulepermission.modulepermissionData[i].permissionname});
        }
        finedo.select2({
            "componentname":"permissionid",
            "tipmsg":"请输入功能权限名称",
            "inputlength":1,
            "idname":"permissionid",
            "textname":"permissionname",
            "data":modulepermissionlist,
            "reload":isreload
        });
    },
    loadViewtree:function(isinit){
        finedo.action.ajax({
            url:"../../finedo/permission/queryperimissionview",
            callback:function(jsondata){
	            if(jsondata.fail){
	                finedo.message.error(jsondata.resultdesc);
	                return;
	            }
	            modulepermission.viewtreelist = jsondata.object;
	            for(var i = 0; i < modulepermission.viewtreelist.length; i++){
	                modulepermission.viewtreelist[i].id=modulepermission.viewtreelist[i].nodeid;
	                modulepermission.viewtreelist[i].pid=modulepermission.viewtreelist[i].parentnodeid;
	                modulepermission.viewtreelist[i].name=modulepermission.viewtreelist[i].nodename;
	                modulepermission.viewtreelist[i].open=true;
	            }
	            if(isinit){
	                finedo.getTree('permissionviewtree',{
	                    simple:true,
	                    nodes:modulepermission.viewtreelist,
	                    onclick:moduleRight.permissionViewClick
	                });
	                return;
	            }
	            finedo.getTree('permissionviewtree').loaddata(modulepermission.viewtreelist);
            }
        });
    },
    permissionViewClick:function(nodedata){
        $('#modifyviewtree_card').trigger("click");
        modulepermission.currentRightView = nodedata;
        moduleRight.showRightView();
        moduleRight.candelete();
    },
    showRightView:function(){
        if(!modulepermission.currentRightView){
            return;
        }
        $("#parentnodeid").val(modulepermission.currentRightView.parentnodeid);
        $("#orderseq").val(modulepermission.currentRightView.orderseq);
        finedo.getselect('viewid').setvalue(modulepermission.currentRightView.viewid);
        $("#nodeid").val(modulepermission.currentRightView.nodeid);
        $("#nodename").val(modulepermission.currentRightView.nodename);
        $("#permissionid").val(modulepermission.currentRightView.permissionid).trigger("change");
        finedo.getradio("isnavigation").setvalue(modulepermission.currentRightView.isnavigation);
        $("#permissionentry").val(modulepermission.currentRightView.permissionentry);
        $("#remark").val(modulepermission.currentRightView.remark);
    },
    clearRightViewCtl:function(){
        if(!modulepermission.currentRightView){
            return;
        }
        $("#parentnodeid").val(modulepermission.currentRightView.nodeid);
        $("#orderseq").val("");
        finedo.getselect('viewid').setvalue("");
        $("#nodeid").val("");
        $("#nodename").val("");
        $("#permissionid").val("").trigger("change");
        finedo.getradio("isnavigation").setvalue(modulepermission.currentRightView.isnavigation);
        $("#permissionentry").val("");
        $("#remark").val("");
    },
    doSaveViewtree:function(){
        var result=finedo.validate({
            "nodeid":{label:"节点ID", datatype:"string", maxlength:100, required:true},
            "nodename":{label:"节点名称", datatype:"string", maxlength:100, required:true}
        }, true);
        if(!result){
            return;
        }
        var isnav = finedo.getradio("isnavigation").getvalue();
        if(isnav == '是'){
            if($.trim($("#permissionentry").val()) == ''){
                finedo.message.warning('请输入导航菜单URL');
                return;
            }
        }
        var action = "";
        if(modulepermission.permissionViewOptype == "modify"){
            action = '../../finedo/permission/permissionviewmodify';
        }else if(modulepermission.permissionViewOptype == "add"){
            action = '../../finedo/permission/permissionviewadd';
            $("#orderseq").val($("#nodeid").val());
        }
        var form = $("#permissionviewform");
        var options = {     
            url:       action,
            success:   function(jsondata){
                finedo.message.hideWaiting();
                if(jsondata.fail){
                    finedo.message.error(jsondata.resultdesc);
                    return;
                }
                finedo.message.tip(jsondata.resultdesc);
                moduleRight.loadViewtree(false);
            },
            type:      'POST',
            dataType:  "json"
        };
        finedo.message.showWaiting();
        form.ajaxSubmit(options);
    },
    /**
     * 判断当前节点能否删除，如果可以则显示删除按钮。只有叶子节点才能删除
     */
    candelete:function(){
        var showdeletebtn = true;
        if(modulepermission.currentRightView.children && modulepermission.currentRightView.children.length > 0){
            showdeletebtn = false;
        }
        if(showdeletebtn == true){
            $("#deleteviewtreebtn").show();
        }else{
            $("#deleteviewtreebtn").hide();
        }
    },
    doDeleteViewtree:function(){
        finedo.message.question("您确定删除该权限视图信息吗？", null, function(which){  
            if (which){ 
                finedo.action.ajax({
                    url:"../../finedo/permission/permissionviewdelete",
                    data:{id:modulepermission.currentRightView.nodeid},
                    callback:function(jsondata){
	                    if(jsondata.fail){
	                        finedo.message.error(jsondata.resultdesc);
	                        return;
	                    }
	                    finedo.message.tip(jsondata.resultdesc);
	                    moduleRight.clearRightViewCtl();
	                    modulepermission.currentRightView = undefined;
	                    moduleRight.loadViewtree(false);
                    }
                });
            }
        });
    },
    initView:function(){
        finedo.action.ajax({
            iswait:false,
            url:"../../finedo/permission/queryview",
            callback:function(jsondata){
	            if(jsondata.fail){
	                finedo.message.error(jsondata.resultdesc);
	                return;
	            }
	            var viewlist = [];
	            for(var i = 0; i < jsondata.object.length; i++){
	                viewlist.push({"code":jsondata.object[i].viewid, "value":jsondata.object[i].viewname});
	            }
	            var options={
	                type:"single",
	                data:viewlist
	            };
	            finedo.getselect("viewid", options);
            }
        });
    }
};
</script>
<script type='text/javascript' src='../../resource/js/lazyload.js'></script>
<script language="javascript">
LazyLoad.css([
    '../../resource/themes/default/style.css',
    '../../resource/js/finedoui/commonui/themes/commonui.css',
    '../../resource/js/finedoui/dialog/themes/style.css',
    '../../resource/js/finedoui/grid/themes/style.css',
    '../../resource/js/finedoui/tree/themes/style.css',
    '../../resource/js/select2/css/select2.min.css'
    ]);
LazyLoad.js([
    '../../resource/js/jquery/jquery-1.11.0.js',
    '../../resource/js/jquery/jquery.form.js',
    '../../resource/js/finedoui/base/finedo.core.js',
    '../../resource/js/finedoui/commonui/finedo.commonui.js',
    '../../resource/js/finedoui/dialog/finedo.dialog.js',
    '../../resource/js/finedoui/grid/finedo.grid.js',
    '../../resource/js/finedoui/tree/finedo.tree.js',
    '../../resource/js/select2/js/select2.full.min.js',
    '../../resource/js/select2/js/i18n/zh-CN.js'
    ], function() {
    modulepermission.init();
});
</script>
</body>
</html>
