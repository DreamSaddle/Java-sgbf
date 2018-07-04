//设置商品小计小数位数为2
var xj = $(".xiaoji");
for(var i=0; i<xj.length; i++) {
	var num = new Number(parseFloat(xj[i].innerHTML));
	xj[i].innerHTML = num.toFixed(2);
}
var qrList = $("a[class=qr]");
       		

//鼠标移入某一商品确认订单展示该订单下的所有商品
for(var i=0; i<qrList.length; i++) {
	qrList[i].onmouseover = function() {
	var selfId = this.id;
	for(var i=0; i<qrList.length; i++) {
		if(selfId == qrList[i].id) {
			qrList[i].style.color = "red";
		}
	}
	this.style.color = "red";
};
qrList[i].onmouseout = function() {
	var selfId = this.id;
	for(var i=0; i<qrList.length; i++) {
		if(selfId == qrList[i].id) {
			qrList[i].style.color = "green";
		}
	}
	this.style.color = "green";
	};
}