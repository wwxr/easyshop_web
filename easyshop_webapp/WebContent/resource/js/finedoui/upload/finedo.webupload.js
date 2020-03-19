/**
 * 定义文件查询、上传、删除、单个下载、批量下载对应的url
 */
//文件查询url
var file_queryurl = "/finedo/file/query";
//文件上传url
var file_uploadurl = "/finedo/file/webupload";
//文件删除url
var file_deleteurl = "/finedo/file/delete";
//单个文件下载url
var file_downloadurl ="/finedo/file/download";
//多个文件下载url
var file_downloadmultiurl ="/finedo/file/downloadmulti";
//缩略图url
var file_thumbnailurl = '/finedo/file/downloadthumbnail';
//绑定文件与实体
var file_bindentityurl ="/finedo/file/bindentity";
//检查文件分块是否已上传
var file_checkchunkurl = "/finedo/file/checkchunk";
//文件上传成功，合并分块
var file_mergechunksurl ="/finedo/file/mergechunks";


;(function($, undefined) {
	/**
	 * 上传控件
	 * options:{
	 * 	valueid: 设置赋值的id，在控件下传与删除控件时，将文件的fileid值更新此id对应的value
	 * 	reqparams: 请求参数，Json格式(文件上传时的附带参数)
	 * 	value: 文件ID串，多个以逗号分开
	 * 	showicon: true/false,默认为true，是否显示图标
	 * 	showname: true/false,默认为true，是否显示原始名称
	 * 	showsize: true/false,默认为true，是否显示文件大小
	 * 	onclick: 点击文件的回调函数
	 * 	onuploadcomplete: 上传成功后回调函数
	 * 	multidown: true/false，是否支持批量下载，默认为true不支持批量下载
	 * 	editable: true/false，是否可编辑，默认为true，不支持只提供下载预览功能，可编辑增加上传与删除功能
	 * 	deletecallback: 删除回调函数
	 * 	entityid: 关联id
	 * 	oninitcomplete: 控件初始化完成回调
	 * 	standard：none/size/scale，是否限制文件规格（尺寸、比例），默认为none，不做限制，非图片设置size或scale也不生效
	 * 	fwidth:规格为size或scale时，设置为宽度的大小或是比例值
	 * 	fheight:规格为size或scale时，设置为高度的大小或是比例值
	 * 	queryAction : 查询文件清单url
	 * 	uploadAction ：上传文件url
	 * 	deleteAction ：删除文件url
	 * 	downloadAction ：下载文件url
	 * 	downloadmultiAction ：文件批量下载url
	 * 	checkchunkAction ：检查分块是否已上传请求url
	 * 	mergechunksAction ：分块合并请求url
	 * 	thumbnailAction ：缩略图请求url
	 *  bindentityAction:绑定文件与实体
	 *  thumbnail:是否生成缩略图,true/false，默认为true,即默认生成缩略图
	 *  chunked:是否分片上传，默认为false
	 *  fileNumLimit:整形，限制文件数量，不传不限制
	 * 	fileSizeLimit:限制总上传文件大小(单位：字节），不设置则不限制上传文件大小
	 *  fileSingleSizeLimit：限制单个文件大小(单位：字节），不设置则不限制上传文件大小
	 *  accept：文件类型，{
                title: '请选择要上传的文件',
                extensions: 'gif,jpg,jpeg,bmp,png',
                mimeTypes: 'image/*'
            }
     *  auto：true/false，是否自动上传，如果是则选择后即上传,
     *  threads:上传并发数。允许同时最大上传进程数。默认值：3
	 * }
	 */
	$.fn.webupload = function(options){
		var $finedofile = this;
		var webuploadid = $finedofile.attr('id');
		var filelist = [];
		var webuploader;
		var default_options = {
			//设置选完文件后是否自动上传
            auto: true,
            //swf文件路径
            swf: '../../resource/js/finedoui/upload/webuploader/Uploader.swf',
            // 文件接收服务端。
            server: file_uploadurl,
            // 选择文件的按钮。可选。
            // 内部根据当前运行是创建，可能是input元素，也可能是flash.
            pick: {
                id: '#'+webuploadid+'uploadbtn',//这个id是你要点击上传文件按钮的外层div的id,
                label: '上传文件',
                multiple:true//是否可以批量上传，true可以同时选择多个文件
            },
            chunked: true, //开启分块上传
            chunkSize:5*1024*1024,//分块大小，默认5M
            fileNumLimit:100,
            compress: false,//不压缩
            //选择文件类型
            accept: {
                title: '请选择要上传的文件'
            },
            threads:3,
            queryAction:file_queryurl,
            uploadAction:file_uploadurl,
            deleteAction:file_deleteurl,
            downloadAction:file_downloadurl,
            downloadmultiAction:file_downloadmultiurl,
            checkchunkAction:file_checkchunkurl,
            mergechunksAction:file_mergechunksurl,
            thumbnailAction:file_thumbnailurl,
            bindentityAction:file_bindentityurl,
            reqparams:{},//请求参数
            showicon: true, //是否显示图标
    		showname: true, //是否显示原始名称
    		showsize: true, //是否显示文件大小
    		multiupload: true,
    		multidown: true,
    		editable: true,
    		standard: 'none',
    		thumbnail:true,
    		width: 0,
    		height: 0
    	};
		$.extend(true, default_options, options)
		
		this.setOption = this.setoption = function(key, value){
			default_options[key] = value;
		};
		
		this.getOption = this.getoption = function(key){
			return default_options[key];
		};

		/**
         * 设置控件的值，如果是input，则将上传控件中所有文件的ID（以逗号分开）设置为input的value
         * data值结构为[{"fileid":"FD111"},{"fileid":"FD222"}]
         */
        this.setValue = this.setvalue = function(){
        	var val = '';
        	for(var i = 0; i < filelist.length; i++){
        		if(i > 0)
        			val += ',';
        		val += filelist[i].fileid;
        	}
        	$("#"+$finedofile.getoption("valueid")).val(val);
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
        	var options = default_options;
        	for(var fileindex = 0; fileindex < data.length; fileindex++){
            	var uiid = data[fileindex].uiid;
            	var newfileitem = false;//控件加载文件时，div id为文件标识，新上传的div id为前台生成的标识,前台生成的标识不需要重新生成fileitem的div
        		if(!data[fileindex].uiid){
        			uiid = data[fileindex].fileid;
        			data[fileindex].uiid = uiid;
        			newfileitem = true;
        		}
            	var fileitem;
            	if(newfileitem){
            		fileitem = $('<div class="finedo-upload-fileitem">');
            		fileitem.attr('id', uiid);
            	}
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
            	if(newfileitem){
            		fileitem.append(filediv);
            	}else{
            		$("#"+uiid).html('');
            		$("#"+uiid).append(filediv);
            	}
            	
            	//预览按钮
            	var fileopdiv = $('<div class="finedo-upload-fileitem-op">');
            	
            	if($finedofile.canpreview(data[fileindex])){
	            	var previewitem = $('<div class="finedo-upload-op-icon"><span>预览</span></div>');
	            	fileopdiv.append(previewitem);
	            	previewitem.click(data[fileindex], function(event){$finedofile.preview(event.data);});
            	}
            	
            	var downloaditem = $('<div class="finedo-upload-op-icon finedo-upload-op-download"><span>下载</span></div>');
            	fileopdiv.append(downloaditem);
            	if(finedo.fn.istrue(default_options.editable)){
                	var deleteitem = $('<div class="finedo-upload-op-icon finedo-upload-op-del"><span>删除</span></div>');
                	fileopdiv.append(deleteitem);
        			deleteitem.bind('click', data[fileindex], function(event){
        				$finedofile.deletefile([event.data]);
        			});
            	}
            	if(newfileitem){
            		fileitem.append(fileopdiv);
            	}else{
            		$("#"+uiid).append(fileopdiv);
            	}
            	
            	downloaditem.bind('click', data[fileindex], function(event){
    				$finedofile.download([event.data]);
    			});
            	
            	if(newfileitem){
            		$('#'+webuploadid+'filelist').append(fileitem);
            	}
            	filelist.push(data[fileindex]);
        	}
        	$finedofile.setvalue();
        };

        /**
         * 清空文件列表
         */
        this.clear = function(){
        	$('#'+$finedofile.attr('id')+'filelist').html('');
        	filelist = [];
        	$finedofile.setvalue();
        };
        
        /**
         * 移动文件清单
         * data数据结构：[{"fileid":"FD00027"}, {"fileid":"FD00028"}]
         */
        this.removeFiles = this.removefiles = function(data){
        	for(var i = 0; i < data.length; i++){
        		var uiid = data[i].uiid;
        		$('#'+uiid).remove();
        		//从webloader队列中删除
        		if(uiid.indexOf(webuploadid) != -1){
        			var fileid = uiid.replace(webuploadid, '');
        			webuploader.removeFile(fileid, true);
        		}
        		for(var j = 0; j < filelist.length; j++){
        			if(data[i].fileid == filelist[j].fileid){
        				filelist.splice(j,1);
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
        	return filelist;
        };
        
        /**
         * 根据文件ID列表加载文件信息
         * 格式为：[{"fileid":"FD000505"},{"fileid":"FD0002"}]
         */
        this.load = function(data){
        	if(!data && !data.length)
        		return;
        	finedo.action.doJsonRequest($finedofile.getoption("queryAction"), {'filelist':data}, function(retdata){
        		if(finedo.resultcode.success != retdata.resultcode){
    				finedo.message.error(retdata.resultdesc);
    				return;
    			}
    			
    			$finedofile.showfiles(retdata.object.filelist);
    			if(retdata.object.filelist.length == 0){
    				if(!finedo.fn.istrue($finedofile.getoption("editable"))){
    					$('#'+webuploadid+'uploadnav').hide();
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
        	var options = default_options;
        	var entityid = $finedofile.getoption("entityid");
        	var deletedatalist = [];
        	var filelistval = '';
        	for(var i = 0; i < data.length; i++){
        		if(i > 0)
        			filelistval += ',';
        		if(finedo.fn.istrue(options.showname)){
        			filelistval += data[i].filename;
            	}else{
            		filelistval += data[i].fileid+data[i].filetype;
            	}
        		deletedatalist.push({fileid:data[i].fileid,entityid:entityid});
        	}
        	
        	//文件删除不做实际删除，只清除本功能通过entityid关联的文件信息
        	if(noaskdelete){
        		finedo.action.doJsonRequest($finedofile.getoption("deleteAction"), {"filelist":deletedatalist}, function(retdata){
            		if(retdata.fail){
        				finedo.message.error(retdata.resultdesc);
        				return;
        			}
        			$finedofile.removefiles(data);
        		});
        		return;
        	}
        	finedo.message.question('是否删文件【'+filelistval+'】？', null, function(which){
        		if(which == false)
        			return;
            	finedo.action.doJsonRequest($finedofile.getoption("deleteAction"), {"filelist":deletedatalist}, function(retdata){
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
        
        this.uploadSuccess = this.uploadsuccess = function(data){
        	if($.isFunction($finedofile.getoption("nuploadcomplete"))){
        			$finedofile.getoption("onuploadcomplete")(retdata.object);
        	}else if(finedo.fn.isfunction($finedofile.getoption("nuploadcomplete"))){
        		var fun = eval($finedofile.getoption("nuploadcomplete"));
        		fun(retdata.object);
        	}
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
                var downurl = $finedofile.getoption("downloadAction");
                downurl = downurl.indexOf('?') == -1 ? downurl+'?fileid='+data.fileid : downurl+'&fileid='+data.fileid;
                finedo.dialog.previewPicture(downurl);
                return;
            }
            
        	var previewhtml = '<div>';
            var imgindex=0;
        	for(var i = 0; i < filelist.length; i++){
        		var filedata = filelist[i];
                if(filedata.fileid==data.fileid){
                    imgindex=i;
                }
        		if($finedofile.canpreview(filedata)){
        			previewhtml+='<img alt="'+filedata.filename+'" data-original="'+$finedofile.getoption("downloadAction")+'?fileid='+filedata.fileid+'" src="'+$finedofile.getoption("thumbnailAction")+'?fileid='+filedata.fileid+'"></img>';
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
        	var downurl = $finedofile.getoption("downloadAction");
        	var key = 'fileid';
        	if(data.length > 1){
        		downurl = $finedofile.getoption("downloadmultiAction");
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
        
        this.initWebuploader = function(){
        	WebUploader.Uploader.register({
        		//时间点1：所有分块进行上传之前调用此函数
	            'before-send-file': function(file) {
	            	var uploader = this.owner;
        			var deferred = new $.Deferred();
        			//由于register为全局注册，页面中存在多实例的情况 下，需判断具体是哪个实体
        			if(webuploadid != file.webuploadid){
            	    	deferred.resolve();
						return deferred.promise();
        			}
        			//1、计算文件的唯一标记，用于断点续传
        			uploader.md5File(file).progress(function(percentage) {
        				$('#'+webuploadid+file.id+'progress').css('width', (percentage * 100)+'%');
        				$('#'+webuploadid+file.id+'progressnum').html('文件MD5计算:'+(percentage*100)+'%');
        	        }).then(function(val) {
        	        	$('#'+webuploadid+file.id+'progressnum').html('文件MD5计算完成');
        				file.md5=val;
        				//获取MD5后检查服务器中此文件是否存在，如果存在则直接查询显示此文件
        				var dataitem = [{"fileid":val}];
        				finedo.action.doJsonRequest($finedofile.getoption("queryAction"), {'filelist':dataitem}, function(retdata){
        	        		if(retdata.success){
        	        			if(retdata.object && retdata.object.filelist && retdata.object.filelist.length > 0){
        	        				retdata.object.filelist[0].uiid = webuploadid+file.id;
        	        				$finedofile.showfiles(retdata.object.filelist);
        	        				
        	        				//关联文件与实体
        	        				var entityid = $finedofile.getoption("entityid");
        	        				if(finedo.fn.isnotnon(entityid)){
        	        					dataitem[0].entityid = entityid;
	        	        				finedo.action.doJsonRequest($finedofile.getoption("bindentityAction"), {'filelist':dataitem}, function(retdata){
	        	        					
	        	        				});
        	        				}
        	        				//文件存在，跳转直接显示
        							deferred.reject();
        	        			}else{
            	    				deferred.resolve();
        	        			}
        	    			}else{
        	    				deferred.resolve();
        	    			}
        	        	});
        			});
        			return $.when(deferred);
        		},
        		//时间点2：如果有分块上传，则每个分块上传之前调用此函数  
	            'before-send':function(block){
        			var deferred = new $.Deferred();
        			//由于register为全局注册，页面中存在多实例的情况 下，需判断具体是哪个实体
        			if(webuploadid != block.file.webuploadid){
            	    	deferred.resolve();
						return deferred.promise();
        			}
        			block.file.chunks = block.chunks;
        			//如果是分块上传，则验证此分块是否已上传 
        			if(block.chunks && block.chunks != 1){
        				$.ajax({
        					type: "POST",
        					url: file_checkchunkurl,
        					data: {
        						//文件唯一标记  
        						fileid : block.file.md5,
        						//当前分块下标  
        						chunk : block.chunk,
        						//当前分块大小  
        						chunksize : block.end - block.start
        					},
        					dataType: "json",
        					success: function(jsondata) {
        						if (jsondata.success) {
        							//分块存在，跳过  
        							deferred.reject();
        						} else {
        							//分块不存在或不完整，重新发送该分块内容  
        							deferred.resolve();
        						}
        					}
        				});
        			}else {
        				deferred.resolve();
        			}
        			return $.when(deferred);
        		},
        		//时间点3：所有分块上传成功后调用此函数
	            'after-send-file':function(file){
	            	
	            }
            });
        	if($finedofile.getoption("fileNumLimit") <= 1){
        		$.extend(true, default_options,{pick:{multiple:false}})
        	}
        	webuploader=WebUploader.create(default_options);
        	// 当文件被加入队列之前触发，此事件的handler返回值为false，则此文件不会被添加进入队列。
        	webuploader.on('beforeFileQueued', function (file) {
            	var totalfilesize = filelist.length + webuploader.getFiles('inited','queued','progress').length;
            	if(totalfilesize >= default_options.fileNumLimit){
            		finedo.message.error("最多只能上传"+default_options.fileNumLimit+"个文件！");
            		return false;
            	}
        		return true;
            });
            // 当有文件被添加进队列的时候
        	webuploader.on('fileQueued', function (file) {
            	var html = '<div class="finedo-upload-fileitem" id="'+webuploadid+file.id+'">\
			                    <div class="finedo-upload-fileitem-name" style="width:100%;" id="'+webuploadid+file.id+'_progressbar">\
			                <div class="finedo-upload-icon jpg">'+file.name+'('+WebUploader.formatSize(file.size)+')</div>\
			                <div>\
				                <div class="finedo-upload-progress-load finedo-upload-progress-display" style="width:50%;">\
				                    <div class="finedo-upload-progress-color" id="'+webuploadid+file.id+'progress"></div>\
				                </div>\
				                <label class="finedo-upload-disabled" id="'+webuploadid+file.id+'progressnum"></label>\
				            </div>\
			            </div>\
			        </div>';
            	$('#'+webuploadid+'filelist').append(html);
            	file.webuploadid = webuploadid;
            });
            // 文件上传过程中创建进度条实时显示。
        	webuploader.on('uploadProgress', function(file, percentage) {
            	$('#'+webuploadid+file.id+'progress').css('width', (percentage * 100)+'%');
    			$('#'+webuploadid+file.id+'progressnum').html((percentage * 100)+'%');
            });

            //发送前填充数据
        	webuploader.on('uploadBeforeSend', function(block, formdata, header) {
            	var uploadparams = $.extend({},default_options.reqparams);
            	uploadparams.entityid = $finedofile.getoption("entityid");
            	uploadparams.maxfilesize = $finedofile.getoption("fileSingleSizeLimit");
            	uploadparams.standard = $finedofile.getoption("standard");
            	uploadparams.width = $finedofile.getoption("fwidth");
            	uploadparams.height = $finedofile.getoption("fheight");
            	uploadparams.filter = $finedofile.getoption("accept").extensions;
            	uploadparams.thumbnail = $finedofile.getoption("thumbnail");
            	uploadparams.fileid = block.file.md5;
            	if(!uploadparams.maxfilesize){
            		uploadparams.maxfilesize = -1;
            	}
            	
            	$.extend(formdata,uploadparams);
            });
            //当文件上传成功时触发
        	webuploader.on('uploadSuccess', function(file, responsedata) {
            	if(responsedata.fail){
            		finedo.message.error(responsedata.resultdesc);
            		$("#"+webuploadid+file.id).remove();
            		return;
            	}
            	var uploadfiledata = responsedata.object;
            	uploadfiledata.uiid = webuploadid+file.id;
            	//文件上传完成，判断文件是否进行了分块上传，如果是则调用请求完成分块数据合并与入库
            	if(file.chunks && file.chunks != 1){
            		responsedata._raw = undefined;
	    			$.ajax({
	    				type: "POST",
	    				url: file_mergechunksurl,
	    				data: uploadfiledata,
    					dataType: "json",
	    				success : function(jsondata) {
	    					if(jsondata.fail){
	    	            		finedo.message.error(jsondata.resultdesc);
	    	            		return;
	    	            	}
	    					var filedata = [];
	    					filedata.push(uploadfiledata);
	    					$finedofile.showfiles(filedata);
	    					$finedofile.uploadSuccess(uploadfiledata);
	    				}
	    			});
	    			return;
            	}
            	var filedata = [];
				filedata.push(uploadfiledata);
				$finedofile.showfiles(filedata);
				$finedofile.uploadSuccess(uploadfiledata);
            });
            //当文件上传出错时触发。
        	webuploader.on('uploadError', function(file, reason) {
        		if(!reason){
        			return;
        		}
            	finedo.message.error("文件【"+file.name+"】上传错误，错误码："+reason);
            }); 
            //不管成功或者失败，文件上传完成时触发。
        	webuploader.on('uploadComplete', function(file) {
            	$('#'+webuploadid+file.id+'_progressbar').remove();
            });
            //所有文件上传完毕的回调方法
        	webuploader.on('uploadFinished', function(){
                
            });
            //验证不通过触发
            webuploader.on('error', function(errorcode){
            	if(errorcode == 'Q_EXCEED_NUM_LIMIT'){
            		finedo.message.error("最多只能上传"+default_options.fileNumLimit+"个文件！");
            	}else if(errorcode == 'Q_EXCEED_SIZE_LIMIT'){
            		var errorinfo = '文件大小错误';
            		var fileSingleSizeLimit = $finedofile.getoption("fileSingleSizeLimit");
            		if(fileSingleSizeLimit){
            			errorinfo += ',单个文件大小不能超过'+WebUploader.formatSize(fileSingleSizeLimit);
            		}
            		var fileSizeLimit = $finedofile.getoption("fileSizeLimit");
            		if(fileSizeLimit){
            			errorinfo += ',所有文件累计大小不能超过'+WebUploader.formatSize(fileSizeLimit);
            		}
            		finedo.message.error(errorinfo);
            	}else if(errorcode == 'Q_TYPE_DENIED'){
            		var accept = $finedofile.getoption("accept");
            		finedo.message.error('文件类型错误，文件类型必须是:'+accept.extensions);
            	}
            });
        };
        
        /**
         * 控件初始化
         */
        this.init = function(){
        	var html = '<div class="finedo-upload-filelist-content">\
		        <div class="finedo-upload-nav" id="'+webuploadid+'uploadnav">\
		            <div class="finedo-upload-nav-left" style="position:relative;">';
        	if(finedo.fn.istrue(default_options.editable)){
        		html += '<div id="'+webuploadid+'uploadbtn" class="webuploader-container"><div class="webuploader-pick">上传文件</div></div>';
        	}
        	if(finedo.fn.istrue(default_options.multidown)){
        		var leftpos = 120;
        		if(!finedo.fn.istrue(default_options.editable)){
        			leftpos = 10;
        		}
        		html += '<input class="finedo-upload-downbtn-all" id="'+webuploadid+'downloadall" value="全部下载" type="button" style="position:absolute;left:'+leftpos+'px;">';
        	}
		    html += '</div>\
		        </div>\
		        <div id="'+webuploadid+'filelist">\
		        </div>\
		    </div>';
        	var uploadcontent = $(html);
        	if(finedo.fn.isnotnon(options.width))
        		$(uploadcontent).width(options.width);
        	if(finedo.fn.isnotnon(options.height))
        		$(uploadcontent).height(options.height);
			$finedofile.append(uploadcontent);
			$finedofile.delegate('#'+webuploadid+'downloadall', "click", function(e){
				$finedofile.downloadall();
			});
			$finedofile.append('<iframe name="'+webuploadid+'downframe" id="'+webuploadid+'downframe" style="display:none;"></iframe>');
			//判断是否设置value值，有值加载文件列表
			var fileids = $finedofile.getoption("value");
			var fileidlist = [];
			if(finedo.fn.isnotnon(fileids)){
				var fileidAry = fileids.split(",");
				for(var i = 0; i < fileidAry.length; i++){
					if(finedo.fn.isnon(fileidAry[i]))
						continue;
					fileidlist.push({"fileid":fileidAry[i]});
				}
			}
			var entityid = $finedofile.getoption("entityid");
			if(finedo.fn.isnotnon(entityid)){
				var relidAry = entityid.split(",");
				for(var i = 0; i < relidAry.length; i++){
					if(finedo.fn.isnon(relidAry[i]))
						continue;
					fileidlist.push({"entityid":relidAry[i]});
				}
			}
			
			if(fileidlist.length > 0){
				$finedofile.load(fileidlist);
			}
			//初始化webuploader
			$finedofile.initWebuploader();
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
finedo.getWebupload = finedo.getwebupload = function(controlid, options){
	if(finedo.controls[controlid] && typeof(options) == "undefined") {
		return finedo.controls[controlid];
	}
	finedo.controls[controlid]=$('#'+controlid).webupload(options);
	return finedo.controls[controlid];
};

