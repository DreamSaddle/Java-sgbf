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
    
    <title>所有订单信息</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/admin_customerdetail.css">
	<script type="text/javascript" src="${pageContext.request.contextPath }/admin/js/jquery-1.4.2.js"></script>

	<script type="text/javascript">
		function toPage(p) {
			document.getElementById("hidden_p").value = p;
			window.form_searchlike.submit();
		}
	</script>
  </head>
  
  <body>
    <div id="detail_top">
  		<a href="${pageContext.request.contextPath }/admin.jsp" target="_parent">
  			<img alt="home" src="${pageContext.request.contextPath }/admin/images/home.png">
  		</a>
  		<strong>您现在所在的位置是：<span id="now_page">所有订单信息页面</span></strong>
  	</div>
  	<form action="orderDetailInfoServlet" name="form_searchlike">
	  	<div id="detail_search">
	  		<span>订单名称：</span>
	  			<input type="hidden" name="currentPage" value="" id="hidden_p" />
	  			<%
	  				String key = request.getParameter("p"); 
		  			if (key != null) {
	  					key = new String(key.getBytes("ISO-8859-1"), "UTF-8");
	  				}
	  			%>
	  			<input type="hidden" name="op" value="queryorderdetails" />
	  			<input type="text" name="p" id="detail_search_txt" placeholder="根据客户名称/地址查询" value="<%=key==null?"":key %>" />
	  			<input type="submit" value="查询" id="detail_search_btn" />
	  		
	  		<div id="detail_search_button">
	  			<a href="orderDetailInfoServlet?op=preaddgood" target="right">预留按钮</a>
	  		</div>
	  	</div>
  	</form>
    <table id="show_table">
    	<tbody>
    		<tr>
    			<th>订单编号</th>
    			<th>客户名称</th>
    			<th>客户电话</th>
    			<th>客户地址</th>
    			<th>商品名称</th>
    			<th>购买数量</th>
    			<th>单价</th>
    			<th>小计</th>
    			<th>订单状态</th>
    			<th>下单时间</th>
    			<th>操作</th>
    		</tr>
    		<c:choose>
    			<c:when test="${not empty requestScope.pageBean.pageData }">
    				<c:forEach items="${requestScope.pageBean.pageData}" var="order_">
    					<tr>
    						<td>${order_.order.orderId }</td>
    						<td>${order_.order.customer.name }</td>
    						<td>${order_.order.customer.movePhone }</td>
    						<td>${order_.order.customer.address }</td>
    						<td>${order_.good.goodsName }</td>
    						<td>${order_.quantity }</td>
    						<td>￥${order_.good.price }</td>
    						<td class="admin_orders_xiaoji">${order_.quantity * order_.good.price }</td>
    						<td>
    							<c:choose>
    								<c:when test="${order_.order.status  == 0}">
    									未确认
    								</c:when>
    								<c:otherwise>
    									已确认
    								</c:otherwise>
    							</c:choose>
    						</td>
    						<td>${order_.order.orderTime }</td>
    						<td>
    							<a href="orderDetailInfoServlet?op=deletegoodbyid&id=${order_.order.orderId }" title="删除"><img class="type_handimg" alt="del" src="${pageContext.request.contextPath }/admin/images/ooopic_1508847971.ico"></a>
    							<a href="orderDetailInfoServlet?op=editgoodbyid&id=${order_.order.orderId }" title="修改"><img class="type_handimg" alt="del" src="${pageContext.request.contextPath }/admin/images/ooopic_1508848001.ico"></a>
    							<a href="orderDetailInfoServlet?op=detailgoodinfo&id=${order_.order.orderId }" title="详情"><img class="type_handimg" alt="del" src="${pageContext.request.contextPath }/admin/images/ooopic_1508847946.ico"></a>
    						</td>
    					</tr>
    				</c:forEach>
    			
    				<%--分页 --%>
    			  <tr id="paging">
    			  <form action="orderDetailInfoServlet">
		            <td colspan="10" align="center">
		          	    当前${requestScope.pageBean.currentPage }/共${requestScope.pageBean.totalPage }页     &nbsp;&nbsp;
		              <c:if test="${requestScope.pageBean.currentPage > 1}">
		              	<a href="javascript:toPage(1)">首页</a>
		                <a href="javascript:toPage(${requestScope.pageBean.currentPage-1})">上一页 </a>
		              </c:if>
		              
		              <c:if test="${requestScope.pageBean.currentPage < requestScope.pageBean.totalPage}">
		                <a href="javascript:toPage(${requestScope.pageBean.currentPage+1})">下一页 </a>
						<a href="javascript:toPage(${requestScope.pageBean.totalPage})">末页</a>
		              </c:if>
		              		<input type="hidden" name="p" value="<%=key==null?"":key %>" id="hidden_p" />
		              		跳转至：<input type="text" name="currentPage" id="pagejump_txt" />
		             		<input type="hidden" name="op" value="queryorderdetails" />
		             		<input type="submit" value="Go" id="pagejump_btn" />
		            </td>
		            </form>
		          </tr>
    			</c:when>
    			<c:otherwise>
    				<tr>
    					<td colspan="10">
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
