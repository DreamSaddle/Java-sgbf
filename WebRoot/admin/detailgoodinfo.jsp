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
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/admin/css/admin_customerdetail.css">

  </head>
  
  <body>
    <div id="detail_top">
  		<a href="goodsInfoPageBeanServlet?op=querygoods" target="right">
  			<img alt="home" src="${pageContext.request.contextPath }/admin/images/home.png">
  		</a>
  		<strong>您现在所在的位置是：<span id="now_page">商品<u style="color:#EC557D">${requestScope.good.goodsName }</u>详细信息查看页面</span></strong>
  	</div>
  	  <table id="goodAdd_table">
  		<tr>
  			<td class="title_td">商品类型：</td>
  			<td>
  				<input class="input_txt_readyonly" disabled="true" value="${requestScope.good.type.typeName }" type="text" name="goodType" />
  			</td>
  		</tr>
  		<tr>
  			<td class="title_td">商品名称：</td>
  			<td>
  				<input class="input_txt_readyonly" disabled="true" value="${requestScope.good.goodsName }" type="text" name="goodName" />
  			</td>
  		</tr>
  		<tr>
  			<td class="title_td">商品价格：</td>
  			<td>
  				<input class="input_txt_readyonly" disabled="true" value="${requestScope.good.price }" type="text" name="goodPrice" />
  			</td>
  		</tr>
  		<tr>
  			<td class="title_td">商品折扣：</td>
  			<td>
  				<input class="input_txt_readyonly" disabled="true" value="${requestScope.good.discount }" type="text" name="goodDiscount" />
  			</td>
  		</tr>
  		<tr>
  			<td class="title_td">是否新品：</td>
  			<td>
  				<c:choose>
					<c:when test="${requestScope.good.isNew == 0}">
						<input class="input_txt_readyonly" disabled="true" value="是" type="text" name="isNew" />
					</c:when>
					<c:otherwise>
						<input class="input_txt_readyonly" disabled="true" value="否" type="text" name="isNew" />
					</c:otherwise>
				</c:choose>
  			</td>
  		</tr>
  		<tr>
  			<td class="title_td">是否推荐：</td>
  			<td>
  				<c:choose>
					<c:when test="${requestScope.good.isRecommend == 0}">
						<input class="input_txt_readyonly" disabled="true" value="是" type="text" name="isRecomment" />
					</c:when>
					<c:otherwise>
						<input class="input_txt_readyonly" disabled="true" value="否" type="text" name="isRecomment" />
					</c:otherwise>
				</c:choose>
  			</td>
  		</tr>
  		<tr>
  			<td class="title_td">商品状态：</td>
  			<td>
  				<c:choose>
					<c:when test="${requestScope.good.STATUS == 0}">
						<input class="input_txt_readyonly" disabled="true" value="上架" type="text" name="status" />
					</c:when>
					<c:otherwise>
						<input class="input_txt_readyonly" disabled="true" value="下架" type="text" name="status" />
					</c:otherwise>
				</c:choose>
  			</td>
  		</tr>
  		<tr>
  			<td class="title_td">商品图片：</td>
  			<td>
  				<img style="width:40px; height:40px;" src="${pageContext.request.contextPath }/reception/images/${requestScope.good.photo }" />
  			</td>
  		</tr>
  		<tr>
  			<td class="title_td">商品备注：</td>
  			<td>
  				<input class="input_txt_readyonly" disabled="true" value="${requestScope.good.remark }" type="text" name="remark" />
  			</td>
  		</tr>
  		<tr>
  			<td colspan="2">
  				<button id="input_sub" type="button" onclick="javascript:history.go(-1)">返回</button>
  			</td>
  		</tr>
  	  </table>
  </body>
</html>
