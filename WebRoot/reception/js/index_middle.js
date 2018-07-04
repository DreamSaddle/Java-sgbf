/*中部两张广告图切换效果*/
window.onload = function() {
	$("#img_li1").css('background-color', '#848383');
	$("#img_td1").css('background-color', 'black');
};
var time;
function changeimg() {
	var src_ = $("#middle_img").attr("src");
	if(src_ == "/sgbf_taohan/reception/images/rb-1.jpg") {
		$("#middle_img").attr("src", "/sgbf_taohan/reception/images/rb-2.jpg");
		$("#img_li2").css('background-color', '#848383');
		$("#img_li1").css('background-color', '#C5C0C0');
	} else {
		$("#middle_img").attr("src", "/sgbf_taohan/reception/images/rb-1.jpg");
		$("#img_li1").css('background-color', '#848383');
		$("#img_li2").css('background-color', '#C5C0C0');
	}
}
function qq() {
	time = setInterval("changeimg()", 5000);
}
qq();

$("#img_li1").mouseover(function() {
	$(this).css('background-color', '#848383');
	$("#img_li2").css('background-color', '#C5C0C0');
	$("#middle_img").attr("src", "/sgbf_taohan/reception/images/rb-1.jpg");
	clearInterval(time);
}).mouseout(function() {
	qq();
});
$("#img_li2").mouseover(function() {
	$(this).css('background-color', '#848383');
	$("#img_li1").css('background-color', '#C5C0C0');
	$("#middle_img").attr("src", "/sgbf_taohan/reception/images/rb-2.jpg");
	clearInterval(time);
}).mouseout(function() {
	qq();
});
/*-----------end---------------*/

var flag = 0;
function changetdimg() {

	if(flag == 0) {
		$("#new_img").attr("src", "/sgbf_taohan/reception/images/fr-1.jpg");
		flag = 1;
	} else if(flag == 1) {
		$("#new_img").attr("src", "/sgbf_taohan/reception/images/fr-2.jpg");
		flag = 2;
	} else {
		$("#new_img").attr("src", "/sgbf_taohan/reception/images/fr-3.jpg");
		flag = 0;
	}
}
function qq2() {
	time = setInterval("changetdimg()", 2000);
}
qq2();