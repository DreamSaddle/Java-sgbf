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
    
    <title>水果缤纷</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/reception/css/index_middle.css">
	<script type="text/javascript" src="${pageContext.request.contextPath }/reception/js/jquery-1.4.2.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/reception/js/iframe.setting.js"></script>
  </head>
  
  <body>
    <%
  		//获取销量前六商品集合
  		ArrayList<GoodsInfo> gListSex = new GoodsInfoDao().getSalesBeforeSexGoodsList();
  		request.setAttribute("gListSex", gListSex);
  		
  		//商品资讯数据
  		ArrayList<GoodsInfo> gListRandomSex = new GoodsInfoDao().getRandomSexGoodsList();
  		request.setAttribute("gRandomList", gListRandomSex);
  	%>
    <div id="banner">
    	
    </div>
    <%--广告三则 --%>
    <div id="ad">
    	<div id="ad_son">
    		<a href="#" target="_parent"><img src="${pageContext.request.contextPath }/reception/images/ban-1.jpg" /></a>
    		<a href="#" target="_parent"><img src="${pageContext.request.contextPath }/reception/images/ban-2.jpg" /></a>
    		<a href="#" target="_parent"><img src="${pageContext.request.contextPath }/reception/images/ban-3.jpg" /></a>
    	</div>
    </div>
    <%--果园推荐 --%>
    <div id="recommand">
    	<div id="recommand_title">
    		<span id="title_word">果园推荐</span>
    		<span id="title_eng">RECOMMAND</span>
    	</div>
    	<div id="recommand_context">
    		<div id="recommand_context_left">
    			<a href="#" target="_parent"><img src="${pageContext.request.contextPath }/reception/images/rc-1.jpg" /></a>
    		</div>
    		<div id="recommand_context_right">
    			<c:choose>
    				<c:when test="${not empty requestScope.gListSex }">
    					<c:forEach items="${requestScope.gListSex }" var="good">
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
    				</c:when>
    				<c:otherwise>
    					NOT DATA
    				</c:otherwise>
    			</c:choose>
    		</div>
    	</div>
    </div>
    <script type="text/javascript">
    	var dels = document.getElementsByTagName("del");
    	for(var i=0; i<dels.length; i++) {
    		dels[i].innerHTML = "￥" + parseFloat(dels[i].innerHTML).toFixed(2);
    	}
    </script>
    <%--中部图片植入 --%>
   	<div id="middle_img_two">
   		<img id="middle_img" src="${pageContext.request.contextPath }/reception/images/rb-1.jpg" />
   		<div id="middle_img_buttom">
   			<ul>
   				<li id="img_li1">1</li>
   				<li id="img_li2">2</li>
   			</ul>
   		</div>
   	</div>
   	<%--每日新品特卖 --%>
   	<div id="everyday_newgoods">
   		<div id="everyday_newgoods_title">
   			<span>———————</span>
   			<strong>每日新品特卖</strong>
   			<span>———————</span>
   			<p>新鲜水果每一天，健康生活每一刻 </p>
   		</div>
   		<div id="everyday_newgoods_context">
   			<div id="everyday_newgoods_context_left">
   				<p>有机生鲜</p>
   				<h2>天然无污染水果</h2>
   				<span id="enc_discount">6.8折</span><span id="enc_qi">起</span>
   				<div id="left_look">
   					<a href="#" target="_parent">查看详情 &gt;</a>
   				</div>
   			</div>
   			<div id="everyday_newgoods_context_right">
   				<a href="#" target="_parent">
   					<img id="middle_img" src="${pageContext.request.contextPath }/reception/images/nw-1.jpg" />
   				</a>
   			</div>
   		</div>
   	</div>
   	<%--新品特卖下四张广告图 --%>
   	<div id="enc_bottom_ad">
    	<div id="enc_bottom_ad_son">
    		<a href="#" target="_parent"><img src="${pageContext.request.contextPath }/reception/images/nw-2.jpg" /></a>
    		<a href="#" target="_parent"><img src="${pageContext.request.contextPath }/reception/images/nw-3.jpg" /></a>
    		<a href="#" target="_parent"><img src="${pageContext.request.contextPath }/reception/images/nw-4.jpg" /></a>
    		<a href="#" target="_parent"><img src="${pageContext.request.contextPath }/reception/images/nw-5.jpg" /></a>
    	</div>
    </div>
    <%--商品资讯 --%>
    <div id="goods_news">
    	<div id="news_title">
    		<span style="color:#84A970; font-size:16px; float:left;">蔬果资讯</span>
    		<span style="float:right;font-size:13px;">
    			<a href="#" target="_parent" style="text-decoration: none; color: black;">更多资讯</a>
    		</span>
    	</div>
    	<div id="news_con">
    		<div id="news_con_left">
	    		<div id="news_con_left_con">
	    			<table>
	    				<tr>
	    					<th>名称</th>
	    					<th>价格</th>
	    					<th>折扣</th>
	    					<th>新品</th>
	    				</tr>
	    				<c:choose>
	    					<c:when test="${not empty requestScope.gRandomList }">
	    						<c:forEach items="${requestScope.gRandomList }" var="gRandomList">
	    							<tr>
				    					<c:choose>
				    						<c:when test="${not empty gRandomList.goodsName }">
				    							<td>
				    								<a href="#" target="_parent">${gRandomList.goodsName }</a>
				    							</td>
				    						</c:when>
				    						<c:otherwise>
				    							<td>
				    								<a href="#" target="_parent">${gRandomList.goodsName }</a>
				    							</td>
				    						</c:otherwise>
				    					</c:choose>
				    					<td>${gRandomList.price }</td>
				    					<td>${gRandomList.discount }</td>
				    					<c:choose>
				    						<c:when test="${gRandomList.isNew == 0 }">
					    						<td>是</td>
					    					</c:when>
					    					<c:otherwise>
					    						<td>否</td>
					    					</c:otherwise>
				    					</c:choose>
				    				</tr>
	    						</c:forEach>
	    					</c:when>
	    					<c:otherwise>
	    						<tr>
	    							<td colspan="4">NOT DATA</td>
	    						</tr>
	    					</c:otherwise>
	    				</c:choose>
	    			</table>
	    		</div>
	    	</div>
	    	<div id="news_con_right">
	    		<img src="${pageContext.request.contextPath }/reception/images/fr-1.jpg" id="new_img" />
	    	</div>
    	</div>
    </div>
    <script type="text/javascript" src="${pageContext.request.contextPath }/reception/js/index_middle.js"></script>
  </body>
</html>
