<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>联系我们</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/reception/css/gsrm.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/reception/css/lxwm.css">
  </head>
  
  <body>
    <div id="banner">
    	
    </div>
    <div id="middle_con">
    	<div id="left_img">
    		<img src="${pageContext.request.contextPath }/reception/images/tou-1.png" />
    	</div>
    	<div id="right_con">
    		<p id="con_title">向越来越多的人提供最好吃的水果</p>
    		<p>
    			<span>
					FRESH蔬果（集团）有限公司以蔬果、水果、粮油、肉类、冻品、水产、南北干货以及花卉等农产品批发市场经营管理、生鲜配送为主力业态。
	    		</span>
    		</p>
    		<p>
    			<span>
	    			用毕生精力致力于水果产业链和水果专营连锁业态的发展，为消费者提供最好吃的水果。开拓创新立宏愿，决心“一生只做一件事，一心一意做水果”。
	    		</span>
    		</p>
    	</div>
    </div>
    <p id="tishi">
   		*如有合作需要，请填写以下表单，我们将尽快给您回复，并为您提供最真诚的服务，谢谢您的支持。 
   	</p>
   	<div id="lx_form">
   		<form>
   			<p>姓名</p>
   			<input class="txt" type="text" name="name" placeholder="请输入真实姓名" />
   			<span>*</span>
   			<p>电话</p>
   			<input class="txt" type="text" name="name" placeholder="请输入真实电话" />
   			<span>*</span>
   			<p>联系时间</p>
   			<select>
   				<option value="" style="display:none;">请选择</option>
   				<option value="工作日">工作日</option>
   				<option value="周末">周末</option>
   				<option value="随时">随时</option>
   			</select>
   			<p>留言内容</p>
   			<textarea></textarea>
   			<span>*</span>
   			<p>购买方式</p>
   			<input type="radio" value="批发" name="gmfs" />批发
   			<input id="radio2" type="radio" value="零售" name="gmfs" />零售
   			<br /><br />
   			<input type="submit" value="提交" id="sub" />
   		</form>
   	</div>
  </body>
</html>
