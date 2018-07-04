<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>管理员界面右侧</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/right.css">

  </head>
  
  <body>
  	<hr />
  	<div id="div_all">
  		<div id="div_img">
  			<img src="${pageContext.request.contextPath }/admin/images/admin_p.gif" />
  		</div>
  		<div id="div_word">
  			<p id="p_nowtime">当前时间：<span id="span_time"></span></p>
  			<p id="p_admin">${sessionScope.adminName }</p>
  			<p id="p_welcome">欢迎进入管理中心</p>
  		</div>
  	</div>
  	<script type="text/javascript">
  		function newTime() {
  			var timeEle = document.getElementById("span_time");
  	  		var nowTime = new Date();
  			timeEle.innerHTML = nowTime.getFullYear()+"年"+(nowTime.getMonth()+1)+"月"+nowTime.getDate()+"日 "+nowTime.getHours()+"时"+nowTime.getMinutes()+"分"+nowTime.getSeconds()+"秒";
 			
  			setTimeout("newTime()", 1000);
  		}
  		window.onload = newTime();
   	</script>
  </body>
</html>
