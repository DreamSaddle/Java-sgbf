<%@page import="sgbf.dao.BulletinInfoDao"%>
<%@page import="sgbf.entity.BulletinInfo"%>
<%@page import="sgbf.entity.GoodsInfo"%>
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
    
    <title>最新资讯</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/reception/css/gsrm.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/reception/css/news.css">
	<script type="text/javascript" src="${pageContext.request.contextPath }/reception/js/jquery-1.4.2.js"></script>
  </head>
  
  <body>
  	<%
  		ArrayList<BulletinInfo> bList = new BulletinInfoDao().getAllBulletinsList();
  		request.setAttribute("bList", bList);
  	%>
  	
    <div id="banner">
    	
    </div>
    <div id="news_con">
    	<c:choose>
    		<c:when test="${not empty requestScope.bList }">
    			<div>
    				<c:forEach items="${requestScope.bList }" var="bulletin">
    					<div class="news_ones">
    						<%--时间部分 --%>
    						<div class="news_ones_time">
    							<span class="fulldate">${bulletin.createTime }</span>
    							<span ></span>
    						</div>
    						<%--内容部分 --%>
    						<div class="news_ones_con">
    							<span>${bulletin.title }</span>
    							<span>${bulletin.content }</span>
    						</div>
    					</div>
    				</c:forEach>
    			</div>
    		</c:when>
    		<c:otherwise>
    			<div class="news_ones">
    				NOT DATA
    			</div>
    		</c:otherwise>
    	</c:choose>
    </div>
    <script type="text/javascript" src="${pageContext.request.contextPath }/reception/js/news.js"></script>
  </body>
</html>
