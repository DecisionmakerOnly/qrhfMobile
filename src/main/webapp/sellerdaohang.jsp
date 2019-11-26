<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User) request.getSession().getAttribute("user");
	Integer userId = user.getId();
	String userName=user.getUserName();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>导航栏</title>
<link href="<%=basePath%>/common/css/bootstrap.css" rel="stylesheet" type="text/css" media="all">
<link href="<%=basePath%>/common/css/style2.css" rel="stylesheet" type="text/css" media="all" />
<script src="<%=basePath%>/common/js/jquery-3.2.1.min.js"></script>
<script src="<%=basePath%>/common/js/bootstrap.js"></script>
<style type="text/css">
	.navbar .nav > li .dropdown-menu {
	    margin: 0;
	}
	.navbar .nav > li:hover .dropdown-menu {
	    display: block;
	}
</style>
<script type="text/javascript">
	
	window.onload = function (){//解决iframe在非IE、firefox浏览器下（如edge、chrome浏览器）重复刷新的问题
		var iframe = document.createElement('iframe');
		iframe.id="mainFrame";
		iframe.width="100%";
		iframe.frameborder="0";
		iframe.scrolling="no";
		iframe.style.border="0px";
		iframe.setAttribute('frameborder', '0', 0);
		iframe.onload = function(){
			iframe.onload = null;
		};
		document.getElementById("col-md-10").appendChild(iframe);
		toSellerList();
	}

	function zsy(){
		var yScroll = (window.parent.document.documentElement.scrollHeight >window.parent.document.documentElement.clientHeight) ? window.parent.document.documentElement.scrollHeight : window.parent.document.documentElement.clientHeight; 
		return yScroll;
	}

	$(function() {
		var h=zsy();
		$("#listBody").height(h-100);
		//取到窗口的高度 
		var winH = $(window).height();
		//取到页面的高度 
		var bodyH = $(document).height();
		if(bodyH > winH){ 
			window.parent.document.getElementById("mainFrame").height=bodyH;
		}else{ 
			window.parent.document.getElementById("mainFrame").height=winH; 
		} 
	})
	
	function exit(){
		parent.top.location.href = "<%=basePath%>/daohang.jsp";
	}
	
	function main(){
		$("#mainFrame").attr('src',"<%=basePath%>/seller/compareSeller");
	}
	
	 function toSellerList() {
		$("#mainFrame").attr('src',"<%=basePath%>seller/compareSeller.action");
	} 
	
	function goodsInfo() {
		$("#mainFrame").attr('src',"<%=basePath%>/seller/tree.jsp");
	}
	
	function toAddGoods() {
		$("#mainFrame").attr('src',"<%=basePath%>/sellergoods/add.jsp");
	}
	
	$(function() {
		var userName = "<%=userName%>";
		$("#welcome").html("欢迎你！" + userName);
		$("#col-md-10").height($(window).height()-$("#daohang").height());
	})
	
</script>
</head>
<body>
	<div id="daohang" class="header">
		<div class="container">
			<div>
				<nav class="navbar navbar-default">
					<div class="container-fluid">
						<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
							<ul class="nav navbar-nav cl-effect-16">
								<li><a href="javascript:main()" style="margin:0px 20px">首页</a></li>
								<li><a href="javascript:goodsInfo()" style="margin:0px 20px">商品维护</a></li>
								<li><a href="javascript:toAddGoods()" style="margin:0px 20px">添加商品</a></li>
								<li><a href="javascript:main()" style="margin:0px 20px">菜单3</a></li>
								<li><a href="javascript:main()" style="margin:0px 20px">菜单4</a></li>
								<li><a href="javascript:main()" style="margin:0px 20px">菜单5</a></li>
							</ul>
							<ul class="nav navbar-nav navbar-right">
								<li><a href="javascript:exit()"><p id="welcome"></p></a></li>
							</ul>
						</div>
					</div>
				</nav>
			</div>
		</div>
	</div>
	<div style="width:100%;float:left;padding:0;overflow:auto" id="col-md-10"></div>
</body>
</html>
