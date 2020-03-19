;
if(typeof(finedo.controls) == "undefined"){
    finedo.controls = [];
};
finedo.commonui = {
    /*
     * 注册radio事件
     */
    registerradio:function(){
        $('label[class="finedo-radio-checked"], label[class="finedo-radio-label"]').unbind('click');
        
        $('label[class="finedo-radio-checked"], label[class="finedo-radio-label"]').click(function(){
            var radioid=$(this).attr('for');
            $('label[for="' + radioid + '"]').removeClass();
            $(this).attr('class', 'finedo-radio-checked');
            
            $('#' + radioid).val($(this).attr('value'));
            var radioctl = finedo.getradio(radioid);
            if(finedo.fn.isnotnon(radioctl)){
                radioctl.onchange();
            }
        });
    },
    /*
     * 注册checkbox事件
     */
    registercheckbox:function(){
        $('label[class="finedo-checkbox-label"], label[class="finedo-checkbox-checked"]').unbind('click');
        
        $('label[class="finedo-checkbox-label"], label[class="finedo-checkbox-checked"]').click(function(){
            if($(this).attr('class') == "finedo-checkbox-label") {
                $(this).removeClass();
                $(this).attr('class', "finedo-checkbox-checked");
            }else {
                $(this).removeClass();
                $(this).attr('class', "finedo-checkbox-label");
            }
            
            var checkboxvalues="";
            var checkboxid=$(this).attr('for');
            $('label[class="finedo-checkbox-checked"][for="' + checkboxid + '"]').each(function(){
                if(checkboxvalues.length > 0)
                    checkboxvalues=checkboxvalues + ",";
                checkboxvalues=checkboxvalues + $(this).attr('value');
            });
            
            $('#' + checkboxid).val(checkboxvalues);
            var checkboxctl = finedo.getcheckbox(checkboxid);
            if(finedo.fn.isnotnon(checkboxctl)){
                checkboxctl.onchange();
            }
        });
    },
    /*
     * 注册下拉框事件
     */
    registerselect:function(){
        /************** 下拉框函数定义****************/
        $('.finedo-select').unbind('click');
        
        $('.finedo-select').click(function(e) {
            // 先关闭所有下拉框
            $('.finedo-select-hover').attr('class', 'finedo-select');
            $('.finedo-select-con').hide();
            
            $(this).attr('class', 'finedo-select-hover');
            
            var objid=$(this).attr('id') + "div";
            $('#' + objid).toggle();
            
            //阻止事件冒泡，否则事件会冒泡到下面的文档点击事件
            e.stopPropagation();
            
            // 如果存在class="finedo-hint-info"元素, 则显示
            var obj_hint_info=objid.split("_")[0] ;
            if($('#' + obj_hint_info).length > 0) {
                finedo.showhintinfo(obj_hint_info);
            }
        });
        
        $(document).unbind('click');
        $(document).click(function(e) {
            $('.finedo-select-hover').attr('class', 'finedo-select');
            $('.finedo-select-con').hide();
        });
    
        $('.finedo-select-con li').unbind('click');
        $('.finedo-select-con li').click(function(e) {
            var spanclass=$(this).children('span').attr('class');
            if(spanclass != 'finedo-select-multiple' && spanclass != 'finedo-select-multiple-yes') {
                // 单选
                $('.finedo-select-hover').attr('class', 'finedo-select');
                $('.finedo-select-con').hide();
                
                var selectid=$(this).attr('for');
                var selectnameid=selectid + "_name";
            
                var code=$(this).attr('val');
                var value=$(this).text();
                
                $('#' + selectid).val(code);
                $('#' + selectnameid).html(value);

                var selectctl = finedo.getselect(selectid);
                if(finedo.fn.isnotnon(selectctl)){
                    selectctl.onchange();
                }
            }else {
                // 多选标志
                var opflag=true;
                if(spanclass == "finedo-select-multiple"){
                    $(this).children('span').attr("class","finedo-select-multiple-yes");
                    // 选中
                    opflag=true;
                }else{
                    $(this).children('span').attr("class","finedo-select-multiple");
                    // 去选中
                    opflag=false;
                }
                
                var selectid=$(this).attr('for');
                var selectnameid=selectid + "_name";
            
                var code=$(this).attr('val');
                var value=$(this).text();
                
                finedo.commonui.changeselect(selectid, selectnameid, code, value, opflag);
                                    
                //  判断是否存在子节点，如果有，则选中父节点，子节点全部选中，如果去选父节点，则子节点全部去选
                var curspanmargin=finedo.commonui.getpxvalue($(this).children('span').css('margin-left'));
                
                // 遍历li的所有后面的同级li
                 $.each($(this).nextAll('li'), function() {
                    var nextspanmargin=finedo.commonui.getpxvalue($(this).children('span').css('margin-left'));
                    if(nextspanmargin > curspanmargin) {
                        // 是子节点
                        if(opflag) {
                            // 选中
                            $(this).children('span').attr("class","finedo-select-multiple-yes");
                        }else {
                            // 去选中
                            $(this).children('span').attr("class","finedo-select-multiple");
                        }
                        
                        code=$(this).attr('val');
                        value=$(this).text();
                        finedo.commonui.changeselect(selectid, selectnameid, code, value, opflag);
                    }else {
                        // 子节点已经结束
                        return false;
                    }
                });
    
                //阻止事件冒泡，否则事件会冒泡到下面的文档点击事件
                e.stopPropagation();
            }
        });
    },
    /*
     * 注册开关事件
     */
    registeronoff:function(){
        $('input[class="finedo-on"], input[class="finedo-off"]').unbind('click');
        
        $('input[class="finedo-on"], input[class="finedo-off"]').click(function(){
            if($(this).attr("class") == "finedo-on") {
                $(this).removeClass();
                $(this).attr("class", "finedo-off");
                $(this).val("off");
            }else {
                $(this).removeClass();
                $(this).attr("class", "finedo-on");
                $(this).val("on");
            }
        });
    },
    /*
     * select控件多选
     */
    changeselect:function(selectid, selectnameid, code, value, opflag){
        // 剔重
        var codeexists=false;
        var selectcode=$('#' + selectid).val();
        var selectcodearr=selectcode.split(",");
        for(var i=0; i<selectcodearr.length; i++) {
            if(code == selectcodearr[i]) {
                codeexists=true;
                break;
            }
        }
        var selectname=$('#' + selectnameid).html();
        var selectnamearr=selectname.split(",");
        
        if(opflag) {
            // 选中
            if(!codeexists) {
                // 不存在
                if(selectcode.length > 0) {
                    $('#' + selectid).val($('#' + selectid).val() + ',');
                    $('#' + selectnameid).html($('#' + selectnameid).html() + ",");
                }
                $('#' + selectid).val($('#' + selectid).val() + code);
                $('#' + selectnameid).html($('#' + selectnameid).html() + value);
            }else {
                // 已存在  
            }
        }else {
            // 去选中
            if(!codeexists) {
                // 不存在
            }else {
                $('#' + selectid).val('');
                for(var i=0; i<selectcodearr.length; i++) {
                    if(code == selectcodearr[i]) {
                        continue;
                    }
                    
                    if($('#' + selectid).val().length > 0) {
                        $('#' + selectid).val($('#' + selectid).val() + ',');
                    }
                    $('#' + selectid).val($('#' + selectid).val() + selectcodearr[i]);
                }
                
                $('#' + selectnameid).html('');
                for(var i=0; i<selectnamearr.length; i++) {
                    if(value == selectnamearr[i]) {
                        continue;
                    }
                    
                    if($('#' + selectnameid).html().length > 0) {
                        $('#' + selectnameid).html($('#' + selectnameid).html() + ",");
                    }
                    $('#' + selectnameid).html($('#' + selectnameid).html() + selectnamearr[i]);
                }
            }
        }
        var selectctl = finedo.getselect(selectid);
        if(finedo.fn.isnotnon(selectctl)){
            selectctl.onchange();
        }
    },
    getpxvalue:function(pxstr){
        var len=pxstr.length;
        return pxstr.substring(0, len-2) - 0;
    },
    setRadioVal:function(id, value){
        $('#' + id).val(value);
        // 全部去选中
        $('label[for="' + id + '"]').attr("class","finedo-radio-label");
        // 选中
        $('label[for="' + id + '"][value="' + value + '"]').attr("class","finedo-radio-checked");
    },
    setCheckboxVal:function(id, value){
        $('#' + id).val(value);
        // 全部去选中
        $('label[for="' + id + '"]').attr("class","finedo-checkbox-label");
        var valuearr=value.split(",");
        for(var i=0; i<valuearr.length; i++) {
            // 选中
            $('label[for="' + id + '"][value="' + valuearr[i] + '"]').attr("class","finedo-checkbox-checked");
        }
    }
};

