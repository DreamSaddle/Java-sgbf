
//标识是否可以登录/注册
var emailflag = false;
var pwdflag = false;
var pwdokflag = true;
var codeflag = false;

function getXMLHttpRequest() {
	try {
		return new XMLHttpRequest();
	} catch(e) {
		try {
			return ActiveXObject("Msxml2.XMLHTTP");
		} catch(e) {
			try {
				return ActiveXObject("Microsoft.XMLHTTP");
			} catch(e) {
				alert("你的浏览器实在是太垃圾了");
				throw e;
			}
		}
	}
}

function verifyEmail(flag) {
	var emailEle = document.getElementById("email");
	if(emailEle.value.trim() == "") {
		return;
	}
	var xmlHttp = getXMLHttpRequest();
	xmlHttp.open("post", "customerInfoServlet", true);
	xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xmlHttp.send("op=verifyemail&email="+emailEle.value);
	xmlHttp.onreadystatechange = function() {
		if(xmlHttp.readyState == 4 && xmlHttp.status == 200) {
			var content = xmlHttp.responseText;

			//邮箱存在
			if(content.trim() == "exists") {
				var name_txt = document.getElementById("email");
				//注册
				if(flag == "reg") {
					name_txt.value = "";
					name_txt.placeholder="该邮箱已被注册";
					emailflag = false;
				} else {
					document.getElementById("email").placeholder="";
					emailflag = true;
				}
			} else {
				var name_txt = document.getElementById("email");
				if (flag == "login") {
					name_txt.value = "";
					name_txt.placeholder="用户名不存在";
					emailflag = false;
				} else {
					document.getElementById("email").placeholder="";
					emailflag = true;
				}
			}
		}
	};
}


function verifyPwd() {
	var emailEle = document.getElementById("email");
	var pwdEle = document.getElementById("pwd");
	if(emailEle.value.trim() == "" || pwdEle.value.trim() == "") {
		pwdEle.value = "";
		pwdEle.placeholder = "请先输入用户名";
		return;
	}
	var xmlHttp = getXMLHttpRequest();
	xmlHttp.open("post", "customerInfoServlet", true);
	xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xmlHttp.send("op=verifypwd&email="+emailEle.value+"&pwd="+pwdEle.value);
	xmlHttp.onreadystatechange = function() {
		if(xmlHttp.readyState == 4 && xmlHttp.status == 200) {
			var content = xmlHttp.responseText;

			if(content.trim() == "f") {
				var pwd_txt = document.getElementById("pwd");
				pwd_txt.value = "";
				pwd_txt.placeholder="密码错误";
				pwdflag = false;
			} else {
				document.getElementById("email").placeholder="";
				pwdflag = true;
			}
		}
	};
}


function varifyPwdOk() {
	var pwd = document.getElementById("pwd");
	var pwdok = document.getElementById("pwdok");
	if(pwd.value != pwdok.value) {
		pwdok.value = "";
		pwdok.placeholder = "两次密码不一致";
		pwdokflag = false;
	} else {
		pwdokflag = true;
	}
}

function noneErrorMsg() {
	var error_msg = document.getElementById("error_msg");
	//邮箱错误时，再次输入邮箱去除错误信息
	if("邮箱错误" == error_msg.innerHTML.trim()) {
		error_msg.innerHTML = "";
	}
}

/*-------------------------登录验证码---------------------*/
//点击图片刷新验证码
function change() {
	//浏览器存在缓存问题，所以后面加上时间区分
	document.getElementById("verifycodeimg").src = "customerInfoServlet?op=getloginverifycode&a="+ new Date().getTime();
}

