<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String basePath = "http://" + request.getServerName() + ":"
			+ request.getServerPort() + request.getContextPath();
%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>正在为你跳转到支付平台，请稍候...</title>
<style type="text/css">
/* loding..样式 */
.loadmian_q {
	background:;
	height: 330px;
	margin: 0 auto;
	margin-top: 10%;
	width: 625px;
}

.loadmian_w {
	font-family: "微软雅黑", Tahoma, Geneva, sans-serif;
	height: auto;
	margin: 0 auto;
	padding-top: 10px;
	width: 473px;
}

.loadmian_w span {
	color: #2D6CA2;
	font-size: 78px;
	font-weight: bold;
}

.loadmian_col {
	color: #2D6CA2;
	font-size: 52px;
}

.loadmian_e {
	color: #E04141;
	float: right;
	font-size: 20px;
	font-weight: bold;
	margin-top: 60px;
}

.floatL {
	float: left;
}

.loadmian_r {
	height: auto;
	margin: 0 auto;
	width: 533px;
}

.loadmian_t {
	background: none repeat scroll 0 0 #FAFAFA;
	border: 1px dashed #E0E0E0;
	color: #666666;
	font-size: 14px;
	height: auto;
	line-height: 28px;
	margin-top: 40px;
	overflow: hidden;
	padding: 10px;
}

.loadmian_t p {
	font-family: 微软雅黑;
	margin: 0;
	padding: 0;
	text-indent: 2em;
}

.loadmian_t font {
	color: #4884B7;
	float: right;
	font-size: 12px;
}
</style>
<script src="${ctx}/static/jquery/1.7.1/jquery-1.7.js" type="text/javascript"></script> 
<script type="text/javascript">
	$(document).ready(function() {
		//$('#form1').submit();
		//模拟进度条
		window.setTimeout(function(){
			$('#filter_tip').show();
			var i = 0;
			var pI = window.setInterval(function() {
				if (i >= 100) {
					window.clearInterval(pI);
					return;
				}
				;
				$('#numPerId').html(i);
				i++;
			}, 100);
		},5);
	});
</script>
</head>
<body>
	<div class="loadmian_q ui-draggable" id="filter_tip" style="display:none ;">
		<div class="loadmian_w">
			<span class="floatL"><span id="numPerId">0</span><font
				class="loadmian_col">%</font></span><font id="msgPerId" class="loadmian_e">正在跳转到支付平台，请稍候...</font>
			<div style="clear: both"></div>
		</div>
		<div class="loadmian_r">
			<div class="loadmian_t">
				<p>在此过程中不要关闭当前页面
			</div>
		</div>
	</div>
	<form name="form1" id="form1" action="${RECHARGE_URL}" method="post">
		<input type="hidden" name="interfaceName" value="${interfaceName}">
		<input type="hidden" name="interfaceVersion" value="${interfaceVersion}">
		<input type="hidden" name="tranData" value="${tranDataBase64}">
		<input type="hidden" name="merSignMsg" value="${merSignMsgBase64}">
		<input type="hidden" name="merCert" value="${merCertBase64}">
	</form>
	<script type="text/javascript">
		form1.submit();
	</script>
</body>
</html>