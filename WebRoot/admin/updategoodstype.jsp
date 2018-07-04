<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>商品信息修改</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/admin_customerdetail.css">

  </head>
  
  <body>
    <div id="detail_top">
  		<a href="goodsTypeServlet?op=querytypes" target="right">
  			<img alt="home" src="${pageContext.request.contextPath }/admin/images/home.png">
  		</a>
  		<strong>您现在所在的位置是：<span id="now_page">商品类型修改页面</span></strong>
  	</div>
  	<form action="goodsTypeServlet">
  	  <table id="typeAdd_table">
  	  	<input type="hidden" name="op" value="updatetype" />
  	  	<input type="hidden" name="typeId" value="${type.typeId }" />
  	  	<tr>
  	  		<td>
  	  			类型编号：${type.typeId }
  	  		</td>
  	  	</tr>
  		<tr>
  			<td>类型名称：</td>
  			<td>
  				<input type="text" value="${type.typeName }" name="typeName" id="typeAdd_table_txt" placeholder="请输入类型名称" />
  			</td>
  			<td>
  				<input type="submit" value="修改" id="typeAdd_table_btn" />
  			</td>
  		</tr>
  	  </table>
  	</form>
  </body>
</html>
