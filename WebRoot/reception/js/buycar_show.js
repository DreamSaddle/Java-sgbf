//鼠标点击数量文本框获取改变之前的数量
var oldGoodNum;

function getXmlHttpRequest() {
	try {
		return new XMLHttpRequest();
	} catch(e) {
		alert("你的浏览器真的垃圾!");
		return;
	}
}

//根据加减按钮改变购买数量
function changeNumByText(flag, goodId) {
	var span_num = document.getElementById("num"+goodId+"");
	if(flag == 1) {
		var newNum = parseInt(span_num.value) - 1;
		if(newNum < 1) {
			alert("至少要买1个哦!");
			return;
		}
		//更改Session中对应商品的数量
		changeNumForSession(newNum, goodId);
		//更改商品小计
		calcGoodSub(newNum, goodId);
		/*----在选中商品复选框时再改变商品数量----*/
		//改变数量时动态刷新以选择的商品的合计金额
		changeSumWithNumChange(1, goodId);
		span_num.value = newNum;
	} else {
		var newNum = parseInt(span_num.value) + 1;
		//更改Session中对应商品的数量
		changeNumForSession(newNum, goodId);
		//更改商品小计
		calcGoodSub(newNum, goodId);
		//改变数量时动态刷新以选择的商品的合计金额
		changeSumWithNumChange(0, goodId);
		span_num.value = newNum;
		}
}

//鼠标点击数量文本框，获取修改之前的数量
function getNumById(goodId) {
	var span_num = document.getElementById("num"+goodId+"");
	
	oldGoodNum = span_num.value;
}

//焦点离开文本框，根据文本框输入值改变数量
function changeNumByInput(goodId) {
	var span_num = document.getElementById("num"+goodId+"");
	//此处省略各种数据有效性验证
	if(isNaN(span_num.value) || parseInt(span_num.value) < 1) {
		alert("请输入有效数量!");
		span_num.value = 1;
		return;
	}
	
	//改变数量时动态刷新以选择的商品的合计金额
	changeSumWithNumChange(2, goodId);
	
	//通过Ajax刷新Session中的对应数量
	changeNumForSession(span_num.value, goodId);
	
}

//根据数量的变动动态刷新合计金额
function changeSumWithNumChange(flag, goodId) {
	var chkList = document.getElementsByName("isChooseSomeOne");
	var span_sum = document.getElementById("sum");
	for (var i = 0; i < chkList.length; i++) {
		if(goodId == chkList[i].value) {
			var chk = chkList[i];
			if(chk.checked) {
				if (flag == 1) {  //减
					span_sum.innerHTML = parseFloat(span_sum.innerHTML) - parseFloat(document.getElementById("price"+goodId+"").innerHTML);
					span_sum.innerHTML = new Number(span_sum.innerHTML).toFixed(2);
				} else if(flag == 0) {  //加
					span_sum.innerHTML = parseFloat(span_sum.innerHTML) + parseFloat(document.getElementById("price"+goodId+"").innerHTML);
					span_sum.innerHTML = new Number(span_sum.innerHTML).toFixed(2);
				} else if(flag == 2) {  //文本框输入，且商品前复选框为选中状态
					calcGoodSumByInputChange(goodId, span_sum);
				}
	
				disableBuyButton();
				}
			//文本框输入，且商品前复选框为非选中状态
			if(!chk.checked && flag == 2) {
				calcGoodSumByInputChange(goodId, span_sum);
			}
		}
	}
}

//根据商品数量文本框输入值的改变而改变 商品总计和对应商品小计
function calcGoodSumByInputChange(goodId, span_sum) {
	var span_num = document.getElementById("num"+goodId+"");
	var nowGoodNum = span_num.value; //现有量
				
	//将输入的数量与之前的数量进行比较，如果现有数量大于之前数量，则 合计+(现有量-原有量)*对应单价
	//如果现有数量小于之前数量，则 合计-(原有量-现有量)*对应单价
	
	if(nowGoodNum == oldGoodNum) {  //相等就不做修改
		return;
	}
	if(nowGoodNum > oldGoodNum) {  //合计+(现有量-原有量)*对应单价
		/*-- 修改对应商品小计--*/
		calcGoodSub(nowGoodNum, goodId);
		
		/*-- 修改合计金额 --*/
		//商品单价
		var price = parseFloat(document.getElementById("price"+goodId+"").innerHTML);
		//修改之前合计金额
		var sumPrice = parseFloat(span_sum.innerHTML);
		//重新设置合计金额
		span_sum.innerHTML = sumPrice + (nowGoodNum-oldGoodNum) * price;
		span_sum.innerHTML = new Number(span_sum.innerHTML).toFixed(2);
	}
	if(nowGoodNum < oldGoodNum) {  //合计-(原有量-现有量)*对应单价
		/*-- 修改对应商品小计--*/
		calcGoodSub(nowGoodNum, goodId);
		
		/*-- 修改合计金额 --*/
		//商品单价
		var price = parseFloat(document.getElementById("price"+goodId+"").innerHTML);
		//修改之前的合计金额
		var sumPrice = parseFloat(span_sum.innerHTML);
		//重新设置合计金额
		span_sum.innerHTML = sumPrice - (oldGoodNum-nowGoodNum) * price;
		span_sum.innerHTML = new Number(span_sum.innerHTML).toFixed(2);
	}
}


