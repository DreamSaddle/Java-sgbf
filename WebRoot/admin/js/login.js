
//标识是否可以登录
var nameflag = false;
var pwdflag = false;

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
				alert("你的浏览器实在是忒垃圾了");
				throw e;
			}
		}
	}
}

function verifyName() {
	var nameEle = document.getElementById("name");
	if(nameEle.value.trim() == "") {
		return;
	}
	var xmlHttp = getXMLHttpRequest();
	xmlHttp.open("post", "adminInfoServlet", true);
	xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xmlHttp.send("op=verifyname&adminName="+nameEle.value);
	xmlHttp.onreadystatechange = function() {
		if(xmlHttp.readyState == 4 && xmlHttp.status == 200) {
			var content = xmlHttp.responseText;

			if(content == "f") {
				var name_txt = document.getElementById("name");
				name_txt.value = "";
				name_txt.placeholder="用户名不存在";
				nameflag = false;
			} else {
				document.getElementById("name").placeholder="";
				nameflag = true;
			}
		}
	};
}


function verifyPwd() {
	var nameEle = document.getElementById("name");
	var pwdEle = document.getElementById("pwd");
	if(nameEle.value.trim() == "" || pwdEle.value.trim() == "") {
		pwdEle.value = "";
		pwdEle.placeholder = "请先输入用户名";
		return;
	}
	var xmlHttp = getXMLHttpRequest();
	xmlHttp.open("post", "adminInfoServlet", true);
	xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xmlHttp.send("op=verifypwd&adminName="+nameEle.value+"&adminPwd="+pwdEle.value);
	xmlHttp.onreadystatechange = function() {
		if(xmlHttp.readyState == 4 && xmlHttp.status == 200) {
			var content = xmlHttp.responseText;

			if(content == "f") {
				var pwd_txt = document.getElementById("pwd");
				pwd_txt.value = "";
				pwd_txt.placeholder="密码错误";
				pwdflag = false;
			} else {
				document.getElementById("name").placeholder="";
				pwdflag = true;
			}
		}
	};
}


function isLoginOk() {
	if(!nameflag || !pwdflag) {
		return false;
	}

	return true;
}