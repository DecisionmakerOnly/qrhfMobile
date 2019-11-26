<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User) request.getSession().getAttribute("user");
	Integer userId = user.getId();
	String loginName=user.getLoginName();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head> 
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>注册成功</title>
<script type="text/javascript" src="<%=basePath%>common/js/jquery-3.2.1.min.js"></script>
<style type="text/css">
body {
	margin: 0px;
	padding: 0px;
	font-family: "微软雅黑", Arial, "Trebuchet MS", Verdana, Georgia,
		Baskerville, Palatino, Times;
	font-size: 16px;
}

div {
	margin-left: auto;
	margin-right: auto;
}

a {
	text-decoration: none;
	color: #1064A0;
}

a:hover {
	color: #0078D2;
}

img {
	border: none;
}

h1, h2, h3, h4 {
	/*	display:block;*/
	margin: 0;
	font-weight: normal;
	font-family: "微软雅黑", Arial, "Trebuchet MS", Helvetica, Verdana;
}

h1 {
	font-size: 44px;
	color: #0188DE;
	padding: 20px 0px 10px 0px;
}

h2 {
	color: #0188DE;
	font-size: 16px;
	padding: 10px 0px 40px 0px;
}

a {
	font-size: 34px;
	color: red;
}

#page {
	width: 910px;
	padding: 20px 20px 40px 20px;
	margin-top: 80px;
}

.button {
	width: 180px;
	height: 28px;
	margin-left: 0px;
	margin-top: 10px;
	background: #009CFF;
	border-bottom: 4px solid #0188DE;
	text-align: center;
}

.button a {
	width: 180px;
	height: 28px;
	display: block;
	font-size: 14px;
	color: #fff;
}

.button a:hover {
	background: #5BBFFF;
}
</style>
<script type="text/javascript">
function login(){
	alert("请牢记您的登录账号:<%=loginName %>")
	window.location.href='<%=basePath%>user/login.jsp';
	}
</script>
</head>
<body>
	<div id="page"
		style="border-style: dashed; border-color: #e4e4e4; line-height: 30px;">
		<h1>恭喜您注册成功~</h1>
		<h2>Congratulations on your success in registration.</h2>
		<font color="#666666">您的登录账号是：<span style="font-size: 34px; color: red;"><%=loginName %> </span>,请牢记您的账号
	
		</font><br />
		<br />
		<div class="button">
			<a onclick="login()" title="点击进入登录页面" target="_blank">点击进入登录页面</a>
		</div>
	</div>
</body>
</html>