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
    
    <title>当前管理员信息</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/admin_customerdetail.css">
	<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/jquery-1.4.2.js"></script>

  </head>
  
  <body>
    <div id="detail_top">
  		<a href="${pageContext.request.contextPath }/admin.jsp" target="_parent">
  			<img alt="home" src="${pageContext.request.contextPath }/admin/images/home.png">
  		</a>
  		<strong>您现在所在的位置是：<span id="now_page">管理员<u style="color:red;">${sessionScope.adminName }</u>信息管理页面</span></strong>
  	</div>
  	<div id="detail_search">
  		
  	</div>
    <table id="show_table">
    	<tbody>
    		<tr>
    			<th>编号</th>
    			<th>账号</th>
    			<th>密码</th>
    			<th>操作</th>
    		</tr>
			<tr>
				<td>${requestScope.admin.id }</td>
				<td>${requestScope.admin.adminName }</td>
				<td>${requestScope.admin.adminPwd }</td>
				<td>
					<a href="adminInfoServlet?op=deleteadmin&id=${requestScope.admin.id }" title="注销" target="_parent"><img class="type_handimg" src="${pageContext.request.contextPath }/admin/images/ooopic_1508847971.ico"></a>
					<a href="adminInfoServlet?op=editadmin&id=${requestScope.admin.id }" title="修改"><img class="type_handimg" src="${pageContext.request.contextPath }/admin/images/ooopic_1508848001.ico"></a>
				</td>
			</tr>
    	</tbody>
    </table>
    <script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/admin_customerdetail.js"></script>
  </body>
</html>
