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
    
    <title>客户详情</title>
    
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
  		<strong>您现在所在的位置是：<span id="now_page">客户详情页面</span></strong>
  	</div>
  	<form action="customerInfoServlet">
  		<div id="detail_search">
	  		<span>用户名：</span>
	  		<input type="hidden" name="op" value="customerdetail" />
	  		<input type="text" name="key" id="detail_search_txt" placeholder="根据邮箱查询" />
	  		<input type="submit" value="查询" id="detail_search_btn" />
	  	</div>
  	</form>
    <table id="show_table">
    	<tbody>
    		<tr>
    			<th>客户编号</th>
    			<th>客户邮箱</th>
    			<th>注册时间</th>
    			<th>客户姓名</th>
    			<th>固定电话</th>
    			<th>移动电话</th>
    			<th>客户地址</th>
    		</tr>
    		<c:choose>
    			<c:when test="${not empty requestScope.cList }">
    				<c:forEach items="${requestScope.cList}" var="customer">
    					<tr>
    						<td>${customer.id }</td>
    						<td>${customer.email }</td>
    						<td>${customer.registerTime }</td>
    						<td>
    							<c:choose>
    								<c:when test="${customer.name == null}">
	    								尚未填写
	    							</c:when>
	    							<c:otherwise>
	    								${customer.name }
	    							</c:otherwise>
    							</c:choose>
    						</td>
    						<td>
    							<c:choose>
    								<c:when test="${customer.telphone == null}">
	    								尚未填写
	    							</c:when>
	    							<c:otherwise>
	    								${customer.telphone }
	    							</c:otherwise>
    							</c:choose>
    						</td>
    						<td>
								<c:choose>
    								<c:when test="${customer.movePhone == null}">
	    								尚未填写
	    							</c:when>
	    							<c:otherwise>
	    								${customer.movePhone }
	    							</c:otherwise>
    							</c:choose>
							</td>
    						<td>
    							<c:choose>
    								<c:when test="${customer.address == null}">
	    								尚未填写
	    							</c:when>
	    							<c:otherwise>
	    								${customer.address }
	    							</c:otherwise>
    							</c:choose>
    						</td>
    					</tr>
    				</c:forEach>
    			</c:when>
    			<c:otherwise>
    				<tr>
    					<td colspan="8">
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
