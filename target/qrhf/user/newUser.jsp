<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>新用户登录</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script type="text/javascript" src="<%=basePath%>common/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrapValidator.js"></script>
<link href='<%=basePath%>common/css/bootstrap.min.css' rel='stylesheet'><style type="text/css">
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
	width: 300px;
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
.verification{
	color: white;
	width: 300px;
	margin: auto;
}
</style>
<script type="text/javascript">
	function login() {
		window.location.href = "<%=basePath%>user/login.jsp";
	}
	var InterValObj; //timer变量，控制时间
	var count = 60; //间隔函数，1秒执行
	var curCount;//当前剩余秒数
	function sendEmail(){
		curCount = count;
		var chare =$("#chare").val();
// 		if (loginType == null) {
// 			alert("选择验证方式:手机号/邮箱");
// 			return;
// 		}
// 		if(loginType==1){
			
// 		}else if(loginType==2){
			
// 		}
		var myregEmail = /^([\.a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/;
		var myregPhone=/^[1][3,4,5,7,8][0-9]{9}$/;
		 if(myregPhone.test(chare)){
			 var loginType = 1;
				var isValid = 0;
				$.ajax({
					type : "post",
					url : "<%=basePath%>user/checkLoginEmail",
					data : {
						"chare" : chare,
						"loginType" :loginType
					},
					dataType : "json",
					async: false,
					success : function(data) {
						if (data == 2) {
							isValid = data;
							$("#emailerror").css("color", "red");
							$("#emailerror").html('×请先注册!');
						} else if (data == 1) {
							isValid = data;
							$("#emailerror").css("color", "green");
							$("#emailerror").html("");
						}
					}
				});
				if(isValid==1){
					$("#btn").attr("disabled", "true");
					$("#btn").val( + curCount + "秒再获取");
					InterValObj = window.setInterval(SetRemainTime, 1000); //启动计时器，1秒执行一次
					$.ajax({
						type : "post",
						url : "<%=basePath%>user/phoneCode",
						data : {
							"chare": chare
						},
						dataType : "json",
						async: false,
						success : function(data) {
							if (data == "1") {
							} else if (data == "2") {
							}
						}
					});
			}
		 }else if(myregEmail.test(chare)){
			 var loginType = 2;
			 var isValid = 0;
				$.ajax({
					type : "post",
					url : "<%=basePath%>user/checkLoginEmail",
					data : {
						"chare" : chare,
						"loginType" :loginType
					},
					dataType : "json",
					async: false,
					success : function(data) {
						if (data == 2) {
							isValid = data;
							$("#emailerror").css("color", "red");
							$("#emailerror").html('×请先注册!');
						} else if (data == 1) {
							isValid = data;
							$("#emailerror").css("color", "green");
							$("#emailerror").html("");
						}
					}
				});
				if(isValid==1){
					//设置button效果，开始计时
					$("#btn").attr("disabled", "true");
					$("#btn").val( + curCount + "秒再获取");
					InterValObj = window.setInterval(SetRemainTime, 1000); //启动计时器，1秒执行一次
					$.ajax({
						type : "post",
						url : "<%=basePath%>user/sendEmail",
						data : {
							"chare": chare
						},
						dataType : "json",
						async: false,
						success : function(data) {
							if (data == "1") {
								isValid = data;
							} else if (data == "2") {
								isValid = data;
							}
						}
					});
				}
		 }else if(!myregEmail.test(chare) || !myregPhone.test(chare)){
		 		$("#emailerror").html("×请输入有效的手机号/邮箱！");
		 		return false;
		 }
		function SetRemainTime() {
			if (curCount == 0) {                
				window.clearInterval(InterValObj);//停止计时器
				$("#btn").removeAttr("disabled");//启用按钮
				$("#btn").val("重新发送验证码");
//					code = ""; //清除验证码。如果不清除，过时间后，输入收到的验证码依然有效    
			}
			else {
				curCount--;
				$("#btn").val( + curCount + "秒再获取");
			}
		}
	}
	 function emailLogin() {
		var myregEmail = /^([\.a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/;
		var myregPhone=/^[1][3,4,5,7,8][0-9]{9}$/;
// 		var loginType=$("#loginType").val();
		var chare=$("#chare").val();
		var user_code = $("#user_code").val();
		 if(myregPhone.test(chare)){
			 var loginType=1;
		}else if(myregEmail.test(chare)){
			 var loginType=2;
		}
		var isValid = 0;
			$.ajax({
				type : "post",
				url : "<%=basePath%>user/checkCode",
				data : "user_code=" + user_code,
				dataType : "json",
				async: false,
				success : function(data) {
				data = parseInt(data, 10);
					if (data == 2) {
						isValid = data;
						$("#codeerror").css("color", "green");
						$("#codeerror").html('');
					} else if (data == 1) {
						isValid = data;
						$("#codeerror").css("color", "red");
						$("#codeerror").html('× 验证码有误，请核实后重新填写!');
					}
				}
		});
		if(isValid==2){
			$.ajax({
				type : "post",
				url : "<%=basePath%>user/emailLogin.action",
				data : {
					"chare" : chare,
					"loginType":loginType
				},
				dataType : "json",
				success : function(data) {
					if (data.i == 1) {
						window.parent.location.href = "<%=basePath%>main.jsp"; 
					}else if (data.i == 2) {
						alert("请先注册");
					} 
				}
			});
		}
	}
</script>
</head>
<body >
	 <div style="padding:30px 100px 10px;">
	 	<div align="center">
			<h2 style="color: white">新用户登录</h2>
		</div>
	 	<div class="form-group">
			<div class="ceshi" >
				<input type="hidden" id="loginType" name="loginType">
				<input class="form-control" type="text" id="chare" placeholder="请输入手机号/邮箱" onblur="this.placeholder='请输入手机号/邮箱'" name="chare" onfocus="this.placeholder=''"  autocomplete="off" /> 
			</div>
			<div class="verification">
				<input id="btn" style="margin-left: 310px;" name="btn" class="btn btn-default" value="点击获取验证码" onclick="sendEmail()"autocomplete="off"  />
	  			<span id="emailerror" style="display:block;color: red; font-size: 18px;margin-left:25px;"></span>
	  		</div>
	  		</div>
	  		<div class="form-group">
		  		<div class="ceshi">	
					<input type="text" class="form-control" id="user_code" name="user_code" placeholder="验证码" data-toggle="tooltip" data-placement="right" title="<h4>请输入验证码</h4>" onfocus="this.placeholder=''" onblur="this.placeholder='验证码'" autocomplete="off" onkeyup="value=value.replace(/[^\d]/g,'') ">
				</div>
				<div class="verification">
					<span id="codeerror" style="display:block;color: red; font-size: 18px;margin-left:25px; "></span>
				</div>
			</div>
			<div class="form-group has-feedback">
				<div class="ceshi" >
					<button type="submit" class="btn btn-primary" onclick="emailLogin();">登录</button>
				</div>
			</div>
	 </div>
</body>
</html>