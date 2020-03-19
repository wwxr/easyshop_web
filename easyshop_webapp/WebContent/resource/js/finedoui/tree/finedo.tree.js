;(function($, undefined) {
	/**
	 * 树形控件
	 * options:{
	 * 	nodes: 控件初始化节点，如果传了初始化节点数据，则不加载url进行数据初始化
	 * 	url: 控件数据加载action，返回数据格式为对象数组
	 * 	onclick: 节点单击事件回调
	 * 	async：true/false，是否异步加载，如果是则点击节点调用服务加载下级，否则不再调用服务加载下级，一次读取数据。默认为false
	 * 	simple：true/false，json数据对象是否为简单的数据格式，即数组对象没有下级对象，通过pid查找下级节点，默认为false
	 * 	selecttype:(single/multi/''),单选与多选，默认为空
	 * 	cascade:true/false,级联，默认为true
	 *  cascadetype:all/up/down，级联类型，默认为all,全部级联、向上级联、向下级联
	 * }
	 * 树形控件节点数据格式：
	 * {
	 * 	id:节点id
	 * 	pid:上级节点id
	 * 	name:节点名称，显示当前节点的名称串
	 * 	icon：自定义节点图标
	 * 	open:true/false，节点当前是否已展开
	 * 	children:[]下级节点列表
	 * 	checked:true/false，当前节点是否已选中
	 * }
	 * 查询树节点返回json对象结构实例：{
		    "object": [
		        {
		            "id": "XX",
		            "pid": "parentid",
		            "name": 组织节点,
		            "icon": "images/test.png",
		            "open": "true",
		            "children": []
		        }
		    ],
		    "resultcode": "SUCCESS",
		    "resultdesc": "查询组织结构信息成功",
		    "resultlist": [],
		    "resultlistString": "",
		    "success": true
		}
	 */
	$.fn.tree = function(options){
		var $finedotree = this;
		var $clickitem;//当前被点击的对象
		var $treeid = $finedotree.attr('id');
		var eventName = 'selectdata';
		var selecteditems=[];
		var currentNodeid;
		var default_options = {
			async:false,
			simple:false,
			cascade:true,
			cascadetype:'all'
		};
		var fullcheckcls = "node chk icon_checkbox_yes";
		var fulluncheckcls = "node chk icon_checkbox_no";
		var iconopencls = "node icon_open";
		var iconclosecls = "node icon_close";
		var loadingcls = "node icon_loading";
		var icondocucls = "node icon_docu";
		var iconemptycls = "node icon_empty";
		if(finedo.fn.isNon($finedotree.data('options'))){
			var options = $.extend(default_options,options);
			$finedotree.data('options', options);
		}

		this.setUrl = this.seturl = function(url){
			$finedotree.data('options').url = url;
		};

		this.setOnclick = this.setonclick = function(onclick){
			$finedotree.data('options').onclick = onclick;
		};

		this.setAsync = this.setasync = function(async){
			$finedotree.data('options').async = async;
		};

		this.setSimple = this.getsimple = function(simple){
			$finedotree.data('options').simple = simple;
		};

		this.setSelecttype = this.setselecttype = function(selecttype){
			$finedotree.data('options').selecttype = selecttype;
		};
		
		this.setCascade = this.setcascade = function(cascade){
			$finedotree.data('options').cascade = cascade;
		};
		
		this.setCascadetype = this.setcascadetype = function(cascadetype){
			$finedotree.data('options').cascadetype = cascadetype;
		};
		
		this.getoption = function(key){
			return $finedotree.data('options')[key];
		};
		
		this.setoption = function(key, value){
			$finedotree.data('options')[key] = value;
		};
		
		this.getselecteditems = function(){
			return selecteditems;
		};
		
		this.dataSelected = this.dataselected = function(data, selected){
			if(finedo.fn.isNon($finedotree.data('options').selecttype))
				return;
			if(selected == true){
				var dataindex = finedo.fn.inarray(data,selecteditems, null);
				if(dataindex == -1)
					selecteditems.push(data);
				finedo.fn._triggerEvent(eventName, JSON.stringify(selecteditems));
			}else{
				var dataindex = finedo.fn.inarray(data,selecteditems, null);
        		if(dataindex != -1)
        			selecteditems.splice(dataindex,1);
        		finedo.fn._triggerEvent(eventName, JSON.stringify(selecteditems));
			}
		};
		
		/**
		 * 级联处理上级
		 */
		this.cascadeParent = this.cascadeparent = function(data, selected){
			if(data.pid == '0' || finedo.fn.isnon(data.pid)){
				return;
			}
			var pdata = $('#'+$treeid+'_'+data.pid).data('data');
			if(finedo.fn.isnon(pdata))
				return;
			var ischecked = false;
			for(var i = 0; i < pdata.children.length; i++){
				if($('#'+$treeid+'_'+pdata.children[i].id+'_check').attr("treenode_check") == "true"){
					ischecked = true;
					break;
				}
			}
			if(selected == true){
				if(ischecked == true){
					$('#'+$treeid+'_'+pdata.id+'_check').attr("treenode_check", "true");
					$('#'+$treeid+'_'+pdata.id+'_check').removeClass(fulluncheckcls);
					$('#'+$treeid+'_'+pdata.id+'_check').addClass(fullcheckcls);
					$finedotree.dataSelected(pdata ,true);
					$finedotree.cascadeParent(pdata, selected);
				}
			}else{
				if(ischecked == false){
					$('#'+$treeid+'_'+pdata.id+'_check').attr("treenode_check", "false");
					$('#'+$treeid+'_'+pdata.id+'_check').removeClass(fullcheckcls);
					$('#'+$treeid+'_'+pdata.id+'_check').addClass(fulluncheckcls);
					$finedotree.dataSelected(pdata ,false);
					$finedotree.cascadeParent(pdata, selected);
				}
			}
			
		};
		
		/**
		 * 级联处理下级
		 */
		this.cascade = function(data, selected){
			if(finedo.fn.isnon(data.children))
				return;
			for(var i = 0; i < data.children.length; i++){
				if(selected == false){
					$('#'+$treeid+'_'+data.children[i].id+'_check').attr("treenode_check", "false");
					$('#'+$treeid+'_'+data.children[i].id+'_check').removeClass(fullcheckcls);
					$('#'+$treeid+'_'+data.children[i].id+'_check').addClass(fulluncheckcls);
					$finedotree.dataSelected(data.children[i] ,false);
				}else{
					$('#'+$treeid+'_'+data.children[i].id+'_check').attr("treenode_check", "true");
					$('#'+$treeid+'_'+data.children[i].id+'_check').removeClass(fulluncheckcls);
					$('#'+$treeid+'_'+data.children[i].id+'_check').addClass(fullcheckcls);
					$finedotree.dataSelected(data.children[i] ,true);
				}
				$finedotree.cascade(data.children[i], selected);
			}
		};

		/**
		 * 递归遍历所有下级节点
		 */
		this.parseChildren = this.parsechildren = function(data, node){
			for(var i = 0; i < data.length; i++){
				if(data[i].pid != node.id){
					continue;
				}
				if(finedo.fn.isNon(node.children)){
					node.children = [];
				}
				node.children.push(data[i]);
				$finedotree.parseChildren(data, data[i]);
			}
		};
		
		/**
		 * 格式化数据，将简单的数据格式化为树形结构的数据
		 */
		this.formatData = this.formatdata = function(data){
			var formatdata = [];
			for(var i = 0; i < data.length; i++){
				if(data[i].pid != '0'){
					continue;
				}
				formatdata.push(data[i]);
				$finedotree.parseChildren(data, data[i]);
			}
			return formatdata;
		};
		
		/**
		 * 加载树节点
		 */
		this.loadNodes = this.loadnodes = function(parentNode, data, parentNodeid){
			var rootopen = true;
			if(parentNode != $finedotree){
				var ulid = parentNode.attr('id');
				ulid = ulid.substring(0, ulid.length-3);
				var ulidata = $('#'+ulid).data('data');
				ulidata.children = data;
				var iconobj = $('#'+ulid+'_ico');
				iconobj.attr('treenode_loaded',true);
				if(data.length == 0){
					iconobj.unbind('click');
				}
				iconobj.removeClass(loadingcls);
				if(finedo.fn.isnotnon(ulidata.icon)){
					iconobj.addClass(iconemptycls);
					iconobj.css('background-image','url('+ulidata.icon+')');
				}else{
					if(data.length == 0){
						iconobj.addClass(icondocucls);
						return;
					}
					iconobj.addClass(iconopencls);
				}
			}
			var ischecked = false;
			if(finedo.fn.isnotnon(parentNodeid)){
			    var checkstr = $("#"+$treeid+"_"+parentNodeid+"_check").attr("treenode_check");
			    ischecked = checkstr == "true" ? true : false;
			}
			if(ischecked){
			    if(!finedo.fn.isTrue($finedotree.data('options').cascade) || $finedotree.data('options').cascadetype == 'up'){
			        ischecked = false;
			    }
			}
			for(var i = 0; i < data.length; i++){
                var nodedata = data[i];
                if(finedo.fn.isnon(nodedata.checked)){
                    nodedata.checked = ischecked;
                }
				rootopen = parentNode == $finedotree && i == 0 ? true : false;
				if(!rootopen && finedo.fn.istrue(nodedata.open))
					rootopen = true;
				var node = $('<li id="'+$treeid+'_'+nodedata.id+'">');
				if(finedo.fn.isnon(nodedata.children))
					nodedata.children = [];
				node.data('data', nodedata);
				var switchNode, checkNode, aNode;
				if(finedo.fn.isnon(nodedata.children)){
					
					switchNode = $('<span id="'+$treeid+'_'+nodedata.id+'_ico" class="'+(finedo.fn.isnotnon(nodedata.icon) ? iconemptycls : (finedo.fn.istrue($finedotree.getoption("async")) ? iconclosecls : icondocucls))+'"></span>');
					aNode = $('<a id="'+$treeid+'_'+nodedata.id+'_a" title="'+nodedata.name+'">\
							<span id="'+$treeid+'_'+nodedata.id+'_span">'+nodedata.name+'</span></a>');
				}else{
					switchNode = $('<span id="'+$treeid+'_'+nodedata.id+'_ico" class="'+(finedo.fn.isnotnon(nodedata.icon) ? iconemptycls : (rootopen ? iconopencls: iconclosecls))+'"></span>');
					aNode = $('<a id="'+$treeid+'_'+nodedata.id+'_a" title="'+nodedata.name+'">\
							<span id="'+$treeid+'_'+nodedata.id+'_span">'+nodedata.name+'</span></a>');
				}
				//判断节点是否自定义了显示图标
				if(finedo.fn.isnotnon(nodedata.icon)){
					$(switchNode).css('background-image','url('+nodedata.icon+')');
					$(switchNode).css('background-size','22px');
				}
				node.append(switchNode);
				if($finedotree.data('options').selecttype == 'multi'){
					checkNode = $('<span id="'+$treeid+'_'+nodedata.id+'_check" class="'+fulluncheckcls+'"></span>');
					if(finedo.fn.istrue(nodedata.checked)){
						$(checkNode).attr('treenode_check', 'true');
						$(checkNode).attr('class', fullcheckcls);
						selecteditems.push(nodedata);
					}else{
						$(checkNode).attr('treenode_check', 'false');
						$(checkNode).attr('class', fulluncheckcls);
					}
					checkNode.bind('click', nodedata, function(event){
						if($(this).attr('treenode_check') == 'true'){
							$(this).attr('treenode_check', 'false');
							$(this).removeClass(fullcheckcls);
							$(this).addClass(fulluncheckcls);
							$finedotree.dataSelected(event.data ,false);
							if(finedo.fn.isTrue($finedotree.data('options').cascade)){
								if($finedotree.data('options').cascadetype == 'up'){
									$finedotree.cascadeParent(event.data, false);
								}else if($finedotree.data('options').cascadetype == 'down'){
									$finedotree.cascade(event.data, false);
								}else{
									$finedotree.cascade(event.data, false);
									$finedotree.cascadeParent(event.data, false);
								}
							}
						}else{
							$(this).attr('treenode_check', 'true');
							$(this).removeClass(fulluncheckcls);
							$(this).addClass(fullcheckcls);
							$finedotree.dataSelected(event.data ,true);
							if(finedo.fn.isTrue($finedotree.data('options').cascade)){
								if($finedotree.data('options').cascadetype == 'up'){
									$finedotree.cascadeParent(event.data, true);
								}else if($finedotree.data('options').cascadetype == 'down'){
									$finedotree.cascade(event.data, true);
								}else{
									$finedotree.cascade(event.data, true);
									$finedotree.cascadeParent(event.data, true);
								}
							}
						}
					});
					node.append(checkNode);
				}else if($finedotree.data('options').selecttype == 'single'){
					aNode.bind('dblclick', nodedata, function(event){
						finedo.fn._triggerEvent(eventName, event.data);
					});
				}
				node.append(aNode);
				
				switchNode.bind('click', nodedata, function(event){
					var ulid = $treeid+'_'+event.data.id+'_';
					if($(this).attr('treenode_switch') == 'close'){
						$(this).attr('treenode_switch', 'open');
						if(finedo.fn.isnon(event.data.icon)){
							$(this).removeClass(iconopencls);
							$(this).addClass(iconclosecls);
						}
						$('#'+ulid + 'ul').toggle(200);
					}else{
						$(this).attr('treenode_switch', 'close');
						//如果是异步加载方式，则判断当前节点是否已加载过
						if(finedo.fn.istrue($finedotree.getoption("async"))){
							if(finedo.fn.isnon($(this).attr('treenode_loaded'))){
								if($(this).hasClass(loadingcls))
									return;
								$(this).removeClass();
								$(this).removeAttr('style');
								$(this).addClass(loadingcls);
								$finedotree.load(event.data);
								$('#'+ulid + 'ul').show();
								return;
							}
						}
						if(finedo.fn.isnon(event.data.icon)){
							$(this).removeClass(iconclosecls);
							$(this).addClass(iconopencls);
						}
						$('#'+ulid + 'ul').toggle(200);
					}
				});
				if($.isFunction($finedotree.data('options').onclick)){
					aNode.bind('click', nodedata, function(event){
						if(currentNodeid){
							$('#'+$treeid+'_'+currentNodeid+'_span').css("color","");
						}
						currentNodeid = event.data.id;
						$('#'+$treeid+'_'+currentNodeid+'_span').css("color","blue");
						$finedotree.data('options').onclick(event.data);
					});
				}
				
				if(finedo.fn.istrue($finedotree.getoption('async')) || finedo.fn.isNotNon(nodedata.children)){
					var ulNode = $('<ul id="'+$treeid+'_'+nodedata.id+'_ul" style="display:'+(rootopen ? 'block': 'none')+';">');
					node.append(ulNode);
				}
				parentNode.append(node);
				if(finedo.fn.isNotNon(nodedata.children)){
					$finedotree.loadNodes(ulNode, nodedata.children);
				}
			}
		};
		
		this.load = function(reqdata){
			if(finedo.fn.isnon($finedotree.data('options').url))
				return;
			var requestdata = $.extend($finedotree.data('options').data,reqdata);
            var reqjson = finedo.version >= 3.0 ? true : false;
			
			finedo.action.ajax({
                url:$finedotree.data('options').url,
                data:requestdata,
                reqjson:reqjson,
                iswait:false,
                callback:function(retdata){
                    var objdata = retdata;
                    if(finedo.fn.isobject(retdata) && retdata.fail){
                        finedo.message.error(data.resultdesc);
                        return;
                    }
                    if(finedo.fn.isobject(retdata) && finedo.fn.isarray(retdata.object)){
                        objdata = objdata.object;
                    }
                    if(finedo.fn.isTrue($finedotree.data('options').simple)){
                        objdata = $finedotree.formatData(objdata);
                    }
                    $finedotree.loadNodes(finedo.fn.isnon(reqdata) ? $finedotree : $('#'+$treeid+'_'+reqdata.id+'_ul'), objdata, finedo.fn.isnon(reqdata) ? undefined : reqdata.id);
                }
			});
		};
		
		this.loadData = this.loaddata = function(nodes){
			$finedotree.html('');
			$finedotree.setoption(nodes, nodes);
			if(finedo.fn.isTrue($finedotree.data('options').simple))
				nodes = $finedotree.formatData(nodes);
			$finedotree.loadNodes($finedotree, nodes);
		};
		
        /**
         * 控件初始化
         */
        this.init = function(){
        	if($finedotree.data('init') == true)
        		return $finedotree;
        	$finedotree.data('init', true);
        	
        	var attroptions = {};
        	$.each($(this)[0].attributes, function(index, attr) {
        		attroptions[attr.name] = attr.value;
			});
        	if(finedo.fn.isFunction(attroptions.onclick))
        		attroptions.onclick = eval(attroptions.onclick);
        	var options = $.extend($finedotree.data('options'),attroptions);
			$finedotree.data('options', options);
			if(finedo.fn.isnotnon(options.nodes)){
				var nodes = options.nodes;
				if(finedo.fn.isTrue($finedotree.data('options').simple))
					nodes = $finedotree.formatData(nodes);
				$finedotree.loadNodes($finedotree, nodes);
			}else{
				$finedotree.load();
			}
			return $finedotree;
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
finedo.getTree = finedo.gettree = function(controlid, options){
	if(finedo.controls[controlid] && typeof(options) == "undefined") {
		return finedo.controls[controlid];
	}
	finedo.controls[controlid]=$('#'+controlid).tree(options);
	return finedo.controls[controlid];
};

/**
 * 页面加载后自动加载树控件

$(document.body).ready(function(){
	$(document.body).find(".fdtree").each(function(treeindex,treeitem){
		if(finedo.fn.isNotNon($(treeitem).attr('id')))
			finedo.getTree($(treeitem).attr('id'));
	});
});
*/
