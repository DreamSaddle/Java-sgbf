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
    
    <title>所有公告信息</title>
    
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
  		<strong>您现在所在的位置是：<span id="now_page">所有公告信息页面</span></strong>
  	</div>
  	<form action="bulletinInfoServlet" name="form_searchlike">
	  	<div id="detail_search">
	  		<span>标题名称：</span>
	  			<input type="hidden" name="currentPage" value="" id="hidden_p" />
	  			<input type="hidden" name="op" value="querybulletins" />
	  			<%
	  				String key = request.getParameter("p");
		  			if (key != null) {
	  					key = new String(key.getBytes("ISO-8859-1"), "UTF-8");
	  				}
	  			%>
	  			<input type="text" name="p" id="detail_search_txt" placeholder="根据标题/内容查询" value="<%=key==null?"":key %>" />
	  			<input type="submit" value="查询" id="detail_search_btn" />
	  		
	  		<div id="detail_search_button">
	  			<a href="${pageContext.request.contextPath }/admin/addbulletininfo.jsp" target="right">添加公告</a>
	  		</div>
	  	</div>
  	</form>
    <table id="show_table">
    	<tbody>
    		<tr>
    			<th>公告编号</th>
    			<th>公告标题</th>
    			<th>公告内容</th>
    			<th>发布人</th>
    			<th>发布时间</th>
    			<th>操作</th>
    		</tr>
    		<c:choose>
    			<c:when test="${not empty requestScope.pageBean.pageData }">
    				<c:forEach items="${requestScope.pageBean.pageData}" var="bulletin">
    					<tr>
    						<td>${bulletin.id }</td>
    						<td>${bulletin.title }</td>
    						<td>${bulletin.content }</td>
    						<td>${bulletin.admin.adminName }</td>
    						<td>${bulletin.createTime }</td>
    						<td>
    							<a href="bulletinInfoServlet?op=deletebulletinbyid&id=${bulletin.id }" title="删除"><img class="type_handimg" alt="del" src="${pageContext.request.contextPath }/admin/images/ooopic_1508847971.ico"></a>
    							<a href="bulletinInfoServlet?op=editbulletinbyid&id=${bulletin.id }" title="修改"><img class="type_handimg" alt="del" src="${pageContext.request.contextPath }/admin/images/ooopic_1508848001.ico"></a>
    							<a href="bulletinInfoServlet?op=detailbulletininfo&id=${bulletin.id }" title="详情"><img class="type_handimg" alt="del" src="${pageContext.request.contextPath }/admin/images/ooopic_1508847946.ico"></a>
    						</td>
    					</tr>
    				</c:forEach>
    			
    				<%--分页 --%>
    			  <tr id="paging">
    			  <form action="bulletinInfoServlet">
		            <td colspan="6" align="center">
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
		              		<input type="hidden" name="op" value="querybulletins" />
		              		跳转至：<input type="text" name="currentPage" id="pagejump_txt" />
		             		<input type="submit" value="Go" id="pagejump_btn" />
		            </td>
		            </form>
		          </tr>
    			</c:when>
    			<c:otherwise>
    				<tr>
    					<td colspan="6">
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
