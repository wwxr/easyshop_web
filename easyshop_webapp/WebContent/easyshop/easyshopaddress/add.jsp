<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs2.jsp" %>

<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>
${finedo_htmleditor_js }
<body>
<div>
	<div class="ylnav">
	<span>新增地址信息</span><input type="button" value="" class="back" onClick="(function(){window.parent.$('.finedo-dialog-mask').remove();window.parent.$('.finedo-dialog').remove();})()">
    </div>
    
    
<div class="yledit">
	
	
	<table>
			<tr>
				<td class="ylname1">
				省 / 市 / 区：
				</td>
				<td class="ylname2" colspan='3'>
				<div class="city-picker-selector" id="city-picker-search">
				<div class="city-picker-selector" id="city-picker-search">
					<div class="selector-item storey province">
							<a href="javascript:;" class="selector-name reveal df-color " id='province'>请选择省份</a>
							<input type="hidden" name="userProvinceId" id='userProvinceId'
								class="input-price val-error" value=""
								data-required="userProvinceId">
							<div class="selector-list listing hide">
								<div class="selector-search">
									<input type="text" class="input-search" value=""
										placeholder="拼音、中文搜索">
								</div>
								<ul>
									<li>北京市</li>
									<li>天津市</li>
								</ul>
							</div>
						</div>
				<div class="selector-item storey city">
							<a href="javascript:;"
								class="selector-name reveal df-color forbid" id='city'>请选择城市</a> <input
								type="hidden" name="userCityId" id='userCityId' class="input-price val-error"
								value="" data-required="userCityId">
							<div class="selector-list listing hide">
								<div class="selector-search">
									<input type="text" class="input-search" value=""
										placeholder="拼音、中文搜索">
								</div>
								<ul></ul>
							</div>
						</div>
				<div class="selector-item storey district">
							<a href="javascript:;"
								class="selector-name reveal df-color forbid" id='area'>请选择区县</a> <input
								type="hidden" name="userDistrictId" id='userDistrictId'
								class="input-price val-error" value=""
								data-required="userDistrictId">
							<div class="selector-list listing hide">
								<div class="selector-search">
									<input type="text" class="input-search" value=""
										placeholder="拼音、中文搜索">
								</div>
								<ul></ul>
							</div>
						</div>
				</div>
				</td>
			</tr>
			<tr>
				<td class="ylname1">联系人姓名：</td>
				<td>
					<input type="text" class="yltext" id="username" name="username" maxlength="20" placeholder="请输入联系人姓名"  ><span style="color:red;">*必填项</span>
				</td>
				<td class="ylname1">联系人号码</td>
				<td class="ylname2">
					<input type="text" class="yltext" id="phone" name="phone" maxlength="11" placeholder="请输入手机号"  ><span style="color:red;">*必填项</span>
				</td>
			</tr>
			<tr>
				<td class="ylname1">默认地址：</td>
				<td>
					<select class='selectdata' id='isdefault' >
					<option value=''>请选择</option>
					<option value='Y'>是</option>
					<option value='N'>否</option>
					</select>
					<span style="color:red;">*必填项</span>
				</td>
				<td class="ylname1"></td>
				<td class="ylname2"></td>
			</tr>
			<tr>
				<td class="ylname1">地址详情：</td>
				<td>
					<textarea  id="address" name="address" placeholder="请输入地址简介" maxlength="100"></textarea>
					<span style="color:red;">*必填项</span>
			    </td>
		    </tr>
		</table>	
	</div>
    <div class="ylsubmit"><input type="button" class="ylbtn" value="提    交" onClick="easyshopaddressadd.dosubmit()" ></div>
</div>

<script language="javascript">
var easyshopaddressadd={};
/**
 * 增加页面初始化，用于初始化表单
 */
easyshopaddressadd.initadd=function(){

    //模拟城市-联动/搜索
    $('#city-picker-search').cityPicker({
        dataJson: cityData,
        renderMode: true,
        search: true,
        linkage: true
    });
};
easyshopaddressadd.checkdata=function(){
	var result=true;
	if(finedo.fn.isNon($("input[name='userProvinceId']").val())){
		finedo.message.info("请选择省份");
		return;
	}
	if(finedo.fn.isNon($("input[name='userCityId']").val())){
		finedo.message.info("请选择市");
		return;
	}
	if(finedo.fn.isNon($("input[name='userDistrictId']").val())){
		finedo.message.info("请选择区/县");
		return;
	}
	if(finedo.fn.isNon($("#isdefault").val())){
		finedo.message.info("请选择是否默认");
		return;
	}
	if(finedo.fn.isNon($("#address").val())){
		finedo.message.info("请输入地址详情");
		return;
	}
	if(finedo.fn.isNon($("#username").val())){
		finedo.message.info("请输入用户姓名");
		return;
	}
	if(finedo.fn.isNon($("#phone").val())){
		finedo.message.info("请输入联系人号码");
		return;
	}
	return result;
};
/**
 * 提交方法
 */
easyshopaddressadd.dosubmit=function() {
	if(!easyshopaddressadd.checkdata()) 
		return;
	finedo.action.ajax({
		url:"../../finedo/easyshopaddress/add",
		data:{
			province:$("input[name='userProvinceId']").prev().text(),//省
			city:$("input[name='userCityId']").prev().text(),//市
			area:$("input[name='userDistrictId']").prev().text(),//区
			provincenum:$("input[name='userProvinceId']").val(),//省
			citynum:$("input[name='userCityId']").val(),//市s
			areanum:$("input[name='userDistrictId']").val(),//区
			isdefault:$("#isdefault").val().trim(),//默认
			address:$("#address").val().trim(),//地址详情
			username:$("#username").val().trim(),//地址详情
			phone:$("#phone").val().trim(),//地址详情
			},
			callback:function(jsondata){
				if(jsondata.fail){
					finedo.message.error(jsondata.resultdesc);
					return;
				}
				finedo.message.info(jsondata.resultdesc,'提示',function(){
					window.parent.$('#datagrid').grid().refresh();
					window.parent.$(".finedo-dialog-mask").remove();
					window.parent.$(".finedo-dialog").remove();
				});
		}
	});
	
};

</script>
<script type='text/javascript' src='../../resource/js/lazyload.js'></script>
<script language="javascript">
LazyLoad.css([
    '../../resource/themes/default/style.css',
    '../../resource/js/finedoui/commonui/themes/commonui.css',
    '../../resource/js/finedoui/dialog/themes/style.css',
    '../../resource/js/finedoui/upload/themes/style.css',
    '../../resource/js/finedoui/image/viewer.min.css',
    '../../resource/js/city-picker.css',
    '../../easyshop/style/style.css'
    ]);
LazyLoad.js([
    '../../resource/js/jquery/jquery-1.11.0.js',
    '../../resource/js/jquery/jquery.form.js',
    '../../resource/js/finedoui/base/finedo.core.js',
    '../../resource/js/finedoui/commonui/finedo.commonui.js',
    '../../resource/js/finedoui/dialog/finedo.dialog.js',
    '../../resource/js/finedoui/date/WdatePicker.js',
    '../../resource/js/finedoui/upload/finedo.upload.js',
    '../../resource/js/cityPicker-1.0.0.js?v=1',
    '../../resource/js/citydata.js',
    '../../resource/js/finedoui/image/viewer.min.js',   ], function() {
    easyshopaddressadd.initadd();
});
</script>
</body>
</html>