/** 
 * 定义radio js组件
 * options {
 *  data:[] //数据列表
 *  value  //默认值
 *  datasource //数据源，也就是tb_sys_statictype表中对应的typename。如果data没传则按datasource的值去后台取数据
 *  ctx 应用名，如相对路径写../..，根据调用页面的路径层次而定
 * }
 * */
;(function($, undefined) {
    /*
     * radio控件
     */
    $.fn.radio = function(options){
        var $finedoradio = this;
        if(options){
            $finedoradio.data('options', options);
        }
        
        /*
         * 设置值
         */
        this.setvalue = function(value) {
            var id=$finedoradio.attr('id');
            $('#' + id).val(value);
            
            // 全部去选中
            $('label[for="' + id + '"]').attr("class","finedo-radio-label");
            // 选中
            $('label[for="' + id + '"][value="' + value + '"]').attr("class","finedo-radio-checked");
            $finedoradio.data("lastchangeval", value);
        };
        
        /*
         * 获取值
         */
        this.getvalue = function() {
            var id=$finedoradio.attr('id');
            return $('#' + id).val();
        };

        /*
         * change事件触发
         */
        this.onchange = function(){
            var preval = $finedoradio.data("lastchangeval");
            var curval = this.getvalue();
            if(preval == curval){
                return;
            }
            var changecallback = $finedoradio.data('options').onchange;
            if(!changecallback){
                return;
            }
            if(!$.isFunction(changecallback)){
                return;
            }
            $finedoradio.data("lastchangeval", curval);
            changecallback(curval);
        };
        
        /**
         * 初始化radio控件数据
         */
        this.initdata = function(rowdata){
            var id=$finedoradio.attr('id');
            var radiovalue=$finedoradio.data('options').value;
            if(typeof(radiovalue) == "undefined" || radiovalue == null)
                radiovalue="";
            var radiodiv = '<div class="finedo-radio-div">';
            for(var i=0; i<rowdata.length; i++) {
                var code=rowdata[i].code;
                var value=rowdata[i].value;
                            
                radiodiv = radiodiv + '<label for="' + id + '" value="' + code + '" class="finedo-radio-label">' + value + '</label>&nbsp;&nbsp;';
            }
            radiodiv = radiodiv + '</div>';
            
            $finedoradio.after(radiodiv);
            
            // 设置radio默认值
            $finedoradio.setvalue(radiovalue);
                        
            // 注册事件
            finedo.commonui.registerradio();
        };
        
        /**
         * 控件初始化
         */
        this.init = function(){
            if(finedo.fn.isnon($finedoradio.data('options'))){
                return;
            }
            if($finedoradio.data('init') == true)
                return $finedoradio;
            $finedoradio.data('init', true);
            
            var id=$finedoradio.attr('id');
            
            // 重置input属性
            $finedoradio.attr('name', id);
            // 如下语句在IE8下不兼容
            //$finedoradio.attr('type', 'hidden');
            $finedoradio.css('display', 'none');
            $finedoradio.val('');
            
            var rowdata=$finedoradio.data('options').data;
            
            if(finedo.fn.isnon(rowdata)){
                //按datasource查询
                var datasource=$finedoradio.data('options').datasource;
                if(finedo.fn.isnon(datasource)){
                    finedo.message.error('请传入初始化Radio组件的数据或数据源！');
                    return;
                }
                var appctx=$finedoradio.data('options').ctx;
                if(finedo.fn.isnon(appctx) && typeof ctx != "undefined"){
                    appctx = ctx;
                }
                if(finedo.fn.isnon(appctx)){
                    appctx = "";
                }
                finedo.action.ajax({
                    url:appctx+'/finedo/staticdata/loaddata',
                    reqjson:finedo.version >= 3.0 ? true : false,
                    data:{'typename':datasource},
                    callback:(function(retdata){
                        if(retdata.fail){
                            finedo.message.error(retdata.resultdesc);
                            return;
                        }
                        var retdatalist = retdata.object;
                        rowdata = [];
                        retdatalist.forEach(function(element,index,data){
                            rowdata.push({"code":element.attrname, "value":element.attrvalue});
                        });
                        $finedoradio.initdata(rowdata);
                    })
                });
            }else{
                $finedoradio.initdata(rowdata);
            }
            
            return $finedoradio;
        };
        
        return this.init();
    };
})(jQuery);

