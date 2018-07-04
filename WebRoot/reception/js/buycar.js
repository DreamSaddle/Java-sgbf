/*购物车相关操作ajax*/

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

//添加商品到购物车
function addGoodToCar() {
	var goodId = document.getElementById("goodId");
	var goodNum = document.getElementById("buynum");
	
	var xmlHttp = getXMLHttpRequest();
	xmlHttp.open("post", "buyCarServlet", true);
	xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xmlHttp.send("op=addgood&goodId="+goodId.value+"&goodNum="+goodNum.value);
	xmlHttp.onreadystatechange = function() {
		if(xmlHttp.readyState == 4 && xmlHttp.status == 200) {
			var content = xmlHttp.responseText;

			if("suc" == content.trim()) {
				alert("添加成功");
				
				//刷新顶部我的购物车数量
				var carNum = window.parent.document.getElementById("mycarnum");
				carNum.innerHTML = parseInt(carNum.innerHTML) + 1;
			}
		}
	};
}

//立即购买
function buyNow() {
	//验证是否登录
	if(document.getElementById("js_hidden").value == "0") {
		if(confirm("你还没有登录，是否现在登录？")) {
			window.location.href = "reception/login.jsp";
		}
		return;
	}
	//获取商品编号
	var goodId = document.getElementById("goodId").value;
	var buyNum = document.getElementById("buynum").value;
	
	document.getElementById("hidden_goodIds").value = goodId;
	document.getElementById("hidden_sum").value = buyNum;
	
	window.form_addorder.submit();
}

/*立即购买样式设置*/
$("#buy_now").mouseover(function() {
	$(this).css({"background-color": "white", "border": "1px solid green", "cursor": "pointer"});
	$("#ljgm").css('color', 'green');
}).mouseout(function() {
	$(this).css({"background-color": "green", "border": "1px solid green", "cursor": "pointer"});
	$("#ljgm").css('color', 'white');
});