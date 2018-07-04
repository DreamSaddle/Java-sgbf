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
    
    <title>商品详细信息</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/reception/css/goodsdetail.css">
	<script type="text/javascript" src="${pageContext.request.contextPath }/reception/js/jquery-1.4.2.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/reception/js/gooddetail.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/reception/js/iframe.setting.js"></script>
  </head>
  
  <body>
  <%
  	int goodId = Integer.parseInt(request.getParameter("goodId"));
  	GoodsInfo good = new GoodsInfoDao().getGoodByGoodId(goodId);
  	request.setAttribute("good", good);
  %>
    <div id="good_info">
    	<div id="good_info_img">
    		<div id="good_info_img_con">
    			<img src="${pageContext.request.contextPath }/reception/images/${good.photo }" />
    		</div>
    	</div>
    	<div id="good_info_word">
    		<h2>${good.goodsName }</h2>
    		<div class="good_con">
    			<span id="title">价格：</span>
    			<span id="val">￥${good.price }</span>
    		</div>
    		<br /><br /><br /><br />
    		<div class="good_con">
    			<span>评论：1条</span>
    			<span>|</span>
    			<span>收藏：1</span>
    		</div>
    		<br /><br /><br /><br />
    		<div id="buy_num">
    			<div id="buy_num_enter">
    				<span>购买数量：</span>
    				<input type="text" name="buynum" id="buynum" value="1" id="buynum" onblur="viaflyNum()"/>
    			</div>
    			<div id="changenum">
    				<div id="changetop">
    					<button onclick="changeNum(1)">▲</button>
    				</div>
    				<div id="changedown">
    					<button onclick="changeNum(0)">▼</button>
    				</div>
    			</div>
    		</div>
    		<div id="btns">
  				<div id="buy_car" onclick="addGoodToCar()">
  					<input type="hidden" value="${good.goodsId }" name="goodId" id="goodId" />
  					加入购物车
  				</div>
  				<div id="buy_now">
  					<a href="javascript:buyNow()" id="ljgm" target="_self">立即购买</a>
  					<%--用于验证是否登录 --%>
  					<input type="hidden" value="<%=request.getSession().getAttribute("name")==null ? 0:1 %>" id="js_hidden" />
  					<%--隐藏，用于立即购买表单提交 --%>
					<form action="orderInfoServlet" style="display: none;" name="form_addorder">
			       		<input type="hidden" name="op" value="addorder" />
			       		<input type="hidden" name="goodId" value="" id="hidden_goodIds" />
			       		<input type="hidden" name="num" value="" id="hidden_sum" />
			       		<input type="hidden" name="cz" value="addorderBybuynow" />
			       	</form>
  				</div>
     		</div>
    	</div>
    </div>
    <script type="text/javascript" src="${pageContext.request.contextPath }/reception/js/buycar.js"></script>
  </body>
</html>