/**
 * 定义radio控件获取函数
 */ 
finedo.getradio = finedo.getRadio = function(controlid, options){
    if(finedo.controls[controlid] && typeof(options) == "undefined") {
        return finedo.controls[controlid];
    }
    finedo.controls[controlid]=$('#'+controlid).radio(options);
    return finedo.controls[controlid];
};

/** 
 * 定义checkbox js组件
 * options {
 *  data:[] //数据列表
 *  value  //默认值
 *  datasource //数据源，也就是tb_sys_statictype表中对应的typename。如果data没传则按datasource的值去后台取数据
 *  ctx 应用名，如相对路径写../..，根据调用页面的路径层次而定
 * }
 * */
;(function($, undefined) {
    /**
     * checkbox控件
     */
    $.fn.checkbox = function(options){
        var $finedocheckbox = this;
        if(options){
            $finedocheckbox.data('options', options);
        }
        /*
         * 设置值
         */
        this.setvalue = function(value) {
            var id=$finedocheckbox.attr('id');
            $('#' + id).val(value);
            
            // 全部去选中
            $('label[for="' + id + '"]').attr("class","finedo-checkbox-label");
            
            var valuearr=value.split(",");
            for(var i=0; i<valuearr.length; i++) {
                // 选中
                $('label[for="' + id + '"][value="' + valuearr[i] + '"]').attr("class","finedo-checkbox-checked");
            }
            $finedocheckbox.data("lastchangeval", value);
        };

        /*
         * change事件触发
         */
        this.onchange = function(){
            var preval = $finedocheckbox.data("lastchangeval");
            var curval = this.getvalue();
            if(preval == curval){
                return;
            }
            var changecallback = $finedocheckbox.data('options').onchange;
            if(!changecallback){
                return;
            }
            if(!$.isFunction(changecallback)){
                return;
            }
            $finedocheckbox.data("lastchangeval", curval);
            changecallback(curval);
        };
        
        /*
         * 获取值
         */
        this.getvalue = function() {
            var id=$finedocheckbox.attr('id');
            return $('#' + id).val();
        };

        /**
         * 初始化checkbox控件数据
         */
        this.initdata = function(rowdata){
            var id=$finedocheckbox.attr('id');
            var checkboxvalue=$finedocheckbox.data('options').value;
            if(typeof(checkboxvalue) == "undefined" || checkboxvalue == null)
                checkboxvalue="";
            
            var checkboxdiv='<div class="finedo-checkbox-div" >';
            for(var i=0; i<rowdata.length; i++) {
                var code=rowdata[i].code;
                var value=rowdata[i].value;
                
                checkboxdiv=checkboxdiv + '<label class="finedo-checkbox-label" for="' + id + '" value="' + code + '">' + value + '</label>';
            }
            checkboxdiv = checkboxdiv + '</div>';
            
            $finedocheckbox.after(checkboxdiv);
            
            // 设置默认值
            $finedocheckbox.setvalue(checkboxvalue);
            
            // 注册事件
            finedo.commonui.registercheckbox();
        };
        
        /**
         * 控件初始化
         */
        this.init = function(){
            if(finedo.fn.isnon($finedocheckbox.data('options'))){
                return;
            }
            if($finedocheckbox.data('init') == true)
                return $finedocheckbox;
            $finedocheckbox.data('init', true);
            
            var id=$finedocheckbox.attr('id');
            // 重置input属性
            $finedocheckbox.attr('name', id);
            // 如下语句在IE8下不兼容
            //$finedocheckbox.attr('type', 'hidden');
            $finedocheckbox.css('display', 'none');
            $finedocheckbox.val('');
                        
            var rowdata=$finedocheckbox.data('options').data;
            if(finedo.fn.isnon(rowdata)){
                //按datasource查询
                var datasource=$finedocheckbox.data('options').datasource;
                if(finedo.fn.isnon(datasource)){
                    finedo.message.error('请传入初始化Checkbox组件的数据或数据源！');
                    return;
                }
                var appctx=$finedocheckbox.data('options').ctx;
                if(finedo.fn.isnon(appctx) && typeof(ctx) != "undefined"){
                    appctx = ctx;
                }
                if(finedo.fn.isnon(appctx)){
                    appctx = "";
                }
                finedo.action.ajax({
                    url:appctx+'/finedo/staticdata/loaddata',
                    reqjson:finedo.version >= 3.0 ? true : false,
                    data:{'typename':datasource},
                    callback:(function(retdata){
                        if(retdata.fail){
                            finedo.message.error(retdata.resultdesc);
                            return;
                        }
                        var retdatalist = retdata.object;
                        rowdata = [];
                        retdatalist.forEach(function(element,index,data){
                            rowdata.push({"code":element.attrname, "value":element.attrvalue});
                        });
                        $finedocheckbox.initdata(rowdata);
                    })
                });
            }else{
                $finedocheckbox.initdata(rowdata);
            }
            return $finedocheckbox;
        };
        
        return this.init();
    };
})(jQuery);

