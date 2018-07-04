<%@page import="sgbf.util.BuyCar"%>
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
    
    <title>所有订单</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style type="text/css">
		* {margin: auto;}
		table {
			width: 1000px;
		}
		table tr {
			width: 100%;
			height: 50px;
		}
		table tr td {
			text-align: center;
		}
		.car_info_td {
			border-bottom: 2px dashed green;
		}
		img {
			width: 40px;
			height: 40px;
		}
		a {
			text-decoration: none;
			color: green;
		}
		.add_sub {
			width: 27px;
			line-height: 18px;
			text-align: center;
		}
		#clearing {
			width: 60px;
			height: 20px;
			line-height: 20px;
			border: 0px;
			color: green;
			
		}
		#clearing:hover {
			cursor: pointer;
		}
	</style>
	<script type="text/javascript" src="${pageContext.request.contextPath }/reception/js/jquery-1.4.2.js"></script>
  </head>
  
  <body>
    <table>
        <c:choose>
          <c:when test="${not empty requestScope.orders}">
          	<tr>
          	  <th>状态</th>
	          <th>名称</th>
	          <th>价格</th>
	          <th>数量</th>
	          <th>小计</th>
	          <th>图片</th>
	          <th>操作</th>
	        </tr>
            <c:forEach items="${requestScope.orders}" var="order_">
              <tr>
              	<td class="car_info_td">
              		<c:choose>
	              		<c:when test="${order_.order.status == 0 }">
	              			未确认
	              		</c:when>
	              		<c:otherwise>
	              			已确认
	              		</c:otherwise>
	              	</c:choose>
              	</td>
                <td class="car_info_td">${order_.good.goodsName}</td>
                <%--单价 --%>
                <td class="car_info_td">
                	<span id="price${good_.key }">${order_.good.price}</span>
                </td>
                <%--数量 --%>
                <td class="car_info_td">
                	${order_.quantity }
                </td>
                <%--小计 --%>
                <td class="car_info_td">
                	<span id="sub${order_.good.goodsId }" class="xiaoji">${order_.good.price * order_.quantity }</span>
                </td>
                <td class="car_info_td"><img class="goods_img" src="${pageContext.request.contextPath }/reception/images/${order_.good.photo }" /></td>
                <td class="car_info_td">
                	<c:if test="${order_.order.status == 0 }">
                		<a href="orderDetailInfoServlet?op=isaffrimorder&orderId=${order_.order.orderId }" class="qr" id="${order_.order.orderId }">确认订单</a>
                	</c:if>
                	<a href="#">删除</a>
                </td>
              </tr>
            </c:forEach>
            
            <tr>
            	<td colspan="7" style="text-align: right;"><a href="index.jsp">返回首页</a></td>
            </tr>
          </c:when>
          <c:otherwise>
            <tr>
              <td colspan="7" style="height: 200px; line-height: 200px; color: darkgray;">还没有订单哦，<a href="index.jsp">去逛逛</a></td>
            </tr>
          </c:otherwise>
        </c:choose>
       </table>
       <script type="text/javascript" src="${pageContext.request.contextPath }/reception/js/orders.js"></script>
  </body>
</html>
