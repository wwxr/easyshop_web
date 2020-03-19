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
    	<div class="add-common-name">订单物品关联表详细信息<br/>
            <ul>
            	<li class="add-link-li">全部</li> 
            </ul>
        </div>
    </div>
    
	<div class="finedo-nav-title">基本信息</div> 
	<ul class="finedo-ul">
			
		<li>
			<span class="finedo-label-title">订单编号</span>
			<span class="finedo-label-info" id="ordercode"></span>
		</li>
		<li>
			<span class="finedo-label-title">物品id</span>
			<span class="finedo-label-info" id="goodsid"></span>
		</li>
	</ul>
</div>
<script language="javascript">
var easyshopordergoodsdetail={};
/**
 * 详情页面经初始化，加载数据
 */
easyshopordergoodsdetail.initdetail=function(){
	finedo.action.ajax({
        "url":"../../finedo/easyshopordergoods/querybyid",
        "data":{"ordergoodsid":finedo.fn.getParameter("ordergoodsid")},
        "callback":function(retdata){
            if(retdata.fail){
                finedo.message.error(retdata.resultdesc);
                return;
            }
            var retobject = retdata.object;
			$("#ordercode").html(retobject.ordercode);
			$("#goodsid").html(retobject.goodsid);
        }
    });
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
    easyshopordergoodsdetail.initdetail();
});
</script>
</body>
</html>
