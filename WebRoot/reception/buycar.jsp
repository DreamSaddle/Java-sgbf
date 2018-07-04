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
    
    <title>购物车</title>
    
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
	<script type="text/javascript" src="${pageContext.request.contextPath }/reception/js/buycar_show.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/reception/js/jquery-1.4.2.js"></script>
  </head>
  
  <body>
    <table>
        <c:choose>
          <c:when test="${not empty sessionScope.buycar.goodsMap}">
          	<tr>
	          <th><input type="checkbox" name="isAllChoose" onchange="allChooose()" /></th>
	          <th>名称</th>
	          <th>价格</th>
	          <th>数量</th>
	          <th>小计</th>
	          <th>图片</th>
	          <th>操作</th>
	        </tr>
            <c:forEach items="${sessionScope.buycar.goodsMap}" var="good_">
              <tr>
              	<td class="car_info_td"><input type="checkbox" name="isChooseSomeOne" value="${good_.key}" /></td>
                <td class="car_info_td">${good_.value.goodsName}</td>
                <%--单价 --%>
                <td class="car_info_td">
                	<span id="price${good_.key }">${good_.value.price}</span>
                </td>
                <%--数量 --%>
                <td class="car_info_td">
                	<input type="button" value="-" onclick="changeNumByText(1, ${good_.key })" class="add_sub" />
                	<input type="text" onfocus="getNumById(${good_.key })" onblur="changeNumByInput(${good_.key })" id="num${good_.key }" value="${good_.value.num }" style="width:38px; height:23px; text-align: center;" />
                	<input type="button" value="+" onclick="changeNumByText(0, ${good_.key })" class="add_sub" />
                </td>
                <%--小计 --%>
                <td class="car_info_td">
                	<span id="sub${good_.key }" class="xiaoji">${good_.value.num * good_.value.price }</span>
                </td>
                <td class="car_info_td"><img class="goods_img" src="${pageContext.request.contextPath }/reception/images/${good_.value.photo }" /></td>
                <td class="car_info_td">
                	<a href="buyCarServlet?op=delete2car&goodId=${good_.key }">删除</a>
                </td>
              </tr>
            </c:forEach>
            <tr>
            	<td colspan="7" style="text-align: right;">
            	合计￥
            	<span id="sum">0.00</span>
            	<button id="clearing" onclick="jiesuan()">下订单</button>
            	<input type="hidden" value="<%=request.getSession().getAttribute("name")==null ? 0:1 %>" id="js_hidden" />
            	<script type="text/javascript">
            		//鼠标移入结算按钮
            		var sum = document.getElementById("sum");
            		$("#clearing").mousemove(function() {
            			if(sum.innerHTML == "0.00" || parseInt(sum.innerHTML) == 0) {
                			$(this).css('cursor', 'no-drop');	
                		} else {
                			$(this).css('cursor', 'pointer');
                		}
            		});
            	</script>
            	</td>
            </tr>
            <tr>
            	<td colspan="7" style="text-align: right;"><a href="index.jsp">继续购物</a></td>
            </tr>
          </c:when>
          <c:otherwise>
            <tr>
              <td colspan="7" style="height: 200px; line-height: 200px; color: darkgray;">购物车中还没有商品哦，<a href="index.jsp">去逛逛</a></td>
            </tr>
          </c:otherwise>
        </c:choose>
       </table>
       <%--隐藏，用于提交订单 --%>
		<form action="orderInfoServlet" style="display: none;" name="form_addorder">
       		<input type="hidden" name="op" value="addorder" />
       		<input type="hidden" name="goodIds" value="" id="hidden_goodIds" />
       		<input type="hidden" name="sum" value="" id="hidden_sum" />
       		<input type="hidden" name="cz" value="addorderBybuycar" />
       	</form>
		<%--设置商品小计小数位数为2 --%>
       <script type="text/javascript">
       		var xj = $(".xiaoji");
       		for(var i=0; i<xj.length; i++) {
       			var num = new Number(parseFloat(xj[i].innerHTML));
       			xj[i].innerHTML = num.toFixed(2);
       		}
       </script>
  </body>
</html>
