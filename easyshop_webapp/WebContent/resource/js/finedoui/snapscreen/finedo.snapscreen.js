;(function($, undefined) {
	/**
	 * 截屏控件
	 * options:{
	 * 	content: 进度条中显示的内容
	 * }
	 */
	$.fn.snapscreen = function(options){
		$finedosnapscreen = this;
		var snapplugin;
		
		if(options){
			$finedosnapscreen.data('options', options);
		}
		
		this.snapscreen = function(){
			setTimeout(function () {
		        try{
		            res =snapplugin.saveSnapshot($finedosnapscreen.data('options').hostname, '/', $finedosnapscreen.data('options').port);
		        }catch(e){
		            return;
		        }
		        document.body.removeChild(snapplugin);
		    }, 50);
		};
        /**
         * 控件初始化
         */
        this.init = function(){
        	snapplugin = document.createElement("object");
            try{snapplugin.type = "application/x-pluginbaidusnap";}catch(e){
                return;
            }
            snapplugin.style.cssText = "position:absolute;left:-9999px;width:0;height:0;";
            snapplugin.setAttribute("width","0");
            snapplugin.setAttribute("height","0");
            document.body.appendChild(snapplugin);
			return $finedosnapscreen;
        };
        
		return this.init();
	};
})(jQuery);

/**
 * 定义控件获取函数
 */ 
finedo.getsnapscreen = function(options){
	var snapscreenControl = $(document).snapscreen(options);
	return snapscreenControl;
};