/**
 * 定义checkbox控件获取函数
 */ 
finedo.getcheckbox = finedo.getCheckbox = function(controlid, options){
    if(finedo.controls[controlid] && typeof(options) == "undefined") {
        return finedo.controls[controlid];
    }
    finedo.controls[controlid]=$('#'+controlid).checkbox(options);
    return finedo.controls[controlid];
};

/** 
 * 定义select js组件
 * options {
 *  data:[] //数据列表
 *  value  //默认值
 *  datasource //数据源，也就是tb_sys_statictype表中对应的typename。如果data没传则按datasource的值去后台取数据
 *  type   //single:单选, multi:多选
 *  ctx 应用名，如相对路径写../..，根据调用页面的路径层次而定
 * }
 * */
;(function($, undefined) {
    /*
     * select控件
     */
    $.fn.select = function(options){
        var $finedoselect = this;
        var finedoselectarray = [];
        if(options){
            $finedoselect.data('options', options);
        }
        
        /*
         * 递归生成tree结构
         */
        this.generatetree = function(top_code, level) {
            var id=$finedoselect.attr('id');
            var type=$finedoselect.data('options').type;
            if(typeof(type) == "undefined" || type == null)
                type="single";
            var rowdata=$finedoselect.data('options').data;
            for(var i=0; i<rowdata.length; i++) {
                var code=rowdata[i].code;
                var value=rowdata[i].value;
                var parent=rowdata[i].parent;
                
                if(parent == top_code) {
                    var marginleft=level*11;
                    
                    var lidiv="";
                    if(type == "single") {
                        // 单选
                        lidiv='<li for="' + id + '" value="' + code + '" val="' + code + '"><span style=" margin-left:' + marginleft + 'px;"></span>' + value + '</li>';
                    }else {
                        // 多选
                        lidiv='<li for="' + id + '" value="' + code + '" val="' + code + '"><span class="finedo-select-multiple" style=" margin-left:' + marginleft + 'px; "></span>' + value + '</li>';
                    }
                    finedodataarray.push(lidiv);
                    
                    $finedoselect.generatetree(code, level+1);
                }
            }
        };
        
        /*
         * 设置值
         */
        this.setvalue = function(selectedcode) {
            var id=$finedoselect.attr('id');
            var type=$finedoselect.data('options').type;
            if(typeof(type) == "undefined" || type == null)
                type="single";
            
            var selectid=id;
            var selectnameid=selectid + "_name";
            
            var selectidstr=selectedcode;
            var selectnameidstr="";
            var rowdata=$finedoselect.data('options').data;
            
            if(type == 'multi') {
                // 多选: 全部去选中
                $('li[for="' + id + '"]').children('span').attr("class","finedo-select-multiple");  
            }
            
            for(var i=0; i<rowdata.length; i++) {
                var code=rowdata[i].code;
                var value=rowdata[i].value;
                
                if(type == 'single') {
                    // 单选
                    if(selectedcode == code) {
                        selectnameidstr=value;
                        break;
                    }
                }else {
                    // 多选           
                    var selectedcodearr=selectedcode.split(",");
                    for(var j=0; j<selectedcodearr.length; j++) {
                        if(selectedcodearr[j] == code) {
                            if(selectnameidstr.length > 0)
                                selectnameidstr = selectnameidstr + ",";
                            selectnameidstr = selectnameidstr + value;
                            
                            // 选中
                            $('li[for="' + id + '"][val="' + code + '"]').children('span').attr("class","finedo-select-multiple-yes");
                        }
                    }               
                }
            }
            
            $('#' + selectid).val(selectidstr);
            $('#' + selectnameid).html(selectnameidstr);
            $finedoselect.data("lastchangeval", selectidstr);
        };
        /*
         * change事件触发
         */
        this.onchange = function(){
            var preval = $finedoselect.data("lastchangeval");
            var curval = this.getvalue();
            if(preval == curval){
                return;
            }
            var changecallback = $finedoselect.data('options').onchange;
            if(!changecallback){
                return;
            }
            if(!$.isFunction(changecallback)){
                return;
            }
            $finedoselect.data("lastchangeval", curval);
            changecallback(curval);
        };
        /*
         * 获取值
         */
        this.getvalue = function() {
            var id=$finedoselect.attr('id');
            return $('#' + id).val();
        };
        this.reset = function(rowdata){
            var id=$finedoselect.attr('id');
            var selectedcode=$finedoselect.data('options').value;
            var style=$finedoselect.data('options').style;
            var type=$finedoselect.data('options').type;
            
            if(typeof(type) == "undefined" || type == null)
                type="single";
            if(typeof(selectedcode) == "undefined" || selectedcode == null)
                selectedcode="";
            
            var selectdiv="<ul>";
            
            // 判断是否为分级显示, 是否存在"parent"属性
            var istree=false;
            for(var i=0; i<rowdata.length; i++) {
                var parent=rowdata[i].parent;
                if(typeof(parent) != "undefined" && parent != null) {
                    istree=true;
                    break;
                }
            }                       
            
            if(istree) {
                // 递归生成tree
                finedodataarray=[];
                
                // 支持多个顶级节点
                for(var i=0; i<rowdata.length; i++) {
                    var top_code=rowdata[i].code;
                    var top_value=rowdata[i].value;
                    var parent=rowdata[i].parent;
                    
                    if(parent == "0") {
                        var lidiv="";
                        if(type == "single") {
                            lidiv='<li for="' + id + '" value="' + top_code + '" val="' + top_code + '"><span class="finedo-select-arrow"></span>' + top_value + '</li>';
                        }else {
                            lidiv='<li for="' + id + '" value="' + top_code + '" val="' + top_code + '"><span class="finedo-select-multiple"></span>' + top_value + '</li>';
                        }
                        finedodataarray.push(lidiv);
                        
                        $finedoselect.generatetree(top_code, 2);
                    }
                }
                for(var i=0; i<finedodataarray.length; i++) {
                    selectdiv=selectdiv + finedodataarray[i];
                }
            }else {
                for(var i=0; i<rowdata.length; i++) {
                    var code=rowdata[i].code;
                    var value=rowdata[i].value;
                    var img=rowdata[i].img;
                    var parent=rowdata[i].parent;
                    
                    if(type == "single") {
                        // 设置图标
                        if(typeof(img) != "undefined" && img != null) {
                            selectdiv=selectdiv + '<li for="' + id + '" value="' + code + '" val="' + code + '"><img src="' + img + '">' + value + '</li>';
                        }else {                     
                            selectdiv=selectdiv + '<li for="' + id + '" value="' + code + '" val="' + code + '">' + value + '</li>';
                        }
                    }else {
                        selectdiv=selectdiv + '<li for="' + id + '" value="' + code + '" val="' + code + '"><span class="finedo-select-multiple"></span>' + value + '</li>';
                    }
                }
            }
            
            selectdiv=selectdiv + '</ul></div></div>';
            $("#"+id + "_namediv").html(selectdiv);
            // 设置默认值
            $finedoselect.setvalue(selectedcode);
            
            // 注册事件
            finedo.commonui.registerselect();
        }
        /**
         * 初始化select控件数据
         */
        this.initdata = function(rowdata){
            var id=$finedoselect.attr('id');
            var selectedcode=$finedoselect.data('options').value;
            var style=$finedoselect.data('options').style;
            var type=$finedoselect.data('options').type;
            
            var selectdiv="";
            if(typeof(style) == "undefined" || style == null) {
                selectdiv='<div class="finedo-select-list">';
            }else {
                selectdiv='<div class="finedo-select-list" style="' + style + '">';
            }
            var selectdiv=selectdiv + 
                              '<div class="finedo-select" id="' + id + '_name"></div>' +
                              '<div class="finedo-select-con" id="' + id + '_namediv" style="display:none">';
            
            $finedoselect.after(selectdiv);
            
            $finedoselect.reset(rowdata);
        };
        
        /*
         * 控件初始化
         */
        this.init = function(){
            if(finedo.fn.isnon($finedoselect.data('options'))){
                return;
            }
            if($finedoselect.data('init') == true)
                return $finedoselect;
            $finedoselect.data('init', true);
            
            var id=$finedoselect.attr('id');
            
            // 重置input属性
            $finedoselect.attr('name', id);
            // 如下语句在IE8下不兼容
            //$finedoselect.attr('type', 'hidden');
            $finedoselect.css('display', 'none');
            $finedoselect.val('');
            
            var rowdata=$finedoselect.data('options').data;
            if(finedo.fn.isnon(rowdata)){
                //按datasource查询
                var datasource=$finedoselect.data('options').datasource;
                if(finedo.fn.isnon(datasource)){
                    finedo.message.error('请传入初始化Select组件的数据或数据源！');
                    return;
                }
                var appctx=$finedoselect.data('options').ctx;
                if(finedo.fn.isnon(appctx) && typeof(ctx) != "undefined"){
                    appctx = ctx;
                }
                if(finedo.fn.isnon(appctx)){
                    appctx = "";
                }
                finedo.action.ajax({
                    url:appctx+'/finedo/staticdata/loaddata',
                    reqjson:finedo.version >= 3.0 ? true : false,
                    data:{'typename':datasource},
                    callback:(function(retdata){
                        if(retdata.fail){
                            finedo.message.error(retdata.resultdesc);
                            return;
                        }
                        var retdatalist = retdata.object;
                        rowdata = [];
                        retdatalist.forEach(function(element,index,data){
                            rowdata.push({"code":element.attrname, "value":element.attrvalue});
                        });
                        $finedoselect.data('options').data = rowdata;
                        $finedoselect.initdata(rowdata);
                    })
                });
            }else{
                $finedoselect.initdata(rowdata);
            }
            return $finedoselect;
        };
        
        return this.init();
    };
})(jQuery);

