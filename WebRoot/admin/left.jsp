<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>管理员界面左侧</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/admin_menu.css">
	<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/jquery-1.4.2.js"></script>
  </head>
  
  <body>
    	<table>
    		<tr>
    			<td><a href="customerInfoServlet?op=customerdetail" target="right">客户详情</a></td>
    		</tr>
    		<tr>
    			<td><a href="orderDetailInfoServlet?op=queryorderdetails" target="right">客户订单</a></td>
    		</tr>
    		<tr>
    			<td><a href="goodsTypeServlet?op=querytypes" target="right">商品类型</a></td>
    		</tr>
    		<tr>
    			<td><a href="goodsInfoPageBeanServlet?op=querygoods" target="right">所有商品</a></td>
    		</tr>
    		<tr>
    			<td><a href="bulletinInfoServlet?op=querybulletins" target="right">公告信息</a></td>
    		</tr>
    		<tr>
    			<td><a href="adminInfoServlet?op=nowselfadmin&admin=${sessionScope.adminName }" target="right">修改信息</a></td>
    		</tr>
    		<tr>
    			<td><a href="adminInfoServlet?op=exitadmin" target="_parent">退出</a></td>
    		</tr>
    	</table>
    
    <script type="text/javascript">
    	$("td").mouseover(function() {
    		$(this).css('background-color', 'white');
    	}).mouseout(function() {
    		$(this).css('background-color', '');
    	});
    </script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/admin_menu.js"></script>
  </body>
</html>
