<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs2.jsp"%>

<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>

<body>
<div>
    <div class="add-common-head">
        <div class="add-common-name-add">灰度目标管理<br/>
            <ul>
                <li id="common_add_card" class="add-link-li">普通新建</li> 
                <li>|</li>
                <li id="excel_add_card">批量导入</li>
            </ul>
        </div>
    </div>
    <div id="common_add_div">
        <ul class="finedo-ul">
        <form method="post" id="ajaxForm" name="ajaxForm">
            <li>
                <span class="finedo-label-title"><font color=red>*</font>灰度目标：</span>
                <input class="finedo-text" type="text" id="objid" name="objid" value="">
            </li>
            <li>
                <span class="finedo-label-title"><font color=red>*</font>灰度目标：</span>
                <input class="finedo-text" type="text" id="objid" name="objid" value="">
            </li>
            <li>
                <span class="finedo-label-title"><font color=red>*</font>灰度目标：</span>
                <input class="finedo-text" type="text" id="objid" name="objid" value="">
            </li>
            <li>
                <span class="finedo-label-title"><font color=red>*</font>灰度目标：</span>
                <input class="finedo-text" type="text" id="objid" name="objid" value="">
            </li>
            <li>
                <span class="finedo-label-title"><font color=red>*</font>灰度目标：</span>
                <input class="finedo-text" type="text" id="objid" name="objid" value="">
            </li>
        </form>
        </ul>
        <ul>
            <li class="add-center"><input type="button" class="finedo-button" value="提    交" onClick="addgray.dosubmit()" ></li>
        </ul>
    </div>
    <div id="excel_add_div" style="display:none">
        <form method="post" id="importForm" name="importForm">
            <input type="hidden" id="hisid" name="hisid">
            <input type="hidden" id="appid" name="appid">
        </form>
        
        <div class="finedo-nav-title">导入Excel</div>
        <ul class="finedo-ul">
            <li>
                <input type="text" id="uploaddiv" name="uploaddiv" filter=".xls,.xlsx" multiupload="false">
            </li>
        </ul>
        
        <ul>
            <li class="add-center"><input type="button" class="finedo-button" value="提    交" onclick="addgray.doimport();"></li>
        </ul>
        
        <div id="importresultdiv" style="display:none">
            <div class="finedo-nav-title"><font color=red>导入Excel结果</font></div>
            <div class="query-common-con">
                <ul id="importresultul" class="finedo-ul"></ul>
            </div>
        </div>
        
        <div class="finedo-nav-title">导入Excel格式说明</div>
        <ul class="finedo-ul">
            <li>
                 <span class="finedo-label-title">模板下载</span><span class="finedo-label-info"><a href="javascript:addgray.downloadExcel()" >灰度目标批量导入Excel模板 </a></span>
            </li>
            <li>
                <span class="finedo-label-title">第一列：</span><span class="finedo-label-info">灰度目标标识，如手机号码</span>
            </li>
        </ul>
    </div>
    <!-- 表格栏  -->
    <div class="finedo-nav-title">灰度目标清单</div>
    <table id="datagrid"></table>
