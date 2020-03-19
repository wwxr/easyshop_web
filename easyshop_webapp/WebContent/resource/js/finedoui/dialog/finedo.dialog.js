
/**
 * 消息弹出窗口
 */ 
finedo.message = {
	info:function(content, title, callback, style){
		this.showmessage(content, title, 'info', callback, style);
	},
	error:function(content, title, callback, style){
		this.showmessage(content, title, 'error', callback, style);
	},
	question:function(content, title, callback, style){
		this.showmessage(content, title, 'question', callback, style);
	},
	warning:function(content, title, callback, style){
		this.showmessage(content, title, 'warning', callback, style);
	},
	showmessage:function(content, title, type, callback, style){
		var imgclassName = '';
		if(title == undefined){
			if(type == 'info'){
				title = '提示';
				imgclassName = 'finedo-message-info';
			} else if(type == 'question'){
				title = '询问';
				imgclassName = 'finedo-message-question';
			} else if(type == 'error'){
				title = '错误';
				imgclassName = 'finedo-message-error';
			} else if(type == 'warning'){
				title = '警告';
				imgclassName = 'finedo-message-warning';
			}
		}else{
			if(type == 'info') imgclassName = 'finedo-message-info';
			else if(type == 'question') imgclassName = 'finedo-message-question';
			else if(type == 'error') imgclassName = 'finedo-message-error';
			else if(type == 'warning') imgclassName = 'finedo-message-warning';
		}
		var msgTag = $('<div class="finedo-message-mask"></div>').css({display:'block',width:'100%',height:$(document).height()}).appendTo('body');
		var msgTagId = 'mm'+new Date().getTime();
		msgTag.attr('id', msgTagId);
		var msgcontentTagId = 'm'+new Date().getTime();
		var msgdivhtml = '<div '+(style != undefined ? 'style="'+style+'"' : '')+' id="'+msgcontentTagId+'" class="finedo-message"> \
							<div class="finedo-message-til" id="'+msgcontentTagId+'title"> \
								<strong>'+title+'</strong> \
								<input id="'+msgcontentTagId+'close" class="finedo-message-close" type="button"> \
							</div> \
							<div class="finedo-message-con"> \
								<span class="'+imgclassName+'"></span> \
								<p> \
									<div style="overflow:auto;max-height:'+($(window).height()-100)+'px;max-width:'+($(window).width()-100)+'px;"> \
									<label id="'+msgcontentTagId+'content"> \
									</label> \
									</div> \
								</p> \
								<p class="finedo-message-center"> \
									<input id="'+msgcontentTagId+'ok" class="finedo-message-button" type="button" value="确定"> \
									&nbsp;&nbsp;&nbsp;&nbsp;\
									<input id="'+msgcontentTagId+'cancel" style="display:none;" class="finedo-message-button" type="button" value="取消"> \
								</p> \
							</div> \
						</div>';
		
		var msgcontentTag = $(msgdivhtml).appendTo('body');
		$("#"+msgcontentTagId+"ok").focus();
		if(type == 'question'){
			$('#'+msgcontentTagId+'cancel').show();
		}
		//拖动效果
		$("#"+msgcontentTagId+"title").mousedown(function(e){  
            $(this).css('cursor','move');//改变鼠标指针的形状  
            var offset = $(this).offset();//DIV在页面的位置  
            var x = e.pageX - offset.left;//获得鼠标指针离DIV元素左边界的距离  
            var y = e.pageY - offset.top;//获得鼠标指针离DIV元素上边界的距离  
            $(document).bind('mousemove',function(ev)//绑定鼠标的移动事件，因为光标在DIV元素外面也要有效果，所以要用doucment的事件，而不用DIV元素的事件  
            {  
                var _x = ev.pageX - x;//获得X轴方向移动的值  
                var _y = ev.pageY - y - document.documentElement.scrollTop;//获得Y轴方向移动的值  
                $(msgcontentTag).css({left:_x+'px',top:_y+'px'});  
            });  
              
        });  
        $(document).mouseup(function() {  
        	$("#"+msgcontentTagId+"title").css('cursor','default');  
        	$(this).unbind('mousemove');  
        });
		
		$('#'+msgcontentTagId+'content').html(content);
		msgcontentTag.css({display:'block',left:($(document.body).outerWidth(true) - msgcontentTag.width()) / 2,top:($(window).height()/2-msgcontentTag.height()/2)});
		
		$('#'+msgcontentTagId+'close').bind('click', function(){
			msgTag.remove();
			msgcontentTag.remove();
		});
		$('#'+msgcontentTagId+'ok').bind('click', function(){
			msgTag.remove();
			msgcontentTag.remove();
			if($.isFunction(callback)){
				callback(true);
			}
		});
		$('#'+msgcontentTagId+'cancel').bind('click', function(){
			msgTag.remove();
			msgcontentTag.remove();
			if($.isFunction(callback)){
				callback(false);
			}
		});
	},
	showwaiting:function(){
		$('<div class="finedo-showwaiting-mask"></div>').css({display:'block',width:'100%',height:$(document).height()}).appendTo('body');
		$('<div class="finedo-showwaiting-mask-msg"></div>').appendTo('body').css({display:'block',left:$(document.body).outerWidth(true) / 2,top:($(document).height()-$(window).height() + $(window).height()/2)});
	},
	showWaiting:function(){
		finedo.message.showwaiting();
	},
	hidewaiting:function(){
		$(".finedo-showwaiting-mask").remove();
		$(".finedo-showwaiting-mask-msg").remove();
	},
	hideWaiting:function(){
		finedo.message.hidewaiting();
	},
	tip:function(context, callback){
		var msgtip = $('<div class="finedo-message-tip"></div>').appendTo('body');
		msgtip.html(context);
		msgtip.css({display:'block',left:($(document.body).outerWidth(true) - msgtip.width()) / 2,top:($(window).height()/2-msgtip.height()/2),'max-height':($(window).height()-100)+'px','max-width':($(window).width()-100)+'px'});
		setTimeout(function(){
			$(msgtip).remove();
			if(finedo.fn.isfunction(callback)){
				callback();
			}
		}, 3000);
	}
};

