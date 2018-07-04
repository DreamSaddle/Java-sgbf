//用户查看订单信息，或其他信息
var mouseoverflag = 1;
$('#header_customer:eq(0)').mouseover(function(){
	var customer_info_span = document.getElementById("customer_info").innerHTML;
	//没有登录就终止执行
	if(customer_info_span.indexOf("注册") != -1) {
		return;
	}
	
	//只有在第一次移入才获取订单总量
	if (mouseoverflag == 1) {
		getSumOrders();
		mouseoverflag = 2;
	}
	
    $(this).css('overflow','visible');
}).mouseout(function(){
    $(this).css('overflow','hidden');
});



//查询用户总订单条数
function getSumOrders() {
	var xmlHttp = getXmlHttpRequest();
	xmlHttp.open("post", "orderInfoServlet", true);
	xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xmlHttp.send("op=getSumOrders");
	xmlHttp.onreadystatechange = function() {
		if(xmlHttp.readyState == 4 && xmlHttp.status == 200) {
			var content = xmlHttp.responseText;
			$("#my_order_num").text(content);
		}
	};
}

function getXmlHttpRequest() {
	try {
		return new XMLHttpRequest();
	} catch(e) {
		alert("你的浏览器真的垃圾!");
		return;
	}
}