<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs2.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>修改静态数据</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<style>
.finedo-table input{width:80%;}
</style>
</head>
<body>
<div>
    <div class="add-common-head">
        <div class="add-common-name-add">修改静态数据<br/>
        </div>
        <input type="button" class="finedo-button-blue" style="float:right" value="提交" onclick="staticdatamodify.dosubmit();">
    </div>
    
    <form method="post" id="ajaxForm" name="ajaxForm">
    <input type="hidden" id="typeid" name="typeid">
    <div id="common_add_div" >
        <div class="finedo-nav-title">数据类型</div>
        <ul class="finedo-ul">
            <li>
                <span class="finedo-label-title"><font color=red>*</font>功能模块</span>
                <input type="text" id="moduleid"></input>
            </li>
            <li>
                <span class="finedo-label-title"><font color=red>*</font>配置类型</span>
                <input type="text" id="configtype"></input>
            </li>
            <li>
                <span class="finedo-label-title"><font color=red>*</font>类型名称</span>
                <input type="hidden" name="datatype" value="字符串"/>
                <input class="finedo-text" type="text" id="typename" name="typename" value="" title="类型名称不能为空，请填写类型名称">
            </li>
            <li>
                <span class="finedo-label-title"><font color=red>*</font>数据级别</span>
                <input type="text" id="lvl"></input>
            </li>
            <li id="sqlli" style="display:none;">
                <span class="finedo-label-title"><font color=red>*</font>SQL语句</span>
                <input class="finedo-text" type="text" id="sqlscript" name="sqlscript" value="" style="width:80%;">
                <input type="button" class="finedo-button" value="预览" onClick="staticdatamodify.previewsql()" >
            </li>
            <li>
                <span class="finedo-label-title">类型说明</span>
                <input class="finedo-text" type="text" id="typedesc" name="typedesc" value="" style="width:80%;">
            </li>
        </ul>
        <div class="finedo-nav-title">数据项</div>
        <div id="dataitems">
            <table class="finedo-table" id="datatable">
                <tr>
                    <th>数据标签</th>       
                    <th>数据值</th> 
                    <th>排序</th>
                    <th>备注</th> 
                    <th>
                       <input type="button" class="finedo-button" value="添加数据项" onClick="staticdatamodify.additem()" >
                    </th> 
                </tr>
                <tr>
                    <td>
                        <input class="finedo-text" type="text" id="data_attrname" name="data_attrname" value="">
                    </td>
                    <td>
                        <input class="finedo-text" type="text" id="data_attrvalue" name="data_attrvalue" value="">
                    </td>
                    <td>
                        <input class="finedo-text" type="text" id="data_orderseq" name="data_orderseq" value="" onkeypress="staticdatamodify.checkInteger(this)" onblur="staticdatamodify.checkInteger(this)">
                    </td>
                    <td>
                        <input class="finedo-text" type="text" id="data_remark" name="data_remark" value="">
                    </td>
                    <td>
                        <input type="button" class="finedo-button" value="删除" onClick="staticdatamodify.deleteitem(this);" >
                    </td>
                </tr>
            </table>
        </div>
        <ul>
            <li class="add-center"><input type="button" class="finedo-button" value="提    交" onClick="staticdatamodify.dosubmit()" ></li>
        </ul>
    </div>
    </form>
