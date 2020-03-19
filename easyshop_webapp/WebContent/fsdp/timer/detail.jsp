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
    	<div class="add-common-name">定时器详情<br/></div>
    </div>
    
    <div id="common_add_div" >
    	<div class="finedo-nav-title">基本信息</div>
	   	<ul class="finedo-ul">
	   		<li>
				<span class="finedo-label-title"><font color=red>*</font>技术说明</span>
				<span class="finedo-label-info">1) 定时器类必须声明@Component、@Control、@Service注解, 否则Spring不会加载该类</span>
				<span class="finedo-label-info">2) 新增、修改、删除定时器重启应用服务器才能生效</span>
			</li>
			
			<li>
				<span class="finedo-label-title"><font color=red>*</font>定时任务名称</span>
				<span class="finedo-label-info" id="name"></span>
			</li>

           	<li>
           		<span class="finedo-label-title"><font color=red>*</font>Bean类名</span>
           		<span class="finedo-label-info" id="beanname"></span>
           	</li>

           	<li>
           		<span class="finedo-label-title"><font color=red>*</font>Bean类方法名</span>
           		<span class="finedo-label-info" id="method"></span>
           	</li>
           	
           	<li>
           		<span class="finedo-label-title"><font color=red>*</font>CRON</span>
           		<span class="finedo-label-info" id="cron"></span>
           	</li>
           	
           	<li>
           		<span class="finedo-label-title"><font color=red>*</font>创建时间</span>
           		<span class="finedo-label-info" id="optdate"></span>
           	</li>
		</ul>
    </div>
</div>
<script language="javascript">
var timerdetail={
    inittimer:function(){
        finedo.action.ajax({
            "url":"../../finedo/timer/querybyid",
            "data":{"id":finedo.fn.getParameter("id")},
            "callback":function(retdata){
                if(retdata.fail){
                    finedo.message.error(retdata.resultdesc);
                    return;
                }
                var timertask = retdata.object;
                $("#name").html(timertask.name);
                $("#beanname").html(timertask.beanname);
                $("#method").html(timertask.method);
                $("#cron").html(timertask.cron);
                $("#optdate").html(timertask.optdate);
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
    '../../resource/js/finedoui/dialog/themes/style.css'
    ]);
LazyLoad.js([
    '../../resource/js/jquery/jquery-1.11.0.js',
    '../../resource/js/jquery/jquery.form.js',
    '../../resource/js/finedoui/base/finedo.core.js',
    '../../resource/js/finedoui/commonui/finedo.commonui.js',
    '../../resource/js/finedoui/dialog/finedo.dialog.js'
    ], function() {
    timerdetail.inittimer();
});
</script>
</body>
</html>
