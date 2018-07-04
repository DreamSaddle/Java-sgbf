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
    
    <title>发布公告信息</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/admin_customerdetail.css">

  </head>
  
  <body>
    <div id="detail_top">
  		<a href="bulletinInfoServlet?op=querybulletins" target="right">
  			<img alt="home" src="${pageContext.request.contextPath }/admin/images/home.png">
  		</a>
  		<strong>您现在所在的位置是：<span id="now_page">公告信息发布页面</span></strong>
  	</div>
  	<form action="bulletinInfoServlet" method="post">
  	  <table id="goodAdd_table">
  	  	<input type="hidden" name="op" value="addbulletin" />
  		<tr>
  			<td class="title_td">公告标题：</td>
  			<td>
  				<input type="text" class="input_td" name="title" placeholder="请输入公告标题" />
  			</td>
  		</tr>
  		<tr>
  			<td class="title_td">公告内容：</td>
  			<td>
  				<textarea name="content" style="width: 400px;" placeholder="请输入公告内容"></textarea>
  			</td>
  		</tr>
  		<tr>
  			<td class="title_td">发布人：</td>
  			<td>
  				<%--发布人为当前登录用户 --%>
  				<input type="text" disabled="true" class="input_td" value="${sessionScope.adminName }" />
  				<input type="hidden" name="admin" value="${sessionScope.adminName }" />
  			</td>
  		</tr>
  		<tr>
  			<td class="title_td">发布时间：</td>
  			<td>
  				<input class="input_txt"  type="text" name="createtime" />
  			</td>
  		</tr>
  		<tr>
  			<td colspan="2">
  				<input id="input_sub" type="submit" value="发布" />
  			</td>
  		</tr>
  	  </table>
  	</form>
  </body>
</html>