</div>
<script language="javascript">
var staticdatamodify={
    initstaticdata:function(){
        var typeid = finedo.fn.getParameter("typeid");
        $("#typeid").val(typeid);
        finedo.action.ajax({
            url:"../../finedo/staticdata/queryStaticdataById",
            data:{"typeid":typeid},
            callback:function(retdata){
                if(retdata.fail){
                    finedo.message.error(retdata.resultdesc);
                    return;
                }
                var staticdata = retdata.object;
                $("#typename").val(staticdata.statictype.typename);
                $("#typedesc").val(staticdata.statictype.typedesc);
                
                finedo.getselect("moduleid", {
                    datasource:"功能模块",
                    ctx:"../..",
                    value:staticdata.statictype.moduleid
                });
                finedo.getradio("configtype", {
                    datasource:"静态数据类型",
                    value:staticdata.statictype.configtype,
                    ctx:"../..",
                    onchange:function(itemvalue){
                        if(itemvalue == "keyvalue"){
                            $("#dataitems").show();
                            $("#sqlli").hide();
                            return;
                        }
                        $("#dataitems").hide();
                        $("#sqlli").show();
                    }
                });
                finedo.getselect("lvl", {
                    datasource:"静态数据级别",
                    ctx:"../..",
                    value:staticdata.statictype.lvl
                });
                
                //数据项判断
                if(staticdata.statictype.configtype == "sql"){
                    $("#dataitems").hide();
                    $("#sqlli").show();
                    $("#sqlscript").val(staticdata.staticsql.sqlscript);
                    return;
                }
                var itemlist = staticdata.staticdatalist;
                if(finedo.fn.isnon(itemlist)){
                    return;
                }
                var tr = $("#datatable").find("tr:last").clone();
                $("#datatable").find("tr:last").remove();
                for(var itemindex = 0; itemindex < itemlist.length; itemindex++){
                    var dataitem = itemlist[itemindex];
                    var itemtr = tr.clone();
                    itemtr.find("input[name='data_attrname']").val(dataitem.attrname);
                    itemtr.find("input[name='data_attrvalue']").val(dataitem.attrvalue);
                    itemtr.find("input[name='data_orderseq']").val(dataitem.orderseq);
                    itemtr.find("input[name='data_remark']").val(dataitem.remark);
                    $("#datatable").append(itemtr);
                }
            }
        });
        
    },
    //数据验证
    checkdata:function() {
        /**
         *   通用数据验证
         *   label       名称
         *   datatype    数据类型  string email phone url date datetime time number digits 
         *   minlength   最小长度
         *   maxlength   最大长度
         *   required    是否必填 true/false
         */
         var result=finedo.validate({
             "moduleid":{label:"功能模块", datatype:"string", maxlength:50, required:true},
             "configtype":{label:"配置类型", datatype:"string", maxlength:200, required:true},
             "typename":{label:"类型名称", datatype:"string", required:true},
             "lvl":{label:"数据级别", datatype:"string", maxlength:50, required:true}
         }, true);
        if(!result){
            return result;
        }
        var configtype = finedo.getradio("configtype").getvalue();
        if(configtype == "sql"){
            if(finedo.fn.isnon($.trim($("#sqlscript").val()))){
                finedo.message.warning("请输入SQL语句！");
                return false;
            }
            return true;
        }
        var inputs = $("#datatable").find("input");
        var hasError = false;
        $.each(inputs,function(){
            var input = $(this);
            if(input.attr("type")=='text'&&input.attr("name")!="data_remark"){
                if($.trim(input.val())==""){
                    input.css("border","1px solid red");
                    hasError = true;
                }
            }
        });
        result = !hasError;
        return result;
     },
     dosubmit:function() {
         if(!staticdatamodify.checkdata()) 
             return;
         finedo.action.ajaxForm({
             form:"ajaxForm",
             url:"../../finedo/staticdata/modifyStaticdata",
             callback:function(jsondata){
                 if(jsondata.fail){
                     finedo.message.error(jsondata.resultdesc);
                     return;
                 }
                 finedo.message.info(jsondata.resultdesc);
             }
         });
     },
     additem:function(){
         var tr = $("#datatable").find("tr:last").clone();
         tr.find("td:last").html('<input type="button" class="finedo-button" value="删除" onClick="staticdatamodify.deleteitem(this);" >');
         $("#datatable").append(tr);
     },
     deleteitem:function(obj){
         var tr = $(obj).parent().parent();
         tr.remove();
     },
     checkInteger:function(input){
         var obj = $(input);
         obj.val(obj.val().replace(/[^\d.]/g,""));//清除“数字”和“.”以外的字符   
         obj.val(obj.val().replace(/^\./g,""));//验证第一个字符是数字而不是.   
         obj.val(obj.val().replace(/\.{2,}/g,"."));//只保留第一个. 清除多余的.  
         obj.val(obj.val().replace(".","$#$").replace(/\./g,"").replace("$#$","."));
     },
     previewsql:function(){
         var sql = $.trim($("#sqlscript").val());
         if(finedo.fn.isnon(sql)){
             finedo.message.warning("请输入要预览的SQL");
             return;
         }
         finedo.dialog.showDialog({
             width:800,
             height:450,
             'url':'../../fsdp/staticdata/previewsql.jsp'
         });
     }
};
</script>
<script type='text/javascript' src='../../resource/js/lazyload.js'></script>
<script language="javascript">
LazyLoad.css([
    '../../resource/themes/default/style.css',
    '../../resource/js/finedoui/commonui/themes/commonui.css',
    '../../resource/js/finedoui/dialog/themes/style.css'
    ]);
LazyLoad.js([
    '../../resource/js/jquery/jquery-1.11.0.js',
    '../../resource/js/jquery/jquery.form.js',
    '../../resource/js/finedoui/base/finedo.core.js',
    '../../resource/js/finedoui/commonui/finedo.commonui.js',
    '../../resource/js/finedoui/dialog/finedo.dialog.js'
    ], function() {
    staticdatamodify.initstaticdata();
});
</script>
</body>
</html>
