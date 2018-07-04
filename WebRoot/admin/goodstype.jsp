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
    
    <title>My JSP 'goodstype.jsp' starting page</title>
    
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
  		<strong>您现在所在的位置是：<span id="now_page">商品类型页面</span></strong>
  	</div>
  	<div id="detail_search">
  		<div id="detail_search_button">
  			<a href="${pageContext.request.contextPath }/admin/addgoodstype.jsp" target="right">添加类型</a>
  		</div>
  	</div>
    <table id="show_table">
    	<tbody>
    		<tr>
    			<th>类型编号</th>
    			<th>类型名称</th>
    			<th>操作</th>
    		</tr>
    		<c:choose>
    			<c:when test="${not empty requestScope.tList }">
    				<c:forEach items="${requestScope.tList}" var="type">
    					<tr>
    						<td>${type.typeId }</td>
    						<td>${type.typeName }</td>
    						<td>
    							<a href="goodsTypeServlet?op=deletetype&id=${type.typeId }" title="删除"><img class="type_handimg"  src="${pageContext.request.contextPath }/admin/images/ooopic_1508847971.ico"></a>
    							<a href="goodsTypeServlet?op=querytypebyid&id=${type.typeId }" title="修改"><img class="type_handimg"  src="${pageContext.request.contextPath }/admin/images/ooopic_1508848001.ico"></a>
    						</td>
    					</tr>
    				</c:forEach>
    			</c:when>
    			<c:otherwise>
    				<tr>
    					<td colspan="4">
    						<span>没有数据哦!</span>
    					</td>
    				</tr>
    			</c:otherwise>
    		</c:choose>
    	</tbody>
    </table>
    <script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/admin_customerdetail.js"></script>
  </body>
</html>
