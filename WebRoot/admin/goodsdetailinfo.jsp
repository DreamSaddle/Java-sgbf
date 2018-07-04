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
    
    <title></title>
    
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
  		<img alt="home" src="${pageContext.request.contextPath }/admin/images/home.png">
  		<strong>您现在所在的位置是：<span id="now_page">所有商品信息页面</span></strong>
  	</div>
  	<div id="detail_search">
  		<button id="detail_search_button">
  			<a href="${pageContext.request.contextPath }/admin/addgoodstype.jsp" target="right">添加商品</a>
  		</button>
  	</div>
    <table id="show_table">
    	<tbody>
    		<tr>
    			<th>商品编号</th>
    			<th>商品类型</th>
    			<th>商品名称</th>
    			<th>商品价格</th>
    			<th>商品折扣</th>
    			<th>是否新品</th>
    			<th>是否推荐</th>
    			<th>商品状态</th>
    			<th>商品图片</th>
    			<th>操作</th>
    		</tr>
    		<c:choose>
    			<c:when test="${not empty requestScope.gList }">
    				<c:forEach items="${requestScope.gList}" var="good">
    					<tr>
    						<td>${good.goodsId }</td>
    						<td>${good.type.typeName }</td>
    						<td>${good.goodsName }</td>
    						<td>${good.price }</td>
    						<td>${good.discount }</td>
    						<td>
    							<c:choose>
    								<c:when test="${good.isNew == 0}">
    									是
    								</c:when>
    								<c:otherwise>
    									否
    								</c:otherwise>
    							</c:choose>
    						</td>
    						<td>
    							<c:choose>
    								<c:when test="${good.isRecommend == 0}">
    									是
    								</c:when>
    								<c:otherwise>
    									否
    								</c:otherwise>
    							</c:choose>
    						</td>
    						<td>
    							<c:choose>
    								<c:when test="${good.STATUS == 0}">
    									上架
    								</c:when>
    								<c:otherwise>
    									下架
    								</c:otherwise>
    							</c:choose>
    						</td>
    						<td>${good.photo }</td>
    						<td>
    							<a href="goodsTypeServlet?op=deletetype&id=${type.typeId }"><img class="type_handimg" alt="del" src="${pageContext.request.contextPath }/admin/images/ooopic_1508847971.ico"></a>
    							<a href="goodsTypeServlet?op=querytypebyid&id=${type.typeId }"><img class="type_handimg" alt="del" src="${pageContext.request.contextPath }/admin/images/ooopic_1508848001.ico"></a>
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
