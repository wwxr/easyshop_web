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
        <div class="add-common-name-add">安装包发布<br/></div>
    </div>
    <div id="common_add_div" >
        <ul class="finedo-ul">
            <form method="post" id="ajaxForm" name="ajaxForm">
            <input type="hidden" id="appid" name="appid">
            <input type="hidden" id="fileid" name="fileid">
            <li>
                <span class="finedo-label-title"><font color=red>*</font>平台：</span>
                <input type="text" id="platform">
            </li>
            <li>
                <span class="finedo-label-title"><font color=red>*</font>版本号：</span>
                <input class="finedo-text" type="text" value="" id="version" name="version">
            </li>
            <li>
                <span class="finedo-label-title"><font color=red>*</font>升级要求：</span>
                <input type="text" id="demand">
            </li>
            <li>
                <span class="finedo-label-title"><font color=red>*</font>升级类型：</span>
                <input type="text" id="uptype">
            </li>
            <li>
                <span class="finedo-label-title"><font color=red>*</font>版本类型：</span>
                <input type="text" id="versiontype">
            </li>
            <li>
                <span class="finedo-label-title">安装包标签：</span>
                <input class="finedo-text" type="text" value="" id="tag" name="tag" maxlength="50">
            </li>
            <li>
                <span class="finedo-label-title">更新内容：</span>
                <textarea class="finedo-textarea" id="content" name="content" style="width:80%;"></textarea>
            </li>
            </form>
            <li>
                <span class="finedo-label-title"><font color=red>*</font>安装包：</span>
                <input type="text" id="installfile" name="installfile">
            </li>
            <li class="add-center">
                <input type="button" class="finedo-button" value="发    布" onClick="apppublish.doadd()" >
            </li>
        </ul>
    </div>
</div>
<script type="text/javascript">
var apppublish={
    initapp:function(){
        var appid = finedo.fn.getParameter("appid");
        $("#appid").val(appid);
        finedo.getfile('installfile', {
            ctx:"../..",
            filter : ".apk,.ipa",
            showicon : "true",
            showname : "true",
            showsize : "true",
            multiupload : "false",
            multidown : "false",
            editable : "true"
        });
        
        finedo.getradio("platform", {
            data:[
                {"code":"Android", "value":"Android"},
                {"code":"iOS", "value":"iOS"}
            ],
            value:"Android"
        });
        finedo.getradio("demand", {
            data:[
                {"code":"强制升级", "value":"强制升级"},
                {"code":"可选升级", "value":"可选升级"}
            ],
            value:"强制升级"
        });
        finedo.getradio("uptype", {
            data:[
                {"code":"全量", "value":"全量"},
                {"code":"增量", "value":"增量"}
            ],
            value:"全量"
        });
        finedo.getradio("versiontype", {
            data:[
                {"code":"正式版本", "value":"正式版本"},
                {"code":"灰度版本", "value":"灰度版本"}
            ],
            value:"正式版本"
        });
    },
    // 数据验证
    checkdata:function(){
        /**
         *   通用数据验证
         *   label       名称
         *   datatype    数据类型  string email phone url date datetime time number digits 
         *   minlength   最小长度
         *   maxlength   最大长度
         *   required    是否必填 true/false
         */
         var result=finedo.validate({
             "platform":{label:"平台", datatype:"string", maxlength:30, required:true},
             "version":{label:"版本号", datatype:"digits", maxlength:10, required:true},
             "demand":{label:"升级要求", datatype:"string", required:true},
             "uptype":{label:"升级类型", datatype:"string", required:true},
             "versiontype":{label:"版本类型", datatype:"string", required:true},
             "tag":{label:"安装包标签", datatype:"string", maxlength:50, required:false},
             "content":{label:"更新内容", datatype:"string", maxlength:1000, required:false},
             "installfile":{label:"安装包", datatype:"string", required:true}
         }, true);
        return result;
    },
    doadd:function() {
        if(!apppublish.checkdata()){
            return;
        }
        var filelist = finedo.getfile('installfile').getfilelist();
        if(finedo.fn.isnon(filelist)){
            finedo.message.warning('请上传安装包');
            return;
        }
        $("#fileid").val(filelist[0].fileid);
        finedo.action.ajaxForm({
            form:"ajaxForm",
            url:"../../finedo/app/addappversion",
            callback:function(retdata){
                if(retdata.fail){
                    finedo.message.error(retdata.resultdesc);
                    return;
                }
                finedo.message.info(retdata.resultdesc);
            },
            clearForm:false
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
    '../../resource/js/finedoui/upload/themes/style.css'
    ]);
LazyLoad.js([
    '../../resource/js/jquery/jquery-1.11.0.js',
    '../../resource/js/jquery/jquery.form.js',
    '../../resource/js/finedoui/base/finedo.core.js',
    '../../resource/js/finedoui/commonui/finedo.commonui.js',
    '../../resource/js/finedoui/dialog/finedo.dialog.js',
    '../../resource/js/finedoui/upload/finedo.upload.js'
    ], function() {
    apppublish.initapp();
});
</script>
</body>
</html>


