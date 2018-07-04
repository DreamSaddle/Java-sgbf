<%@page import="sgbf.dao.CustomerInfoDao"%>
<%@page import="sgbf.entity.CustomerInfo"%>
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
    
    <title>购买</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
		* {margin: auto;}
		#address {
			width: 950px;
			margin-top: 40px;
		}
		.queren {
			color: gray;
			font-size: 16px;
			font-weight: 900;
		}
		#order {
			width: 950px;
			margin-top: 100px;
		}
		h3 {
			color: gray;
		}
		table {
			width: 950px;
		}
		table tr {
			width: 100%;
			height: 50px;
			color: green;
		}
		table tr td {
			text-align: center;
			color: green;
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
			width: 75px;
			height: 20px;
			line-height: 20px;
			border: 0px;
			color: green;
			
		}
		#clearing:hover {
			cursor: pointer;
		}
		#sum {
			color: red;
			font-weight: 800;
		}
	</style>
	<script type="text/javascript" src="${pageContext.request.contextPath }/reception/js/jquery-1.4.2.js"></script>
  </head>
  
  <body>
    <div id="address">
    	<span class="queren">确认收货地址</span>
    	<span style="float: right; font-size: 12px;"><a href="#">管理收货地址</a></span>
    	<hr />
    	<input type="radio" value="${requestScope.loginCustomer.address }" name="addr" onchange="changeAddr(this)" />${requestScope.loginCustomer.address }
    	<br />
    	<input type="radio" value=" 湖北省 恩施土家族苗族自治州 恩施市 湖北民族学院（信息工程学院）" name="addr" onchange="changeAddr(this)" /> 湖北省 恩施土家族苗族自治州 恩施市 湖北民族学院（信息工程学院）
    	<br />
    	<input type="radio" value="重庆市沙坪坝区西永镇西科公寓" name="addr" onchange="changeAddr(this)" />重庆市沙坪坝区西永镇西科公寓
    	
    	<script type="text/javascript">
    		function changeAddr(t) {
    			document.getElementById("shdz").innerHTML = t.value;
    		}
    	</script>
    </div>
    <div id="order">
    	<h3>确认订单信息</h3>
    	<table>
        <c:choose>
          <c:when test="${not empty sessionScope.ordergoodsMap}">
          	<tr>
	          <th>名称</th>
	          <th>价格</th>
	          <th>数量</th>
	          <th>小计</th>
	          <th>图片</th>
	        </tr>
            <c:forEach items="${sessionScope.ordergoodsMap}" var="good_">
              <tr>
                <td class="car_info_td">
                	<a href="${pageContext.request.contextPath }/reception/gooddetail.jsp?goodId=${good_.key.goodsId}" target="index_frame_middle">${good_.key.goodsName}</a>
                </td>
                <%--单价 --%>
                <td class="car_info_td">
                	<span id="price${good_.key.goodsId }">${good_.key.price}</span>
                </td>
                <%--数量 --%>
                <td class="car_info_td">
					${good_.value }
                </td>
                <%--小计 --%>
                <td class="car_info_td">
                	<span id="sub${good_.key.goodsId }" class="xiaoji">${good_.value * good_.key.price }</span>
                </td>
                <td class="car_info_td"><img class="goods_img" src="${pageContext.request.contextPath }/reception/images/${good_.key.photo }" /></td>
              </tr>
            </c:forEach>
            <tr>
            	<td colspan="5" style="text-align: right; color: gray; border-bottom: 2px solid orange;">
            		收货人：${requestScope.loginCustomer.name }<br />
            		电话：${requestScope.loginCustomer.movePhone }<br />
            		寄送至：<span id="shdz">${requestScope.loginCustomer.address }</span><br />
            	</td>
            </tr>
            <tr>
            	<td colspan="5" style="text-align: right;">
            	合计￥
            	<span id="sum">${requestScope.sum }</span>
            	<a href="orderDetailInfoServlet?op=buynow" id="clearing" onclick="jiesuan()">立即购买</a>
            	</td>
            </tr>
            <tr>
            	<td colspan="5" style="text-align: right;"><a href="reception/buycar.jsp">返回购物车</a></td>
            </tr>
          </c:when>
          <c:otherwise>
            <tr>
              <td colspan="5" style="height: 200px; line-height: 200px; color: darkgray;">购物车中还没有商品哦，<a href="index.jsp">去逛逛</a></td>
            </tr>
          </c:otherwise>
        </c:choose>
       </table>
    </div>
  </body>
</html>
