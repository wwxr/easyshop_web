/**
 * 命名空间
 */
var FINEDO = {};
/**
 * 错误码
 */
FINEDO.RESULTCODE = {success:'SUCCESS',fail:0000};

$(document.body).ready(function(){
	initUI();
});

/**
 * UI组件渲染
 * @return
 */
function initUI(){
	$.each($("input"),function(){
		var type = $(this).attr("type");
		if('text'==type||'password'==type||'file'==type){
			$(this).attr("class",'input-text');
		}
	});
	$.each($("textarea"),function(){
		$(this).attr("class",'input-textarea');
	});
}

/**
 * 字符串扩展方法，用于在URL中追加或者修改参数
 * @param name
 * @param value
 * @return
 */
String.prototype.changeQuery = function(name,value) { 
	var reg = new RegExp("(^|)"+ name +"=([^&]*)(|$)"); 
	var tmp = name + "=" + value; 
	if(this.match(reg) != null) { 
		return this.replace(eval(reg),tmp); 
	} else { 
		if(this.match("[\?]")) { 
			return this + "&" + tmp; 
		} else { 
			return this + "?" + tmp; 
		} 
	} 
};

/**
 * 操作命令对象
 */
FINEDO.Action = {
	/**
	 * 一般性的命令操作，用于GET方式提交
	 * url:调用的路径
	 * callback:执行完成后的回调函数
	 * alertmsg:执行完成后是否弹出返回信息
	 */
	doCommand:function(url,callback,alertmsg){
		FINEDO.Mode.create();
		$.getJSON(url, function(data){
			FINEDO.Mode.destroy();
			if(alertmsg){
				$.messager.alert("提示",data.resultdesc);
			}
			if($.isFunction(callback)){
				callback(data);
			}
	
		});
	}
	/**
	 * 执行命令
	 * datagrid:指定查询的数据列表对象
	 * url:调用的路径
	 * data:查询参数
	 */
	,doSearch:function(datagrid,url,param){
		FINEDO.Mode.create();
		$('#'+datagrid).datagrid({
				url:url,
				queryParams: param
		});
		FINEDO.Mode.destroy();
	}
	/**
	 * 删除记录的公用方法
	 * datagrid:指定被删除的数据列表对象
	 * action:指定删除数据的处理方法
	 * itemid:记录的编号
	 * callback:执行完成后的回调函数
	 */
	,doDelete:function(datagrid,action,itemid,callback){
		if(itemid==""){
			$.messager.alert("提示","请选择要删除的记录！");
			return;
		}
		message = "您确定删除该记录吗？";
		
		$.messager.confirm('提示', message, function(which){  
	        if (which){ 
	        	FINEDO.Mode.create();
	        	$.getJSON(action+'?id='+itemid, function(ret){
	        		FINEDO.Mode.destroy();
					$.messager.alert("提示",ret.resultdesc);
					$('#'+datagrid).datagrid('reload'); 
					if($.isFunction(callback)){
						callback();
					}
	            });
	        }  
	    });  
		
	}
	
	/**
	 * 批量删除记录的公用方法
	 * datagrid:指定被删除的数据列表对象
	 * action:指定删除数据的处理方法
	 * key:指定记录的主键编码
	 * callback:执行完成后的回调函数
	 */
	,doBatchDelete:function(datagrid,action,key,callback){
		var ids = [];
		var message = "您确定删除这些记录吗?";
		var rows = $('#'+datagrid).datagrid('getSelections');
		for(var i=0; i<rows.length; i++){
			ids.push(rows[i][key]);
		}
		if(ids.length==0){
			$.messager.alert("提示","请选择要删除的记录！");
			return;
		}
		$.messager.confirm('提示', message, function(which){  
	        if (which){ 
	        	FINEDO.Mode.create();
	        	$.getJSON(action+'?id='+ids.join(','), function(ret){
	        		FINEDO.Mode.destroy();
					$.messager.alert("提示",ret.resultdesc);
					$('#'+datagrid).datagrid('reload'); 
					if($.isFunction(callback)){
						callback();
					}
	            });
	        }  
	    });  
	}
	/**
	 * 排序操作
	 * datagrid:指定排序的数据列表对象
	 * url:调用的路径
	 * data:查询参数
	 */
	,doSort:function(datagrid,url,param){
		FINEDO.Mode.create();
		$.post(url,param,function(data){
			FINEDO.Mode.destroy();
			$('#'+datagrid).datagrid('reload');   
		},'json');
	}
};


/**
 * 遮罩层对象
 */
FINEDO.Mode = {
	create:function(){
	    	 $("<div class=\"datagrid-mask\"></div>").css({display:"block",width:"100%",height:$(window).height()}).appendTo("body"); 
		    $("<div class=\"datagrid-mask-msg\"></div>").html("加载中，请稍等!").appendTo("body").css({display:"block",left:($(document.body).outerWidth(true) - 190) / 2,top:($(window).height() - 45) / 2});
		
		
	},
	destroy:function(){
		$(".datagrid-mask").remove(); 
	     $(".datagrid-mask-msg").remove();  
	}
};

/**
 * 信息提示框
 * 
 * @author YangFan
 * @param title
 *            提示标题
 * @param message
 *            提示语
 * @param type
 *            提示框类型(空、error、info、question、warning)
 */
function message(title,message,type){
	$.messager.alert(title,message,type);
}