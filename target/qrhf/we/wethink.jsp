<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我们</title>
<meta name="description" content="User login page" />
<script type="text/javascript" src="<%=basePath%>common/js/jquery-3.2.1.min.js"></script>
<style type="text/css">
	 .left {
        float: left;
        width: 800px;
        height: 980px;
        margin-right: -100%;
        border: none;
      }
       .left-div{
      	position: absolute;
      	margin:0 auto;
      	top:55px;
      	left:180px;
      	height:260px;
      	width:420px;
      	font-family: 'Noto Serif CJK SC', 'Noto Serif CJK', 'Source Han Serif SC', ‘Source Han Serif’, source-han-serif-sc, serif;
      }
      .left-img{ 
      	position: absolute;
      	margin:0 auto;
      	top:190px;
      	left:200px;
      	height:280px;
      	width:360px;
      }
      .left2-div{
      	position: absolute;
      	margin:0 auto;
      	top:540px;
      	left:180px;
      	height:260px;
      	width:420px;
      	font-family: 'Noto Serif CJK SC', 'Noto Serif CJK', 'Source Han Serif SC', ‘Source Han Serif’, source-han-serif-sc, serif;
      }
     .left2-img{
      	position: absolute;
      	margin:0 auto;
      	top:660px;
      	left:200px;
      	height:270px;
      	width:380px;
      }
      .right {
        float: left;
        width: 800px;
        height: 980px;
        margin-right: -100%;
        border: none;
/*         width: 100%; */
      }
      .right-div{
      	border：1px solid red;
      	position: absolute;
      	margin:0 auto;
      	top:55px;
      	left:910px;
      	height:260px;
      	width:420px;
      }
      .right-img{
      	position: absolute;
      	margin:0 auto;
      	top:220px;
      	left:910px;
      	height:280px;
      	width:380px;
      }
      .right2-div{
      	position: absolute;
      	margin:0 auto;
      	top:535px;
      	left:910px;
      	height:260px;
      	width:420px;
      }
      .right2-img{
      	position: absolute;
      	margin:0 auto;
      	top:660px;
      	left:910px;
      	height:270px;
      	width:380px;
      }
      .right-content {
        width: 800px;
        height: 980px;
        margin-left: 750px;
        border-left:1px dashed black; 
        font-family: 'Noto Serif CJK SC', 'Noto Serif CJK', 'Source Han Serif SC', ‘Source Han Serif’, source-han-serif-sc, serif;
      }
</style>
<script type="text/javascript">
	function zsy() {
		var yScroll = (window.parent.document.documentElement.scrollHeight > window.parent.document.documentElement.clientHeight) ? window.parent.document.documentElement.scrollHeight : window.parent.document.documentElement.clientHeight;
		return yScroll;
	}
	$(function() {
		var h = zsy();
		$("#listBody").height(h - 100);
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
<body style="width: 100%;">
	<div style="width: 100%; height: 1020px;">
		<div class="left">
			<img class="left-img"  src="<%=basePath%>common/images/1.png">
			<div class="left-div">
				<p style="font-size: 20px;">我想做的......</p>
	     		<p>●创造一个有人控制、无人能干预的智能管理系统，这个<br>&emsp;系统能使管理方式更精准，管理过程更高效。</p>
				<p>●.......</p>
			</div>
		</div>
		<div class="left">
			<img class="left2-img"  src="<%=basePath%>common/images/4.jpg">
			<div class="left2-div">
				<p style="font-size: 20px;">我们需要的......</p>
				<p>●行业智能管理模式的设计人员和实现设计人员思想软件<br>&emsp;研发人员及程序编写人员......。</p>
				<p>●.......</p>
			</div>
		</div>
	    <div class="right">
	      <div class="right-content">
	      		<div class="right-div">
			      	<p style="font-size: 20px;">我们的客户......</p>
					<p>●自主经营、自负盈亏的单位或组织。</p>
					<p>●您的需求，就是我们的改进方向！轻挪鼠标指向“欢迎<br>&emsp;您”下拉菜单，单击“意见反馈”，提出您的建议，一<br>&emsp;经采用就会赢得抽奖。</p>
					<p>●.......</p>
	      		</div>
	      		<img class="right-img"  src="<%=basePath%>common/images/2.png">
	      		
	      		<div class="right2-div">
	      		<p style="font-size: 20px;">智能时代......</p>
	     			<p>●人机一体，互联互通。</p>
	     			<p>●.......</p>
	      		</div>
	      		<img class="right2-img"  src="<%=basePath%>common/images/3.png">
	      </div>
	    </div>
	</div>
</body>
</html>