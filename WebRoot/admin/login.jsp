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
    
    <title>后台登录</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/login.css" >
	<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/login.js"></script>
	
  </head>
  
  <body>
  	<c:if test="${not empty sessionScope.adminName }">
  		<%request.getSession().removeAttribute("adminName"); %>
  	</c:if>
    <div id="login_div">
    	<div id="login_logo">
    		<a href="${pageContext.request.contextPath }/index.jsp" target="none_"><img src="${pageContext.request.contextPath }/admin/images/logo_2.png" /></a>
    		<h1>水果缤纷后台登录</h1>
    	</div>
    	<form action="adminInfoServlet" method="post" onsubmit="return isLoginOk()">
    		<table border="0">
	    		<tr>
	    			<td class="hint_txt">用户名：</td>
	    			<td><input class="login_txt" type="text" name="adminName" id="name" onblur="verifyName()" /></td>
	    		</tr>
	    		<tr>
	    			<td class="hint_txt">密&emsp;码：</td>
	    			<td><input class="login_txt" type="password" name="adminPwd" id="pwd" onblur="verifyPwd()" /></td>
	    		</tr>
	    		<tr>
	    			<td colspan="2">
	    				<input type="hidden" name="op" value="login" />
	    				<input id="login_btn" type="submit" value="登&emsp;&nbsp;录" />
	    			</td>
	    		</tr>
	    	</table>
    	</form>
    	<script type="text/javascript">
    		document.getElementById("name").focus();
    	</script>
    </div>
  </body>
</html>
