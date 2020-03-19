;(function($, undefined) {
	/**
	 * 分页插件
	 * options:{
	 * 	pagination:true,//是否分页
		oncerequest:false,//是否一次加载
	 	ajax:true,	//是否通过ajax加载分页
        pagesize : 10, 		//默认一页显示数量
        pagelist: [10, 20, 50, 100], //分页数量
        page: 当前为哪一页，默认为1
        pretext: 上一页链接字
        nexttext: 下一页链接字
        firsttext: 第一页链接字
        lasttext: 最后一页链接字
        gotext: 跳转到某一页链接字
        url: 分页请求url
        queryparams: 请求参数
        beforesend: 请求前执行函数
        success: 成功返回回调
        complete:请求执行完成回调
        error：请求错误回调
	 * 	
	 * }
	 */
	$.fn.pager = function(options){
		var $finedopager = this;
		var default_options = {
			form:null,//页面跳转分页时，如果传了form，按form来请求，否则按location.href形式加载
			pagination:true,//是否分页
			oncerequest:false,//是否一次加载
			ajax:true,	//是否通过ajax加载分页
            pagesize : 10, 		//默认一页显示数量
            pagelist: [10, 20, 50, 100], //分页数量
            page: 1,//当前为哪一页，默认为1
            pretext: "上一页",
            nexttext: "下一页",
            firsttext: "首页",
            lasttext: "尾页",
            gotext: "GO",
            url: "",
            queryparams: {},
            beforesend: null,
            success: null,
            complete: null,
            error: null
		};
		
		if(finedo.fn.isnon($finedopager.data('options'))){
			var options = $.extend(true, default_options,options);
			$finedopager.data('options', options);
		}
		
		this.firstpage = function(){
			var pages = $finedopager.pageroption();
			if(pages.page == 1)
				return;
			pages.page = 1;
			this.query();
		};

		this.prepage = function(){
			var pages = $finedopager.pageroption();
			if(pages.page == 1)
				return;
			pages.page -= 1;
			this.query();
		};

		this.nextpage = function(){
			var pages = $finedopager.pageroption();
			if(pages.page >= pages.totalpage)
				return;
			pages.page += 1;
			this.query();
		};

		this.lastpage = function(){
			var pages = $finedopager.pageroption();
			if(pages.page >= pages.totalpage)
				return;
			pages.page = pages.totalpage;
			this.query();
		};

		this.junmpage = function(val){
			var pages = $finedopager.pageroption();
			if(val == pages.page)
				return;
			if(val < 1 || val > pages.totalpage)
				return;
			pages.page = parseInt(val);
			this.query();
		};
		
		this.refresh = function(){
			this.query();
		};
		
		this.updatepages = function(data){
			var pages = $finedopager.pageroption();
			var total = data.total;
			var totalpage = Math.ceil(parseInt(total) / parseInt(pages.rows));
			$("#"+$finedopager.attr("id")+"total").html(total);
			$("#"+$finedopager.attr("id")+"totalpages").html(totalpage);
			$("#"+$finedopager.attr("id")+"jumppageval").val(pages.page);
			$finedopager.pageroption({"total":total,"totalpage":totalpage});
		};
		
		this.query = function(){
			var options = $finedopager.data("options");
			var pages = $finedopager.pageroption();
			var loadurl = options.url;
			if(finedo.fn.isnon(loadurl)){
				return;
			}
			if(finedo.fn.istrue(options.pagination)){
				if(loadurl.indexOf("?") == -1){
					loadurl += "?page="+pages.page+"&rows="+(finedo.fn.istrue(options.oncerequest) ? "100000000" : pages.rows);
				}else{
					loadurl += "&page="+pages.page+"&rows="+(finedo.fn.istrue(options.oncerequest) ? "100000000" : pages.rows);
				}
			}
			
			//如果有排序字段，将以asc与desc为键将值请求到服务端
			if(finedo.fn.isnotnon(options.asc)){
				loadurl += loadurl.indexOf("?") == -1 ? "?" : "&";
				loadurl += "asc="+options.asc;
			}
			if(finedo.fn.isnotnon(options.desc)){
				loadurl += loadurl.indexOf("?") == -1 ? "?" : "&";
				loadurl += "desc="+options.desc;
			}
			$.ajax({
	            url: loadurl,
	            data: options.queryparams,
	            type: "post",
	            dataType: 'json',
	            beforeSend: function(XMLHttpRequest){
	            	if($.isFunction(options.beforesend)){
						options.beforesend(XMLHttpRequest);
					}else if(finedo.fn.isfunction(options.beforesend)){
						var fun = eval(options.beforesend);
						fun(XMLHttpRequest);
					}
	            },
	            success: function(data){
	            	$finedopager.updatepages(data);
	            	if($.isFunction(options.success)){
						options.success(data);
					}else if(finedo.fn.isfunction(options.success)){
						var fun = eval(options.success);
						fun(data);
					}
	            },
	            error: function(XMLHttpRequest, textStatus, errorThrown){
	            	if($.isFunction(options.error)){
						options.error(XMLHttpRequest, textStatus, errorThrown);
					}else if(finedo.fn.isfunction(options.error)){
						var fun = eval(options.error);
						fun(XMLHttpRequest, textStatus, errorThrown);
					}
	            },
	            complete: function(XMLHttpRequest, textStatus){
	            	if($.isFunction(options.complete)){
						options.complete(XMLHttpRequest, textStatus);
					}else if(finedo.fn.isfunction(options.complete)){
						var fun = eval(options.complete);
						fun(XMLHttpRequest, textStatus);
					}
	            }
	        });
		};
		
		this.load = function(queryoptions){
			var options = $finedopager.data("options");
			options = $.extend(true, options,queryoptions);
			$finedopager.pageroption({page:1});
			$finedopager.data('options', options);
			$finedopager.query();
		};
		
		/**
		 * pagervals格式
		 * {
		 * 	page:1, 
		 * 	rows:20, 
		 * 	total:0, 
		 * 	totalpage:1
		 * }
		 */
		this.pageroption = function(pagervals){
			if(pagervals){
				$finedopager.data("pageroption", $.extend($finedopager.data("pageroption"),pagervals));
				return;
			}
			return $finedopager.data("pageroption");
		};
		
		this.initpage = function(){
			var options = $finedopager.data('options');
			var $pageid = $finedopager.attr("id");
			var pagestr = '<div class="finedo-page">' +
			'<div class="finedo-num">' +
			'<label><input class="finedo-btn-num" type="button" id="'+$pageid+'firstpagebtn" value="'+options.firsttext+'"/></label>' +
			'<label><input class="finedo-btn-num" type="button" id="'+$pageid+'prepagebtn" value="'+options.pretext+'"/></label>' +
			'<label><input class="finedo-btn-num" type="button" id="'+$pageid+'nextpagebtn" value="'+options.nexttext+'"/></label>' +
			'<label><input class="finedo-btn-num" type="button" id="'+$pageid+'lastpagebtn" value="'+options.lasttext+'"/></label>' +
			'<label>跳转到<input class="finedo-text-num" type="text" id="'+$pageid+'jumppageval"/>页/<span class="finedo-color" id="'+$pageid+'totalpages">1</span>页&nbsp;</label>' +
			'<label><input class="finedo-btn-num" type="button" value="'+options.gotext+'" id="'+$pageid+'jumppagebtn" title="跳转到指定页"/></label>' +
			'<label>共<span class="finedo-color" id="'+$pageid+'total">0</span>条</label></div>' +
			'<div class="finedo-show">' +
			'<select class="finedo-showsel" id="'+$pageid+'pagesel">';
			for(var pageindex = 0; pageindex < options.pagelist.length; pageindex++){
				pagestr += '<option '+(options.pagesize == options.pagelist[pageindex] ? 'selected' : '')+'>'+options.pagelist[pageindex]+'</option>';
			}
			pagestr += '</select></div></div>';
			$finedopager.append($(pagestr));
			$("#"+$pageid+"firstpagebtn").bind("click",function(){
				$finedopager.firstpage();
			});
			$("#"+$pageid+"prepagebtn").bind("click",function(){
				$finedopager.prepage();
			});
			$("#"+$pageid+"nextpagebtn").bind("click",function(){
				$finedopager.nextpage();
			});
			$("#"+$pageid+"lastpagebtn").bind("click",function(){
				$finedopager.lastpage();
			});
			$("#"+$pageid+"pagesel").bind("change",function(){
				$finedopager.pageroption({rows:$(this).val()});
				$finedopager.refresh();
			});
			$("#"+$pageid+"jumppagebtn").bind("click",function(){
				var jumpval = $.trim($("#"+$finedopager.attr("id")+"jumppageval").val());
				var regu = "^[1-9]{1}[0-9]*$";
				var re = new RegExp(regu);
				if (jumpval.search(re) == -1) {
					$("#"+$finedopager.attr("id")+"jumppageval").val(pages.rows);
					return;
				}
				$finedopager.junmpage(jumpval);
			});
			var pageopt = {page:1, rows:options.pagesize, total:0, totalpage:1};
			pageopt = $.extend(pageopt,{page:options.page});
			$finedopager.pageroption(pageopt);
		};
		
		/**
         * 控件初始化
         */
        this.init = function(){
        	if($finedopager.data('init') == true)
        		return $finedopager;
        	$finedopager.data('init', true);
        	
        	var attroptions = {};
        	$.each($(this)[0].attributes, function(index, attr) {
        		attroptions[attr.name] = attr.value;
			});
        	if(finedo.fn.isFunction(attroptions.onclick))
        		attroptions.onclick = eval(attroptions.onclick);
        	var options = $.extend($finedopager.data('options'),attroptions);
        	$finedopager.data('options', options);
        	$finedopager.initpage();
			return $finedopager;
        };
        
		return this.init();
	};
})(jQuery);

/**
 * 保存控件对象数组的定义
 */
if(typeof(finedo.controls) == "undefined"){
	finedo.controls = [];
};
/**
 * 定义控件获取函数
 */ 
finedo.getPager = finedo.getpager = function(controlid, options){
	if(finedo.controls[controlid] && typeof(options) == "undefined") {
		return finedo.controls[controlid];
	}
	finedo.controls[controlid]=$('#'+controlid).pager(options);
	return finedo.controls[controlid];
};
