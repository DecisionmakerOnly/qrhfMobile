<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String loginIdentification = request.getParameter("loginIdentification");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>
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
	width: 790px;
	margin: auto;
}
.ceshi input{
	background-color: black;
	font-size: 36px;
	color: white;
	height: 135px;
}

.ceshi input::-webkit-input-placeholder{
	color: white;
	font-size: 36px;
}
.ceshi select {
	background-color: black;
	color: white;
	font-size: 36px; 
	height: 45px;
}
.ceshi button {
	height: 135px;
	width: 790px;
	font-size: 36px;
}
.btnCss button{
	height:135px;
	width:395px;
	font-size:36px;
}
</style>
<script type="text/javascript">
// $(function () { $("[data-toggle='tooltip']").tooltip({html : true });});
$(function(){
	$('#form').bootstrapValidator({
			message: 'This value is not valid',
		        fields: {
// 		        	isFactory:{
// 		        		message:'选择错误',
// 		        		validators:{
// 		        			notEmpty:{
// 		        				message:'请选择登录行业'
// 		        			}
// 		        		}
// 		        	},
		        	loginName: {
		                message: '登录名验证失败',
		                validators: {
		                    notEmpty: {
		                        message: '登录账号不能为空'
		                    }
		                }
		            },
		            password: {
		                validators: {
		                    notEmpty: {
		                        message: '登录密码不能为空'
		                    },
		                    regexp: {
		                        regexp: /^[a-zA-Z0-9_\.]+$/,
		                        message: '密码非法'
		                    }
		                }
		            },
		         
		        }
		    });
});
function doLogin() {
	if($("#form").data('bootstrapValidator').validate().isValid()){
		var isFactory = $("#isFactory").val();
		var loginName=$("#loginName").val();
		var password=$("#password").val()
		$.post(
			"<%=basePath%>user/login.action",
			$("#form").serialize(),
			function(data) {
				if(data.i==0){
					if(isFactory==1){
						location.href="<%=basePath%>main.jsp";
					}else if(isFactory==2){
						location.href="<%=basePath%>seller/daohang.jsp";
					}
				}else if(data.i==1){
					alert("密码不正确");
				}else if(data.i==2){
					alert("此账号不存在！");
				}else if(data.i==3){
					alert("试用期结束，请续费！");
				}
			 }
		)
	}else{
		return false;
	}
}
	function sellerLogin() {
		window.location.href = "<%=basePath%>seller/login.jsp";
	}
	function login() {
		window.location.href = "<%=basePath%>user/login.jsp";
	}
	function newUser(){
		window.location.href="<%=basePath%>user/newUser.jsp";
	}
	//打开模态框
	function openPassDlg() {
		$("#passDlg").modal('show');
	}
	//关闭模态框
	function closeDlgs() {
		$("#passDlg").modal('hide');
	}
	var InterValObj; //timer变量，控制时间
	var count = 60; //间隔函数，1秒执行
	var curCount;//当前剩余秒数
	function sendEmail(){
		curCount = count;
// 		var loginType = $("#loginType").val();
		var chare =$("#chare").val();
// 		if (loginType == null) {
// 			alert("选择找回方式:手机号/邮箱");
// 			return;
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
					"loginType":loginType
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
// 			var loginType = $("#loginType").val();
			var chare=$("#chare").val();
			var user_code = $("#user_code").val();
			if (chare == "") {
				alert("手机号/邮箱不可为空");
				return;
			}
			 if(myregPhone.test(chare)){
				 var loginType=1;
			}else if(myregEmail.test(chare)){
				 var loginType=2;
			}
			var isValid = 0;
				$.ajax({
					type : "post",
					url : "<%=basePath%>user/checkCode",
					data : 
						"user_code=" + user_code,
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
								window.parent.location.href = "<%=basePath%>user/toUpdatePassword";
							}else if (data.i == 2) {
								alert("请先注册");
							} 
						}
					});
				}
		}
	 function toRegister(){
		 parent.top.location.href = "<%=basePath%>user/register.jsp";
	 }
	// 登录的回车事件
	$(window).keydown(function(event) {
	    if (event.keyCode == 13) {
	    	$('.log-btn').trigger('click');
	    	}
	   });