/**
 * 定义select控件获取函数
 */ 
finedo.getselect = finedo.getSelect = function(controlid, options){
    if(finedo.controls[controlid] && typeof(options) == "undefined") {
        return finedo.controls[controlid];
    }
    finedo.controls[controlid]=$('#'+controlid).select(options);
    return finedo.controls[controlid];
};

$(function() {
    /* 注册radio事件 */
    finedo.commonui.registerradio();
        
    /* 注册checkbox事件 */
    finedo.commonui.registercheckbox();
    
    /* 注册下拉框事件 */
    finedo.commonui.registerselect();
    
    /* 注册开关事件 */
    finedo.commonui.registeronoff();
});

/************** 提示标签 ****************/
finedo.showhintinfo = function showhintinfo(id) {
    var spaninfoobj=$('span[class="finedo-hint-info"][for="' + id + '"]');
    var spanerrorobj=$('span[class="finedo-hint-error"][for="' + id + '"]');
    var spanrightobj=$('span[class="finedo-hint-right"][for="' + id + '"]');
    
    if(spaninfoobj.length > 0) {
        $(spaninfoobj).css('display', 'inline-block');
    }
    
    if(spanerrorobj.length > 0) {
        $(spanerrorobj).css('display', 'none');
    }
    
    if(spanrightobj.length > 0) {
        $(spanrightobj).css('display', 'none');
    }
};

