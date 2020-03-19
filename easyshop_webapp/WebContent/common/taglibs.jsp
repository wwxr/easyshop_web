<%@ page trimDirectiveWhitespaces="true" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/fsdp.tld" prefix="fsdp" %>

<%-- Web应用Context路径 --%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="version" value="20150215001" />

<%-- 全局CSS样式 --%>
<c:set var="style_css" value="<link href='${ctx }/resource/themes/easyui/style.css?version=${version }' rel='stylesheet' type='text/css' />"/>

<%-- JQuery基础库 --%>
<c:set var="jquery_js" value="<script type='text/javascript' src='${ctx}/resource/js/jquery/jquery-1.11.0.js?version=${version }'></script><script src='${ctx}/resource/js/jquery/jquery.cookie.js?version=${version }' type='text/javascript'></script><script src='${ctx}/resource/js/jquery/jquery.form.js?version=${version }' type='text/javascript'></script>"  />

<%-- 日期选择器库  --%>
<c:set var="datepicker_js" value="<script type='text/javascript' src='${ctx}/resource/js/finedoui/date/WdatePicker.js?version=${version }'></script>"  />

<%-- 富文本编辑器库 --%>
<c:set var="ueditor_js" value="<script type='text/javascript' src='${ctx}/resource/js/ueditor/ueditor.config.js?version=${version }'></script><script type='text/javascript' src='${ctx}/resource/js/ueditor/ueditor.all.min.js?version=${version }'></script><script type='text/javascript' src='${ctx}/resource/js/ueditor/lang/zh-cn/zh-cn.js?version=${version }'></script>"  />

<%-- highcharts报表库 --%>
<c:set var="highcharts_js" value="<script src='${ctx}/resource/js/highcharts/highcharts.js?version=${version }' type='text/javascript'></script>"  />
<c:set var="highcharts_more_js" value="<script src='${ctx}/resource/js/highcharts/highcharts-more.js?version=${version }' type='text/javascript'></script>"  />
<c:set var="highcharts_3d_js" value="<script src='${ctx}/resource/js/highcharts/highcharts-3d.js?version=${version }' type='text/javascript'></script>"  />

<%-- echarts报表库 --%>
<c:set var="echarts_js" value="<script src='${ctx}/resource/js/echarts/echarts.js?version=${version }' type='text/javascript'></script>"  />

<%-- easy ui库 --%>
<c:set value="metro" var="SYSTEM_SKIN"></c:set>
<c:if test="${!empty tet}">
<c:set value="${tet}" var="SYSTEM_SKIN"></c:set>
</c:if>
<c:set var="easyui_js" value="<link rel='stylesheet' href='${ctx}/resource/js/easyui/themes/${SYSTEM_SKIN }/easyui.css?version=${version }'><link rel='stylesheet' href='${ctx}/resource/js/easyui/themes/icon.css?version=${version }'><script src='${ctx}/resource/js/easyui/jquery.easyui.min.js?version=${version }' type='text/javascript'></script>"  />
<c:set var="easyui_portal_js" value="<link rel='stylesheet' href='${ctx}/resource/js/easyui-portal/portal.css?version=${version }'><script src='${ctx}/resource/js/easyui-portal/jquery.portal.js?version=${version }' type='text/javascript'></script>"  />


<%-------------------------------------------------------------------------------%>

<%-- FSDP 核心公共JS库 --%>
<c:set var="finedo_js" value="<script type='text/javascript'>var ctx='${ctx }';</script><script type='text/javascript' src='${ctx}/resource/js/finedo.easyui.js?version=${version }'></script>"  />

<%-- FSDP 数据验证JS库 --%>
<c:set var="validator_js" value="<script type='text/javascript' src='${ctx}/resource/js/finedo.easyui.validator.js?version=${version }'></script>"  />




<%-------------------------------------------------------------------------------%>

<%-- FSDP 核心公共JS库 --%>
<c:set var="finedo_core_js" value="<script type='text/javascript' src='${ctx}/resource/js/finedoui/base/finedo.core.js?version=${version }'></script>"  />

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

<%-- FSDP 富文本编辑器库 --%>
<c:set var="finedo_htmleditor_js" value="<script type='text/javascript' charset='utf-8' src='${ctx }/resource/js/ueditor/ueditor.config.js?version=${version }'></script><script type='text/javascript' charset='utf-8' src='${ctx }/resource/js/ueditor/ueditor.all.min.js?version=${version }'> </script><script type='text/javascript' charset='utf-8' src='${ctx }/resource/js/ueditor/lang/zh-cn/zh-cn.js?version=${version }' ></script>"  />

<%-- FSDP 数据选择JS库 --%>
<c:set var="finedo_choose_js" value="<script type='text/javascript' src='${ctx}/resource/js/finedo.choose.js?version=${version }'></script>"  />
