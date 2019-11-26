<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String shareCode = request.getParameter("shareCode");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>注册</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link href='<%=basePath%>common/css/bootstrap.min.css' rel='stylesheet'>
<script type='text/javascript' src='<%=basePath%>common/js/jquery-3.2.1.min.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/bootstrap.min.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/bootstrapValidator.js'></script>
<style type="text/css">
body {
	background-color: black;
	font-family: 'Noto Serif CJK SC', 'Noto Serif CJK', 'Source Han Serif SC', ‘Source Han Serif’, source-han-serif-sc, serif;
}

.registerCss {
	width: 790px;
	margin: auto;
}

.registerCss input{
	background-color: black;
	font-size: 36px;
	color: white;
	height: 135px;
}

.registerCss input::-webkit-input-placeholder{
	color: white;
	font-size: 36px;
}
.registerCss select {
	background-color: black;
	color: white;
	font-size: 36px; 
	height: 45px;
	width: 124px;
}
.registerCss button {
	height:135px;
	width:390px;
	font-size:36px;
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
	width: 520px;
	margin: auto;
}
.verificationBtn{
	color: white; 
	margin: auto; 
} 
#fx{animation:change 10s linear 0s infinite;font-size:50px;font-weight:900;}
@keyframes change{
0% {color:#f60;}
 5% {color:#ff0;}
 7% {color:#333;}
 10% {color:#cf0;}
 
 15% {color:#cf0;} 
 20%{color:#333;} 
 25%{color:#ff0;} 
 30%{color:#f60;}
 
 35%{color:#cf0;}  
 40%{color:#333;}
 45%{color:#ff0;}
 50%{color:#f60;}
 
 55%{color:#f60;}
 60%{color:#ff0;}
 65%{color:#333;}
 70%{color:#cf0;}
 
 75%{color:#cf0;}
 80%{color:#f60;}
 85%{color:#333;}
 85%{color:#ff0;}
 
 85%{color:#f60;}
 90%{color:#cf0;}
 95%{color:#333;}
 100% {color:#f00;}
 }
 #fx2{animation:change2 10s linear 0s infinite;font-size:50px;font-weight:900;}
@keyframes change2{
0% {color:#FF0000;}
 5% {color:#FF0000;}
 7% {color:white;}
 10% {color:#FF00FF;}
 13% {color:#FF00FF;}
 15% {color:#FF00FF;} 
 18%{color:red;} 
 20%{color:#FF00FF;} 
 25%{color:blue;} 
 30%{color:#FF00FF;}
 
 35%{color:#FF0000;}  
 40%{color:blue;}
 45%{color:#FF0000;}
 50%{color:#FF00FF;}
 
 55%{color:white;}
 60%{color:#FF00FF;}
 65%{color:white;}
 70%{color:#FF00FF;}
 
 75%{color:#FF0000;}
 80%{color:violet;}
 85%{color:#FF0000;}
 
 90%{color:violet;}
 95%{color:#333;}
 100% {color:#FF00FF;}
 }
</style>
<script type="text/javascript">
$(function () {
// $("[data-toggle='tooltip']").tooltip({html : true });
	if(<%=shareCode%>!=null){
		$(document).attr('title','智能软件控制建筑材料的价格和数量，让您更轻松！');
		$("#fx").css('display','block');
		$("#fx2").css('display','block');
	}
});
var InterValObj; //timer变量，控制时间
var count = 60; //间隔函数，1秒执行
var curCount;//当前剩余秒数
var myregEmail = /^([\.a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/;
var myregPhone=/^[1][3,4,5,7,8][0-9]{9}$/;
function sendEmail(){
	curCount = count;
	var chare =$("#chare").val();
	 if(myregEmail.test(chare)){
		var isValid = 0;
		var loginType=2;
		$.ajax({
			type : "post",
			url : "<%=basePath%>user/checkLoginEmail",
			data : {
				"chare" : chare,
				"loginType" : loginType
			},
			dataType : "json",
			async: false,
			success : function(data) {
				if (data == "1") {
					isValid = data;
					$("#emailerror").css("color", "red");
					$("#emailerror").html('×该邮箱已被注册!');
				} else if (data == "2") {
					isValid = data;
					$("#emailerror").css("color", "green");
					$("#emailerror").html("");
				}
			}
		});
	if(isValid==2){
		//设置button效果，开始计时
		$("#btn").attr("disabled", "true");
		$("#btn").val( + curCount + "秒再获取");
		InterValObj = window.setInterval(SetRemainTime, 1000); //启动计时器，1秒执行一次
		//$("#btn").attr("disabled", "true");
		//$("#btn").val("已发送验证码");
		//向后台发送处理数据
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
	}else if(myregPhone.test(chare)){
		var isValid = 0;
		var loginType=1;
		$.ajax({
			type : "post",
			url : "<%=basePath%>user/checkLoginEmail",
			data : {
				"chare" : chare,
				"loginType" : loginType
			},
			dataType : "json",
			async: false,
			success : function(data) {
				if (data == "1") {
					isValid = data;
					$("#emailerror").css("color", "red");
					$("#emailerror").html('×该手机号已被注册!');
				} else if (data == "2") {
					isValid = data;
					$("#emailerror").css("color", "green");
					$("#emailerror").html("");
				}
			}
		});
		if(isValid==2){
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
	}else if(!myregEmail.test(chare) || !myregPhone.test(chare)){
		$("#emailerror").html("×请输入有效的手机号/邮箱！");
		return false;
	}
	function SetRemainTime() {
		if (curCount == 0) {                
			window.clearInterval(InterValObj);//停止计时器
			$("#btn").removeAttr("disabled");//启用按钮
			$("#btn").val("重新发送验证码");
//				code = ""; //清除验证码。如果不清除，过时间后，输入收到的验证码依然有效    
		}
		else {
			curCount--;
			$("#btn").val( + curCount + "秒再获取");
		}
	}
}
function register() {
	var name = $("#name").val();
	var userName=$("#userName").val();
	var password = $("#password").val();
	var rePassword = $("#repassword").val();
	var email =$("#email").val();
	var user_code = $("#user_code").val();
	var checked=$("#checked").val();
	var chare =$("#chare").val();
	var myregName=/(^[\u4e00-\u9fa5]{1}[\u4e00-\u9fa5\.·。]{0,8}[\u4e00-\u9fa5]{1}$)|(^[a-zA-Z]{1}[a-zA-Z\s]{0,8}[a-zA-Z]{1}$)/;
	var myreg = /^([\.a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/;
	var reg=/^(?![^a-zA-Z]+$)(?!\D+$)/;
	 if(myregPhone.test(chare)){
		 var loginType=1;
	}else if(myregEmail.test(chare)){
		 var loginType=2;
	}
	if (name.length < 2 || name.length > 20) {
		$("#loginerror").css("color", "red");
		$("#loginerror").html("×企业/组织长度为2-20位");
		return false;
	} else {
		$("#loginerror").css("color", "green");
		$("#loginerror").html("");
	}
	if(!myregName.test(userName)){
		$("#usererror").css("color", "red");
		$("#usererror").html("×创建人只能输入中文和英文");
		return false;
	} else {
		$("#usererror").css("color", "green");
		$("#usererror").html("");
	}
	if (password.length < 6 || password.length > 18) {
		$("#passworderror").css("color", "red");
		$("#passworderror").html('×密码长度为6-18位字母、数字!');
		return false;
	} else {
		$("#passworderror").css("color", "green");
		$("#passworderror").html("");
	}
	if (!reg.test(password)) {
		$("#passworderror").css("color", "red");
		$("#passworderror").html('×密码必须为6-18位字母、数字!');
		return false;
	} else {
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
	 
	var isValid = 0;
	$.ajax({
		type : "post",
		url : "<%=basePath%>company/checkLoginname",
		data : {
			"name" : name
		},
		dataType : "json",
		async: false,
		success : function(data) {
			if (data == 2) {
				isValid = data;
				$("#loginerror").css("color", "green");
				$("#loginerror").html("");
			} else if (data == 1) {
				isValid = data;
				$("#loginerror").css("color", "red");
				$("#loginerror").html('×该企业/组织已存在!');
			}
		}
	});
	if(isValid==2){
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
					$("#codeerror").html('√ 验证码正确');
				} else if (data == 1) {
					isValid = data;
					$("#codeerror").css("color", "red");
					$("#codeerror").html('× 验证码有误，请核实后重新填写!');
				}
			}
		});
		}
	if($("input").filter(":checked").length==0){
		alert("请勾选“阅读并接受注册条款”");
		return false;
		}else{
			$("#loginerror2").html("");
	}
	if(isValid==2){
		$.ajax({
			type : "post",
			url : "<%=basePath%>user/register",
			data : {
				"name" : name,
				"userName" : userName,
				"password" : password,
				"chare" : chare,
				"shareCode" : <%=shareCode%>,
				"loginType":loginType
			},
			dataType : "json",
			success : function(data) {
				if (data == 1) {
					setTimeout("window.location.href='<%=basePath%>user/success.jsp'", 1);
					alert("注册成功！");
				}
			}
		});
	}else {
		alert("注册失败!");
	}
}
function toLogin(){
	parent.top.location.href = "<%=basePath%>/user/login.jsp";
}
//打开模态框
function openPassDlg() {
	$("#passDlg").modal('show');
}
//关闭模态框
function closeDlgs() {
	$("#passDlg").modal('hide');
}
function toDaoHang(){
	parent.top.location.href = "<%=basePath%>daohang.jsp";
}
</script>
</head>
<body>
	<div style="margin-top:200px;">
		<div style="font-size:20px; color: red;display: none; " align="center" id="fx" >
			<br><br><br><br><br><br>
			<div style="font-size:20px; color: red;display: none; " align="center" id="fx2" >
				<strong style="font-size:30px;">您的好友将“建筑材料采购价格和数量的控制系统”分享给您，打开注册试用吧！</strong><br><h1> </h1>
			</div>
			<br>
			<strong  style="font-size:40px;">不试不知道，一试真奇妙！</strong>
			<br><br><br><br>
		</div>
		<div align="center" >
			<h2 style="color: white;font-size: 36px;">注册</h2>
		</div>
		<div class="form-group">
	  		<div class="registerCss">
	  			<input type="text" class="form-control" id="name" data-toggle="tooltip" data-placement="right" title="<h4>请输入名称:企业/组织</h4>" type="text" autocomplete="off" placeholder="名称:企业/组织"  onblur="this.placeholder='名称:企业/组织'" >
	  		</div>
	  		<div class="verification" >
	  			<span id="loginerror" style="display:block;color: red; font-size: 36px;margin-left:15px;"></span>
	  		</div>
	  	</div>
	  	<div class="form-group">
	  		<div class="registerCss">
	  			<input type="text" class="form-control" id="userName"  data-toggle="tooltip" data-placement="right" title="<h4>请输入创建人</h4>" type="text" autocomplete="off"  placeholder="创建人" onblur="this.placeholder='创建人'">
	  		</div>
	  		<div class="verification">
	  			<span id="usererror" style="display:block;color: red; font-size: 36px;margin-left:25px; "></span>
	  		</div>
	  	</div>
  		<div class="form-group">
  			<div class="registerCss">
  				<input type="password" class="form-control" id="password"  data-toggle="tooltip" data-placement="right" title="<h4>请输入密码<h4>" placeholder="密码"  onblur="this.placeholder='密码'" oncontextmenu="return false" onpaste="return false" >
  			</div>
  			<div class="verification">
  				<span id="passworderror" style="display:block;color: red; font-size: 36px;margin-left:25px; "></span>
  			</div>
  		</div>
  		<div class="form-group">
  			<div class="registerCss">
  				<input type="password" class="form-control" id="repassword" data-toggle="tooltip" data-placement="right" title="<h4>请再次确认密码</h4>"  placeholder="再次输入密码" onblur="this.placeholder='再次输入密码'" oncontextmenu="return false" onkeyup="this.value=this.value.replace(/\s+/g,'')" onpaste="return false" />
  			</div>
  			<div class="verification">
  				<span id="repassworderror" style="display:block;color: red; font-size: 36px;margin-left:25px; "></span>
  			</div>
  		</div>
  		<div class="form-group">
			<div class="registerCss" >
				<input class="form-control" type="text" id="chare" name="chare"  data-toggle="tooltip" data-placement="left" title="<h4>请输入手机号/邮箱</h4>" placeholder="手机号/邮箱" onblur="this.placeholder='手机号/邮箱'" autocomplete="off" /> 
			</div>
			<div>
				<input id="btn" name="btn" style="margin-top:-133px; width:280px;height:128px; margin-left: 605px;font-size: 36px;" class="btn btn-default" value="点击获取验证码" onclick="sendEmail()" readonly="readonly" />
  			</div>
  			<div class="verification">
  				<span id="emailerror" style="display:block;color: red; font-size: 36px;margin-left:25px;"></span>
  			</div>
  		</div>
	  	<div class="form-group">
	  		<div class="registerCss">	
				<input type="text" class="form-control" id="user_code" name="user_code" placeholder="验证码" data-toggle="tooltip" data-placement="right" title="<h4>请输入验证码</h4>" onblur="this.placeholder='验证码'" autocomplete="off" onkeyup="value=value.replace(/[^\d]/g,'') ">
			</div>
			<div class="verification">
				<span id="codeerror" style="display:block;color: red; font-size: 36px;margin-left:25px;"></span>
			</div>
		</div>
		<div class="verification">
			<div style="margin-left: 50px;">
				<label style="font-size: 36px;">
					<a onclick="openPassDlg()" role="button" ><input id="check" name="check" type="checkbox"><a onclick="openPassDlg()" role="button" ><span style="color: white;font-size: 36px;">阅读并接受</span>《注册条款》</a>
				</label>
			</div>
		</div>
		<div class="form-group">
			<div class="registerCss">
				<button type="submit" class="btn btn-primary" onclick="register();">立即注册</button>
				<button type="submit" class="btn btn-primary" onclick="toLogin()" >返回登录</button>
			</div>
		</div>
	</div>
	<div id="passDlg" style="font-family: 'Noto Serif CJK SC', 'Noto Serif CJK', 'Source Han Serif SC', ‘Source Han Serif’, source-han-serif-sc, serif;" class="modal fade"  tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content" >
					<div class="modal-header">
						<h4 class="modal-title" id="myModalLabel">注册条款</h4>
					</div>
					<div class="modal-body" style=" overflow:scroll;height:500px;width: 600px;" >
						<div align="center"><h2>买方须知</h2></div>
						<div align="left">一、总则</div>
						1.1. 买方点击本系统注册页面的同意注册按钮并完成注册程序、获得自动采购系统买方账号和密码时，视为买方与北京千瑞恒福科贸有限公司已达成本协议，就买方进入自动采购系统消费（即买方通过自动采购系统终端与卖方进行交易）达成本协议的全部约定。<br>
						1.2. 北京千瑞恒福科贸有限公司及买方均已认真阅读本协议中全部条款，及发布的其他全部服务条款和操作规则的内容，对本协议及前述服务条款和规则均以知晓、理解并接受，同意将其作为确定双方权利义务的依据。<br>
						1.3. 北京千瑞恒福科贸有限公司将不断推出新的服务，本服务条款适用于北京千瑞恒福科贸有限公司提供的各种服务，但当您使用北京千瑞恒福科贸有限公司某一特定服务时，如该服务另有单独的服务条款、指引或规则，您应遵守本服务条款及北京千瑞恒福科贸有限公司随时公布的与该服务相关的服务条款、指引或规则等。前述所有的指引和规则，均构成本服务条款的一部分。除非本服务条款另有其它明示规定，新推出的产品或服务、增加或强化目前本服务的任何新功能，均受到本服务条款的规范。<br>
						1.4. 北京千瑞恒福科贸有限公司有权在必要时修改本服务条款，服务条款一旦发生变动，将会在相关页面上公布修改后的服务条款。如果不同意所改动的条款，用户应主动取消此项服务。如果用户继续使用本服务，则视为接受服务条款的变动。<br>
						1.5. 用户应自行配备上网所需设备，包括电脑、调制解调器或其它必备上网装置，自行负担企业上网所需支付的与此服务有关的电话费用、网络费用。<br>
						1.6. 保证妥善保管好企业工作平台的帐号及相关密码，如果造成帐户信息失密，由此给您带来的损失，均由您自己承担。您应对任何人利用您的账户信息所进行的活动负完全的责任，北京千瑞恒福科贸有限公司无法对非法或未经您授权使用您的账户信息的行为作出甄别，因此北京千瑞恒福科贸有限公司不承担任何责任。<br>
						1.7. 北京千瑞恒福科贸有限公司所提供的项目管理模块为收费方式提供。资费说明标明在网站相应服务的相应页面上。如果用户选择这些增值服务，用户应按有关的收费标准、付款方式支付相关服务费及其它费用。<br>
						1.8. 用户须明确，本服务涉及到互联网及移动通讯等服务，鉴于计算机及互联网的特殊性，因黑客、病毒、Internet 上通路的阻塞、电信部门技术、阿里云公司或政策调整或北京千瑞恒福科贸有限公司为进行服务器配置、维护等造成的服务中断或不能满足用户要求的风险。开通服务的用户须承担以上风险，北京千瑞恒福科贸有限公司对服务的及时性、安全性、准确性不作担保，对因此导致用户不能发送和接受阅读消息、或传递错误，个人设定的时效、未予储存或其它问题不承担任何责任。<br>
						1.9.您知晓并承认关于本服务的使用，北京千瑞恒福科贸有限公司服务器有权为您分配最大的储存空间。通过本服务存储或传送的任何信息、通讯资料和其它内容。您亦同意，长时间未使用的帐号，北京千瑞恒福科贸有限公司有权关闭并收回帐号。您也同意，北京千瑞恒福科贸有限公司有权根据情况，不论通知与否，随时变更这些一般措施及限制。<br>
						1.10. 用户信息收集范围以及使用目的：北京千瑞恒福科贸有限公司仅在用户注册或者使用客户端时，基于账户安全、定位、联络功能、平台协助保障用户相应权益的需要，使用用户的主体信息、个人信息、地址、手机号、电子邮箱、通讯录、当前位置等必要的用户信息。除此之外，北京千瑞恒福科贸有限公司不会收集用户信息。用户同意北京千瑞恒福科贸有限公司基于上述目的及范围收集信息。<br>
						<div align="left">二、买方注册</div>
						2.1.注册资格
						买方承诺：买方具有完全民事权利能力和行为能力。<br>
						2.2.注册目的
						买方承诺：买方进行用户注册并非出于违反法律法规或破坏北京千瑞恒福科贸有限公司交易秩序的目的。<br>
						2.3.买方同意根据买方注册页面的要求提供有效电子邮箱、所在城市等信息，设置自动采购系统账号及密码，买方应确保所提供全部信息的真实性、完整性和准确性。
						<div align="left">三、买方服务</div>
						3.1.买方承诺遵守下列服务规则：<br>
						3.1.1.买方应当遵守法律法规、规章、规范性文件及政策要求的规定，不得在本网站或利用服务从事非法或其他损害或第三方权益的活动。<br>
						3.1.2.买方应当遵守法律法规应当谨慎合理使用和妥善保管网账号及密码，对其注册账号和密码下进行的行为和发生的事件负责。<br>
						3.1.3.买方通过自动采购系统与卖方进行交易时，应当遵守本协议的全部约定及北京千瑞恒福科贸有限公司发布的其他关于交易的服务条款和操作规则的全部规定。<br>
						<div align="left">四、特别声明</div>
						4.1.买方未通过自动采购系统与卖方之间进行的交易不属于网络交易，北京千瑞恒福科贸有限公司对不属于网络交易的交易事项不承担任何责任，买方不得因其与卖方之间因此类交易发生的任何争议投诉北京千瑞恒福科贸有限公司或要求承担任何责任。<br>
						4.2.不论在何种情况下，北京千瑞恒福科贸有限公司对由于信息网络设备维护、信息网络连接故障、电脑、通讯或其他系统的故障、电力故障、罢工、劳动争议、暴乱、起义、骚乱、生产力或生产资料不足、火灾、洪水、风暴、爆炸、战争、政府行为、司法行政机关的命令、其他不可抗力或第三方的不作为而造成的不能服务或延迟服务不承担责任。<br>
						4.3.为了买方更加方便和安全的使用北京千瑞恒福科贸有限公司的服务，北京千瑞恒福科贸有限公司将收集买方与自动采购有关的特征信息，用于标识用户的设备。同时，北京千瑞恒福科贸有限公司会积极采取先进的技术手段和有效的管理机制来保障买方的账户安全，保障买方的隐私信息不被任何未授权的使用或者泄露。<br>
						<div align="left">五、买方服务</div>
						5.1.北京千瑞恒福科贸有限公司建立专业的客服团队，并建立完善的客户服务制度，从技术、人员和制度上保障用户提问及投诉渠道的畅通，为买方提供及时的疑难解答与投诉反馈。
						<div align="left">六、协议的变更和终止</div>
						6.1.协议的变更<br>
						北京千瑞恒福科贸有限公司有权随时对本协议内容或发布的其他服务条款及操作规则的内容进行变更，变更时北京千瑞恒福科贸有限公司将在网站内显著位置发布公告，变更自公告发布之时生效，如买方继续使用自动采购系统提供的服务即视为买方同意该等内容变更，如买方不同意变更后的内容则有权注销账户、停止使用。<br>
						6.2.协议的终止<br>
						6.2.1. 北京千瑞恒福科贸有限公司有权依据本协议约定注销买方的账号，本协议于账号注销之日终止。<br>
						6.2.2. 北京千瑞恒福科贸有限公司有权依据本协议约定终止全部自动采购服务，本协议于北京千瑞恒福科贸有限公司全部服务终止之日终止。<br>
						6.2.3.本协议终止后，买方无权要求北京千瑞恒福科贸有限公司继续向其提供任何服务或履行任何其他义务，包括但不限于为买方保留或向买方披露其原自动采购系统账号中的任何信息，向买方或第三方转发任何其未曾阅读或发送过的信息等。<br>
						<div align="left">七、协议生效</div>
						7.1.本协议于买方点击北京千瑞恒福科贸有限公司自动采购系统注册页面的同意注册并完成注册程序、获得买方账号和密码时生效，对买方具有约束力。
															<div align="center"><h2>卖方须知</h2></div>
						<div align="left">一、总则</div>
						1.1. 卖方点击本系统注册页面的同意注册按钮并完成注册程序、获得自动采购系统卖方账号和密码时，视为卖方与北京千瑞恒福科贸有限公司已达成本协议，就卖方进入自动采购系统销售商品（即卖方通过自动采购系统终端与买方进行交易）达成本协议的全部约定。<br>
						1.2. 北京千瑞恒福科贸有限公司及卖方均已认真阅读本协议中全部条款，及发布的其他全部服务条款和操作规则的内容，对本协议及前述服务条款和规则均以知晓、理解并接受，同意将其作为确定双方权利义务的依据。<br>
						<div align="left">二、用户注册</div>
						2.1.注册资格<br>
						卖方承诺：卖方具有完全民事权利能力和行为能力。<br>
						2.2.注册目的<br>
						卖方承诺：卖方进行用户注册并非出于违反法律法规或破坏北京千瑞恒福科贸有限公司交易秩序的目的。<br>
						2.3.卖方同意根据用户注册页面的要求提供有效电子邮箱、所在城市等信息，设置自动采购系统账号及密码，卖方应确保所提供全部信息的真实性、完整性和准确性。<br>
						<div align="left">三、卖方服务</div>
						3.1.卖方承诺遵守下列服务规则：<br>
						3.1.1.卖方应当遵守法律法规、规章、规范性文件及政策要求的规定，不得在本网站或利用服务从事非法或其他损害第三方权益的活动。<br>
						3.1.2.卖方应当遵守法律法规应当谨慎合理使用和妥善保管网账号及密码，对其注册账号和密码下进行的行为和发生的事件负责。<br>
						3.1.3.卖方通过自动采购系统与买方进行交易时，应当遵守本协议的全部约定及北京千瑞恒福科贸有限公司发布的其他关于交易的服务条款和操作规则的全部规定。<br>
						<div align="left">四、特别声明</div>
						4.1.卖方未通过自动采购系统与买方之间进行的交易不属于网络交易，北京千瑞恒福科贸有限公司对不属于网络交易的交易事项不承担任何责任，卖方不得因其与买方之间因此类交易发生的任何争议投诉北京千瑞恒福科贸有限公司或要求承担任何责任。<br>
						4.2.不论在何种情况下，北京千瑞恒福科贸有限公司对由于信息网络设备维护、信息网络连接故障、电脑、通讯或其他系统的故障、电力故障、罢工、劳动争议、暴乱、起义、骚乱、生产力或生产资料不足、火灾、洪水、风暴、爆炸、战争、政府行为、司法行政机关的命令、其他不可抗力或第三方的不作为而造成的不能服务或延迟服务不承担责任。<br>
						4.3.为了卖方更加方便和安全的使用北京千瑞恒福科贸有限公司的服务，北京千瑞恒福科贸有限公司将收集卖方与自动采购有关的特征信息，用于标识卖方的设备。同时，北京千瑞恒福科贸有限公司会积极采取先进的技术手段和有效的管理机制来保障用户的账户安全，保障用户的隐私信息不被任何未授权的使用或者泄露。<br>
						<div align="left">五、客户服务</div>
						5.1.北京千瑞恒福科贸有限公司建立专业的客服团队，并建立完善的客户服务制度，从技术、人员和制度上保障卖方提问及投诉渠道的畅通，为卖方提供及时的疑难解答与投诉反馈。<br>
						<div align="left">六、协议的变更和终止</div>
						6.1.协议的变更<br>
						北京千瑞恒福科贸有限公司有权随时对本协议内容或发布的其他服务条款及操作规则的内容进行变更，变更时北京千瑞恒福科贸有限公司将在网站内显著位置发布公告，变更自公告发布之时生效，如卖方继续使用自动采购系统提供的服务即视为同意该等内容变更，如不同意变更后的内容则卖方有权注销账户、停止使用。<br>
						6.2.协议的终止<br>
						6.2.1. 北京千瑞恒福科贸有限公司有权依据本协议约定注销卖方的账号，本协议于账号注销之日终止。<br>
						6.2.2. 北京千瑞恒福科贸有限公司有权依据本协议约定终止全部自动采购服务，本协议于北京千瑞恒福科贸有限公司全部服务终止之日终止。<br>
						6.2.3.本协议终止后，卖方无权要求北京千瑞恒福科贸有限公司继续向其提供任何服务或履行任何其他义务，包括但不限于为卖方保留或向卖方披露其原自动采购系统账号中的任何信息，向卖方或第三方转发任何其未曾阅读或发送过的信息等。<br>
						<div align="left">七、协议生效</div>
						7.1.本协议于卖方点击北京千瑞恒福科贸有限公司自动采购系统注册页面的同意注册并完成注册程序、获得卖方账号和密码时生效，对卖方具有约束力。<br>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" onclick="toDaoHang()">不接受</button>
						<button type="button" class="btn btn-primary" onclick="closeDlgs()" >接受</button>
					</div>
				</div>
			</div>
		</div>
</body>
</html>