finedo.showhinterror = function showhinterror(id, message) {
    var spaninfoobj=$('span[class="finedo-hint-info"][for="' + id + '"]');
    var spanerrorobj=$('span[class="finedo-hint-error"][for="' + id + '"]');
    var spanrightobj=$('span[class="finedo-hint-right"][for="' + id + '"]');
    if(spaninfoobj.length > 0) {
        $(spaninfoobj).css('display', 'none');
    }
    
    if(spanerrorobj.length > 0) {
        $(spanerrorobj).css('display', 'inline-block');
        $(spanerrorobj).html(message + '&nbsp;');
    }
    
    if(spanrightobj.length > 0) {
        $(spanrightobj).css('display', 'none');
    }
};

finedo.showhintright = function showhintright(id) {
    var spaninfoobj=$('span[class="finedo-hint-info"][for="' + id + '"]');
    var spanerrorobj=$('span[class="finedo-hint-error"][for="' + id + '"]');
    var spanrightobj=$('span[class="finedo-hint-right"][for="' + id + '"]');
    
    if(spaninfoobj.length > 0) {
        $(spaninfoobj).css('display', 'none');
    }
    
    if(spanerrorobj.length > 0) {
        $(spanerrorobj).css('display', 'none');
    }
    
    if(spanrightobj.length > 0) {
        $(spanrightobj).css('display', 'inline-block');
        $(spanrightobj).html('&nbsp;');
    }
};
/************** 提示标签 ****************/

/**
 * 初始化select2控件
   option:{
       "componentname":对应页面中select标签的id
       "tipmsg":提示要输入的内容
       "multiple":是否支持多选，默认为false
       "action":执行查询请求的url，如果action没传，则默认按data初始化
       "datafunc":查询条件处理函数，如
            function(param){
                return {personname: params.term};
            }
       "idname":查询结果对象的id名，多级用逗号分开，如sysuser.usercode
       "textname":查询结果对句的text名，多级用逗号分开，如sysuser.personname
       "defaultValue":默认值
       "defaultText":默认文本
       "inputlength":最少输入几个字符执行查询，默认为1
       "data":按指定数据初始化，数据格式：[{id:"静态数据",text:"静态数据"}]
       "reload":重新加载数据
       "textshow":text显示方式：text/idtext
   }
 */