//Ajax刷新Session中商品对象的数量
function changeNumForSession(newNum, goodId) {
	var xmlHttp = getXmlHttpRequest();
	xmlHttp.open("post", "buyCarServlet", true);
	xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xmlHttp.send("op=changeNum2Session&newNum="+newNum+"&goodId="+goodId);
	xmlHttp.onreadystatechange = function() {
		if(xmlHttp.readyState == 4 && xmlHttp.status == 200) {
			var content = xmlHttp.responseText;
			if(content == "0") {
				return;
			}
		}
	};
}

//动态更新商品小计
function calcGoodSub(newNum, goodId) {
	var span_sub = document.getElementById("sub"+goodId+"");
	var span_price = document.getElementById("price"+goodId+"");
		
	span_sub.innerHTML = newNum * parseFloat(span_price.innerHTML);
	//防止小计出现多为小数位
	setSubPointTwo();
}

window.onload = function() {
	//第一次进入禁用结算按钮
	if(document.getElementById("sum").innerHTML == "0.00") {
		document.getElementById("clearing").disabled=true;
	}
	
	//每个商品的复选框动态更新合计金额
	var chkList = document.getElementsByName("isChooseSomeOne");
	for (var i = 0; i < chkList.length; i++) {
		var chk = chkList[i];
		chk.onchange = function() {
		//选中商品就刷新增加合计金额
		if(this.checked) {
			calcGoodSum(0, this.value);

			disableBuyButton();
		} else { //取消商品就刷新减掉合计金额
			calcGoodSum(1, this.value);
		
			disableBuyButton();
			}
		};
	}
	
	//加载页面时重新计算选中商品的合计金额，防止选中商品刷新页面合计金额为0
	for (var i = 0; i < chkList.length; i++) {
		var chk = chkList[i];
		if(chk.checked) {
			calcGoodSum(0, chk.value);
			disableBuyButton();
		}
	}
};

//动态更新商品合计
function calcGoodSum(flag, goodId) {
	var span_sum = document.getElementById("sum");
	var span_sub = document.getElementById("sub"+goodId+"");
	
	var newSum = 0;
	if(flag == 0) {
		newSum = (parseFloat(span_sum.innerHTML) + parseFloat(span_sub.innerHTML)).toFixed(2);
	} else {
		newSum = (parseFloat(span_sum.innerHTML) - parseFloat(span_sub.innerHTML)).toFixed(2);
	}
	
	//防止合计金额负数bug
	if(newSum < 0) {
		newSum = 0;
	}
	
	span_sum.innerHTML = new Number(parseFloat(newSum)).toFixed(2);
	
	return newSum;
}

//根据合计金额禁用结算按钮
function disableBuyButton() {
	if(parseInt(document.getElementById("sum").innerHTML) <= 0) {
	document.getElementById("clearing").disabled=true;
} else {
	document.getElementById("clearing").disabled=false;
	}
}

function allChooose(){
	var chkList = document.getElementsByName("isChooseSomeOne");
	for (var i = 0; i < chkList.length; i++) {
		var chk = chkList[i];
		//如果是选中状态就变为非选中状态
		if(chk.checked) {
			chk.checked = false;
			calcGoodSum(1, chk.value);
	
			disableBuyButton();
		} else { //没有选中就变为选中状态
			chk.checked = true;
		
			calcGoodSum(0, chk.value); //计算合计金额

			disableBuyButton();
		}
	}
}

//设置小计金额为两位小数位
function setSubPointTwo() {
	var xj = $(".xiaoji");
	for(var i=0; i<xj.length; i++) {
		var num = new Number(parseFloat(xj[i].innerHTML));
		xj[i].innerHTML = num.toFixed(2);
	}
}


/*----------------------结算-------------*/
function jiesuan() {
	//验证是否登录
	if(document.getElementById("js_hidden").value == "0") {
		if(confirm("你还没有登录，是否现在登录？")) {
			window.location.href = "reception/login.jsp";
		}
		return;
	}
	
	var goodIds = "";  //多个商品编号组成字符串
	var chkList = document.getElementsByName("isChooseSomeOne");
	for(var i=0; i<chkList.length; i++) {
		if(chkList[i].checked) {
			goodIds += chkList[i].value+",";
		}
	}
	
	//商品总计
	var sum = document.getElementById("sum").innerHTML;
	
	document.getElementById("hidden_goodIds").value = goodIds;
	document.getElementById("hidden_sum").value = sum;
	
	window.form_addorder.submit();
}

