;(function($, undefined) {
	/**
	 * 进度条控件
	 * options:{
	 * 	content: 进度条中显示的内容
	 * }
	 */
	$.fn.progress = function(options){
		var $finedoprogress = this;
		if(options){
			$finedoprogress.data('options', options);
		}
				
		/**
		 * 设置进度条中显示的内容
		 */
		this.setContent = function(content){
			$finedoprogress.data('options').content = content;
			$('#'+$finedoprogress.attr('id')+'progressmessage').html(content+'&nbsp;&nbsp;(' + $finedoprogress.data('progress') + '%)');
		};
		
		/**
		 * 设置进度值
		 */
		this.setProgress = function(progress){
			progress += '';
    		var regu = "^[1-9]{1}[0-9]*$";
    		var re = new RegExp(regu);
    		if (progress.search(re) == -1) {
    			finedo.message.warning("进度值必须是正整数！");
    			return;
    		}
    		if(progress < 0 || progress > 100)
    			return;
    		
    		// 缓存当前进度值
    		$finedoprogress.data('progress', progress);
    		
			var options = $finedoprogress.data('options');
			if(options.content && options.content != ''){
        		$('#'+$finedoprogress.attr('id')+'progressmessage').html(options.content+'&nbsp;&nbsp;('+progress+'%)');
        	}else{
        		$('#'+$finedoprogress.attr('id')+'progressmessage').html(progress+'%');
        	}
    		$('#'+$finedoprogress.attr('id')+'progress').css('width', progress+'%');
		};
		/**
		 * 获取进度值
		 */
		this.getProgress = function(){
			return $finedoprogress.data('progress');
		};
        /**
         * 控件初始化
         */
        this.init = function(){
        	if($finedoprogress.data('init') == true)
        		return $finedoprogress;
        	$finedoprogress.data('init', true);
        	var defaults = {
        		content: ''//进度条中显示的内容
            };
        	var options = $.extend(defaults,$finedoprogress.data('options'));
        	$finedoprogress.data('options', options);
        	$finedoprogress.html('<div class="finedo-progressbar"><div class="finedo-progressbar-progress" id="'+$finedoprogress.attr('id')+'progress"></div><div class="finedo-progressbar-message" id="'+$finedoprogress.attr('id')+'progressmessage">0%</div></div>');
        	if(options.content && options.content != ''){
        		$('#'+$finedoprogress.attr('id')+'progressmessage').html(options.content+'&nbsp;&nbsp;(0%)');
        	}
        	
        	$finedoprogress.data('progress', 0);
        	
			return $finedoprogress;
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
finedo.getProgress = function(controlid, options){
	if(finedo.controls[controlid] && typeof(options) == "undefined") {
		return finedo.controls[controlid];
	}
	finedo.controls[controlid]=$('#'+controlid).progress(options);
	return finedo.controls[controlid];
};