</script>
</head>
<body>
	<form id="form" class="form-horizontal" method="post" style="margin-top:500px; margin-left:10px;">
		<div style="padding:30px 100px 10px;">
			<div class="form-group" >
				<input type="hidden" id="isFactory" name="isFactory" value="1"/>
		  	</div>
		  	<div class="form-group" >
		  		<div class="ceshi" >
<%-- 		  			<input class="form-control" type="text" name="loginName" id="loginName" data-toggle="tooltip" data-placement="right" title="<h4>请输入您的手机号/邮箱/账号</h4>" placeholder="手机号/邮箱/账号" oncontextmenu="return false" onfocus="this.placeholder=''" onblur="this.placeholder='手机号/邮箱/账号'" autocomplete="off" /> --%>
		  				<input class="form-control" type="text" name="loginName" id="loginName"  placeholder="手机号/邮箱/账号" oncontextmenu="return false" onblur="this.placeholder='手机号/邮箱/账号'" autocomplete="off" />
		  		</div>
		  	</div>
		  	<div class="form-group">
		  		<div class="ceshi">
<%-- 		  			<input class="form-control" data-toggle="tooltip" data-placement="right" title="<h4>请输入您的密码</h4>" type="password" name="password" id="password" placeholder="密码" onfocus="this.placeholder=''" onblur="this.placeholder='密码'" oncontextmenu="return false" onpaste="return false" /> --%>
		  			<input class="form-control" type="password" name="password" id="password" placeholder="密码"   oncontextmenu="return false" onpaste="return false" />
		  		</div>
		  	</div>
			<a onclick="openPassDlg();" role="button" style="font-size: 36px;margin-left:280px;">找回密码</a>
			<div class="form-group">
				<div class="btnCss">
<!-- 				<div class="ceshi"> -->
					<button type="submit" class="btn btn-primary log-btn" onclick="doLogin()" >登录</button>
<!-- 					<br/><br/> -->
				</div>
			</div>
		</div>
	</form>
	<div style="margin-left:500px;margin-top:-160px;">
		<div class="form-group">
			<div class="btnCss">
				<button type="submit" class="btn btn-primary" onclick="toRegister();">立即注册</button>
			</div>
		</div>
	</div>
	<!-- 模态框（Modal） -->
		<!-- 修改 -->
		<div style="font-family: 'Noto Serif CJK SC', 'Noto Serif CJK', 'Source Han Serif SC', ‘Source Han Serif’, source-han-serif-sc, serif;"" id="passDlg" class="modal fade"  tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog" style="width: 800px;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">找回密码</h4>
					</div>
					<div class="container">
						<form class="form-horizontal" id="addForm" >
							<div class="form-group">
								<label class="col-md-2 control-label">请输入手机号/邮箱：</label>
								<div class="col-md-3" >
									<input class="form-control" type="text" id="chare" name="chare" placeholder="请输入手机号/邮箱" onfocus="this.placeholder=''"  autocomplete="off" /> 
								</div>
								<input id="btn" style="margin-left: -15px;" name="btn" class="btn btn-default" value="点击获取验证码" onclick="sendEmail()" readonly="readonly"/>
	  							<span id="emailerror" style="display:block;color: red; font-size: 18px;margin-left:325px;"></span>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">验证码：</label>
								<div class="col-md-3 ">
								 	<input type="text" class="form-control" id="user_code" name="user_code" placeholder="验证码" autocomplete="off" onkeyup="value=value.replace(/[^\d]/g,'') "><br>
								</div>
							</div>
							<span id="codeerror" style="display:block;color: red; font-size: 18px;margin-left:225px;margin-top: -15px; "></span>
							<div class="modal-footer col-md-7">
								<button type="button" class="btn btn-primary" onclick="closeDlgs()">取消</button>
								<button type="button" onclick="emailLogin()" class="btn btn-primary">下一步</button>
							</div>
							</form>
						</div>
					</div>
				</div>
			</div>
</body>
</html>