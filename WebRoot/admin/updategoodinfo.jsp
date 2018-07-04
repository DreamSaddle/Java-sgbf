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
    
    <title>修改商品信息</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/admin_customerdetail.css">

  </head>
  
  <body>
    <div id="detail_top">
  		<a href="goodsInfoPageBeanServlet?op=querygoods" target="right">
  			<img alt="home" src="${pageContext.request.contextPath }/admin/images/home.png">
  		</a>
  		<strong>您现在所在的位置是：<span id="now_page">商品<u style="color:#EC557D">${requestScope.good.goodsName }</u>信息修改页面</span></strong>
  	</div>
  	<form action="goodsInfoServlet" method="post" enctype="multipart/form-data">
  	  <table id="goodAdd_table">
  	  	<input type="hidden" name="op" value="updategood" />
		<tr>
			<td class="title_td">商品编号：</td>
			<td>
				<input type="text" class="input_txt" disabled="true" value="${requestScope.good.goodsId }" />
			</td>
		</tr>
  		<tr>
  			<td class="title_td">商品类型：</td>
  			<td>
  				<select name="goodType">
					<%--第一个显示当前商品所属类型 --%>
					<option style="display: none;" value="${requestScope.good.type.typeId }" >${requestScope.good.type.typeName }</option>
					<c:choose>
	  					<c:when test="${not empty requestScope.types }">
	  						<c:forEach items="${requestScope.types }" var="type">
	  							<option name="${type.typeName }" value="${type.typeId }" />${type.typeName }
	  						</c:forEach>
	  					</c:when>
	  					<c:otherwise>
	  						<option/>没有类型
	  					</c:otherwise>
  					</c:choose>
  				</select>
  			</td>
  		</tr>
  		<tr>
  			<td class="title_td">商品名称：</td>
  			<td>
  				<input class="input_txt" value="${requestScope.good.goodsName }" type="text" name="goodName" placeholder="请输入商品名称" />
  			</td>
  		</tr>
  		<tr>
  			<td class="title_td">商品价格：</td>
  			<td>
  				<input class="input_txt" value="${requestScope.good.price }" type="text" name="goodPrice" placeholder="请输入商品价格" />
  			</td>
  		</tr>
  		<tr>
  			<td class="title_td">商品折扣：</td>
  			<td>
  				<input class="input_txt" value="${requestScope.good.discount }" type="text" name="goodDiscount" placeholder="请输入商品折扣" />
  			</td>
  		</tr>
  		<tr>
  			<td class="title_td">是否新品：</td>
  			<td>
  				<select name="isNew">
  					<option name="yes" value="0" />是
  					<option name="no" value="1" />否
  				</select>
  			</td>
  		</tr>
  		<tr>
  			<td class="title_td">是否推荐：</td>
  			<td>
  				<select name="isRecommed">
  					<option name="yes" value="0" />是
  					<option name="no" value="1" />否
  				</select>
  			</td>
  		</tr>
  		<tr>
  			<td class="title_td">商品状态：</td>
  			<td>
  				<select name="status">
  					<option name="sj" value="0" />上架
  					<option name="xj" value="1" />下架
  				</select>
  			</td>
  		</tr>
  		<tr>
  			<td class="title_td">商品图片：</td>
  			<td>
  				<input id="input_file" type="file" name="goodPhoto" />
  				${requestScope.msg }
  			</td>
  		</tr>
  		<tr>
  			<td class="title_td">商品备注：</td>
  			<td>
  				<textarea name="goodRemark" style="width: 400px;" placeholder="请输入商品备注">${requestScope.good.remark }</textarea>
  			</td>
  		</tr>
  		<input type="hidden" name="id" value="${requestScope.good.goodsId }" />
  		<input type="hidden" name="photo_before_name" value="${requestScope.good.photo }" />
  		<tr>
  			<td colspan="2">
  				<input id="input_sub" type="submit" value="修改" />
  			</td>
  		</tr>
  	  </table>
  	</form>
  </body>
</html>
