<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>找回密码</title>
<script type="text/javascript" src="<%=basePath%>common/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrapValidator.js"></script>
<link href='<%=basePath%>common/css/bootstrap.min.css' rel='stylesheet'>
</head>
<script>
   function editPassword() {
	var password = $("#password").val();
	var rePassword = $("#repassword").val();
	var reg=/^(?![^a-zA-Z]+$)(?!\D+$)/;
	if (!reg.test(password)) {
		$("#passworderror").css("color", "red");
		$("#passworderror").html('×密码必须为6-18位字母、数字!');
		return false;
	}else {
		$("#passworderror").css("color", "green");
		$("#passworderror").html("");
	}
	if (password != rePassword) {
		$("#repassworderror").css("color", "red");
		$("#repassworderror").html("×两次输入密码不一致");
		return false;
	} else {
		$("#repassworderror").css("color", "green");
		$("#repassworderror").html("");
	}
	if(password!=null&&password!=""){
		isValid = 1;
	}else{
		alert("请填写密码");
		isValid = 2;
		return;
	}
	if(isValid == 1){
  	 $.post(
  	 		"<%=basePath%>user/updatePassword",
  	 		$("#user").serialize(),
  	 		function () {
  	 				alert('找回成功，请登录')
  	 				location.href="<%=basePath%>user/login.jsp";
  	 		}
  	 	)
	}
  	 }
	function login() {
		window.location.href = "<%=basePath%>user/login.jsp";
	}
</script>
<body>
	<form id="user" class="form-horizontal" style="margin-left:305px; width: 850px;">
		<div align="center">
			<h1>找回密码</h1>
		</div>
			<input type="hidden" name="email" value="${user.email}">
			<input type="hidden" name="phone" value="${user.phone}">
		<div style="margin-left: 120px;" >		
			<div class="form-group" >
				<label class="col-md-2 control-label">创建人：</label>
				<div class="col-md-6 ">
					<input type="text"class="form-control" name="userName" value="${user.userName}"value="" readonly="readonly">
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-2 control-label">密码：</label>
				<div class="col-md-6 ">
					<input class="form-control"type="password" id="password" name="password" placeholder="密码" oncontextmenu="return false" onpaste="return false" onkeyup="this.value=this.value.replace(/\s+/g,'')" />
				</div>
				<span id="passworderror" style="display:block;color: red; font-size: 18px;margin-left:325px;"></span>
			</div>
			<div class="form-group" >
				<label class="col-md-2 control-label">确认密码：</label>
				<div class="col-md-6">
					<input class="form-control" type="password" id="repassword" placeholder="再次输入密码" oncontextmenu="return false" onkeyup="this.value=this.value.replace(/\s+/g,'')" onpaste="return false" />
				</div>
				<span id="repassworderror" style="display:block;color: red; font-size: 18px;margin-left:325px;"></span>
			</div>
			<div class="modal-footer col-md-8">
				<input  type="button" class="btn btn-primary" onclick="login()" value="取消">
				<input type="button" class="btn btn-primary" onclick="editPassword()"value="提交" > 
			</div>
		</div>
	</form>
</body>
</html>