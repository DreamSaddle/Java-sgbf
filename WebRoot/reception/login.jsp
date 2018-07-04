<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>用户登录</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/reception/css/login_reg.css">
	<script type="text/javascript" src="${pageContext.request.contextPath }/reception/js/loginorreg.js"></script>
  </head>
  
  <body>
    <div id="reg">
    	<form action="customerInfoServlet" method="post" onsubmit="return isLoginOk()">
    		<input type="hidden" name="op" value="customerlogin" />
	    	<div style="width: 360px; border: 1px solid gray; margin-top: 150px; background-color: #E6E6E6;">
	    		<div class="option_div">
	    			<span>用户名：</span>
	    			<input type="text" name="email" id="email" onblur="verifyEmail('login')" class="txt" />
	    		</div>
	    		<div class="option_div">
	    			<span>密&emsp;码：</span>
	    			<input type="password" name="pwd" id="pwd" onblur="verifyPwd()" class="txt" />
	    		</div>
	    		<div class="option_div">
	    			<span>验证码：</span>
	    			<input type="text" name="yzm" id="yzm" onblur="verifyLoginVerifyCode()" onfocus="document.getElementById('error_msg').style.display = 'none'" />
	    			<a href="javascript:change()"><img id="verifycodeimg" src="customerInfoServlet?op=getloginverifycode" /></a>
	    			<span style="font-size: 12px; color: red; display: none; float: right; margin-right: 100px;" id="error_msg">验证码错误</span>
	    		</div>
	    		<div class="option_div">
	    			<input id="sub" type="submit" value="登录" />
	    			<a id="index" class="login_a" href="${pageContext.request.contextPath }/index.jsp">返回首页</a>
	    			<a id="register" class="login_a" href="${pageContext.request.contextPath }/reception/register.jsp">还没有账号?</a>
	    		</div>
	    	</div>
    	</form>
    </div>
  </body>
</html>
