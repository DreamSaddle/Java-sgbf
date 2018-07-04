<%@page import="sgbf.util.PageBean"%>
<%@page import="sgbf.dao.GoodsInfoPageDao"%>
<%@page import="sgbf.dao.GoodsInfoDao"%>
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
    
    <title>果蔬产品</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/reception/css/gsrm.css">
	<script type="text/javascript" src="${pageContext.request.contextPath }/reception/js/jquery-1.4.2.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath }/reception/js/iframe.setting.js"></script>
  </head>
  
  <body>
	 <%
	 	String op = (String) request.getParameter("op");
	 	
	 
	 	String start_ = (String) request.getParameter("currentPage");
	 	if (start_ == null || "".equals(start_.trim())) {
	 		start_ = "1";
	 	}
	 	int start = Integer.parseInt(start_);
	
	 	PageBean<GoodsInfo> pageBean = null;
	 	if ("gsrm".equals(op.trim())) {
	 		//销量靠前商品
		 	pageBean = new GoodsInfoPageDao().getSalesTopPageBean(start);
		 	pageBean.setCurrentPage(start);
	 	} else if ("allgoods".equals(op.trim())) {
	 		//全部商品
		 	pageBean = new GoodsInfoPageDao().getPageBean(start, "");
		 	pageBean.setCurrentPage(start);	
	 	}
	 	
	 	request.setAttribute("pageBean", pageBean);
	 %>
	 <c:set var="op" value="<%=op %>"></c:set>
	<div id="banner">
    	
    </div>
    <div id="gsrm_con">
    	<div id="gsrm_con_left">
    		<div id="gsrm_con_left_con">
    			<div id="left_con_up">
    				<div class="left_con_first">
	    				产品分类
	    			</div>
	    			<div class="left_con_con">
	    				<a href="#" target="_parent">国产水果</a>
	    			</div>
	    			<div class="left_con_con">
	    				<a href="#" target="_parent">进口水果</a>
	    			</div>
	    			<div class="left_con_con">
	    				<a href="#" target="_parent">新鲜时蔬</a>
	    			</div>
    			</div>
    			<div id="left_con_down">
    				<div class="left_con_first">
	    				在线客服
	    			</div>
	    			<div class="left_con_con" id="left_con_con_kf">
	    				<img src="${pageContext.request.contextPath }/reception/images/qq.gif" /><a href="#" target="_parent">蜜桃</a>
	    				<img src="${pageContext.request.contextPath }/reception/images/qq.gif" /><a href="#" target="_parent">芒果</a>
	    			</div>
	    			<div class="left_con_con" id="left_con_con_clock">
	    				<img src="${pageContext.request.contextPath }/reception/images/serviceOnlineTime1.png" /><span>工作时间</span>
	    				<p>周一至周五&nbsp;:8:30-17:30</p>
	    				<p>周六至周日&nbsp;:9:00-17:00</p>
	    			</div>
    			</div>
    		</div>
    	</div>
    	<div id="gsrm_con_right">
    		<c:choose>
   				<c:when test="${not empty requestScope.pageBean }">
   				<div id="gsrm_con_right_up">
   					<c:forEach items="${requestScope.pageBean.pageData }" var="good">
   						<div class="salestopsex">
   							<div class="salestopsex_img">
   								<a href="${pageContext.request.contextPath }/reception/gooddetail.jsp?goodId=${good.goodsId}" target="index_frame_middle"><img src="${pageContext.request.contextPath }/reception/images/${good.photo }" /></a>
   							</div>
   							<div class="salestopsex_name">
   								<p>
   									<a href="${pageContext.request.contextPath }/reception/gooddetail.jsp?goodId=${good.goodsId}" target="index_frame_middle" class="goodsname">${good.goodsName }</a>
   								</p>
   							</div>
   							<p class="salestopsex_price">
   								<span class="salestopsex_nowprice">￥${good.price }</span>
   								<del class="salestopsex_oldprice">${good.price / good.discount * 10}</del>
   							</p>
   							<div class="salestopsex_buy">
   								<a href="${pageContext.request.contextPath }/reception/gooddetail.jsp?goodId=${good.goodsId}" target="index_frame_middle">购 买</a>
   							</div>
   						</div>
   					</c:forEach>
   					</div>
   					<script type="text/javascript">
					  	var dels = document.getElementsByTagName("del");
					  	for(var i=0; i<dels.length; i++) {
					  		dels[i].innerHTML = "￥" + parseFloat(dels[i].innerHTML).toFixed(2);
					  	}
					  </script>
   					<form action="${pageContext.request.contextPath }/reception/gsrm.jsp">
   					<div id="paging">
			          	    当前${requestScope.pageBean.currentPage }/共${requestScope.pageBean.totalPage }页     &nbsp;&nbsp;
			              <c:if test="${requestScope.pageBean.currentPage > 1}">
			              	<a href="${pageContext.request.contextPath }/reception/gsrm.jsp?currentPage=1&op=${op}">首页</a>
			                <a href="${pageContext.request.contextPath }/reception/gsrm.jsp?currentPage=${requestScope.pageBean.currentPage-1}&op=${op}">上一页 </a>
			              </c:if>
			              
			              <c:if test="${requestScope.pageBean.currentPage < requestScope.pageBean.totalPage}">
			                <a href="${pageContext.request.contextPath }/reception/gsrm.jsp?currentPage=${requestScope.pageBean.currentPage+1}&op=${op}">下一页 </a>
							<a href="${pageContext.request.contextPath }/reception/gsrm.jsp?currentPage=${requestScope.pageBean.totalPage}&op=${op}">末页</a>
			              </c:if>
	              		跳转至：<input type="text" name="currentPage" id="pagejump_txt" />
	             			<input type="hidden" name="op" value="${op }" />
	             		<input type="submit" value="Go" id="pagejump_btn" />
   					</div>
   					</form>
   				 </c:when>
   				<c:otherwise>
   					NOT DATA
   				</c:otherwise>
   			</c:choose>
    	</div>
    </div>
  </body>
</html>
