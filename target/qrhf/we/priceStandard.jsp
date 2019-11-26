<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>计费说明</title>
<link href="<%=basePath%>/common/css/kefu.css" rel="stylesheet" type="text/css" media="all" />
<link href="<%=basePath%>/common/css/daohang.css" rel="stylesheet" type="text/css" media="all" />
<link href="<%=basePath%>/common/css/bootstrap.css" rel="stylesheet" type="text/css" media="all">
<link href="<%=basePath%>/common/css/style2.css" rel="stylesheet" type="text/css" media="all" />
<script src="<%=basePath%>/common/js/jquery-3.2.1.min.js"></script>
<script src="<%=basePath%>/common/js/bootstrap.js"></script>
<style type="text/css">
	   .fixed{
	   	margin-top:200px;
		 position:fixed;
		 left:0px;
		 bottom:0px;
	   	 width:100%; 
	   	 height:50px;
	  	 z-index:9999;
	  	 font-size:12px;
	  	 color:black;
       	}
</style>
<script type="text/javascript">
function zsy() {
	var yScroll = (window.parent.document.documentElement.scrollHeight > window.parent.document.documentElement.clientHeight) ? window.parent.document.documentElement.scrollHeight : window.parent.document.documentElement.clientHeight;
	return yScroll;
}
$(function() {
	var h = zsy();
	$("#listBody").height(h - 600);
	//取到窗口的高度 
	var winH = $(window).height();
	//取到页面的高度 
	var bodyH = $(document).height();
	if (bodyH > winH) {
		window.parent.document.getElementById("mainFrame").height = bodyH;
	} else {
		window.parent.document.getElementById("mainFrame").height = winH;
	}
})
</script>
</head>
<body>
			<br><br>
			<h1 align="center">计费说明</h1>
			<br><br>
<div style="margin-left:160px; height: 480px; width: 100%;">
	<div  style="float: left;width: 350px;height: 370px;"  >
		<div style="position:relative;">
			<img style="width: 350px;" alt="试用期" src="<%=basePath%>common/images/syq.png">
			<div align="center" style="color:white; position:absolute; z-index:2; left:120px; top:40px"><h1>试用期</h1></div>
		</div>
		<div class="jumbotron" style="height: 370px;">
			<div class="container">
				<p align="center">升级<span style="font-weight:bold; ">·免费</span></p>
				<p align="center">培训<span style="font-weight:bold; ">·免费</span></p>
				<p align="center">技术支持<span style="font-weight:bold; ">·免费</span></p>
				<p style="font-weight:bold; ">试用时间以公司计费和促销方式为准</p>
			</div>
		</div>
	</div>
	<div style="float:left; margin-left:70px; width: 350px;height: 370px;">
		<div style="position:relative;">
			<img style="width: 350px;" alt="使用期" src="<%=basePath%>common/images/zyb.png">
			<div align="center" style="color:white; position:absolute; z-index:2; left:120px; top:40px"><h1>使用期</h1></div>
		</div>
		<div class="jumbotron" style="height: 370px;">
			<div class="container">
				<p align="center">升级<span style="font-weight:bold; ">·免费</span></p>
				<p align="center">培训<span style="font-weight:bold; ">·免费</span></p>
				<p align="center">技术支持<span style="font-weight:bold; ">·免费</span></p>
				<p style="font-weight:bold; ">计费方式以使用人数和使用时间计费，计费标准以公司计费和促销方式为准。</p>
			</div>
		</div>
	</div>
</div>
<div style=" float: left;margin-left:1000px;margin-top:-480px; height: 480px; width: 350px;">
<div style=" width: 350px;height: 368px; ">
		<div style="position:relative;">
			<img style="width: 350px;" alt="计费和促销方式" src="<%=basePath%>common/images/jffs.png">
			<div align="center" style="color:white; position:absolute; z-index:2; left:50px; top:40px"><h1>计费和促销方式</h1></div>
		</div>
		<div class="jumbotron" style="height: 370px;">
			<div class="container" style="margin-top: -16px;">
				<p><h4>1、<span style="font-weight:bold; ">免费试用</span>一个月,可申请延期；</h4></p>
				<p><h4>2、使用期计费标准：<span style="font-weight:bold; ">99元/人•月</span></h4></p>
				<p><h4>3、使用期折扣标准：</h4></p>
				<p><h5>&nbsp;&nbsp;1个月至5个月·<span style="font-weight:bold; ">无折扣</span>；</h5></p>
<!-- 				<p><h5>&nbsp;&nbsp;2个月·<span style="font-weight:bold; ">无折扣</span>；</h5></p> -->
<!-- 				<p><h5>&nbsp;&nbsp;3个月·<span style="font-weight:bold; ">无折扣</span>；</h5></p> -->
				<p><h5>&nbsp;&nbsp;6个月·<span style="font-weight:bold; ">8.5折</span>；</h5></p>
				<p><h5>&nbsp;&nbsp;1年·<span style="font-weight:bold; ">7折</span>；</h5></p>
				<p><h5>&nbsp;&nbsp;2年·<span style="font-weight:bold; ">5折</span>；</h5></p>
				<p><h4>4、<span style="font-weight:bold; ">促销时间：</br></span>&ensp;&nbsp;2019/10/01 至 2020/09/30</h4></p>
			</div>
		</div>
	</div>
</div>
</body>
</html>