//登录-验证验证码是否正确
function verifyLoginVerifyCode() {
	var yzm = document.getElementById("yzm");
	if (yzm.value == "" || yzm.value.trim() == "") {
		return;
	}
	var xmlHttp = getXMLHttpRequest();
	xmlHttp.open("post", "customerInfoServlet", true);
	xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xmlHttp.send("op=verifyloginverifycode&code="+yzm.value);
	xmlHttp.onreadystatechange = function() {
		if(xmlHttp.readyState == 4 && xmlHttp.status == 200) {
			var content = xmlHttp.responseText;

			if(content.trim() == "f") {
				yzm.value = "";
				document.getElementById("error_msg").style.display = "block";
				//刷新验证码
				document.getElementById("verifycodeimg").src = "customerInfoServlet?op=getloginverifycode&a="+ new Date().getTime();
				codeflag = false;
			} else {
				document.getElementById("error_msg").style.display = "none";
				codeflag = true;
			}
		}
	};
}
/*-------------------------end---------------------*/

/*------------------------------注册验证码---------------------*/
var getVerifyCodeAgain = true;
//获取验证码
function getRegisterVerifyCode() {
	//验证是否可以获取验证码
	if(!getVerifyCodeAgain) {
		document.getElementById("error_msg").innerHTML = "先等等";
		return;
	}
	//邮箱不正确禁止获取验证码
	var email = document.getElementById("email");
	if (email.value == "" || email.value.trim() == "") {
		document.getElementById("error_msg").innerHTML = "邮箱错误";
		return;
	}
	
	//获取验证码之前先验证用户输入邮箱是否已被注册
	//防止用户输入邮箱后马上点击获取验证码
	verifyEmail('reg');
	if(!emailflag) {
		return;
	}

	//发送请求，获取验证码
	var xmlHttp = getXMLHttpRequest();
	xmlHttp.open("post", "customerInfoServlet", true);
	xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xmlHttp.send("op=getregisterverifycode&email="+email.value.trim());
	xmlHttp.onreadystatechange = function() {
		if(xmlHttp.readyState == 4 && xmlHttp.status == 200) {
			var content = xmlHttp.responseText;

			if(content.trim() == "f") {
				document.getElementById("error_msg").innerHTML = "获取失败";
			} else {
				//验证码获取成功就进入有效倒计时
				document.getElementById("yzm_djs").innerHTML = 60;
				changeYzmDjs();
				document.getElementById("error_msg").innerHTML = "";
			}
		}
	};
}

//刷新验证码剩余有效时间
function changeYzmDjs() {
	getVerifyCodeAgain = false;
	var djs_span = document.getElementById("yzm_djs");
	var txt = djs_span.innerHTML;
	djs_span.innerHTML = parseInt(txt) - 1;
	
	var yzm_djs = setTimeout("changeYzmDjs()", 1000);
	
	//验证码过期
	if(txt == "1") {
		//删除过期验证码
		removeVerifyCode();
		clearTimeout(yzm_djs);
		djs_span.innerHTML = "";
		getVerifyCodeAgain = true;
	}
}

//注册-验证验证码是否正确
function verifyRegisterVerifyCode() {
	var yzm = document.getElementById("yzm");
	if (yzm.value == "" || yzm.value.trim() == "") {
		return;
	}
	var xmlHttp = getXMLHttpRequest();
	xmlHttp.open("post", "customerInfoServlet", true);
	xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xmlHttp.send("op=verifyloginverifycode&code="+yzm.value);
	xmlHttp.onreadystatechange = function() {
		if(xmlHttp.readyState == 4 && xmlHttp.status == 200) {
			var content = xmlHttp.responseText;

			if(content.trim() == "f") {
				yzm.value = "";
				document.getElementById("error_msg").innerHTML = "验证码错误";
				codeflag = false;
			} else {
				document.getElementById("error_msg").innerHTML = "";
				codeflag = true;
			}
		}
	};
}

function removeVerifyCode() {
	var xmlHttp = getXMLHttpRequest();
	xmlHttp.open("post", "customerInfoServlet", true);
	xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xmlHttp.send("op=removeRegisterVerifyCode");
}
/*-----------------------end--------------------*/

function isLoginOk() {
	if(!emailflag || !pwdflag || !codeflag) {
		return false;
	}
	
	return true;
}


function isRegisterOk() {
	if(!emailflag || !pwdokflag || !codeflag) {
		return false;
	}
	
	return true;
}