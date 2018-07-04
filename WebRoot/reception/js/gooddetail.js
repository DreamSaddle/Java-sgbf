//加减数量
function changeNum(flag) {
	var numEle = document.getElementById("buynum");
	
	//加
	if(flag == 1) {
		numEle.value = parseInt(numEle.value) + 1;
	} else {  //减
		if(parseInt(numEle.value) - 1 < 1) {
			alert("至少买一个哦!");
			return;
		}
		numEle.value = parseInt(numEle.value) - 1;
	}
}

//验证输入数量是否合格
function viaflyNum() {
	var numEle = document.getElementById("buynum");

	if (isNaN(numEle.value)  || parseInt(numEle.value) < 1) {
		numEle.value = "1";
		alert("请输入正确的数量!");
		return;
	}
}