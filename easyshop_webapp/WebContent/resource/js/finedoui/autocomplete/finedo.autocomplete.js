;(function($, undefined) {
	/**
	 * 自动补全控件
	 * options:{
	 * 	datasource: 自定义方式加载的自动补全源
	 * 	url: 通过调用服务方式加载自动补全数据源
	 * }
	 */
	$.fn.autocomplete = function(options){
		var $finedoautocomplete = this;
		
		if(finedo.fn.isnon($finedoautocomplete.data('options'))){
			var options = $.extend({},options);
			$finedoautocomplete.data('options', options);
		}

		this.setUrl = this.seturl = function(url){
			$finedoautocomplete.data('options').url = url;
		};
		
		this.getoption = function(key){
			return $finedoautocomplete.data('options')[key];
		};
		
		this.setoption = function(key, value){
			$finedoautocomplete.data('options')[key] = value;
		};
		
		this.style = {};
		
		this.pointoffset = function (elem) {
            var box = elem.getBoundingClientRect(), doc = elem.ownerDocument, body = doc.body, docElem = doc.documentElement;
            var clientTop = docElem.clientTop || body.clientTop || 0, clientLeft = docElem.clientLeft || body.clientLeft || 0;
            var top = box.top + (self.pageYOffset || docElem.scrollTop) - clientTop, left = box.left + (self.pageXOffset || docElem.scrollLeft) - clientLeft;
            return {
                left: left,
                top: top,
                right: left + box.width,
                bottom: top + box.height
            };
        };
        
        this.getfocus = function (elem) {
            var index = 0;
            if (document.selection) {// IE Support
                elem.focus();
                var Sel = document.selection.createRange();
                if (elem.nodeName === 'TEXTAREA') {//textarea
                    var Sel2 = Sel.duplicate();
                    Sel2.moveToElementText(elem);
                    var index = -1;
                    while (Sel2.inRange(Sel)) {
                        Sel2.moveStart('character');
                        index++;
                    };
                }else if (elem.nodeName === 'INPUT') {// input
                    Sel.moveStart('character', -elem.value.length);
                    index = Sel.text.length;
                }
            }else if (elem.selectionStart || elem.selectionStart == '0') { // Firefox support
                index = elem.selectionStart;
            }
            return (index);
        };
        
        this.getstyle = 'getComputedStyle' in window ? function (elem, name) {
            return getComputedStyle(elem, null)[name];
        } : function (elem, name) {
            return elem.currentStyle[name];
        };
		
		this.addheadstyle = function (content) {
            var style = this.style[document];
            if (!style) {
                style = this.style[document] = document.createElement('style');
                document.getElementsByTagName('head')[0].appendChild(style);
            };
            style.styleSheet && (style.styleSheet.cssText += content) || style.appendChild(document.createTextNode(content));
        };
        
        this.clonestyle = function (elem, cache) {
            if (!cache && elem['${cloneName}']) return elem['${cloneName}'];
            var className, name, rstyle = /^(number|string)$/;
            var rname = /^(content|outline|outlineWidth)$/; //Opera: content; IE8:outline && outlineWidth  
            var cssText = [], sStyle = elem.style;
            for (name in sStyle) {
                if (!rname.test(name)) {
                    val = this.getstyle(elem, name);
                    if (val !== '' && rstyle.test(typeof val)) { // Firefox 4
                        name = name.replace(/([A-Z])/g, "-$1").toLowerCase();
                        cssText.push(name);
                        cssText.push(':');
                        cssText.push(val);
                        cssText.push(';');
                    };
                };
            };
            cssText = cssText.join('');
            elem['${cloneName}'] = className = 'clone' + (new Date).getTime();
            this.addheadstyle('.' + className + '{' + cssText + '}');
            return className;
        };
        
        this.getinputpositon = function(elem){
            if (document.selection) {   //IE Support  
                elem.focus();
                var Sel = document.selection.createRange();
                return {
                    left: Sel.boundingLeft,
                    top: Sel.boundingTop,
                    bottom: Sel.boundingTop + Sel.boundingHeight
                };  
            } else {
                var cloneDiv = '{$clone_div}', cloneLeft = '{$cloneLeft}', cloneFocus = '{$cloneFocus}', cloneRight = '{$cloneRight}';
                var none = '<span style="white-space:pre-wrap;"> </span>';
                var div = elem[cloneDiv] || document.createElement('div'), focus = elem[cloneFocus] || document.createElement('span');
                var text = elem[cloneLeft] || document.createElement('span');
                var offset = this.pointoffset(elem), index = this.getfocus(elem), focusOffset = { left: 0, top: 0 };
                if (!elem[cloneDiv]) {
                    elem[cloneDiv] = div, elem[cloneFocus] = focus;
                    elem[cloneLeft] = text;
                    div.appendChild(text);
                    div.appendChild(focus);
                    document.body.appendChild(div);
                    focus.innerHTML = '|';
                    focus.style.cssText = 'display:inline-block;width:0px;overflow:hidden;z-index:-100;word-wrap:break-word;word-break:break-all;';
                    div.className = this.clonestyle(elem);
                    div.style.cssText = 'visibility:hidden;display:inline-block;position:absolute;z-index:-100;word-wrap:break-word;word-break:break-all;overflow:hidden;';
                };
                div.style.left = this.pointoffset(elem).left + "px";
                div.style.top = this.pointoffset(elem).top + "px";
                var strTmp = elem.value.substring(0, index).replace(/</g, '<').replace(/>/g, '>').replace(/\n/g, '<br/>').replace(/\s/g, none);
                text.innerHTML = strTmp;
                focus.style.display = 'inline-block';
                try { focusOffset = this.pointoffset(focus); } catch (e) {};
                focus.style.display = 'none';
                return {
                    left: focusOffset.left,
                    top: focusOffset.top,
                    bottom: focusOffset.bottom
                };
            }
        };

		this.showautocomplete = function(datasource){
			var autocompleteul = $('#'+$finedoautocomplete.attr('id')+'autocomplete');
			autocompleteul.html('');
			if(finedo.fn.isnon(datasource) || datasource.length == 0)
				return;
			var autocompletediv = $('#'+$finedoautocomplete.attr('id')+'autocompletediv');
			var controloffset = $finedoautocomplete.offset();
        	var controltype = $finedoautocomplete.get(0).tagName.toUpperCase();
			if(controltype == "INPUT"){
				autocompletediv.css({'min-width':$finedoautocomplete.width(), 'top':controloffset.top+$finedoautocomplete.height()+12,'left':controloffset.left});
			}else if(controltype== "TEXTAREA"){
				var location = $finedoautocomplete.getinputpositon(document.getElementById($finedoautocomplete.attr('id')));
				autocompletediv.css({'top':location.bottom,'left':location.left});
			}
			var html = '';
			for(var index = 0; index < datasource.length; index++){
				html+='<li autocompleteindex="'+$finedoautocomplete.attr('id')+'">'+datasource[index]+'</li>';
			}
			autocompleteul.html(html);
			autocompletediv.show();
		};
		
		this.registerevent = function(){
			$finedoautocomplete.keyup(function(){
				if($(this).attr("id") != $finedoautocomplete.attr('id')){
					return;
				}
				var acval = $.trim($finedoautocomplete.val());
				if(acval == "")
					return;
				var acindex = acval.lastIndexOf(",");
				if(acindex == -1){
					acindex = acval.lastIndexOf("，");
				}
				acval = acindex == -1 ? acval : acval.substr(acindex+1);
				if(acval == "")
					return;
				acval = $.trim(acval);
				var reg = new RegExp(acval, 'i');
				var datasource = $finedoautocomplete.data('datasource');
				var sds = [];
				for(var index = 0; index < datasource.length; index++){
					if(reg.test(datasource[index])){
						sds.push(datasource[index]);
					}
				}
				$finedoautocomplete.showautocomplete(sds);
			});
			$(document).bind('click', function(e){
				var event = e || window.event;
				var ele = event.srcElement || event.target;
				if(ele.id == $finedoautocomplete.attr('id'))
					return;
				if($(ele).attr("autocompleteindex") == $finedoautocomplete.attr('id')){
					var acval = $.trim($finedoautocomplete.val());
					var acindex = acval.lastIndexOf(",");
					if(acindex == -1){
						acindex = acval.lastIndexOf("，");
					}
					acval = acindex == -1 ? '' : acval.substring(0, acindex+1);
					$finedoautocomplete.val(acval+$(ele).text());
					$finedoautocomplete.focus();
				}
				$('#'+$finedoautocomplete.attr('id')+'autocompletediv').hide();
			});
		};

		this.load = function(reqdata){
			if(finedo.fn.isnon($finedoautocomplete.getoption('url'))){
				$finedoautocomplete.registerevent();
				return;
			}
			$.ajax({
	            url: $finedoautocomplete.getoption('url'),
	            data: reqdata,
	            type: "post",
	            dataType: 'json',
	            success: function(data){
					if(finedo.fn.isnotnon(data.resultcode)){
						if(data.fail){
							finedo.message.error(data.resultdesc);
							return;
						}
						var ds = $finedoautocomplete.data('datasource');
						for(var i = 0; i < data.object.length; i++)
							ds.push(data.object[i]);
						$finedoautocomplete.registerevent();
					}
	            }
	        });
		};
		
		/**
         * 控件初始化
         */
        this.init = function(){
        	if($finedoautocomplete.data('init') == true)
        		return $finedoautocomplete;
        	$finedoautocomplete.data('init', true);
        	
        	var attroptions = {};
        	$.each($(this)[0].attributes, function(index, attr) {
        		attroptions[attr.name] = attr.value;
			});
        	var options = $.extend($finedoautocomplete.data('options'),attroptions);
        	$finedoautocomplete.data('options', options);
        	
        	if(finedo.fn.isnotnon(options.datasource)){
        		var ds = [];
        		for(var i = 0; i < options.datasource.length; i++)
					ds.push(options.datasource[i]);
        		$finedoautocomplete.data('datasource',ds);
        	}else{
        		$finedoautocomplete.data('datasource',[]);
        	}
			
        	var autocompletediv = $('<div class="fdautocomplete" id="'+$finedoautocomplete.attr('id')+'autocompletediv"><ul id="'+$finedoautocomplete.attr('id')+'autocomplete"></ul></div>');
        	$finedoautocomplete.after(autocompletediv);
        	autocompletediv.hide();
        	
			$finedoautocomplete.load(options.queryparams);
			
			return $finedoautocomplete;
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
finedo.getautocomplete = function(controlid, options){
	if(finedo.controls[controlid] && typeof(options) == "undefined") {
		return finedo.controls[controlid];
	}
	finedo.controls[controlid]=$('#'+controlid).autocomplete(options);
	return finedo.controls[controlid];
 };
