<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>完善信息</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style type="text/css">
		* {margin: auto;}
		table {
			width: 500px;
			height: 300px;
			margin-top: 20px;
		}
		.info_txt {
			width: 200px;
			height: 20px;
			line-height: 20px;
			border: 1px solid green;
		}
		textarea {
	 		width: 400px;
	 		border: 1px solid green;
		}
		#info_sub {
			width: 150px;
			height: 30px;
			line-height: 30px;
			text-align: center;
			margin-left: 86px;
			border: 0px;
			border-radius: 2px;
			background-color: green;
			color: white;
			cursor: pointer;
			font-size: 14px;
			font-family: 黑体;
			font-weight: 900;
		}
	</style>
  </head>
  
  <body>
    <form action="customerDetailInfoServlet" method="post">
    	<table>
    		<input type="hidden" value="isaddorupdatecustomerdetailinfo" name="op" />
	    	<tr>
	    		<td>收货人：</td>
	    		<td>
	    			<input class="info_txt" type="text" value="${requestScope.customer.name }" name="customername" />
	    		</td>
	    	</tr>
	    	<tr>
	    		<td>固定电话：</td>
	    		<td>
	    			<input class="info_txt" type="text" value="${requestScope.customer.telphone }" name="telphone" />
	    		</td>
	    	</tr>
	    	<tr>
	    		<td>移动电话：</td>
	    		<td>
	    			<input class="info_txt" type="text" value="${requestScope.customer.movePhone }" name="movephone" />
	    		</td>
	    	</tr>
	    	<tr>
	    		<td>收货地址：</td>
	    		<td>
	    			<textarea name="address">${requestScope.customer.address }</textarea>
	    		</td>
	    	</tr>
	    	<tr>
	    		<td colspan="2">
	    			<input id="info_sub" type="submit" value="提  交" />
	    		</td>
	    	</tr>
	    </table>
    </form>
  </body>
</html>
