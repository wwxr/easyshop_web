<%@ page trimDirectiveWhitespaces="true" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/fsdp2.tld" prefix="fsdp" %>

<%-- Web应用Context路径 --%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="version" value="20150215001" />

<%--IE浏览器兼容性设置 --%>
<c:set var="x_ua_compatible" value='<meta http-equiv=\"X-UA-Compatible\" content=\"IE=8\">'/>

<%-- 全局CSS样式 --%>
<c:set var="style_css" value="<link href='${ctx }/resource/themes/default/style.css?version=${version }' rel='stylesheet' type='text/css' />"/>

<%-- JQuery基础库 --%>
<c:set var="jquery_js" value="<script type='text/javascript' src='${ctx}/resource/js/jquery/jquery-1.11.0.js?version=${version }'></script><script src='${ctx}/resource/js/jquery/jquery.cookie.js?version=${version }' type='text/javascript'></script><script src='${ctx}/resource/js/jquery/jquery.form.js?version=${version }' type='text/javascript'></script><!--[if lte IE 8]><script type='text/javascript' src='${ctx}/resource/js/jquery/json2.js?version=${version }'></script><![endif]--><script type='text/javascript' src='${ctx}/resource/js/jquery/uuid.js?version=${version }'></script>"/>
<c:set var="jquery_ui_js" value="<script type='text/javascript' src='${ctx}/resource/js/jquery/jquery-ui.min.js?version=${version }'></script>"/>
<c:set var="jquery_tab_js" value="<link href='${ctx }/resource/js/finedoui/tab/themes/tab.css?version=${version }' rel='stylesheet' type='text/css' /><script type='text/javascript' src='${ctx}/resource/js/finedoui/tab/tab.js?version=${version }'></script>"/>

<%-- highcharts报表库 --%>
<c:set var="highcharts_js" value="<script src='${ctx}/resource/js/highcharts/highcharts.js?version=${version }' type='text/javascript'></script>"  />
<c:set var="highcharts_more_js" value="<script src='${ctx}/resource/js/highcharts/highcharts-more.js?version=${version }' type='text/javascript'></script>"  />
<c:set var="highcharts_3d_js" value="<script src='${ctx}/resource/js/highcharts/highcharts-3d.js?version=${version }' type='text/javascript'></script>"  />

<%-- echarts报表库 --%>
<c:set var="echarts_js" value="<script src='${ctx}/resource/js/echarts/echarts.js?version=${version }' type='text/javascript'></script>"  />


<%-------------------------------------------------------------------------------%>

<%-- FSDP 核心公共JS库 --%>
<c:set var="finedo_core_js" value="<script type='text/javascript'>var ctx='${ctx }';var ajax_token='${sessionScope.LOGINDOMAIN_KEY.token}';</script><script type='text/javascript' src='${ctx}/resource/js/finedoui/base/finedo.core.js?version=${version }'></script>"  />

<%-- FSDP 基础组件JS库 --%>
<c:set var="finedo_commonui_js" value="<link href='${ctx }/resource/js/finedoui/commonui/themes/commonui.css?version=${version }' rel='stylesheet' type='text/css' /><script type='text/javascript' src='${ctx}/resource/js/finedoui/commonui/finedo.commonui.js?version=${version }'></script>"  />

<%-- FSDP 日期选择器库  --%>
<c:set var="finedo_date_js" value="<script type='text/javascript' src='${ctx}/resource/js/finedoui/date/WdatePicker.js?version=${version }'></script>"  />

<%-- FSDP 窗口控件JS库 --%>
<c:set var="finedo_dialog_js" value="<link href='${ctx }/resource/js/finedoui/dialog/themes/style.css?version=${version }' rel='stylesheet' type='text/css' /><script type='text/javascript' src='${ctx}/resource/js/finedoui/dialog/finedo.dialog.js?version=${version }'></script>"  />

<%-- FSDP 表格控件JS库 --%>
<c:set var="finedo_grid_js" value="<link href='${ctx }/resource/js/finedoui/grid/themes/style.css?version=${version }' rel='stylesheet' type='text/css' /><script type='text/javascript' src='${ctx}/resource/js/finedoui/grid/finedo.grid.js?version=${version }'></script>"  />

<%-- FSDP 进度条控件JS库 --%>
<c:set var="finedo_progress_js" value="<link href='${ctx }/resource/js/finedoui/progress/themes/progress.css?version=${version }' rel='stylesheet' type='text/css' /><script type='text/javascript' src='${ctx}/resource/js/finedoui/progress/finedo.progress.js?version=${version }'></script>"  />

<%-- FSDP 上传下载控件JS库 --%>
<c:set var="finedo_upload_js" value="<link href='${ctx }/resource/js/finedoui/upload/themes/style.css?version=${version }' rel='stylesheet' type='text/css' /><script type='text/javascript' src='${ctx}/resource/js/finedoui/upload/finedo.upload.js?version=${version }'></script>"  />

