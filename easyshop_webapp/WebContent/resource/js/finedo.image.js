/**
 * 图片控件，用于展示图片，放大缩小图片
 * 
 */
finedo.image = {
	preview:function(url){
		var docwidth = $(document.body).outerWidth(true);
		var docheight = $(window).height();
		var imgviewid = 'finedoimgpreview';
		var rate = 0.2, currate = 1;
		var imgwidth = 0, imgheight = 0;
		var imgviewTag = '<div id="'+imgviewid+'" class="imageview"><div> \
							<img src="'+url+'" id="'+imgviewid+'img" onclick="finedo.image.closePreview();"/></div> \
							<div class="imageview-bottom"> \
								<div class="imageview-bottom-con"> \
							    	<input type="button" class="imageview-btn-small" id="'+imgviewid+'in"/> \
							   		<span id="'+imgviewid+'rate">100%</span> \
							    	<input type="button" class="imageview-btn-big" id="'+imgviewid+'out"/> \
							    </div> \
							</div></div>';
		$('<div id="finedoimgpreviewmask" class="showDialog-mask" onclick="finedo.image.closePreview();"></div>').css({display:"block",width:"100%",height:$(document).height()}).appendTo("body");
		var div = $(imgviewTag).css({display:"block",width:"100%",height:$(document).height()}).appendTo("body");
		$('#'+imgviewid+'img').bind('load', function(){
			imgwidth = this.width;
			imgheight = this.height;
			$('#'+imgviewid+'in').bind('click', function(){
				currate = currate - rate;
				$('#'+imgviewid+'rate').text('%'+Math.ceil((currate*100)));
				$('#'+imgviewid+'img').width(imgwidth*currate);
				$('#'+imgviewid+'img').height(imgheight*currate);
			});
			$('#'+imgviewid+'out').bind('click', function(){
				currate = currate + rate;
				$('#'+imgviewid+'rate').text('%'+Math.ceil((currate*100)));
				$('#'+imgviewid+'img').width(imgwidth*currate);
				$('#'+imgviewid+'img').height(imgheight*currate);
			});
		});
	}
	,closePreview:function(){
		$('#finedoimgpreview').remove();
		$('#finedoimgpreviewmask').remove();
	}
};

