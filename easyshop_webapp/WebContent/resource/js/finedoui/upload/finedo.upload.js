/**
 * 定义文件查询、上传、删除、单个下载、批量下载对应的url
 */
//文件查询url
var file_queryurl = "/finedo/file/query";
//文件上传url
var file_uploadurl = "/finedo/file/upload";
//文件删除url
var file_deleteurl = "/finedo/file/delete";
//单个文件下载url
var file_downloadurl = "/finedo/file/download";
//文件缩略图url
var file_downloadthumbnailurl = "/finedo/file/downloadthumbnail";
//多个文件下载url
var file_downloadmultiurl = "/finedo/file/downloadmulti";


;(function($, undefined) {
	/**
	 * 上传控件
	 * options:{
	 * 	valueid: 设置赋值的id，在控件下传与删除控件时，将文件的fileid值更新此id对应的value
	 * 	reqparams: 请求参数，Json格式(文件上传时的附带参数)
	 * 	files: 文件ID串，多个以逗号分开
	 * 	showicon: true/false,默认为true，是否显示图标
	 * 	showname: true/false,默认为true，是否显示原始名称
	 * 	showsize: true/false,默认为true，是否显示文件大小
	 * 	onclick: 点击文件的回调函数
	 * 	onuploadcomplete: 上传成功后回调函数
	 * 	filter: 上传文件类型限制，不传不限制，如:doc,xls,xlsx,docx,txt,png,jpg
	 * 	multiupload: true/false,默认为true，是否支持多文件
	 * 	multidown: true/false，是否支持批量下载，默认为false不支持批量下载
	 * 	editable: true/false，是否可编辑，默认为true，不支持只提供下载预览功能，可编辑增加上传与删除功能
	 * 	deletecallback: 删除回调函数
	 * 	entityid: 关联id
	 * 	oninitcomplete: 控件初始化完成回调
	 * 	maxfilesize:限制上传文件大小(单位：K、M、G），不带单位默认为字节。如500K、10M，不设置则不限制上传文件大小
	 * 	standard：none/size/scale，是否限制文件规格（尺寸、比例），默认为none，不做限制，非图片设置size或scale也不生效
	 * 	fwidth:规格为size或scale时，设置为宽度的大小或是比例值
	 * 	fheight:规格为size或scale时，设置为高度的大小或是比例值
	 * 	queryurl : 查询文件清单url
	 * 	uploadurl ：上传文件url
	 * 	deleteurl ：删除文件url
	 * 	downloadurl ：下载文件url
	 * 	downloadmultiurl ：文件批量下载url
	 * 	maxfilenum:最大上传文件数量
	 *  thumbnail:是否生成缩略图,true/false，默认为true,即默认生成缩略图
	 * }
	 */
	$.fn.file = function(options){
		var $finedofile = this;
		
		if(finedo.fn.isnotnon(options)){
			if(finedo.fn.isnon($finedofile.data("options")))
				$finedofile.data("options", options);
			else
				$finedofile.data("options", $.extend($finedofile.data("options"),options));
		};

		this.setOption = this.setoption = function(key, value){
			$finedofile.data('options')[key] = value;
		};
		
		this.getOption = this.getoption = function(key){
			return $finedofile.data('options')[key];
		};
		
		/**
		 * 文件上传action
		 */
		this.setUploadUrl = this.setuploadurl = function(uploadurl){
			$finedofile.setoption("uploadurl", uploadurl);
		};

		/**
		 * 文件查询action
		 */
		this.setQueryUrl = this.setqueryurl = function(queryurl){
			$finedofile.setoption("queryurl", queryurl);
		};

		/**
		 * 单个文件下载action
		 */
		this.setDownloadUrl = this.setdownloadurl = function(downloadurl){
			$finedofile.setoption("downloadurl", downloadurl);
		};

		/**
		 * 批量文件下载action
		 */
		this.setDownloadmultiUrl = this.setdownloadmultiurl = function(downloadmultiurl){
			$finedofile.setoption("downloadmultiurl", downloadmultiurl);
		};

		/**
		 * 文件删除action
		 */
		this.setDeleteUrl = this.setdeleteurl = function(deleteurl){
			$finedofile.setoption("deleteurl", deleteurl);
		};

        /**
         * 文件缩略图action
         */
        this.setDownloadthumbnailUrl = this.setdownloadthumbnailurl = function(downloadthumbnailurl){
            $finedofile.setoption("downloadthumbnailurl", downloadthumbnailurl);
        };
        
        /**
         * 支持多文件操作
         */
		this.setMultiUpload = this.setmultiupload = function(multiupload){
			$finedofile.setoption("multiupload", multiupload);
        };
        
        /**
         * 设置文件点击事件
         */
        this.setOnclick = this.setonclick = function(onclick){
			$finedofile.setoption("onclick", onclick);
        };
        
        /**
         * 设置上传成功回调函数
         */
        this.setOnuploadcomplete = this.setonuploadcomplete = function(onuploadcomplete){
			$finedofile.setoption("onuploadcomplete", onuploadcomplete);
        };
        
        /**
         * 是否显示图标
         */
        this.showIcon = this.showicon = function(isshow){
			$finedofile.setoption("showicon", isshow);
        };

        /**
         * 是否显示原文件名称
         */
        this.showName = this.showname = function(isshow){
			$finedofile.setoption("showname", isshow);
        };

        /**
         * 是否显示文件大小
         */
        this.showSize = this.showsize = function(isshow){
			$finedofile.setoption("showsize", isshow);
        };
        
        /**
         * 设置上传文件格式
         */
        this.setFilter = this.setfilter = function(filter){
			$finedofile.setoption("filter", filter);
        };
        
        /**
         * 设置上传时的附带信息
         */
        this.setReqParams = this.setreqparams = function(reqparams){
			$finedofile.setoption("reqparams", reqparams);
        };

        /**
         * 设置控件标题
         */
        this.setTitle = this.settitle = function(title){
			$finedofile.setoption("title", title);
        };
        
        /**
         * 设置删除后的回调函数，返回删除文件清单
         */
        this.setDeletecallback = this.setdeletecallback = function(deletecallback){
			$finedofile.setoption("deletecallback", deletecallback);
        };
        
        /**
         * 设置是否支持可编辑
         */
        this.setEditable = this.seteditable = function(editable){
			$finedofile.setoption("editable", editable);
        	if(!finedo.fn.istrue(editable)){
        		$('#'+$finedofile.attr('id')+'uploadbtn').hide();
        	}
        	if(!finedo.fn.istrue($finedofile.getoption("editable")) || !finedo.fn.istrue($finedofile.getoption("multidown"))){
        		$('#'+$finedofile.attr('id')+'uploadnav').hide();
        	}
            $(".finedo-upload-op-del").hide();
        };
        
        /**
         * 设置关联id
         */
        this.setEntityid = this.setentityid = function(entityid){
			$finedofile.setoption("entityid", entityid);
        };
        
        /**
         * 设置控件初始化完成的回调函数
         */
        this.setOninitcomplete = this.setoninitcomplete = function(oninitcomplete){
			$finedofile.setoption("oninitcomplete", oninitcomplete);
        };
        
        /**
         * 设置控件的值，如果是input，则将上传控件中所有文件的ID（以逗号分开）设置为input的value
         * data值结构为[{"fileid":"FD111"},{"fileid":"FD222"}]
         */
        this.setValue = this.setvalue = function(){
        	var controltype = $finedofile.get(0).tagName.toUpperCase();
        	if(controltype != 'INPUT')
        		return;
        	var data = $finedofile.data('filelist');
        	var val = '';
        	for(var i = 0; i < data.length; i++){
        		if(i > 0)
        			val += ',';
        		val += data[i].fileid;
        	}
        	$finedofile.val(val);
        	$("#"+$finedofile.getoption("valueid")).val(val);
        };

        /**
         * 设置上传文件最大长度
         */
        this.setMaxfilesize = this.setmaxfilesize = function(maxfilesize){
        	$finedofile.setoption("maxfilesize", maxfilesize);
        };
        
        this.setStandard = this.setstandard = function(standard){
        	$finedofile.setoption("standard", standard);
        };
        
        this.setFwidth = this.setfwidth = function(fwidth){
        	$finedofile.setoption("fwidth", fwidth);
        };
        
        this.setFheight = this.setfheight = function(fheight){
        	$finedofile.setoption("fheight", fheight);
        };
        
        /**
         * 判断是在对象内部显示控件，还是在对象后面追加显示控件
         * 如果引用的对象为div则在对象内容显示控件，如果引用的是input则在控件后面追加显示控件
         */
        this.isInner = this.isinner = function(){
        	var controltype = $finedofile.get(0).tagName.toUpperCase();
        	if(controltype == 'INPUT')
        		return false;
        	return true;
        };
        
        /**
         * 执行上传操作
         */
        this.upload = function(){
        	if($finedofile.uploadcheck() == false) {
        		$finedofile.reset(true);
        		return;
        	}
        	var options = $finedofile.data('options');
        	url = options.uploadurl;
        	var uploadparams = $.extend({},options.reqparams);
        	uploadparams.entityid = options.entityid;
        	uploadparams.maxfilesize = options.maxfilesize;
        	uploadparams.standard = options.standard;
        	uploadparams.width = options.fwidth;
        	uploadparams.height = options.fheight;
        	uploadparams.filter = options.filter;
        	uploadparams.thumbnail = options.thumbnail;
        	if(url.indexOf('?') == -1)
    			url += '?' + $.param(uploadparams);
    		else
    			url += '&' + $.param(uploadparams);
        	
        	$('#'+$finedofile.attr('id')+'uploadprogressbar').show();

        	var uploadControl = $('#'+$finedofile.attr('id')+'uploadfrm').ajaxSubmit({
        		success: function(retdata){
        			
        			if(retdata.fail){
        				finedo.message.error(retdata.resultdesc);
        				$finedofile.reset(true);
        				return;
        			}
        			
        			//如果只能上传一个文件，上传成功后删除之前的文件
        			if(!finedo.fn.istrue(options.multiupload)){
        				if($finedofile.data('filelist').length > 0){
	        				var deldata =$finedofile.data('filelist').concat();
	        				$finedofile.deletefile(deldata, true);
        				}
        			}
        			
        			$finedofile.showfiles([retdata.object]);
        			if($.isFunction(options.onuploadcomplete)){
                		options.onuploadcomplete(retdata.object);
                	}else if(finedo.fn.isfunction(options.onuploadcomplete)){
                		var fun = eval(options.onuploadcomplete);
                		fun(retdata.object);
                	}
        			$finedofile.reset(true);
        		},
        		complete: function(context, xhr, e){
        			//content.status(0:中止上传;200:上传完成;404:上传Action不存在。。。
        			$finedofile.removeData('uploadControl');
        			$('#'+$finedofile.attr('id')+'uploadprogress').css('width', '0%');
        			$('#'+$finedofile.attr('id')+'uploadprogressnum').html('0%');
        			$('#'+$finedofile.attr('id')+'uploadprogressbar').hide();
        			var uploadfileitem = $('#'+$finedofile.attr('id')+'filename');
        			uploadfileitem.show();
        			var newuploadfileitem = uploadfileitem.clone();
        			newuploadfileitem.val('');
        			uploadfileitem.after(newuploadfileitem);
        			uploadfileitem.remove();
        			newuploadfileitem.bind('change', function(event){$finedofile.upload();});
        			if(context.status != '' && context.status != '0' && context.status != '200'){
        				finedo.message.error('文件上传异常，错误编码：'+context.status+"，错误描述："+context.statusText);
        			}
        			$finedofile.reset(true);
        		},
        		uploadProgress: function(event, position, total, percentComplete) {
        			$('#'+$finedofile.attr('id')+'uploadprogress').css('width', percentComplete+'%');
        			$('#'+$finedofile.attr('id')+'uploadprogressnum').html(percentComplete+'%');
        		},
        		url: url,
                type: 'post',
                dataType: 'json'
        	});
        	$finedofile.data('uploadControl', uploadControl);
        };
        
        /**
         * 文件上传验证，验证文件类型
         */
        this.uploadCheck = this.uploadcheck = function(){
            var fileobj = $('#'+$finedofile.attr('id')+'filename');
        	$("#"+$finedofile.attr('id')+"uploadfrm").append(fileobj);
        	$('#'+$finedofile.attr('id')+'filename').css({"opacity":"0", "filter":"alpha(opacity=0)"});
        	var filename = $('#'+$finedofile.attr('id')+'filename').val();
        	if(!filename || filename == ''){
        		finedo.message.warning('请选择要上传的文件！');
        		return false;
        	}
        	if(filename.length > 100){
        		finedo.message.warning('文件名称不能超过100个字符，请修改文件名再上传！');
        		return false;
        	}
        	var options = $finedofile.data('options');
        	if(finedo.fn.isnotnon(options.filter)){
	        	var fileExtIndex = filename.lastIndexOf('.');
	        	if(fileExtIndex == -1){
	        		finedo.message.warning('请选择正确格式的文件，如：'+options.filter);
	        		return false;
	        	}
	        	var fileExt = filename.substr(fileExtIndex);
	        	if(options.filter.indexOf(fileExt) == -1){
	        		finedo.message.warning('请选择正确格式的文件，如：'+options.filter);
	        		return false;
	        	}
        	}
        	if(finedo.fn.isnotnon(options.maxfilenum) && $finedofile.getfilelist().length >= options.maxfilenum){
        		finedo.message.warning('最多支持上传'+options.maxfilenum+"个文件");
        		return false;
        	}
        	return true;
        };
        
        /**
         * 中止上传
         */
        this.abortUpload = this.abortupload = function(){
        	if(!$finedofile.data('uploadControl') || !$finedofile.data('uploadControl').data('jqxhr'))
        		return;
        	$finedofile.data('uploadControl').data('jqxhr').abort();
        };
        
        /**
         * 是否支持预览
         */
        this.canPreview = this.canpreview = function(data){
        	//目前只支持图片预览
        	return finedo.fn.ispicture(data.filetype);
        };
        
        /**
         * 显示文件清单
         * data数据结构：[{"fileid":"FD00027","filesize":"0.13","optsn":"FD00730","downloadcount":"0","filepath":"D:\workspace\java64\upload\2015-06","filetype":".jpg","lastdownloadtime":"","createtime":"2014-12-06","filename":"上传文件.jpg","creator":"ADMIN","entityid":"FSDP_FILEUPLOAD","entityname":"文件上传","remark":""}]
         */
        this.showFiles = this.showfiles = function(data){
        	if(!data)
        		return;
        	var options = $finedofile.data('options');
        	for(var fileindex = 0; fileindex < data.length; fileindex++){
            	var fileitem = $('<div class="finedo-upload-fileitem">');
            	fileitem.attr('id', data[fileindex].fileid);
            	var filediv = $('<div class="finedo-upload-fileitem-name">');
            	var filenamediv = $('<div>');
            	
            	//显示图标
            	if(finedo.fn.istrue(options.showicon)){
            		filenamediv.addClass('finedo-upload-icon '+(data[fileindex].filetype.length > 0 ? data[fileindex].filetype.substr(1) : data[fileindex].filetype));
            	}else{
            		filenamediv.addClass('finedo-upload-noicon');
            	}
            	//显示原名
            	if(finedo.fn.istrue(options.showname)){
            		filenamediv.append(data[fileindex].filename);
            	}else{
            		filenamediv.append(data[fileindex].fileid+data[fileindex].filetype);
            	}
            	//显示大小
            	if(finedo.fn.istrue(options.showsize)){
            		filenamediv.append('('+data[fileindex].hfilesize+')');
            	}
            	if($.isFunction(options.onclick)){
            		filenamediv.click(data[fileindex], function(event){options.onclick(event.data);});
            	}else if(finedo.fn.isfunction(options.onclick)){
            		var fun = eval(options.onclick);
            		filenamediv.click(data[fileindex], function(event){fun(event.data);});
            	}
            	filediv.append(filenamediv);
            	fileitem.append(filediv);
            	
            	//预览按钮
            	var fileopdiv = $('<div class="finedo-upload-fileitem-op">');
            	
            	if($finedofile.canpreview(data[fileindex])){
	            	var previewitem = $('<div class="finedo-upload-op-icon"><span>预览</span></div>');
	            	fileopdiv.append(previewitem);
	            	previewitem.click(data[fileindex], function(event){$finedofile.preview(event.data);});
            	}
            	
            	var downloaditem = $('<div class="finedo-upload-op-icon finedo-upload-op-download"><span>下载</span></div>');
            	fileopdiv.append(downloaditem);
            	if(finedo.fn.istrue($finedofile.data('options').editable)){
                	var deleteitem = $('<div class="finedo-upload-op-icon finedo-upload-op-del"><span>删除</span></div>');
                	fileopdiv.append(deleteitem);
        			deleteitem.bind('click', data[fileindex], function(event){
        				$finedofile.deletefile([event.data]);
        			});
            	}
            	fileitem.append(fileopdiv);
            	
            	downloaditem.bind('click', data[fileindex], function(event){
    				$finedofile.download([event.data]);
    			});
            	
            	fileitem.data('datarows', data[fileindex]);
            	$('#'+$finedofile.attr('id')+'filelist').append(fileitem);
            	$finedofile.data('filelist').push(data[fileindex]);
        	}
        	$finedofile.setvalue();
        };

        /**
         * 清空文件列表
         */
        this.clear = function(){
        	$('#'+$finedofile.attr('id')+'filelist').html('');
        	$filelist = [];
        	$finedofile.setvalue();
        };
        
        /**
         * 移动文件清单
         * data数据结构：[{"fileid":"FD00027"}, {"fileid":"FD00028"}]
         */
        this.removeFiles = this.removefiles = function(data){
        	for(var i = 0; i < data.length; i++){
        		$('#'+data[i].fileid).remove();
        		for(var j = 0; j < $finedofile.data('filelist').length; j++){
        			if(data[i].fileid == $finedofile.data('filelist')[j].fileid){
        				$finedofile.data('filelist').splice(j,1);
        				break;
        			}
        		}
        	}
        	$finedofile.setvalue();
        };
        
        /**
         * 获取控件中所有文件对象数组
         * 返回数据格式为：[{"fileid":"FD00027"}, {"fileid":"FD00028"}]
         */
        this.getFileList = this.getfilelist = function(){
        	return $finedofile.data('filelist');
        };
        
        /**
         * 检查数据格式
         */
        this.checkFileList = this.checkfilelist = function(data){
        	if(!data || !data.length){
        		//finedo.message.warning('非文件对象数组，如：[{"fileid":"FD0001"},{"fileid":"FD0002"}]');
        		return false;
        	}
        	if(data.length == 0){
        		//finedo.message.warning('文件数组为空！');
        		return false;
        	}
        	for(var i = 0; i < data.length; i++){
	        	if(!data[i].fileid){
	        		finedo.message.warning('文件对象中无fileid属性，请确认格式是否正确！');
	        		return false;
	        	}
        	}
        	return true;
        };
        
        this.setentity = this.setEntity = function(entity){
        	var fileidlist = [];	
        	fileidlist.push({"entityid":entity});
        	$finedofile.clear();
        	$finedofile.load(fileidlist);
        };
        
        /**
         * 根据文件ID列表加载文件信息
         * 格式为：[{"fileid":"FD000000000000000505"},{"fileid":"FD0002"}]
         */
        this.load = function(data){
        	if(!data && !data.length)
        		return;
        	finedo.action.doJsonRequest($finedofile.getoption("queryurl"), {'filelist':data}, function(retdata){
        		if(retdata.fail){
    				finedo.message.error(retdata.resultdesc);
    				return;
    			}
    			
    			$finedofile.showfiles(retdata.object.filelist);
    			if(retdata.object.filelist.length == 0){
    				if(!finedo.fn.istrue($finedofile.getoption("editable"))){
    					$('#'+$finedofile.attr('id')+'uploadnav').hide();
    				}
    			}
    			if($.isFunction($finedofile.getoption("oninitcomplete"))){
    				$finedofile.getoption("oninitcomplete")(retdata.object.filelist);
    				$finedofile.setOninitcomplete(undefined);
            	}else if(finedo.fn.isfunction($finedofile.getoption("oninitcomplete"))){
            		var fun = eval($finedofile.getoption("oninitcomplete"));
            		fun(retdata.object.filelist);
    				$finedofile.setOninitcomplete(undefined);
            	}
        	});
        };

        /**
         * 根据文件ID列表删除文件信息，如果不需要询问是否删除，则直接删除同时不调用删除回调函数
         * 格式为：[{"fileid":"FD0001"},{"fileid":"FD0002"}]
         */
        this.deleteFile = this.deletefile = function(data, noaskdelete){
            if(!finedo.fn.istrue($finedofile.getoption("editable"))){
                return;
            }
        	if(!$finedofile.checkfilelist(data))
        		return;
        	var options = $finedofile.data('options');
        	var filelist = '';
        	for(var i = 0; i < data.length; i++){
        		if(i > 0)
        			filelist += ',';
        		if(finedo.fn.istrue(options.showname)){
        			filelist += data[i].filename;
            	}else{
            		filelist += data[i].fileid+data[i].filetype;
            	}
        	}
        	if(noaskdelete){
        		finedo.action.doJsonRequest(options.deleteurl, {"filelist":data}, function(retdata){
            		if(retdata.fail){
        				finedo.message.error(retdata.resultdesc);
        				return;
        			}
        			
        			$finedofile.removefiles(data);
        		});
        		return;
        	}
        	finedo.message.question('是否删文件【'+filelist+'】？', null, function(which){
        		if(which == false)
        			return;
            	finedo.action.doJsonRequest(options.deleteurl, {"filelist":data}, function(retdata){
            		if(retdata.fail){
        				finedo.message.error(retdata.resultdesc);
        				return;
        			}
        			
        			$finedofile.removefiles(data);
        			if($.isFunction(options.deletecallback)){
                		options.deletecallback(data);
                	}else if(finedo.fn.isfunction(options.deletecallback)){
                		var fun = eval(options.deletecallback);
                		fun(data);
                	}
            	});
        	});
        };
        
        /**
         * 删除所有文件，不需要传参，自动从页面中获取已加载的所有文件
         */
        this.deleteAll = this.deleteall = function(){
        	var data = $finedofile.getfilelist();
        	$finedofile.deletefile(data);
        };
        
        /**
         * 文件预览
         */
        this.preview = function(data){
            var browser = finedo.fn.getBrowserAndVer();
            if(browser && browser.browser == 'ie' && browser.version <= '8'){
                var downurl = $finedofile.getoption("downloadurl");
                downurl = downurl.indexOf('?') == -1 ? downurl+'?fileid='+data.fileid : downurl+'&fileid='+data.fileid;
                finedo.dialog.previewPicture(downurl);
                return;
            }
        	var filelist = $finedofile.getfilelist();
            var imgindex=0;
        	var previewhtml = '<div>';
        	for(var i = 0; i < filelist.length; i++){
        		var filedata = filelist[i];
                if(filedata.fileid==data.fileid){
                    imgindex=i;
                }
        		if($finedofile.canpreview(filedata)){
        			previewhtml+='<img alt="'+filedata.filename+'" data-original="'+$finedofile.getoption("downloadurl")+'?fileid='+filedata.fileid+'" src="'+$finedofile.getoption("downloadthumbnailurl")+'?fileid='+filedata.fileid+'"></img>';
        		}
        	}
        	if(previewhtml == '<div>')
        		return;
        	previewhtml += '</div>';
        	$(previewhtml).viewer({"url":"data-original","imgindex":imgindex}).viewer("show");
        };
        
        /**
         * 文件下载
         */
        this.download = function(data){
        	if(finedo.fn.isnon(data))
        		return;
        	if(!$finedofile.checkfilelist(data))
        		return;
        	var fileid = '', token = '', code = '';
        	for(var i = 0; i < data.length; i++){
        		if(i > 0){
        			fileid +=',';
        			code += ",";
        		}
        		fileid += data[i].fileid;
        		code += data[i].code;
        		if(token != '' && data[i].remark)
        			token = data[i].remark;
        	}
        	var downurl = $finedofile.getoption("downloadurl");
        	var key = 'fileid';
        	if(data.length > 1){
        		downurl = $finedofile.getoption("downloadmultiurl");
        		key = 'fileids';
        	}
        	downurl = downurl.indexOf('?') == -1 ? downurl+'?'+key+'='+fileid+'&code='+code+'&token='+token : downurl+'&'+key+'='+fileid+'&code='+code+'&token='+token;
        	$('#'+$finedofile.attr('id')+'downframe').attr('src', downurl);
        };
        
        /**
         * 下载所有
         */
        this.downloadAll = this.downloadall = function(){
        	var data = $finedofile.getfilelist();
        	$finedofile.download(data);
        };

        /**
         * 显示模式：list(列表)、view(视图)
         */
        this.viewModel = this.viewmodel = function(modelType){
        	
        };
        
        /**
         * 重置input file控件位置
         */
        this.reset = function(isshow){
        	
        	var uploadbtnobj = $('#'+$finedofile.attr('id')+'uploadbtn');
        	
			if(finedo.fn.isnotnon(uploadbtnobj) && finedo.fn.istrue(isshow) && finedo.fn.istrue($finedofile.data('options').editable)){
				uploadbtnobj.append($('#'+$finedofile.attr('id')+'filename'));
			}else{
				//$('#'+$finedofile.attr('id')+'filename').css({"display":"none"});
			}
        };
        
        /**
         * 控件初始化
         */
        this.init = function(){
        	//判断上级是否有form，此组件不能放在form下。
        	/*var taglist = $finedofile.parents();
        	for(var tagindex = 0; tagindex < taglist.length; tagindex++){
        		if($(taglist[tagindex]).prop("tagName").toUpperCase() == 'FORM'){
        			finedo.message.error('上传下载控件初始化失败，此控件不能包在form标签下。');
        			return;
        		}
        	}*/
        	$finedofile.data('filelist', []);
        	var defaults = {
        		showicon: true, //是否显示图标
        		showname: true, //是否显示原始名称
        		showsize: true, //是否显示文件大小
        		multiupload: true,
        		multidown: false,
        		editable: true,
        		maxfilesize: -1,
        		standard: 'none',
        		thumbnail:true,
        		width: 0,
        		height: 0
            };
        	var attroptions = {};
        	$.each($(this)[0].attributes, function(index, attr) {
        		attroptions[attr.name] = attr.value;
			});
        	var options = $.extend(attroptions,$finedofile.data('options'));
        	options = $.extend(defaults,options);
        	$finedofile.data('options', options);
        	var appctx = options.ctx;
        	if(finedo.fn.isnon(appctx) && typeof ctx != "undefined"){
        	    appctx = ctx;
        	}
        	if(finedo.fn.isnon(appctx)){
        	    appctx = "";
        	}
        	//设置url
        	if(finedo.fn.isnon(options.queryurl))
        		$finedofile.setqueryurl(appctx+file_queryurl);
        	if(finedo.fn.isnon(options.uploadurl))
        		$finedofile.setuploadurl(appctx+file_uploadurl);
        	if(finedo.fn.isnon(options.deleteurl))
        		$finedofile.setdeleteurl(appctx+file_deleteurl);
        	if(finedo.fn.isnon(options.downloadurl))
        		$finedofile.setdownloadurl(appctx+file_downloadurl);
        	if(finedo.fn.isnon(options.downloadmultiurl))
        		$finedofile.setdownloadmultiurl(appctx+file_downloadmultiurl);
            if(finedo.fn.isnon(options.downloadthumbnailurl))
                $finedofile.setdownloadthumbnailurl(appctx+file_downloadthumbnailurl);

        	var isinner = $finedofile.isinner();
        	if(isinner){
        		$finedofile.html('');
        	}else{
        		//清空之前的内容
        		$("#"+$finedofile.attr('id')+"finedofilecontrol").remove();
        		$("#"+$finedofile.attr('id')+"uploadfrm").remove();
        		// 如下语句在IE8下不兼容
        		//$($finedofile).attr('type', 'hidden');
        		$($finedofile).css('display', 'none');
        		$finedofile.val('');
        		$finedofile.after($('<div id="'+$finedofile.attr('id')+'finedofilecontrol">'));
        	}
        	var uploadcontent = $('<div class="finedo-upload-filelist-content">');
        	if(finedo.fn.isnotnon(options.width))
        		$(uploadcontent).width(options.width);
        	if(finedo.fn.isnotnon(options.height))
        		$(uploadcontent).height(options.height);
        	//初始化控件头部
        	if(finedo.fn.istrue(options.editable) || finedo.fn.istrue(options.multidown)){
	        	var nav = $('<div class="finedo-upload-nav" id="'+$finedofile.attr('id')+'uploadnav">');
	        	var navleft = $('<div class="finedo-upload-nav-left">');
	        	if(finedo.fn.istrue(options.editable)){
	        		var uploadbtn = $('<a href="javascript:;" class="finedo-upload-btn" id="'+$finedofile.attr('id')+'uploadbtn">上传文件</a>');
	        		navleft.append(uploadbtn);
	        	}
	        	if(finedo.fn.istrue(options.multidown)){
	            	var downloadbtn = $('<input type="button" class="finedo-upload-downbtn-all" value="全部下载">');
	            	downloadbtn.bind('click', function(event){$finedofile.downloadall();});
	            	navleft.append(downloadbtn);
	        	}
	        	nav.append(navleft);
	        	/*
	        	var navright = $('<div class="finedo-upload-nav-rig">');
	        	var listdivbtn = $('<div class="finedo-upload-nav-switch" title="列表预览">');
	        	var viewdivbtn = $('<div class="finedo-upload-nav-switch finedo-upload-nav-view" title="缩略图预览">');
	        	listdivbtn.bind('click', function(event){$finedofile.viewmodel('list');});
	        	viewdivbtn.bind('click', function(event){$finedofile.viewmodel('view');});
	        	navright.append(listdivbtn);
	        	navright.append(viewdivbtn);
	        	nav.append(navright);
	        	*/
	        	uploadcontent.append(nav);
        	}
        	
        	uploadcontent.append($('<div id="'+$finedofile.attr('id')+'filelist">'));
        	var uploaddiv = $('<div class="finedo-upload-control" id="'+$finedofile.attr('id')+'uploadprogressbar" style="display:none;">');
			uploaddiv.append($('<div>'+
					'<div class="finedo-upload-progress-load finedo-upload-progress-display">'+
					'<div class="finedo-upload-progress-color" id="'+$finedofile.attr('id')+'uploadprogress"></div></div>'+
					'<label class="finedo-upload-disabled" id="'+$finedofile.attr('id')+'uploadprogressnum">0%</label></div>'));
			
			uploadcontent.append(uploaddiv);
			if(isinner){
				$finedofile.append(uploadcontent);
        	}else{
        		$('#'+$finedofile.attr('id')+'finedofilecontrol').append(uploadcontent);
        	}
			var $finedofileform = '<form name="'+$finedofile.attr('id')+'uploadfrm" id="'+$finedofile.attr('id')+'uploadfrm" method="post" enctype="multipart/form-data">';
			$finedofileform +='<iframe name="'+$finedofile.attr('id')+'downframe" id="'+$finedofile.attr('id')+'downframe" style="display:none;"></iframe>';
			//form添加到body最后，防止form相嵌
			if(finedo.fn.istrue(options.editable)){
				$finedofileform +='<input type="file" name="'+$finedofile.attr('id')+'filename" id="'+$finedofile.attr('id')+'filename" >';
			}
			$finedofileform +='</form>';
            $(document.body).append($finedofileform);
			$('#'+$finedofile.attr('id')+'filename').bind('change', function(event){$finedofile.upload();});
			//判断是否设置value值，有值加载文件列表
			var fileids = $finedofile.data('options').value;
			var fileidlist = [];
			if(finedo.fn.isnotnon(fileids)){
				var fileidAry = fileids.split(",");
				for(var i = 0; i < fileidAry.length; i++){
					if(finedo.fn.isnon(fileidAry[i]))
						continue;
					fileidlist.push({"fileid":fileidAry[i]});
				}
			}
			var entityid = $finedofile.data('options').entityid;
			if(finedo.fn.isnotnon(entityid)){
				var relidAry = entityid.split(",");
				for(var i = 0; i < relidAry.length; i++){
					if(finedo.fn.isnon(relidAry[i]))
						continue;
					fileidlist.push({"entityid":relidAry[i]});
				}
			}

			if(fileidlist.length > 0)
				$finedofile.load(fileidlist);
			else{
				if(!finedo.fn.istrue(options.editable)){
					$('#'+$finedofile.attr('id')+'uploadnav').hide();
				}
			}
			$finedofile.reset(true);
			return $finedofile;
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
finedo.getFileControl = finedo.getfile = function(controlid, options){
	if(finedo.controls[controlid] && typeof(options) == "undefined") {
		return finedo.controls[controlid];
	}
	finedo.controls[controlid]=$('#'+controlid).file(options);
	return finedo.controls[controlid];
};

