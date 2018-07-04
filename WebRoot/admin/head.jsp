<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>后台头部</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/admin_head.css">
	
  </head>
  
  <body>
    <div id="div_title">
    	<h1>
    		<img src="${pageContext.request.contextPath }/admin/images/buycar.png" />
    		<span id="admin_title">
				<a href="${pageContext.request.contextPath }/admin.jsp" target="_parent">水果缤纷后台管理中心</a>
			</span><sub>v18.6.15</sub>
    	</h1>
    </div>
    <div id="div_admin">
    	<span id="time" class="wel_admin"></span>
    	<span id="adminName">${sessionScope.adminName }</span>
    	<span class="wel_admin">,欢迎你!</span>
    </div>
    <script type="text/javascript">
		var nowTime = new Date();
		var timespan = document.getElementById("time");
		nowHour = nowTime.getHours();
		if( nowHour>6 && nowHour <12) {
			timespan.innerHTML = "上午好";
		} else if (nowHour>=12 && nowHour <18) {
			timespan.innerHTML = "下午好";
		} else {
			timespan.innerHTML = "晚上好";
		}
	</script>
  </body>
</html>
