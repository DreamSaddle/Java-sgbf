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
    
    <title>水果缤纷</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/reception/css/index.css">
  	<script type="text/javascript" src="${pageContext.request.contextPath }/reception/js/jquery-1.4.2.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath }/reception/js/iframe.setting.js"></script>
  </head>
  
  <body>
  	<%--首页框架顶部 --%>
  	<div id="index_frame_top">
  		<div id="header_context">
  			<a href="${pageContext.request.contextPath }/index.jsp" target="_parent"><img alt="logo" src="${pageContext.request.contextPath }/reception/images/logo_2.png" id="logo" /></a>
  			<div id="header_ul_a">
  				<ul>
  					<li>
  						<a href="${pageContext.request.contextPath }/index.jsp" target="_parent">首页</a>
  					</li>
  					<li>
  						<a href="${pageContext.request.contextPath }/reception/gsrm.jsp?op=gsrm" target="index_frame_middle">蔬果热卖</a>
  					</li>
  					<li>
  						<a href="${pageContext.request.contextPath }/reception/gsrm.jsp?op=allgoods" target="index_frame_middle">全部产品</a>
  					</li>
  					<li>
  						<a href="${pageContext.request.contextPath }/reception/news.jsp" target="index_frame_middle" >最新资讯</a>
  					</li>
  					<li>
  						<a href="${pageContext.request.contextPath }/reception/lxwm.jsp" target="index_frame_middle">联系我们</a>
  					</li>
  				</ul>
  			</div>
  			<div id="header_customer">
  				<c:choose>
  					<c:when test="${not empty sessionScope.name }">
  						<span id="customer_info">
  							欢迎登录,
  							${sessionScope.name }
  							<a href="customerInfoServlet?op=exit">注销</a>
  						</span>
  					</c:when>
  					<c:otherwise>
  						<span id="customer_info">
		  					<a href="${pageContext.request.contextPath }/reception/login.jsp">登录</a>
		  					/
		  					<a href="${pageContext.request.contextPath }/reception/register.jsp">注册</a>
		  				</span>
  					</c:otherwise>
  				</c:choose>
  				<div id="customer_self_info">
  					<ul>
  						<li><a href="orderDetailInfoServlet?op=getcustomerallorders">我的订单(<span id="my_order_num" style="color: red;">0</span>)</a></li>
  						<li><a href="#">收货地址</a></li>
  						<li><a href="#">基本信息</a></li>
  						<li><a href="customerInfoServlet?op=getcustomerbyid">完善信息</a></li>
  						<li><a href="#">意见反馈</a></li>
  					</ul>
  				</div>
  			</div>
  			<div id="header_buycar">
  				<span>
  					<a href="${pageContext.request.contextPath }/reception/buycar.jsp" target="_parent" style="text-decoration: none; color: green;">
  						我的购物车
  					</a>
  					<span id="mycarnum" style="color:red;">
  						<c:choose>
  							<c:when test="${not empty sessionScope.buycar }">
  								${sessionScope.buycar.mapSize }
  							</c:when>
  							<c:otherwise>
  								0
  							</c:otherwise>
  						</c:choose>
  					</span>
  				</span>
  		</div>
  	  </div>
  	</div>
  	
  	<iframe onload="setIframeHeight();" scrolling="no" width="100%" src="${pageContext.request.contextPath }/reception/index_middle.jsp" frameborder="0" id="middle_frame" class="middle_frame" name="index_frame_middle"></iframe>
  	
  	<div id="index_frame_bottom">
  		<img src="${pageContext.request.contextPath }/reception/images/fot-1.jpg" id="bottom_img" />
  		<div id="bottom_context">
  			<div class="bottom_context_selfContext">
  				<h3>服务保障</h3>
  				<p><a href=#>正品保证</a></p>
  				<p><a href=#>7天无理由退换</a></p>
  				<p><a href=#>退货返运费</a></p>
  				<p><a href=#>7×15小时客户服务</a></p>
  			</div>
  			<div class="bottom_context_selfContext">
  				<h3>支付方式</h3>
  				<p><a href=#>公司转账</a></p>
  				<p><a href=#>货到付款</a></p>
  				<p><a href=#>在线支付</a></p>
  				<p><a href=#>分期付款</a></p>
  			</div>
  			<div class="bottom_context_selfContext">
  				<h3>商家服务</h3>
  				<p><a href=#>商家入驻</a></p>
  				<p><a href=#>培训中心</a></p>
  				<p><a href=#>广告服务</a></p>
  				<p><a href=#>服务市场</a></p>
  			</div>
  			<div class="bottom_context_selfContext">
  				<h3>服务保障</h3>
  				<p><a href=#>免运费</a></p>
  				<p><a href=#>海外配送</a></p>
  				<p><a href=#>EMS</a></p>
  				<p><a href=#>211限时达</a></p>
  			</div>
  		</div>
  		<div id="bottom_copyright">
  			<p>&copy; taohan Copyright</p>
  			<p><a href="#">手机版</a>|本站使用 2018-6-18|<a href="${pageContext.request.contextPath }/admin.jsp" target="block">管理登录</a></p>
  		</div>
  	</div>
  	<script type="text/javascript" src="${pageContext.request.contextPath }/reception/js/index_customer.js"></script>
  </body>
</html>