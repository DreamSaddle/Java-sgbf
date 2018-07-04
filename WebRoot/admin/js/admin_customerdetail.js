$("tr:even").css('background', '#f6f7f9');

//除开标题行和分页行其余鼠标移上去改变背景白色，和字体td字体颜色
$("tr:not(:first):not(#paging)").mouseover(function() {
	$(this).css({"background": "#97BFA2", "cursor": "pointer"});
	$(this).addClass("mouseover_tr");
	$("#show_table>tbody>.mouseover_tr>td").css('color', 'white');
});

$("tr:even").mouseout(function() {
	$(this).css('background', '#f6f7f9');
	$("#show_table>tbody>.mouseover_tr>td").css('color', 'black');
	$(this).removeClass("mouseover_tr");
});
$("tr:odd").mouseout(function() {
	$(this).css('background', 'white');
	$("#show_table>tbody>.mouseover_tr>td").css('color', 'black');
	$(this).removeClass("mouseover_tr");
});


/*防止订单信息小计出现多位小数位*/
var xiaojiList = $(".admin_orders_xiaoji");
for (var i=0; i<xiaojiList.length; i++) {
	var xiaojiText = xiaojiList[i].innerHTML;
	var num = new Number(parseFloat(xiaojiText));
	xiaojiList[i].innerHTML = "￥"+num.toFixed(2);
}