</div>
<script language="javascript">
var addgray={};
addgray.initadd=function(){
    var appid=finedo.fn.getParameter("appid");
    $("#appid").val(appid);
    $('#common_add_card').click(function(e) {
        $('#common_add_div').css('display', 'block');
        $('#common_add_card').attr('class', 'add-link-li');
        
        $('#excel_add_div').css('display', 'none');
        $('#excel_add_card').removeClass();
        finedo.getFileControl('uploaddiv').reset(false);
    });
    
    $('#excel_add_card').click(function(e) {
        $('#common_add_div').css('display', 'none');
        $('#common_add_card').removeClass();
        
        $('#excel_add_div').css('display', 'block');
        $('#excel_add_card').attr('class', 'add-link-li');
    });
    
    finedo.getFileControl('uploaddiv', {
        ctx:"../.."
    });
    
    finedo.getgrid("datagrid",{
        url:"../../finedo/app/querygray",
        queryparams:{appid:appid},
        columns: [
            {code:'objid', title: '灰度目标', width: 100},
            {code:'operation', title: '操作', formatter:addgray.formatOperation}
        ]
    }).load();
};
addgray.formatOperation=function(row){
    var operation = '<a href="javascript:addgray.dodelete(\'' + row.objid+ '\');">[删除]</a>';
    return operation;
};
addgray.dodelete=function(objid){
    finedo.action.ajax({
        url:"../../finedo/app/deletegray",
        data:{appid:$("#appid").val(),objid:objid},
        callback:function(ret){
            if(ret.fail){
                finedo.message.error(ret.resultdesc);
                return;
            }
            finedo.message.tip(ret.resultdesc);
            finedo.getgrid("datagrid").refresh();
        }
    });
};
addgray.dosubmit=function(){
    var indexval = 1;
    var params={};
    $("input[id^='objid']").each(function(index,obj) {
        var objval = $.trim($(this).val());
        if(finedo.fn.isnotnon(objval)){
            params["objid_"+indexval] = objval;
            params["appid_"+indexval] = $("#appid").val();
            indexval++;
        }
    });
    params['counterstr']=indexval.toString();
    params['indexstr']="1";
    params['seperator']="_";
    finedo.action.ajax({
        url:"../../finedo/app/addgray",
        data:params,
        callback:function(ret){
            if(ret.fail){
                finedo.message.error(ret.resultdesc);
                return;
            }
            finedo.message.tip(ret.resultdesc);
            $("input[id^='objid']").each(function(index,obj) {
                $(this).val('');
            });
            finedo.getgrid("datagrid").refresh();
        }
    });
};
addgray.downloadExcel=function(){
    window.open('../../fsdp/app/import.xlsx');
};
addgray.doimport=function(){
    var fileControl=finedo.getFileControl('uploaddiv');
    var filearr=fileControl.getFileList();
    if(filearr.length != 1) {
        finedo.message.error("未上传Excel文件");
        return;
    }
    $('#hisid').val(filearr[0].fileid);
    finedo.action.ajaxForm({
        form:"importForm",
        url:"../../finedo/app/importgray",
        callback:function(retdata){
            if(retdata.fail){
                finedo.message.error(retdata.resultdesc);
                return;
            }
            finedo.message.info(retdata.resultdesc);
            $('#hisid').val('');
            finedo.getgrid("datagrid").refresh();
            addgray.importcallback(retdata);
        },
        clearForm:false
    });
};
addgray.importcallback=function(jsondata){
    $('#importresultdiv').css('display', 'block');
    var resulthtml="<li><span class='finedo-label-title'>导入情况</span><span class='finedo-label-info'><font color=red>" + jsondata.resultdesc + "   总记录数: " + jsondata.object.rowcount + " &nbsp;&nbsp; 成功记录数: " + jsondata.object.successcount + "&nbsp;&nbsp; 失败记录数: " + jsondata.object.failcount + "</font></span></li>";
    var faillist=eval(jsondata.object.faillist);
    for(var i=0; i<faillist.length; i++)  {
        resulthtml += "<li><span class='finedo-label-title'>失败明细</span><span class='finedo-label-info'>" + faillist[i].resultdesc + "</span></li>";
    }
    $('#importresultul').html(resulthtml);
};
</script>
<script type='text/javascript' src='../../resource/js/lazyload.js'></script>
<script language="javascript">
LazyLoad.css([
    '../../resource/themes/default/style.css',
    '../../resource/js/finedoui/commonui/themes/commonui.css',
    '../../resource/js/finedoui/dialog/themes/style.css',
    '../../resource/js/finedoui/grid/themes/style.css',
    '../../resource/js/finedoui/upload/themes/style.css'
    ]);
LazyLoad.js([
    '../../resource/js/jquery/jquery-1.11.0.js',
    '../../resource/js/jquery/jquery.form.js',
    '../../resource/js/finedoui/base/finedo.core.js',
    '../../resource/js/finedoui/commonui/finedo.commonui.js',
    '../../resource/js/finedoui/dialog/finedo.dialog.js',
    '../../resource/js/finedoui/grid/finedo.grid.js',
    '../../resource/js/finedoui/upload/finedo.upload.js'
    ], function() {
    addgray.initadd();
});
</script>
</body>
</html>