finedo.select2 = function(option){
    var settings = {
        "multiple":false,
        "defaultValue":"",
        "defaultText":"",
        "inputlength":1,
        "reload":false,
        "textshow":"text"
    };
    $.extend(settings,option);
    if(settings.reload){
        $('#'+settings.componentname).select2('destroy').empty();
    }
    var select2component;
    if(settings.action){
        var select2Option={
            url: settings.action,
            dataType: 'json',
            type: "POST",
            delay: 250,
            data: function(params){
                var requestdata={};
                if(finedo.version >= 3.0){
                    requestdata[finedo.httpjsonkey] = JSON.stringify(settings.datafunc(params));
                }else{
                    requestdata = settings.datafunc(params);
                }
                return requestdata;
            },
            processResults: function (data, params) {
                params.page = params.page || 1;
                var itemList =  new Array();
                var datalist = data.rows;
                if(typeof(datalist) == "undefined"){
                    datalist = data.object;
                }
                for(dataindex in datalist){
                    var dataitem=datalist[dataindex];
                    if(settings.textshow == 'idtext'){
                        itemList.push({"id": finedo.fn.getvalue(dataitem, settings.idname), "text": finedo.fn.getvalue(dataitem, settings.idname)+"("+finedo.fn.getvalue(dataitem, settings.textname)+")"});
                    }else{
                        itemList.push({"id": finedo.fn.getvalue(dataitem, settings.idname), "text": finedo.fn.getvalue(dataitem, settings.textname)});
                    }
                }
                return {
                    results: itemList,
                    pagination: {
                        more:(params.page * 30) <datalist.size
                    } 
                };
            },
            cache: true
        };
        if(settings.defaultValue){
            select2component= $('#'+settings.componentname).select2({
                ajax:select2Option,
                placeholder:settings.tipmsg,
                allowClear: true,
                language: "zh-CN",
                minimumInputLength: settings.inputlength,
                multiple: settings.multiple,
                initSelection: function (element, callback) {
                    callback({id: settings.defaultValue, text: settings.defaultText});
                }
            });
            $('#'+settings.componentname).append('<option value="' + settings.defaultValue + '">' + settings.defaultText + '</option>');
        }else{
            select2component= $('#'+settings.componentname).select2({
                ajax:select2Option,
                placeholder:settings.tipmsg,
                allowClear: true,
                language: "zh-CN",
                minimumInputLength: settings.inputlength,
                multiple: settings.multiple
            });
        }
    }else{
        select2component= $("#"+settings.componentname).select2({
            placeholder:settings.tipmsg,
            data:settings.data,
            allowClear: true,
            language: "zh-CN",
            multiple: settings.multiple
        });
    }
    return select2component;
};

/**
 * 数据验证
 *  label  名称
    datatype 数据类型  email phone url date datetime time number digits 
    minlength 最小长度
    maxlength 最大长度
    required 是否必填 true/false 
 */

