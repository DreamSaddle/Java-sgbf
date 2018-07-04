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
    
    <title>水果缤纷后台</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

  </head>
  	<c:if test="${empty sessionScope.adminName }">
  		<script type="text/javascript">
  			window.location.href = "admin/login.jsp";
  		</script>
  	</c:if>
  	<%--上下两部分 --%>
    <frameset rows="15%, *">
    	<frame src="${pageContext.request.contextPath }/admin/head.jsp" name="head" noresize="noresize">
    	<%--左右两部分 --%>
    	<frameset cols="11%, *">
    		<frame src="${pageContext.request.contextPath }/admin/left.jsp" name="left" noresize="noresize">
    		<frame src="${pageContext.request.contextPath }/admin/right.jsp" name="right" noresize="noresize">
    	</frameset>
    </frameset>
</html>