<%-- FSDP 集成webupload控件JS库 --%>
<c:set var="finedo_webupload_js" value="<link href='${ctx }/resource/js/finedoui/upload/themes/style.css?version=${version }' rel='stylesheet' type='text/css' /><link href='${ctx }/resource/js/finedoui/upload/webuploader/webuploader.css?version=${version }' rel='stylesheet' type='text/css' /><script type='text/javascript' src='${ctx}/resource/js/finedoui/upload/finedo.webupload.js?version=${version }'></script><script type='text/javascript' src='${ctx}/resource/js/finedoui/upload/webuploader/webuploader.min.js?version=${version }'></script>"  />

<%-- FSDP 富文本编辑器库 --%>
<c:set var="finedo_htmleditor_js" value="<script type='text/javascript' charset='utf-8' src='${ctx }/resource/js/ueditor/ueditor.config.js?version=${version }'></script><script type='text/javascript' charset='utf-8' src='${ctx }/resource/js/ueditor/ueditor.all.js?version=${version }'> </script><script type='text/javascript' charset='utf-8' src='${ctx }/resource/js/ueditor/lang/zh-cn/zh-cn.js?version=${version }' ></script>"  />

<%-- FSDP 数据选择JS库 --%>
<c:set var="finedo_choose_js" value="<script type='text/javascript' src='${ctx}/resource/js/finedo.choose.js?version=${version }'></script>"  />
 
<%-- FSDP 树形控件JS库  --%>
<c:set var="finedo_tree_js" value="<link href='${ctx }/resource/js/finedoui/tree/themes/style.css?version=${version }' rel='stylesheet' type='text/css' /><script type='text/javascript' src='${ctx}/resource/js/finedoui/tree/finedo.tree.js?version=${version }'></script>"  />

<%-- FSDP 图片JS库 --%>
<c:set var="finedo_image_js" value="<link href='${ctx }/resource/js/finedoui/image/viewer.min.css?version=${version }' rel='stylesheet' type='text/css' /><script type='text/javascript' src='${ctx}/resource/js/finedoui/image/viewer.min.js?version=${version }'></script>"  />
 
<%-- FSDP 自动识别JS库  --%>
<c:set var="finedo_autocomplete_js" value="<link href='${ctx }/resource/js/finedoui/autocomplete/themes/style.css?version=${version }' rel='stylesheet' type='text/css' /><script type='text/javascript' src='${ctx}/resource/js/finedoui/autocomplete/finedo.autocomplete.js?version=${version }'></script>"  />

<%-- FSDP MD5加密JS库 --%>
<c:set var="finedo_md5_js" value="<script type='text/javascript' src='${ctx}/resource/js/finedo.md5.js?version=${version }'></script>"  />
 
<%-- FSDP 分页控件JS库 --%>
<c:set var="finedo_pager_js" value="<link href='${ctx }/resource/js/finedoui/pager/themes/style.css?version=${version }' rel='stylesheet' type='text/css' /><script type='text/javascript' src='${ctx}/resource/js/finedoui/pager/finedo.pager.js?version=${version }'></script>"  />

<%-- FSDP 截屏JS库 --%>
<c:set var="finedo_snapscreen_js" value="<script type='text/javascript' src='${ctx}/resource/js/finedoui/snapscreen/finedo.snapscreen.js?version=${version }'></script>"  />

<%-- FSDP 免登陆JS库 --%>
<c:set var="finedo_login_js" value="<script type='text/javascript' src='${ctx}/resource/js/finedoui/login/finedo.login.js?version=${version }'></script>"  />

<%-- BASE64 编码JS库 --%>
<c:set var="jquery_base64_js" value="<script type='text/javascript' src='${ctx}/resource/js/jquery/jquery.base64.js?version=${version }'></script>"  />

<%-- AES 加解密JS库 --%>
<c:set var="crypto_aes_js" value="<script type='text/javascript'>var aesvikey='20081128finedocn';</script><script type='text/javascript' src='${ctx}/resource/js/crypto/aes.js?version=${version }'></script><script type='text/javascript' src='${ctx}/resource/js/crypto/pad-zeropadding.js?version=${version }'></script>"  />

<%-- select2控件JS库 --%>
<c:set var="select2_js" value="<link href='${ctx}/resource/js/select2/css/select2.min.css' rel='stylesheet' /><script src='${ctx}/resource/js/select2/js/select2.full.min.js'></script><script src='${ctx}/resource/js/select2/js/i18n/zh-CN.js'></script>"/>

<%-- vue js库 --%>
<c:set var="vue_js" value="<script src='${ctx}/resource/js/vue/vue.min.js'></script>"/>

<%-- 右键 js库 --%>
<c:set var="finedo_contextmenu_js" value="<link href='${ctx }/resource/js/finedoui/contextmenu/themes/style.css?version=${version }' rel='stylesheet' type='text/css' /><script src='${ctx}/resource/js/finedoui/contextmenu/finedo.contextmenu.js?version=${version }'></script>"/>
