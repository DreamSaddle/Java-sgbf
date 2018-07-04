/*设置iframe框架高度自适应*/
function setIframeHeight() {
	var sub=  window.frames["index_frame_middle"].document;
	if(navigator.userAgent.indexOf("Safari") > 0) {
		$("#middle_frame").height(sub.documentElement.clientHeight);
	} else {
		$("#middle_frame").height(sub.documentElement.clientHeight);
	}
	
	document.title = sub.title;
};