<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>找回秘密</title>
<meta name="description" content="User login page" />
<script type="text/javascript" src="<%=basePath%>common/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrapValidator.js"></script>
<link href='<%=basePath%>common/css/bootstrap.min.css' rel='stylesheet'>
<style type="text/css">
body {
	background-color: black;
}

.ceshi {
	width: 300px;
	margin: auto;
}

.ceshi input{
	background-color: black;
	font-size: 18px;
	color: white;
	height: 45px;
}

.ceshi input::-webkit-input-placeholder{
	color: white;
	font-size: 18px;
}
.ceshi select {
	background-color: black;
	color: white;
	font-size: 18px; 
	height: 45px;
	width: 124px;
}
.ceshi button {
	height: 45px;
	width: 148px;
}
.ceshi2 {
	color: white;
	width: 300px;
	margin: auto;
}
.ceshi2 input{
	background-color: black;
	color: white;
	height: 45px;
	width: 185px;
	margin-left: 118px;
	margin-top: -45px;
}
.btn-default {
	display: inline-block;
	text-align: center;
	cursor: pointer;
	width: 130px;
	height: 45px;
	margin-left:830px;
	margin-top: -45px;
	color: black;
}
</style>
</head>
<body>
	<div style="padding:30px 100px 10px;">
		<div align="center">
			<button type="submit" class="btn btn-warning" onclick="emailLogin()">下一步</button>
		</div>
	  		<div class="form-group">
	  			<div class="ceshi">
	  			<select class="form-control" style="appearance: none; -moz-appearance: none; -webkit-appearance: none;" id="isFactory" name="isFactory">
						<option style="display: none;" selected="selected" disabled="disabled" value="">手机号/邮箱</option>
						<option value="1">手机号</option>
						<option value="2">邮箱</option>
					</select>
	  			</div>
					<div class="ceshi2">
						<input class="form-control" type="text" id="chare" name="chare" onfocus="this.placeholder=''"  autocomplete="off" /> 
					</div>
						<input id="btn" name="btn" class="btn btn-default" value="点击获取验证码" onclick="sendEmail()" />
	  					<span id="emailerror" style="display:block;color: red; font-size: 18px;margin-left:525px;"></span>
	  				</div>
		<div class="form-group">
		  		<div class="ceshi">	
					<input type="text" class="form-control" id="user_code" name="user_code" placeholder="验证码" data-toggle="tooltip" data-placement="right" title="<h4>请输入验证码</h4>" onfocus="this.placeholder=''" onblur="this.placeholder='验证码'" autocomplete="off" onkeyup="value=value.replace(/[^\d]/g,'') ">
				</div>
		</div>
		<div class="form-group">
			<div class="ceshi">
				<button type="submit" class="btn btn-warning" onclick="emailLogin()">下一步</button>
				<button type="submit" class="btn btn-warning" onclick="login()" >取消</button>
			</div>
		</div>
	</div>
</body>
</html>