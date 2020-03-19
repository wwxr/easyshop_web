;(function($, undefined) {
	/**
	 * 表格控件操作
	 * options:{
	 * 	className:样式表
	 * 	pagination:是否分布，默认不传为分页
	 * 	url:加载url
	 * 	pagination:是否分页
	 * 	pagesize:每页显示数据量
	 * 	colortr:隔行显示的class
	 * 	data:请求参数，Json格式
	 * 	oncerequest:一次请求（true/false），默认为false。一次请求意思是指一次将查询结果全部返回，在客户端分页
	 * 	updateurl:列更新action
	 * 	servorder:(true/false)，是否为服务端排序
	 * 	selecttype:(single/multi/''),单选与多选，默认为空
	 * 	expand:(true/false)，是否支持行数据展开，默认为true
	 *  scrollload:(true/false)，是否支持滚动加载，黑认为false
	 *  pagechange:function
	 *  orderchange:function
	 *  ondbclick:function,双击行的回调,返回当前行的json对象
	 *  onclick:function,单击行的回调,返回当前行的json对象
	 *  querydomainkey,如果调用的是AP，则查询传的是querydomain实体类，通过这个键传入querydomain中查询实体的属性名
     *  pagedomainkey,如果调用的是AP，则查询传的是querydomain实体类，通过这个键传入querydomain中分页实体的属性名
	 * }
	 * 列属性：{
	 * 	code:列的编码，对应服务返回字段名
	 * 	name:显示列标题名称
	 * 	width:显示列的宽度
	 * 	order:当前列是否支持排序
	 * 	edit:当前列是否支持编辑
	 * 	formater:格式化输出列
	 * 	canhide:true/false，是否可以隐藏，当document宽度小于800时，隐藏canhide为true的列
	 * }
	 */
	$.fn.grid = function(options){
		var $finedogrid = this;
		var pages;
		var eventName = 'selectdata';
		var clickedtritem;//当前点击的tr
		
		if(finedo.fn.isnotnon(options)){
			if(finedo.fn.isnon($finedogrid.data("options")))
				$finedogrid.data("options", options);
			else
				$finedogrid.data("options").queryparams = {};
				$finedogrid.data("options", $.extend($finedogrid.data("options"),options));
		}
		
		this.getdescitems = function(){
			return $finedogrid.data("descitems");
		};

		this.getascitems = function(){
			return $finedogrid.data("ascitems");
		};

		this.getallselecteditems = function(){
			return $finedogrid.data("allselecteditems");
		};
		
		this.pageoption = function(pagesVal){
			if(pagesVal){
				$finedogrid.data("pages", pagesVal);
				return;
			}
			return $finedogrid.data("pages");
		};
		this.firstPage = this.firstpage = function(){
			pages = $finedogrid.pageoption();
			if(pages.page == 1)
				return;
			pages.page = 1;
			$finedogrid.pageoption(pages);
			$finedogrid.pagechange(pages.page);
		};

		this.prePage = this.prepage = function(){
			pages = $finedogrid.pageoption();
			if(pages.page == 1)
				return;
			pages.page -= 1;
			$finedogrid.pageoption(pages);
			$finedogrid.pagechange(pages.page);
		};

		this.nextPage = this.nextpage = function(){
			pages = $finedogrid.pageoption();
			if(pages.page >= pages.totalpage)
				return;
			pages.page += 1;
			$finedogrid.pageoption(pages);
			$finedogrid.pagechange(pages.page);
		};

		this.lastPage = this.lastpage = function(){
			pages = $finedogrid.pageoption();
			if(pages.page >= pages.totalpage)
				return;
			pages.page = pages.totalpage;
			$finedogrid.pageoption(pages);
			$finedogrid.pagechange(pages.page);
		};

		this.junmPage = this.junmpage = function(val){
			pages = $finedogrid.pageoption();
			if(val == pages.page)
				return;
			if(val < 1 || val > pages.totalpage)
				return;
			pages.page = parseInt(val);
			$finedogrid.pageoption(pages);
			$finedogrid.pagechange(pages.page);
		};
		
		this.pagechange = function(val){
			var options = $finedogrid.data("options");
			if($.isFunction(options.pagechange)){
				options.pagechange({pageindex:pages.page,desc:$finedogrid.getdescitems(),asc:$finedogrid.getascitems()});
			}else if(finedo.fn.isfunction(options.pagechange)){
				var fun = eval(options.pagechange);
				fun({pageindex:pages.page,desc:$finedogrid.getdescitems(),asc:$finedogrid.getascitems()});
			}else{
				this.execquery();
			}
		};
		
		this.refresh = function(){
			this.execquery();
		};
        
		this.selectAll = this.selectall = function(val){
        	$(this).find("tbody input[type=checkbox]").each(function(checkboxindex,checkboxitem){
        		checkboxitem.checked=val;
        		$finedogrid.rowselected(checkboxitem);
        	});
        };
        
        this.needhide = function(){
        	var docwidth = $finedogrid.parent().width();
        	if(docwidth <= 600)
        		return true;
        	return false;
        };
        
        /**
         * 设置options值
         */
        this.setOption = this.setoption = function(key, value){
        	$finedogrid.data("options")[key] = value;
        };
        
        /**
         * 获取缓存的查询条件
         */
        this.getQueryParams = this.getqueryparams = function(){
        	var param = $finedogrid.data("options").queryparams;
        	return finedo.fn.isnon(param) ? '' : param;
        };
        
        /**
         * 获取选择的行的对象数组
         */
        this.getSelectedItem = this.getselecteditem = function(){
        	var selectedItem = [];
        	var options = $finedogrid.data("options");
        	if(options.selecttype == "multi"){
	        	$($finedogrid).find("tbody input[type=checkbox]").each(function(checkboxindex,checkboxitem){
	        		if(checkboxitem.checked == true){
	        			selectedItem.push($finedogrid.data("datarows")[checkboxindex]);
	        		}
	        	});
        	}else if(options.selecttype == "single"){
        		$($finedogrid).find("tbody input[type=radio]").each(function(checkboxindex,checkboxitem){
	        		if(checkboxitem.checked == true){
	        			selectedItem.push($finedogrid.data("datarows")[checkboxindex]);
	        		}
	        	});
        	}
        	return selectedItem;
        };
        
        /**
         * 获取表格数据，如果是缓存到本地分页数据，则返回缓存所有数据，如果是请求服务分页数据，则只返回当前页数据
         */
        this.getData = this.getdata = function(){
        	if(finedo.fn.isnotnon($finedogrid.data("alldatarows"))){
        		return $finedogrid.data("alldatarows").rows;
        	}else{
        		return $finedogrid.data("datarows");
        	}
        };
        
        /**
         * 选中或取消选中某行触发的事件
         */
        this.rowselected = function(checkitem){
        	if(checkitem.checked == true){
        		$finedogrid.getallselecteditems().push($(checkitem).data('data'));
        		if(finedo.fn.isnon($finedogrid.data('options').selecttype)){
        			return;
        		}
        		finedo.fn._triggerevent(eventName, JSON.stringify($finedogrid.getallselecteditems()));
        	}else{
        		var dataindex = finedo.fn.inarray($(checkitem).data('data'),$finedogrid.getallselecteditems(), null);
        		if(dataindex != -1)
        			$finedogrid.getallselecteditems().splice(dataindex,1);
        		if(finedo.fn.isnon($finedogrid.data('options').selecttype)){
        			return;
        		}
        		finedo.fn._triggerevent(eventName, JSON.stringify($finedogrid.getallselecteditems()));
        	}
        };
        
        /**
         * 判断当前行数据是否选中
         */
        this.isselected = function(data){
        	if($finedogrid.getallselecteditems().length == 0)
        		return false;
        	for(var i = 0; i < $finedogrid.getallselecteditems().length; i++){
        		var isequal = true;
        		isequal = finedo.fn.jsonequal(data, $finedogrid.getallselecteditems()[i], null);
        		if(isequal)
        			return true;
        	}
        	return false;
        };
        
        /**
         * 表格排序，参数为对应的input按钮
         */
        this.gridSort = this.gridsort = function(item, code){
        	var options = $finedogrid.data("options");
        	if($(item).attr("class") == "finedo-asc"){
            	$(item).attr("title", "点击降序");
        		$(item).removeClass("finedo-asc");
        		$(item).addClass("finedo-desc");
        		var ascIndex = $.inArray(code, $finedogrid.getascitems());
    			if(ascIndex == -1)
    				$finedogrid.getascitems().push(code);
    			var descIndex = $.inArray(code, $finedogrid.getdescitems());
    			if(descIndex != -1)
    				$finedogrid.getdescitems().splice(descIndex, 1);
    			
    			if($.isFunction(options.orderchange)){
    				options.orderchange({pageindex:pages.page,desc:$finedogrid.getdescitems(),asc:$finedogrid.getascitems()});
    			}else if(finedo.fn.isfunction(options.orderchange)){
    				var fun = eval(options.orderchange);
    				fun({pageindex:pages.page,desc:$finedogrid.getdescitems(),asc:$finedogrid.getascitems()});
    			}else{
	        		if(finedo.fn.istrue($finedogrid.data("options").servorder)){
	        			$finedogrid.load();
	        		}else{
	        			$finedogrid.sort("asc", code);
	        		}
    			}
        	}else{
            	$(item).attr("title", "点击升序");
        		$(item).removeClass("finedo-desc");
        		$(item).addClass("finedo-asc");
    			var descIndex = $.inArray(code, $finedogrid.getdescitems());
    			if(descIndex == -1)
    				$finedogrid.getdescitems().push(code);
    			var ascIndex = $.inArray(code, $finedogrid.getascitems());
    			if(ascIndex != -1)
    				$finedogrid.getascitems().splice(ascIndex, 1);
    			if($.isFunction(options.orderchange)){
    				options.orderchange({pageindex:pages.page,desc:$finedogrid.getdescitems(),asc:$finedogrid.getascitems()});
    			}else if(finedo.fn.isfunction(options.orderchange)){
    				var fun = eval(options.orderchange);
    				fun({pageindex:pages.page,desc:$finedogrid.getdescitems(),asc:$finedogrid.getascitems()});
    			}else{
	        		if(finedo.fn.istrue(this.data("options").servorder)){
	        			$finedogrid.load();
	        		}else{
	        			$finedogrid.sort("desc", code);
	        		}
    			}
        	}
        };
        
        /**
         * order: asc顺序， desc降序
         * code:排序字段
         */
        this.sort = function(ud, code){
        	var sortdata = $finedogrid.getdata().sort(function(a, b) {
        		var aval = finedo.fn.getvalue(a, code), bval = finedo.fn.getvalue(b, code);
        		var ret = 0;
        		if(!isNaN(aval) && !isNaN(bval)){
        			if(parseFloat(aval) > parseFloat(bval))
        				ret = ud == "desc" ? -1 : 1;
        			else if(parseFloat(aval) < parseFloat(bval))
        				ret = ud == "desc" ? 1 : -1;
        			else
        				ret = 0;
        		}else{
        			if(ud == "asc")
        				ret = aval.localeCompare(bval);
        			else
        				ret = bval.localeCompare(aval);
        		}
        		return ret;
        	});
        	$finedogrid.removeData("rowindex");
        	$finedogrid.data("datarows", sortdata);
        	$finedogrid.gridbodyshow(sortdata);
        };
        
        /**
         * 列编辑功能
         */
        this.tdEdit = this.tdedit = function(event){
        	event.stopPropagation();
        	var curtd = $(this);
        	var tdTextValue = $.trim(curtd.text());
        	inputChange = function(newvalue){
            	//将输入框的文本保存
                //将td的内容，即输入框去掉,然后给td赋值
                event.data.data[event.data.column["code"]] = newvalue;
                if(event.data.column["formatter"] != undefined){
					var fun = eval(event.data.column["formatter"]);
					curtd.html(fun(newvalue, event.data.data));
				} else{
					curtd.html(newvalue);
				}
                //让td重新拥有点击事件
                curtd.click(event.data, $finedogrid.tdedit);
                if(newvalue == tdTextValue)
                	return;
                updateInput();
            };
            recoveryInput = function(newvalue){
            	event.data.data[event.data.column["code"]] = newvalue;
        		if(event.data.column["formatter"] != undefined){
					var fun = eval(event.data.column["formatter"]);
					curtd.html(fun(newvalue, event.data.data));
				} else{
					curtd.html(newvalue);
				}
            };
            updateInput = function(){
            	var options = $finedogrid.data("options");
            	if(options.updateurl == undefined || options.updateurl == ''){
            		recoveryInput();
            		finedo.message.error("未配置更新请求Action!");
            		return;
            	}
            	finedo.message.question("是否更新此条记录", null, function(isupdate){
            		if(!isupdate){
            			recoveryInput(tdTextValue);
            			return;
            		}
                	finedo.message.showwaiting();
                	$.post(options.updateurl,event.data.data,function(retjson){
        	        	finedo.message.hidewaiting();
        	        	if(retjson.fail){
        	        		finedo.message.error(retjson.resultdesc);
        	        		recoveryInput(tdTextValue);
        	        	}
        			},'json');
            	});
            };
            //内容长度超过10，则弹出textarea来编辑
        	if(tdTextValue.length > 10){
        		finedo.dialog.show({
            		'loadtype':'text',
            		'text':'<textarea name="finedogridtdta" id="finedogridtdta" style="width:595px;height:325px;">'+tdTextValue+'</textarea>',
            		callback:function(){
            			inputChange($.trim($("#finedogridtdta").val()));
            		}
            	});
        		return;
        	}
        	//将td的内容清空
        	curtd.empty();
            //新建一个输入框
            var input = $("<input>");
            input.width(curtd.width()-10);
            //将保存的文本内容赋值给输入框
            input.attr("value",tdTextValue);
            //将输入框添加到td中
            curtd.append(input);
            //给输入框注册事件，当失去焦点时就可以将文本保存起来
            input.blur(function(){
            	inputChange(input.val());
            });
            input.keyup(function(event){
            	//1.获取当前用户按下的键值
                //解决不同浏览器获得事件对象的差异,
                // IE用自动提供window.event，而其他浏览器必须显示的提供，即在方法参数中加上event
                var myEvent = event || window.event;
                var keyCode = myEvent.keyCode;
                //2.判断是否是ESC键按下
                if(keyCode == 27){
                	//将input输入框的值还原成修改之前的值
                	input.val(tdTextValue);
                } else if(keyCode == 13){
                	inputChange(input.val());
                }
            });
            //将输入框中的文本高亮选中
            //将jquery对象转化为DOM对象
            var inputDom = input.get(0);
            inputDom.select();
            //将td的点击事件移除
            curtd.unbind("click");
        };
        
        /**
         * 以子表方式展开
         */
        this.rowExpand = this.rowexpand = function(rowid, callback, reload){
        	var rowindex = rowid.substring(rowid.lastIndexOf('-')+1);
        	var rowItem = $("#"+rowid);
    		var nextRowItem = rowItem.next("tr");
        	if($(nextRowItem).attr("expandtr") == "true"){
        		$(nextRowItem).toggle();
        		
        		if($(nextRowItem).is(':hidden')){
        			if(reload)
            			$(nextRowItem).remove();
        		}
        		return;
        	}
        	var options = $finedogrid.data("options");
    		var cols = $finedogrid.data("columns").length;
        	if(finedo.fn.istrue(options.rownumbers))
        		cols += 1;
        	if(finedo.fn.isfunction(options.expand))
        		cols += 1;
        	if(options.selecttype == "single" || options.selecttype == "multi")
        		cols += 1;
        	var expandHtml = '<tr expandtr="true"><td colspan="'+cols+'"><div>'+callback($finedogrid.data("datarows")[rowindex])+'</div></td></tr>';
        	rowItem.after(expandHtml);
        };
        
        /**
         * 获取表格列属性，如果有全选列，则绑定全选事件，如果有排序按钮，则绑定排序事件
         */
        this.gridHead = this.gridhead = function(){
			var options = $finedogrid.data("options");
        	var columns = [];//字段数组
        	$(this).find("thead tr").each(function(trindex,tritem){
        		$(tritem).find("th").each(function(tdindex,tditem){
        			var column = {};
        			var isorder = false;
                    $.each($(this)[0].attributes, function(index, attr) {
						column[attr.name] = attr.value;
						if(attr.name == "order" && finedo.fn.istrue(attr.value)){
							isorder = true;
						}
					});
					columns.push(column);
					if(isorder){
						var $orderbutton = $('<input type="button" class="finedo-asc" title="点击排序">');
						$(tditem).append("&nbsp;");
						$(tditem).append($orderbutton);
						$($orderbutton).bind("click", {"code":column.code}, function(event){
							$finedogrid.gridsort(this, event.data.code);
						});
					}
                });
        	});
        	return columns;
        };
        
        //表格展示
        this.gridShow = this.gridshow = function(tabledata){
    		var options = $finedogrid.data("options");
    		pages = $finedogrid.pageoption();
    		var datarows;
    		//一次加载所有数据后再分页处理，在前台对数据进行解析
    		if(finedo.fn.istrue(options.oncerequest)){
    			var alldatarows;
    			if(finedo.fn.isnotnon($finedogrid.data("alldatarows"))){
    				alldatarows = $finedogrid.data("alldatarows");
    			}else{
    				alldatarows = tabledata;
    				$finedogrid.data("alldatarows", tabledata);
    			}
    			if(finedo.fn.istrue(options.pagination)){
        			datarows = [];
        			if(alldatarows.rows.length <= pages.rows){
        				datarows = alldatarows.rows;
        			}else{
	        			var startRowIndex = parseInt(pages.rows)*(parseInt(pages.page)-1);
	        			var endRowIndex = parseInt(pages.rows)*parseInt(pages.page);
	        			for(var index = startRowIndex; index < alldatarows.total && index < endRowIndex; index++){
	        				datarows.push(alldatarows.rows[index]);
	        			}
        			}
    			}else{
    				datarows = alldatarows.rows;
    			}
    		}else{
    			datarows = finedo.fn.isnon(tabledata.rows) ? tabledata : tabledata.rows;
    		}
    		$finedogrid.data("datarows", datarows);
    		if(finedo.fn.istrue(options.pagination)){
    			pages.total = tabledata.total ? tabledata.total : pages.total;
    			pages.totalpage = Math.ceil(parseInt(pages.total) / parseInt(pages.rows));
    			$("#"+this.attr("id")+"total").html(pages.total);
    			$("#"+this.attr("id")+"totalpages").html(pages.totalpage);
    			$("#"+this.attr("id")+"jumppageval").val(pages.page);
    			$("#"+this.attr("id")+"curtotalpage").html(pages.page+"/"+pages.totalpage+"&nbsp;");
    		}
    		this.gridbodyshow(datarows);
        };
        
        /**
         * 是否继续显示，判断内容高度与可视范围高度
         */
        this.showrows = function(rowheight){
        	var offset = $($finedogrid).offset();
        	//var gridheight = offset.top + $($finedogrid).height();
        	var viewheight =$(window).height();//可见高度
			//var scrolltop =$(document).scrollTop();//滚动高度
			//if(gridheight - viewheight - scrolltop >= showheight)
			//	return false;
			//return true;
			var showheight = viewheight - offset.top;
			return showheight<0 ? 2 : showheight/rowheight;
        };
        
        this.rowclick = function(tritem){
        	if(clickedtritem){
        		$(clickedtritem).css("background", "");
        	}
        	var tagName = tritem.get(0).tagName.toUpperCase();
        	while(tritem && tagName != "TR"){
        		tritem = $(tritem).parent();
        		tagName = tritem.get(0).tagName.toUpperCase();
        	}
        	clickedtritem = tritem;
        	$(clickedtritem).css("background", "#dcdcdc");
        };
        
        /**
         * 注册window滚动事件
         */
        this.registerscroll = function(){
        	$(window).bind('scroll',$finedogrid.loadmore);
        };
        
        /**
         * 注销window滚动事件
         */
        this.unregisterscroll = function(){
        	$(window).unbind('scroll',$finedogrid.loadmore);
        };
        
        /**
         * 加载更多
         */
        this.loadmore = function(){
        	if($finedogrid.data("isloadmore"))
        		return;
        	var offset = $($finedogrid).offset();
        	var gridheight = offset.top + $($finedogrid).height();
        	
        	var viewheight =$(window).height();//可见高度
			var scrolltop =$(document).scrollTop();//滚动高度
			if(gridheight - viewheight - scrolltop <= 5){
	        	$finedogrid.data("isloadmore", true);
				$finedogrid.gridbodyshow($finedogrid.getdata());
			}else{
				$finedogrid.removeData("isloadmore");
			}
        };
        
        this.gridBodyShow = this.gridbodyshow = function(datarows){
    		var options = $finedogrid.data("options");
    		var columns = $finedogrid.data("columns");
    		pages = $finedogrid.pageoption();
    		var tbody;
    		this.find('tbody').each(function(index, tbodyitem){
    			tbody = $(tbodyitem);
    		});
    		var rowindex = 0;
    		var showcount = 0;
    		var showindex = 0;
    		var datalength = datarows.length;
    		var recrowindex = $finedogrid.data("rowindex");
    		if(finedo.fn.isnotnon(recrowindex)){
    			rowindex = recrowindex;
    		}else{
    			tbody.html('');
    		}
        	for(; rowindex < datalength; rowindex++){
    			var tr = $('<tr>');
    			var trid = this.attr("id")+"-tbody-tr-"+rowindex;
    			tr.attr("id", trid);
    			//行的双击事件
    			if($.isFunction(options.ondbclick)){
    				tr.dblclick(datarows[rowindex], function(event){
    					options.ondbclick(event.data);
    					event.stopPropagation();
    				});
				}else if(finedo.fn.isfunction(options.ondbclick)){
					tr.dblclick(datarows[rowindex], function(event){
						var fun = eval(options.ondbclick);
						fun(event.data);
						event.stopPropagation();
    				});
				}
    			if($.isFunction(options.onclick)){
    				tr.click(datarows[rowindex], function(event){
    					options.onclick(event.data);
    					$finedogrid.rowclick($(event.target).parent());
    					event.stopPropagation();
                        tr.find("input[name='"+$finedogrid.attr("id")+"radiobox']").each(function(itemindex, item){
                            $(item).trigger("click");
                        });
                        tr.find("input[name='"+$finedogrid.attr("id")+"checkbox']").each(function(itemindex, item){
                            $(item).trigger("click");
                        });
    				});
				}else if(finedo.fn.isfunction(options.onclick)){
					tr.click(datarows[rowindex], function(event){
						var fun = eval(options.onclick);
						fun(event.data);
						$finedogrid.rowclick($(event.target).parent());
						event.stopPropagation();
	                    tr.find("input[name='"+$finedogrid.attr("id")+"radiobox']").each(function(itemindex, item){
	                        $(item).trigger("click");
	                    });
	                    tr.find("input[name='"+$finedogrid.attr("id")+"checkbox']").each(function(itemindex, item){
	                        $(item).trigger("click");
	                    });
    				});
				}else{
					tr.click(datarows[rowindex], function(event){
    					$finedogrid.rowclick($(event.target).parent());
    					event.stopPropagation();
                        tr.find("input[name='"+$finedogrid.attr("id")+"radiobox']").each(function(itemindex, item){
                            $(item).trigger("click");
                        });
                        tr.find("input[name='"+$finedogrid.attr("id")+"checkbox']").each(function(itemindex, item){
                            $(item).trigger("click");
                        });
    				});
				}
    			if(rowindex % 2 == 1){
    				tr.addClass("finedo-colortr");
    			}

    			//显示序列
				if(finedo.fn.istrue(options.rownumbers)){
					var $rownumbertd = $('<td>');
					$rownumbertd.attr("align", "center");
					if(finedo.fn.istrue(options.pagination)){
						$rownumbertd.html((parseInt(pages.page)-1)*parseInt(pages.rows) + parseInt(rowindex)+1);
					}else {
						$rownumbertd.html(parseInt(rowindex)+1);
					}
					tr.append($rownumbertd);
				}
				//显示单选与多选框
				if(options.selecttype == "single"){
					var $selecttypetd = $('<td align="center"></td>');
					var $radioboxitem = $('<input type="radio" id="'+$finedogrid.attr("id")+'radiobox" name="'+$finedogrid.attr("id")+'radiobox">');
					$selecttypetd.append($radioboxitem);
					tr.append($selecttypetd);
					
					if($finedogrid.isselected(datarows[rowindex])){
						$($radioboxitem).attr('checked', true);
					}
					$radioboxitem.data('data',datarows[rowindex]);
					$radioboxitem.bind('change',function(event, tr){
						if(this.checked){
							$finedogrid.getallselecteditems().splice(0, $finedogrid.getallselecteditems().length);
    						$finedogrid.rowselected(this);
						}
					});
					$radioboxitem.click(function(event){
						event.stopPropagation();
					});
					$(tr).click($radioboxitem, function(event){
						event.data.trigger("click");
    				});
				}else if(options.selecttype == "multi"){
					var $selecttypetd = $('<td align="center"></td>');
					var $checkboxitem = $('<input type="checkbox" name="'+$finedogrid.attr("id")+'checkbox">');
					$checkboxitem.show();
					$selecttypetd.append($checkboxitem);
					tr.append($selecttypetd);
					
					if($finedogrid.isselected(datarows[rowindex])){
						$($checkboxitem).attr('checked', true);
					}
					$checkboxitem.data('data',datarows[rowindex]);
					$checkboxitem.bind('change',function(event, tr){
						$finedogrid.rowselected(this);
					});
					$checkboxitem.click(function(event){
						event.stopPropagation();
					});
					$(tr).click($checkboxitem, function(event){
						event.data.trigger("click");
    				});
				}

    			for(var colindex = 0; colindex < columns.length; colindex++){
    				var td = $('<td>');
    				td.attr("align", options.align);
    				for(var colattr in columns[colindex]) {
    					try{
	    					var colattrtype = typeof(columns[colindex][colattr]);
	    					if(colattrtype == "number" || colattrtype == "string" || colattrtype == "boolean")
	    						td.attr(colattr, columns[colindex][colattr]);
    					}catch(e){}
    				}
    				//列编辑
    				if(finedo.fn.istrue(columns[colindex]["edit"])){
    					td.click({"column":columns[colindex], "data":datarows[rowindex]}, $finedogrid.tdedit);
    				}
    				if(columns[colindex]["className"]){
    					td.addClass(columns[colindex]["className"]);
    				}
    				
					if($.isFunction(columns[colindex]["formatter"])){
						td.html(columns[colindex]["formatter"](datarows[rowindex]));
					}else if(finedo.fn.isfunction(columns[colindex]["formatter"])){
						var fun = eval(columns[colindex]["formatter"]);
						td.html(fun(datarows[rowindex]));
					} else{
						td.html(finedo.fn.getvalue(datarows[rowindex], columns[colindex]["code"]));
					}
					if(finedo.fn.istrue(columns[colindex].canhide)){
						td.addClass("finedo-datagrid-canhide");
					}
    				tr.append(td);
    			}
    			//增加扩展列
            	if(finedo.fn.isfunction(options.expand)){
            		var expandtd = $('<td align="center" width="20">');
            		var expandbtn = $('<input type=\"button\" class=\"finedo-expand\" title=\"点击展示\"/>');
            		expandbtn.bind('click', {rowid:trid,callback:eval(options.expand)}, function(event){
            			$finedogrid.rowexpand(event.data.rowid, event.data.callback);
            		});
            		expandtd.append(expandbtn);
            		tr.append(expandtd);
            	}
    			tbody.append(tr);
    			//判断是否需要继续加载
    			if(finedo.fn.istrue(options.scrollload)){
	    			showindex++;
					$finedogrid.data("rowindex", rowindex);
	    			if(rowindex < datalength -1){
	    				if(finedo.fn.isnon(recrowindex)){
	    					$finedogrid.registerscroll();
		    				if(showcount == 0){
		    					showcount = $finedogrid.showrows($(tr).height());
		    				}
	    				}else{
	    					showcount = 10;
	    				}
	    				if(showindex >= showcount-1){
	    					$finedogrid.removeData("isloadmore");
	    					rowindex++;
	        				$finedogrid.data("rowindex", rowindex);
	    					break;
	    				}
	    			}else{
	    				$finedogrid.unregisterscroll();
	    			}
    			}
    		}
        };
        
        /**
         * 发起查询请求
         */
        this.query = function(param){
        	var options = $finedogrid.data("options");
        	
        	$finedogrid.pageoption({page:1, rows:$finedogrid.pageoption().rows, total:0, totalpage:1});
			$finedogrid.removeData("alldatarows");
			$finedogrid.data("allselecteditems", []);
			$finedogrid.unregisterscroll();
			if(finedo.fn.isnotnon(options.poncerequest)){
				$finedogrid.setoption("oncerequest", options.poncerequest);
			}
        	if(!finedo.fn.isnon(param)){
        		// 缓存查询条件
        		options.queryparams=param;
			}
        	$finedogrid.execquery();
        };
        
        this.execquery = function(){
			$finedogrid.removeData("rowindex");
        	var options = $finedogrid.data("options");
        	//如果为一次加载所有数据，则判断数据是否已加载，已加载则直接取缓存数据
			if($finedogrid.data("alldatarows")){
				$finedogrid.gridshow($finedogrid.data("alldatarows"));
				return;
			}
			
			pages = $finedogrid.pageoption();
			var loadurl = options.url;
			if(finedo.fn.isnon(loadurl)){
				finedo.message.error("未配置表格数据加载url");
				return;
			}
			//如果有排序字段，将以asc与desc为键将值请求到服务端
			var querydata = $.extend(true, {}, options.queryparams);
			if($finedogrid.getascitems().length > 0){
			    querydata.asc = $finedogrid.getascitems().join();
			}
            if($finedogrid.getdescitems().length > 0){
                querydata.desc = $finedogrid.getdescitems().join();
            }
            
            var reqjson = finedo.version >= 3.0 ? true : false;
            var requestdata;
            if(finedo.fn.istrue(options.pagination)){
                if(finedo.fn.isnon(options.querydomainkey)){
                    requestdata = $.extend(true, {page:pages.page, rows:(finedo.fn.istrue(options.oncerequest) ? 100000000 : pages.rows)}, querydata);
                }else{
                    requestdata = {};
                    requestdata[options.querydomainkey] = querydata;
                    requestdata[options.pagedomainkey] = {pageindex:pages.page, rownumperpage:(finedo.fn.istrue(options.oncerequest) ? 100000000 : pages.rows)};
                    if($finedogrid.getascitems().length > 0){
                        requestdata.asc = $finedogrid.getascitems().join();
                    }
                    if($finedogrid.getdescitems().length > 0){
                        requestdata.desc = $finedogrid.getdescitems().join();
                    }
                }
            }else{
                requestdata = querydata;
            }
            
	        finedo.action.ajax({
	            url:options.url,
	            data:requestdata,
	            reqjson:reqjson,
	            callback:function(retdata){
	                if($.isFunction(options.callback)){
                        options.callback(retdata);
                    }else if(finedo.fn.isfunction(options.callback)){
                        var fun = eval(options.callback);
                        fun(retdata);
                    }
	                
	                if(finedo.fn.isobject(retdata) && retdata.fail){
	                    finedo.message.error(retdata.resultdesc);
                        return;
	                }
                    if(finedo.fn.isobject(retdata) && retdata.object && finedo.fn.isarray(retdata.object)){
                        //适配返回结果为ReturnValueDomain<List>情况
                        $finedogrid.gridshow(retdata.object);
                    }else if(finedo.fn.isobject(retdata) && retdata.object && retdata.object.datalist && finedo.fn.isarray(retdata.object.datalist)){
                        //适配返回结果为ReturnValueDomain<PageDomain>情况
                        pages.total = retdata.object.rowcount;
                        $finedogrid.gridshow(retdata.object.datalist);
                    }else{
                        $finedogrid.gridshow(retdata);
                    }
	            }
	        });
        };
        
        /**
         * 表格加载，传递值则按传递对象初始化表格，否则调用服务查询数据
         */
		this.load = function(tabledata){
			//加载时重置变量
			var options = $finedogrid.data("options");
			//$finedogrid.pageoption({page:1, rows:$finedogrid.pageoption().rows, total:0, totalpage:1});
			var loadrequest = false;
			if(tabledata instanceof Array || (tabledata instanceof Object && tabledata.rows)){
				$finedogrid.removeData("alldatarows");
			}else{
				tabledata = $finedogrid.data("alldatarows");
				loadrequest = true;
			}
			$finedogrid.data("allselecteditems", []);
			if(finedo.fn.isnotnon(options.poncerequest)){
				$finedogrid.setoption("oncerequest", options.poncerequest);
			}
			//如果参数为空，则请求服务查询
			if(loadrequest){
				$finedogrid.execquery();
				return;
			}
			//判断tabledata对象可有total属性，如果有，直接取总数；
			//没有则为数组，实现本地分页
			var alldatarows;
			if(finedo.fn.isnon(tabledata.total)){
				alldatarows = {"total":tabledata.length,"rows":tabledata};
			}else{
				alldatarows = tabledata;
			}
			$finedogrid.setoption("poncerequest", options.oncerequest);
			$finedogrid.setoption("oncerequest", true);
			$finedogrid.gridshow(alldatarows);
		};
		
		/**
		 * 初始化分页
		 * 参数pageoption结构：{
		 *  columnsize:10,
		 * 	pagesize:10,
		 * 	pagelist:[10, 20, 50, 100]
		 * }
		 */
		this.initPagination = this.initpagination = function(pageoption){
			var $tableid = $finedogrid.attr("id");
			var pagestr = '<div class="finedo-page">' +
			'<div class="finedo-num">' +
			'<label class="finedo-page-canhide"><input class="finedo-btn-num" type="button" id="'+$tableid+'firstpagebtn" value="首页"/></label>' +
			'<label><input class="finedo-btn-num" type="button" id="'+$tableid+'prepagebtn" value="<<" title="上一页"/></label>' +
			'<label><input class="finedo-btn-num" type="button" id="'+$tableid+'nextpagebtn" value=">>" title="下一页"/></label>' +
			'<label class="finedo-page-canhide"><input class="finedo-btn-num" type="button" id="'+$tableid+'lastpagebtn" value="末页"/></label>' +
			'<label class="finedo-page-canhide">跳转到<input class="finedo-text-num" type="text" id="'+$tableid+'jumppageval"/>页/<span class="finedo-color" id="'+$tableid+'totalpages">1</span>页&nbsp;</label>' +
			'<label class="finedo-page-canhide"><input class="finedo-btn-num" type="button" value="GO" id="'+$tableid+'jumppagebtn" title="跳转到指定页"/></label>' +
			'<label><span class="finedo-color" id="'+$tableid+'curtotalpage"></span>共<span class="finedo-color" id="'+$tableid+'total">0</span>条</label></div>' +
			'<div class="finedo-show finedo-page-canhide">' +
			'<select class="finedo-showsel" id="'+$tableid+'pagesel">';
			for(var pageindex = 0; pageindex < pageoption.pagelist.length; pageindex++){
				pagestr += '<option '+(pageoption.pagesize == pageoption.pagelist[pageindex] ? 'selected' : '')+'>'+pageoption.pagelist[pageindex]+'</option>';
			}
			pagestr += '</select></div></div>';
			var tfoot = $('<tfoot><tr><td colspan="'+pageoption.columnsize+'">'+pagestr+'</td></tr></tfoot>');
			$finedogrid.append(tfoot);
			$("#"+$tableid+"firstpagebtn").bind("click",function(){
				$finedogrid.firstpage();
			});
			$("#"+$tableid+"prepagebtn").bind("click",function(){
				$finedogrid.prepage();
			});
			$("#"+$tableid+"nextpagebtn").bind("click",function(){
				$finedogrid.nextpage();
			});
			$("#"+$tableid+"lastpagebtn").bind("click",function(){
				$finedogrid.lastpage();
			});
			$("#"+$tableid+"pagesel").bind("change",function(){
				pages.rows = $(this).val();
				$finedogrid.refresh();
			});
			$("#"+$tableid+"jumppagebtn").bind("click",function(){
				var jumpval = $.trim($("#"+$finedogrid.attr("id")+"jumppageval").val());
				var regu = "^[1-9]{1}[0-9]*$";
				var re = new RegExp(regu);
				if (jumpval.search(re) == -1) {
					finedo.message.warning("请输入正整数！");
					return;
				}
				$finedogrid.junmpage(jumpval);
			});
		};
		
		/**
		 * 初始化表格标题栏
		 */
		this.initHead = this.inithead = function(columns){
			var options = $finedogrid.data("options");
			var $tableheadtr = $('<tr>');
			for(var headindex = 0; headindex < columns.length; headindex++){
				var $tditem = $('<th>');
				$tditem.attr("align", options.align);
				for(var colattr in columns[headindex]) {
					var colattrtype = typeof(columns[headindex][colattr]);
					if(colattrtype == "number" || colattrtype == "string" || colattrtype == "boolean")
						$tditem.attr(colattr, columns[headindex][colattr]);
				}
				$tditem.append(columns[headindex].title);
				if(finedo.fn.istrue(columns[headindex].order)){
					var $orderbutton = $('<input type="button" class="finedo-asc" title="点击排序">');
					$tditem.append("&nbsp;");
					$tditem.append($orderbutton);
					$($orderbutton).bind("click", {"code":columns[headindex].code}, function(event){
						$finedogrid.gridsort(this, event.data.code);
					});
				}
				if(finedo.fn.istrue(columns[headindex].canhide)){
					$tditem.addClass("finedo-datagrid-canhide");
				}
				$tableheadtr.append($tditem);
			}
			var $tablehead = $('<thead>');
			$tablehead.append($tableheadtr);
			$finedogrid.append($tablehead);
		};
		
		/**
		 * 初始化
		 */
		this.init = function(){
			if($finedogrid.data('init') == true)
        		return $finedogrid;
			/*$(window).resize(function(){
				$finedogrid.loadmore();
			});*/
			$finedogrid.data('init', true);
			$finedogrid.data("allselecteditems", []);
			$finedogrid.data("ascitems", []);
			$finedogrid.data("descitems", []);
        	var defaults = {
                pagination : true,	//是否分页，默认不传为分页
                pagesize : 10, 		//默认一页显示数量
                pagelist: [10, 20, 50, 100], //分页数量
                rownumbers : true,	//显示序号
                classname : "finedo-datagrid",	//默认表格样式名称
                selecttype : "none", //选择类型，分为none/single/multi，即空/单选/多选
                align : "center", //数据默认显示的位置为居中
                scrollload: false
            };
        	
    		//获取表格中设置的属性
        	var tableattr = {};
    		$.each($finedogrid[0].attributes, function(index, attr) {
    			tableattr[attr.name] = attr.value;
    		});
            //判断表格是否设置有样式，没有则设置默认样式
            if(finedo.fn.isnon(tableattr["class"])){
            	$finedogrid.addClass(defaults.classname);
            }
    		
            defaults = $.extend(defaults, tableattr);
        	var options = $.extend(defaults, $finedogrid.data("options"));
        	var temppagelist = options.pagelist;
        	var pagesizeexists = false;
        	for(var i = 0; i < temppagelist.length; i++){
        		if(options.pagesize == temppagelist[i]){
        			pagesizeexists = true;
        			break;
        		}
        	}
        	if(!pagesizeexists){
        		for(var i = 0; i < temppagelist.length; i++){
        			if(options.pagesize < temppagelist[i]){
        				temppagelist.splice(i, 0, options.pagesize);
        				break;
        			}
        		}
        		options.pagelist = temppagelist;
        	}
            //保存对象的options
        	$finedogrid.data("options", options);
            //根据标题头获取各列的属性
        	var columns;
        	if(finedo.fn.isnon(options.columns)){
                columns = $finedogrid.gridhead();
                $finedogrid.data("columns", columns);
        	}else{
        		columns = options.columns;
        		$finedogrid.data("columns", columns);
        		$finedogrid.inithead(options.columns);
        	}
            //判断是否显示序号，显示则表头增加一列
        	var $rownumbertditem;
            if(finedo.fn.istrue(options.rownumbers)){
	            $($finedogrid).find("thead tr").each(function(trindex,tritem){
	            	$rownumbertditem = $('<th width="30" align="center"></th>');
	            	$(tritem).prepend($rownumbertditem);
	            });
            }
            //单选多选标题头增加一列
            if(options.selecttype == "single"){
            	var $selecttditem = $('<th width="30" align="center"></th>');
            	if(finedo.fn.isnon($rownumbertditem)){
            		$($finedogrid).find("thead tr").each(function(trindex,tritem){
    	            	$(tritem).prepend($selecttditem);
    	            });
            	}else{
            		$rownumbertditem.after($selecttditem);
            	}
            }else if(options.selecttype == "multi"){
            	var $selecttditem = $('<th width="30" align="center"></th>');
            	var $checkboxinput = $('<input type="checkbox">');
            	$checkboxinput.show();
            	$selecttditem.append($checkboxinput);
				$($checkboxinput).bind("click", function(event){
					$finedogrid.selectall(this.checked);
				});
            	if(finedo.fn.isnon($rownumbertditem)){
            		$($finedogrid).find("thead tr").each(function(trindex,tritem){
    	            	$(tritem).prepend($selecttditem);
    	            });
            	}else{
            		$rownumbertditem.after($selecttditem);
            	}
            }
            //扩展信息标题头追加一列
            if(finedo.fn.isfunction(options.expand)){
	            $($finedogrid).find("thead tr").each(function(trindex,tritem){
	            	$(tritem).append('<th width="20" align="center"></th>');
	            });
            }
            pages = {page:1, rows:options.pagesize, total:0, totalpage:1};
            $finedogrid.pageoption(pages);
            
            //初始化tbody
            $finedogrid.append("<tbody></tbody");
            //判断是否分页
            if(finedo.fn.istrue(options.pagination)){
            	var cols = columns.length;
            	if(finedo.fn.istrue(options.rownumbers))
            		cols += 1;
            	if(finedo.fn.isfunction(options.expand))
            		cols += 1;
            	if(options.selecttype == "single" || options.selecttype == "multi")
            		cols += 1;
            	$finedogrid.initpagination({
            		"columnsize":cols,
           		 	"pagesize":options.pagesize,
           		 	"pagelist":options.pagelist
            	});
            }
            return $finedogrid;
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
finedo.getGrid = finedo.getgrid = function(controlid, options){
	if(finedo.controls[controlid] && typeof(options) == "undefined") {
		return finedo.controls[controlid];
	}
	finedo.controls[controlid]=$('#'+controlid).grid(options);
	return finedo.controls[controlid];
};

/**
 * 删除记录的公用方法
 * datagrid:指定被删除的数据列表对象
 * action:指定删除数据的处理方法
 * itemid:记录的编号
 * callback:执行完成后的回调函数
 */
finedo.action.doDelete = function(datagrid,action,itemid,callback){
	if(itemid==""){
		finedo.message.info("请选择要删除的记录！");
		return;
	}
	message = "您确定删除该记录吗？";
	
	finedo.message.question(message, null, function(which){  
        if (which){ 
        	finedo.message.showWaiting();
        	$.getJSON(action+'?id='+itemid, function(ret){
        		finedo.message.hideWaiting();
        		if(ret.success){
        			finedo.message.info(ret.resultdesc);
	        		$("#"+datagrid).grid().refresh();
					if($.isFunction(callback)){
						callback();
					}
        		}else
        			finedo.message.error(ret.resultdesc);
            });
        }  
    });  
};
