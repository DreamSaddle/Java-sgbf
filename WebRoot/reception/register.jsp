<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>用户注册</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/reception/css/login_reg.css">
	<script type="text/javascript" src="${pageContext.request.contextPath }/reception/js/jquery-1.4.2.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/reception/js/loginorreg.js"></script>
  </head>
  
  <body>
    <div id="reg">
    	<form action="customerInfoServlet" method="post" onsubmit="return isRegisterOk()">
    		<input type="hidden" name="op" value="addcustomer" />
	    	<div style="width: 360px; border: 1px solid gray; margin-top: 150px; background-color: #E6E6E6;">
    			<div class="option_div">
	    			<span>用 户 名：</span>
	    			<input type="text" name="email" id="email" onblur="verifyEmail('reg')" class="txt" onfocus="noneErrorMsg()" />
	    		</div>
	    		<div class="option_div">
	    			<span>密&emsp;&nbsp;&nbsp;码：</span>
	    			<input type="password" name="pwd" id="pwd" class="txt" />
	    		</div>
	    		<div class="option_div">
	    			<span>确认密码：</span>
	    			<input type="password" id="pwdok" onblur="varifyPwdOk()" class="txt" />
	    		</div>
	    		<div class="option_div">
	    			<span>验 证 码：</span>
	    			<input type="text" name="yzm" id="yzm" onblur="verifyRegisterVerifyCode()" onfocus="document.getElementById('error_msg').innerHTML = ''" />
	    			<a href="javascript:getRegisterVerifyCode()" id="reg_getcode" onmouseover="isGetVerifyCodeAgain()">获取验证码</a>
	    			<span style="font-size: 12px; color: green; cursor: no-drop;" id="yzm_djs"></span>
	    			<span style="font-size: 12px; color: red; float: right; margin-right: 70px;" id="error_msg"></span>
	    		</div>
	    		<div class="option_div">
	    			<input id="sub" type="submit" value="注册" />
	    			<a id="index" class="login_a" href="${pageContext.request.contextPath }/index.jsp">返回首页</a>
	    			<a id="register" class="login_a" href="${pageContext.request.contextPath }/reception/login.jsp">已有账号?</a>
	    		</div>
	    	</div>
    	</form>
    </div>
  </body>
</html>