/**
 * 弹出层对话框
 */
finedo.dialog = {
	previewPicture:function(url){
		$('<div id="finedopreviewpicdivmask" class="finedo-showdialog-mask" onclick="finedo.dialog.closePreview();"></div>').css({display:"block",width:"100%",height:$(document).height()}).appendTo("body");
		$('<div id="finedopreviewpicdivcontent" class="finedo-showdialog-content"></div>').html('<img src="'+url+'" onclick="finedo.dialog.closePreview();" width="600px" height="400px">').appendTo("body").css({display:"block",left:($(document.body).outerWidth(true) - 600) / 2,top:0});
	},
	closePreview:function(){
		$('#finedopreviewpicdivcontent').remove();
		$('#finedopreviewpicdivmask').remove();
	},
	/**
	 * 显示窗口
	 */
	show:function(options){
		var default_options = {
			name:''//每个弹出窗口的唯一名称
			,title: ''//标题
			,top: -1 //距离可视窗口顶部高度px
			,left: -1 //距离可视化窗口左侧宽度px
			,width: 600//默认宽度600px
			,height: 438//默认高度438px
			,loadtype: 'iframe'//加载方式（iframe,html,text），是通过iframe加载url，还是直接引用页面中的标签，默认为iframe加载。html为加载指定的div，text为加载一串字符
			,url: ''//通过iframe加载的url
			,div: ''//通过html加载为对应div的id
			,text: ''//通过text加载为一串字符
			,callback: undefined//窗口确认结果后的回调函数，非确认关闭不会调用回调函数
			,showtitle: true//是否显示标题栏，默认显示
			,showbottom: false//是否显示窗口底部内容
			,eventName: 'selectdata'//在弹出窗口为选择数据使用时，以此名称注册事件，接收选中的数据
			,selecttype:''//single、multi
		};
		if(options.top <= 0) {
			options.top=-1;
		}
		if(options.left <= 0) {
			options.left=-1;
		}
			
		var options = $.extend(default_options,options);
		if($.isFunction(options.callback)){
			options.showbottom = true;
		}
		if(options.width > $(document.body).outerWidth(true))
			options.width = $(document.body).outerWidth(true);
		if(options.height > $(window).height())
			options.height = $(window).height();
		
		var dialogdata="";
		var resize = function(dialogid, width, height){
			$('#'+dialogid).width(width);
			$('#'+dialogid).height(height);
			
			var windowleft=($(document.body).outerWidth(true) - width) / 2;
			var windowtop=($(window).height()/2-height/2);
			if(options.left != -1) {
				windowleft=options.left;
			}
			if(options.top != -1) {
				windowtop=options.top;
			}			
			$('#'+dialogid).css({left:windowleft, top:windowtop});
			if(finedo.fn.istrue(options.showtitle))
				height -= $('#'+dialogid+'bar').height();
			else{
				$('#'+dialogid+'bar').hide();
			}
			if(finedo.fn.istrue(options.showbottom))
				height -= $('#'+dialogid+'bm').height();
			else{
				$('#'+dialogid+'bm').hide();
			}
			$('#'+dialogid+'box').height(height);
			$('#'+dialogid+'iframe').height($('#'+dialogid+'box').height());
		};
		var dialogid = 'd'+new Date().getTime();
		var dialogmarkup = '<div class="finedo-dialog" id="'+dialogid+'"> \
								<div class="finedo-dialog-bar" id="'+dialogid+'bar"> \
									<span class="finedo-dialog-title" id="'+dialogid+'title"></span> \
									<input class="finedo-dialog-close" type="button" id="'+dialogid+'close" title="关闭"/> \
									<input class="finedo-dialog-max" type="button" id="'+dialogid+'size" title="最大化"/> \
								</div> \
								<div class="finedo-dialog-content-box" id="'+dialogid+'box"> \
									<div class="finedo-dialog-content" id="'+dialogid+'con"> \
									</div> \
								</div> \
								<div class="finedo-dialog-bottom" id="'+dialogid+'bm"><input type="button" class="finedo-dialog-btn" value="确认" id="'+dialogid+'ok"/></div> \
							</div>';
		var markupMaskTag = $('<div class="finedo-dialog-mask" id="'+dialogid+'mask"></div>').css({display:'block',width:'100%',height:$(document).height()}).appendTo('body'); 
		var markupTag = $(dialogmarkup).appendTo("body");
		$(markupTag).css({display:"block",left:($(document.body).outerWidth(true) - markupTag.width()) / 2,top:($(window).height()/2-markupTag.height()/2)});
		$("#"+dialogid+"size").focus();
		$(markupTag).data('size', 'normal');
		$('#'+dialogid+'title').html(options.title);
		
		if(options.name){
			$(document.body).data(options.name, dialogid);
		}
		$('#'+dialogid+'close').bind('click', function(){
        	finedo.fn.unbindevent(options.eventName);
        	$(window).unbind('resize');
			$('#'+dialogid+'close').unbind('click');
			$('#'+dialogid+'ok').unbind('click');
			$('#'+dialogid+'size').unbind('click');
			$('.finedo-dialog').remove();
			$('.finedo-dialog-mask').remove();
		});
		$('#'+dialogid+'ok').bind('click', function(){
			if($.isFunction(options.callback)){
				options.callback(dialogdata);
			}
        	finedo.fn.unbindevent(options.eventName);
			$(window).unbind('resize');
			$('#'+dialogid+'close').unbind('click');
			$('#'+dialogid+'ok').unbind('click');
			$('#'+dialogid+'size').unbind('click');
			$('.finedo-dialog').remove();
			$('.finedo-dialog-mask').remove();
		});

        //如果存在回调函数，则在最上层窗口注册数据缓存事件
        if($.isFunction(options.callback)){
        	finedo.fn.unbindevent(options.eventName);
        	finedo.fn.bindevent(options.eventName,function(data){
        		if(data.length >2 && (data.substring(0,1) == '[' || data.substring(0,1) == '{')) {
        			// JSON对象
        			eval("dialogdata="+data);
        		}else {
        			// 普通字符串
        			dialogdata=data;
        		}
        		if(options.selecttype=='single')
        			$('#'+dialogid+'ok').trigger('click');
        	});
        };
        
		$('#'+dialogid+'size').bind('click', function(){
			if($(markupTag).data('size') == 'normal'){
				$(this).attr('title','恢复原始大小');
				$(markupTag).data('size', 'max');
				resize(dialogid, $(document.body).outerWidth(true), $(window).height());
			}else{
				$(this).attr('title','最大化');
				$(markupTag).data('size', 'normal');
				resize(dialogid, options.width, options.height);
			}
		});
		//绑定窗口大小变化事件，如果当前窗口是最大化，window发生变化，窗口也随之动态调整大小
		$(window).bind('resize', function(){
			if($(markupTag).data('size') == 'max'){
				resize(dialogid, $(document.body).outerWidth(true), $(window).height());
			}
		});
		
		//拖动效果
		$('#'+dialogid+'bar').mousedown(function(e){
			$('#'+dialogid+'bar').css('cursor','move');//改变鼠标指针的形状  
            var offset = $(markupTag).offset();//DIV在页面的位置
            var x = e.pageX - offset.left;//获得鼠标指针离DIV元素左边界的距离  
            var y = e.pageY - offset.top;//获得鼠标指针离DIV元素上边界的距离  
            $(document).bind('mousemove',function(ev)//绑定鼠标的移动事件，因为光标在DIV元素外面也要有效果，所以要用doucment的事件，而不用DIV元素的事件  
            {  
                var _x = ev.pageX - x;//获得X轴方向移动的值  
                var _y = ev.pageY - y - document.documentElement.scrollTop;//获得Y轴方向移动的值  
                $(markupTag).css({left:_x+'px',top:_y+'px'});  
            });  
              
        });  
        $(document).bind('mouseup',function() {
        	$('#'+dialogid+'bar').css('cursor','default');  
        	$(document).unbind('mousemove');  
        });
        
		//加载弹出窗口url对应的内容
		if(options.loadtype == 'iframe'){
			var iframe = $('<iframe width="100%" frameborder=0 scrolling="auto" id="'+dialogid+'iframe"></iframe>');
			iframe.attr('src',options.url);
			$('#'+dialogid+'con').append(iframe);
		}else if(options.loadtype == 'html'){
			$('#'+dialogid+'box').css({'overflow-y':'auto','overflow-x':'auto'});
			$('#'+dialogid+'con').append($('#'+options.div).clone().css({'display':'block'}));
		}else{
			$('#'+dialogid+'box').css({'overflow-y':'auto','overflow-x':'auto'});
			$('#'+dialogid+'con').html(options.text);
		}
		resize(dialogid, options.width, options.height);
	},
	close:function(name){
		var dialogid = $(document.body).data(name);
		if(!dialogid){
			window.parent.finedo.dialog.close(name);
			return;
		}
		$('#'+dialogid).remove();
		$('#'+dialogid+'mask').remove();
		$(document.body).removeData(name);
	},
	closeAll:function(){
		$('.finedo-dialog').remove();
		$('.finedo-dialog-mask').remove();
		
		window.parent.finedo.dialog.closeAll();
		
	},
	showDialog:function(options){
		var default_options = {
			title: ''//标题
			,top: -1 //距离可视窗口顶部高度px
			,left: -1 //距离可视化窗口左侧宽度px
			,width: 600//默认宽度600px
			,height: 438//默认高度438px
			,loadtype: 'iframe'//加载方式（iframe,html,text），是通过iframe加载url，还是直接引用页面中的标签，默认为iframe加载。html为加载指定的div，text为加载一串字符
			,url: ''//通过iframe加载的url
			,div: ''//通过html加载为对应div的id
			,text: ''//通过text加载为一串字符
			,callback: undefined//窗口确认结果后的回调函数，非确认关闭不会调用回调函数
		};
		var options = $.extend(default_options,options);
		if(options.width > $(document.body).outerWidth(true))
			options.width = $(document.body).outerWidth(true);
		if(options.height > $(window).height())
			options.height = $(window).height();
		
		var dialogdata="";
		var resize = function(dialogid, width, height){
			$('#'+dialogid).width(width);
			$('#'+dialogid).height(height);
			
			var windowleft=($(document.body).outerWidth(true) - width) / 2;
			var windowtop=($(window).height()/2-height/2);
			if(options.left != -1) {
				windowleft=options.left;
			}
			if(options.top != -1) {
				windowtop=options.top;
			}			
			$('#'+dialogid).css({left:windowleft, top:windowtop});
			$('#'+dialogid+'box').height(height);
			$('#'+dialogid+'iframe').height($('#'+dialogid+'box').height());
		};
		var dialogid = 'd'+new Date().getTime();
	    options.id=dialogid;
		var dialogmarkup = '<div class="finedo-dialog" id="'+dialogid+'"> \
								<div class="finedo-dialog-bar" id="'+dialogid+'bar"> \
									<span class="finedo-dialog-title" id="'+dialogid+'title"></span> \
									<input class="finedo-dialog-close" type="button" id="'+dialogid+'close" title="关闭"/> \
									<input class="finedo-dialog-max" type="button" id="'+dialogid+'size" title="最大化"/> \
								</div> \
								<div class="finedo-dialog-content-box" id="'+dialogid+'box"> \
									<div class="finedo-dialog-content" id="'+dialogid+'con"> \
									</div> \
								</div> \
							</div>';
		var markupMaskTag = $('<div class="finedo-dialog-mask" id="'+dialogid+'mask"></div>').css({display:'block',width:'100%',height:$(document).height()}).appendTo('body'); 
		var markupTag = $(dialogmarkup).appendTo("body");
		$(markupTag).css({display:"block",left:($(document.body).outerWidth(true) - markupTag.width()) / 2,top:($(window).height()/2-markupTag.height()/2)});
		$("#"+dialogid+"size").focus();
		$(markupTag).data('size', 'normal');
		$('#'+dialogid+'title').html(options.title);
		$('#'+dialogid+'close').bind('click', function(){
        	finedo.fn.unbindevent(options.eventName);
        	$(window).unbind('resize');
			$('#'+dialogid+'close').unbind('click');
			$('#'+dialogid+'ok').unbind('click');
			$('#'+dialogid+'size').unbind('click');
			$('.finedo-dialog').remove();
			$('.finedo-dialog-mask').remove();
		});
		$('#'+dialogid+'size').bind('click', function(){
			if($(markupTag).data('size') == 'normal'){
				$(this).attr('title','恢复原始大小');
				$(markupTag).data('size', 'max');
				resize(dialogid, $(document.body).outerWidth(true), $(window).height());
			}else{
				$(this).attr('title','最大化');
				$(markupTag).data('size', 'normal');
				resize(dialogid, options.width, options.height);
			}
		});
		//绑定窗口大小变化事件，如果当前窗口是最大化，window发生变化，窗口也随之动态调整大小
		$(window).bind('resize', function(){
			if($(markupTag).data('size') == 'max'){
				resize(dialogid, $(document.body).outerWidth(true), $(window).height());
			}
		});
		
		//拖动效果
		$('#'+dialogid+'bar').mousedown(function(e){
			$('#'+dialogid+'bar').css('cursor','move');//改变鼠标指针的形状  
            var offset = $(markupTag).offset();//DIV在页面的位置
            var x = e.pageX - offset.left;//获得鼠标指针离DIV元素左边界的距离  
            var y = e.pageY - offset.top;//获得鼠标指针离DIV元素上边界的距离  
            $(document).bind('mousemove',function(ev)//绑定鼠标的移动事件，因为光标在DIV元素外面也要有效果，所以要用doucment的事件，而不用DIV元素的事件  
            {  
                var _x = ev.pageX - x;//获得X轴方向移动的值  
                var _y = ev.pageY - y - document.documentElement.scrollTop;//获得Y轴方向移动的值  
                $(markupTag).css({left:_x+'px',top:_y+'px'});  
            });  
              
        });  
        $(document).bind('mouseup',function() {
        	$('#'+dialogid+'bar').css('cursor','default');  
        	$(document).unbind('mousemove');  
        });
        
		//加载弹出窗口url对应的内容
		if(options.loadtype == 'iframe'){
			var iframe = $('<iframe width="100%" frameborder=0 scrolling="auto" id="'+dialogid+'iframe"></iframe>');
			iframe.attr('src',options.url);
			$('#'+dialogid+'con').append(iframe);
		}else if(options.loadtype == 'html'){
			$('#'+dialogid+'box').css({'overflow-y':'auto','overflow-x':'auto'});
			$('#'+dialogid+'con').append($('#'+options.div).clone().css({'display':'block'}));
		}else{
			$('#'+dialogid+'box').css({'overflow-y':'auto','overflow-x':'auto'});
			$('#'+dialogid+'con').html(options.text);
		}
		resize(dialogid, options.width, options.height);
		if(typeof(finedo.controls) == "undefined"){
	    	finedo.controls = [];
	    };
	    finedo.controls["finedo-layer-dialog"] = options;
	},
	closeDialog:function(data){
		var options = parent.finedo.controls["finedo-layer-dialog"];
		if(!options){
			return;
		}
		if($.isFunction(options.callback)){
			options.callback(data);
		}
		delete parent.finedo.controls["finedo-layer-dialog"];
		$('#'+options.id+'mask', window.parent.document).remove();
		$('#'+options.id, window.parent.document).remove();
	}
};
