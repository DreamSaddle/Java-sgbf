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
    
    <title>管理员信息修改</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/admin_customerdetail.css">

  </head>
  
  <body>
    <div id="detail_top">
  		<a href="adminInfoServlet?op=nowselfadmin&admin=${sessionScope.adminName }" target="right">
  			<img alt="home" src="${pageContext.request.contextPath }/admin/images/home.png">
  		</a>
  		<strong>您现在所在的位置是：<span id="now_page">管理员<u style="color:red;">${sessionScope.adminName }</u>信息修改页面</span></strong>
  	</div>
  	<form action="adminInfoServlet" method="post">
  	  <table id="goodAdd_table">
  	  	<input type="hidden" name="op" value="updateadmin" />
		<tr>
			<td class="title_td">管理员编号：</td>
			<td>
				<input type="text" class="input_txt" disabled="true" value="${requestScope.admin.id }"  />
				<input type="hidden" name="id" value="${requestScope.admin.id }" />
			</td>
		</tr>
  		<tr>
  			<td class="title_td">管理员名称：</td>
  			<td>
  				<input type="text" disabled="true" class="input_td" value="${requestScope.admin.adminName }" name="name" />
  			</td>
  		</tr>
  		<tr>
  			<td class="title_td">管理员密码：</td>
  			<td>
  				<input type="text" class="input_td" value="${requestScope.admin.adminPwd }" name="pwd" placeholder="请输入您的密码" />
  			</td>
  		</tr>
  		<tr>
  			<td colspan="2">
  				<input id="input_sub" type="submit" value="修改" />
  			</td>
  		</tr>
  	  </table>
  	</form>
  </body>
</html>