finedo.validate = function(items, ispop){
    var isok = true;
    for(var itemid in items){
        var checkitem = items[itemid];
        var val = $.trim($('#'+itemid).val());
        //判断必填项是否为空
        if(finedo.fn.isTrue(checkitem.required) && finedo.fn.isNon(val)){
            if(ispop) {
                finedo.message.error(checkitem.label+'不能为空！');
                return false;
            }else {
                finedo.showhinterror(itemid, checkitem.label+'不能为空！');
                isok = false;
                continue;
            }
        }
        //非必填且为空，则不做验证
        if(!finedo.fn.isTrue(checkitem.required) && finedo.fn.isNon(val)){
            finedo.showhintright(itemid);
            continue;
        }
        //验证是否小于最小长度，长度度为大于0的正整数才做验证
        if(finedo.validate.isNumber(checkitem.minlength) && checkitem.minlength > 0){
            if(val.length < checkitem.minlength){
                if(ispop) {
                    finedo.message.error(checkitem.label+'【'+val+'】长度不能小于'+checkitem.minlength+'！');
                    return false;
                }else {
                    finedo.showhinterror(itemid, checkitem.label+'【'+val+'】长度不能小于'+checkitem.minlength+'！');
                    isok = false;
                    continue;
                }
            }
        }
        //验证是否大于最大长度，长度度为大于0的正整数才做验证
        if(finedo.validate.isNumber(checkitem.maxlength) && checkitem.maxlength > 0){
            if(val.length > checkitem.maxlength){
                if(ispop) {
                    finedo.message.error(checkitem.label+'【'+val+'】长度不能大于'+checkitem.maxlength+'！');
                    return false;
                }else {
                    finedo.showhinterror(itemid, checkitem.label+'【'+val+'】长度不能大于'+checkitem.maxlength+'！');
                    isok = false;
                    continue;
                }
            }
        }
        var checkitemok = true;
        //验证数据类型
        switch(checkitem.datatype){
            case "email":
                if(!finedo.validate.isEmail(val)){
                    if(ispop) {
                        finedo.message.error(checkitem.label+'【'+val+'】不是有效的email地址！');
                        return false;
                    }else {
                        finedo.showhinterror(itemid, checkitem.label+'【'+val+'】不是有效的email地址！');
                        checkitemok = false;
                    }
                }
                break;
            case "phone":
                if(!finedo.validate.isPhone(val)){
                    if(ispop) {
                        finedo.message.error(checkitem.label+'【'+val+'】不是有效的电话号码！');
                        return false;
                    }else {
                        finedo.showhinterror(itemid, checkitem.label+'【'+val+'】不是有效的电话号码！');
                        checkitemok = false;
                    }
                }
                break;
            case "url":
                if(!finedo.validate.isUrl(val)){
                    if(ispop) {
                        finedo.message.error(checkitem.label+'【'+val+'】不是有效的网址！');
                        return false;
                    }else {
                        finedo.showhinterror(itemid, checkitem.label+'【'+val+'】不是有效的网址！');
                        checkitemok = false;
                    }
                }
                break;
            case "date":
                if(!finedo.validate.isDate(val)){
                    if(ispop) {
                        finedo.message.error(checkitem.label+'【'+val+'】不是有效的日期！');
                        return false;
                    }else {
                        finedo.showhinterror(itemid, checkitem.label+'【'+val+'】不是有效的日期！');
                        checkitemok = false;
                    }
                }
                break;
            case "datetime":
                if(!finedo.validate.isDatetime(val)){
                    if(ispop) {
                        finedo.message.error(checkitem.label+'【'+val+'】不是有效的日期时间！');
                        return false;
                    }else {
                        finedo.showhinterror(itemid, checkitem.label+'【'+val+'】不是有效的日期时间！');
                        checkitemok = false;
                    }
                }
                break;
            case "time":
                if(!finedo.validate.isTime(val)){
                    if(ispop) {
                        finedo.message.error(checkitem.label+'【'+val+'】不是有效的时间！');
                        return false;
                    }else {
                        finedo.showhinterror(itemid, checkitem.label+'【'+val+'】不是有效的时间！');
                        checkitemok = false;
                    }
                }
                break;
            case "number": 
                if(!finedo.validate.isNumber(val)){
                    if(ispop) {
                        finedo.message.error(checkitem.label+'【'+val+'】不是有效的整数！');
                        return false;
                    }else {
                        finedo.showhinterror(itemid, checkitem.label+'【'+val+'】不是有效的整数！');
                        checkitemok = false;
                    }
                }
                break;
            case "digits":
                if(!finedo.validate.isDigits(val)){
                    if(ispop) {
                        finedo.message.error(checkitem.label+'【'+val+'】不是有效的数值！');
                        return false;
                    }else {
                        finedo.showhinterror(itemid, checkitem.label+'【'+val+'】不是有效的数值！');
                        checkitemok = false;
                    }
                }
                break;
            case "idcard":
                if(!finedo.validate.isIdcard(val)){
                    if(ispop) {
                        finedo.message.error(checkitem.label+'【'+val+'】不是有效的身份证号码！');
                        return false;
                    }else {
                        finedo.showhinterror(itemid, checkitem.label+'【'+val+'】不是有效的身份证号码！');
                        checkitemok = false;
                    }
                }
                break;
            default :
                break;
        }
        
        if(ispop) {
            
        }else {
            if(checkitemok){
                finedo.showhintright(itemid);
            }else{
                isok = false;
            }
        }
    }
    if(ispop) {
        return true;
    }else {
        return isok;
    }
};
finedo.validate.isEmail = function(val){
    var reg = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
    return reg.test(val);
};
finedo.validate.isPhone = function(val){
    var reg = /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|(0\d{2,3}-))?[1-9]\d{6,7}(\-\d{1,4})?$/;
    var reg1 = /(^0{0,1}1[3|4|5|6|7|8|9][0-9]{9}$)/;
    return reg.test(val) || reg1.test(val);
};
finedo.validate.isUrl = function(val){
    var reg = /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/;
    return reg.test(val);
};
finedo.validate.isDate = function(val){
    var result = val.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/);
    if (result == null)
        return false;
    var d = new Date(result[1], result[3] - 1, result[4]);
    return (d.getFullYear() == result[1] && (d.getMonth() + 1) == result[3] && d.getDate() == result[4]);;
};
finedo.validate.isDatetime = function(val){
    var result = val.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2}) (\d{1,2}):(\d{1,2}):(\d{1,2})$/);
    if (result == null)
        return false;
    var d = new Date(result[1], result[3] - 1, result[4], result[5], result[6], result[7]);
    return (d.getFullYear() == result[1] && (d.getMonth() + 1) == result[3] && d.getDate() == result[4] && d.getHours() == result[5] && d.getMinutes() == result[6] && d.getSeconds() == result[7]);
};
finedo.validate.isTime = function(val){
    var result = val.match(/^(\d{1,2}):(\d{1,2}):(\d{1,2})$/);
    if (result == null)
        return false;
    return (result[1] >= 0 && result[1] < 24 && result[2] >= 0 && result[2] < 60 && result[3] >= 0 && result[3] < 60);
};
finedo.validate.isNumber = function(val){
    var reg = /^\d+$/;
    return reg.test(val);
};
finedo.validate.isDigits = function(val){
    var reg = /^[-\+]?\d+(\.\d+)?$/;
    return reg.test(val);
};
finedo.validate.isIdcard = function(val){
    var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
    return reg.test(val);
};
