<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs2.jsp" %>

<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>

<body>
<div>
	<div class="add-common-head">
    	<div class="add-common-name-add" id="addtitle">设置log级别</div>
        <input type="button" class="finedo-button-blue" style="float:right" value="设    置" onclick="loglevel.dosubmit();">
    </div>
        
    <form method="post" id="ajaxForm" name="ajaxForm">
    <div id="common_add_div" >
	   	<ul class="finedo-ul">
			<li>
				<span class="finedo-label-title" style="width:150px"><font color=red>*</font>请选择日志级别：</span>
				<input type="text" id="paramvalue" name="paramvalue"></input>
			</li>
		</ul>
		
		<ul>
    		<li class="add-center"><input type="button" class="finedo-button" value="设    置" onClick="loglevel.dosubmit()" ></li>
   		</ul>
	</div>
    </form>
</div>
<script type="text/javascript">
var loglevel={
    initloglevel:function(){
        finedo.action.ajax({
            url:"../../finedo/sysparam/querysysparam",
            data:{"paramid":"1012"},
            callback:function(jsondata){
	            if(jsondata && jsondata.rows && jsondata.rows.length > 0){
	                loglevel.initLogLevel(jsondata.rows[0].paramvalue);
	            }else{
	                loglevel.initLogLevel('DEBUG');
	            }
            }
        });
    },
    dosubmit:function() {
        var paramvalue = finedo.getselect("paramvalue").getvalue();
        finedo.action.ajax({
            url:"../../finedo/sysparam/setloglevel",
            data:{"paramvalue":paramvalue},
            callback:function(jsondata){
	            if(jsondata.fail){
	                finedo.message.error(jsondata.resultdesc);
	                return;
	            }
	            finedo.message.tip('日志级别设置成功');
            }
        });
    },
    initLogLevel:function(defaultvalue){
        var options={
            type:"single",      /*single:单选, multi:多选*/
            data:[
                {"code":"OFF", "value":"关闭日志"},
                {"code":"TRACE", "value":"追踪"},
                {"code":"DEBUG", "value":"调试"},
                {"code":"INFO", "value":"信息"},
                {"code":"WARN", "value":"告警"},
                {"code":"ERROR", "value":"错误"},
                {"code":"FATAL", "value":"重大错误"}
            ],
            value:defaultvalue
        };
        finedo.getselect("paramvalue", options);
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
    loglevel.initloglevel();
});
</script>
</body>
</html>
