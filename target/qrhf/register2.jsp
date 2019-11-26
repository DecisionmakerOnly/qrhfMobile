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
.ceshi {
	width: 300px;
	margin: auto;
}
.ceshi input{
	font-size: 18px;
	color: black;
	height: 35px;
}
.ceshi input::-webkit-input-placeholder{
	color: black;
	font-size: 18px;
}
.ceshi select {
	background-color:white;
	color: black;
	font-size: 18px; 
	height: 35px;
	width: 124px;
}
.ceshi button {
	height: 35px;
	width: 145px;
}
.ceshi2 {
	color: white;
	width: 300px;
	margin: auto;
}
.ceshi2 input{
	background-color:white ;
	color: black;
	height: 35px;
	width: 185px;
	margin-left: 118px;
	margin-top: -35px;
}
.btn-default {
	display: inline-block;
	text-align: center;
	cursor: pointer;
	width: 130px;
	height: 35px;
	margin-left:830px;
	margin-top: -35px;
	color: black;
}
.verification{
	color: white;
	width: 300px;
	margin: auto;
}
.fixedTop{
 	position:fixed;
  	head:0px;
    width:100%; 
    height:45px; 
}
.bgStyle{
	position:fixed;
	padding:30px 100px 10px;
	border：1px solid red; 
	height: 300px;
	width: 100%;
	background:url('<%=basePath%>common/images/beijing.png');
	background-size:100%;
	height:600px;
	transform:translateY(10%);
}
.fixed{
    position:fixed;
  	left:0px;
  	bottom:0px;
    width:100%; 
    height:45px; 
   	z-index:9999;
}
.topWord{
	position:fixed;
	margin-top: 35px;
	margin-left:670px;
	width: 900px;
	font-size:16px;
}
</style>
<script type="text/javascript">
<%-- 	if(<%=shareCode%>==null){ --%>
//	$("#shareCodeDisplay").css('display','block');
//}
$(function () { $("[data-toggle='tooltip']").tooltip({html : true });});
var InterValObj; //timer变量，控制时间
var count = 60; //间隔函数，1秒执行
var curCount;//当前剩余秒数
function sendEmail(){
	curCount = count;
	var loginType = $("#loginType").val();
	var chare =$("#chare").val();
	if (loginType == null) {
		alert("选择验证方式:手机号/邮箱");
		return;
	}
	if(loginType==2){
		var myreg = /^([\.a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/;
		if(!myreg.test(chare)){
			$("#emailerror").html("×请输入有效的邮箱！");
			return false;
		}else{
			$("#emailerror").html("");
		}
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
	}else if(loginType==1){
		var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;
		if(!myreg.test(chare)){
			$("#emailerror").html("×请输入有效的手机号！");
			return false;
		}else{
			$("#emailerror").html("");
		}
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
	var loginType=$("#loginType").val();
	var myregName=/(^[\u4e00-\u9fa5]{1}[\u4e00-\u9fa5\.·。]{0,8}[\u4e00-\u9fa5]{1}$)|(^[a-zA-Z]{1}[a-zA-Z\s]{0,8}[a-zA-Z]{1}$)/;
	var myreg = /^([\.a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/;
	var reg=/^(?![^a-zA-Z]+$)(?!\D+$)/;
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
			if (data == "1") {
				isValid = data;
				$("#loginerror").css("color", "red");
				$("#loginerror").html('×该企业/组织已存在!');
			} else if (data == "2") {
				isValid = data;
				$("#loginerror").css("color", "green");
				$("#loginerror").html("");
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
			$("#loginerror").html("");
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
				"loginType":loginType,
				"shareCode" : <%=shareCode%>
			},
			dataType : "json",
			success : function(data) {
				if (data == 1) {
					setTimeout("window.location.href='<%=basePath%>user/success.jsp'", 1);
					alert("注册成功！");
				}
			}
		});
	}else{
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
<body style="font-family: 'Noto Serif CJK SC', 'Noto Serif CJK', 'Source Han Serif SC', ‘Source Han Serif’, source-han-serif-sc, serif;">
	<div class="fixedTop">
	 	<div align="left" class="topWord">成本和效率是企业核心，也是我们致力于解决问题，我们将持续不断完善和改进我们的解决方案，为企业服好务。</div>
	 </div>
	 <div class="bgStyle">
		<div style="padding:1px 3px 1px;background:white; color:black; width: 580px;margin-left:600px; margin-top: -1px;">
			<div align="center">
				<h2 style="color: black">注册</h2>
			</div>
			<div class="form-group">
		  		<div class="ceshi">
		  			<input type="text" class="form-control" id="name" data-toggle="tooltip" data-placement="right" title="<h5>请输入名称:企业/组织</h5>" type="text" autocomplete="off" placeholder="名称:企业/组织" onfocus="this.placeholder=''" onblur="this.placeholder='名称:企业/组织'" >
		  		</div>
		  		<div class="verification" >
		  			<span id="loginerror" style="display:block;color: red; font-size: 18px;margin-left:25px;"></span>
		  		</div>
		  	</div>
		  	<div class="form-group">
		  		<div class="ceshi">
		  			<input type="text" class="form-control" id="userName"  data-toggle="tooltip" data-placement="right" title="<h5>请输入创建人</h5>" type="text" autocomplete="off"  placeholder="创建人" onfocus="this.placeholder=''" onblur="this.placeholder='创建人'">
		  		</div>
		  		<div class="verification">
			  		<span id="usererror" style="display:block;color: red; font-size: 18px;margin-left:25px; "></span>
			  	</div>
			</div>
			<div class="form-group">
				<div class="ceshi">
					<input type="password" class="form-control" id="password"  data-toggle="tooltip" data-placement="right" title="<h5>请输入密码<h5>" placeholder="密码" onfocus="this.placeholder=''" onblur="this.placeholder='密码'" oncontextmenu="return false" onpaste="return false" >
				</div>
				<div class="verification">
					<span id="passworderror" style="display:block;color: red; font-size: 18px;margin-left:25px; "></span>
				</div>
			</div>
			<div class="form-group">
				<div class="ceshi">
					<input type="password" class="form-control" id="repassword" data-toggle="tooltip" data-placement="right" title="<h5>请再次确认密码</h5>"  placeholder="再次输入密码" onfocus="this.placeholder=''" onblur="this.placeholder='再次输入密码'" oncontextmenu="return false" onkeyup="this.value=this.value.replace(/\s+/g,'')" onpaste="return false" />
				</div>
				<div class="verification">
					<span id="repassworderror" style="display:block;color: red; font-size: 18px;margin-left:25px; "></span>
				</div>
			</div>
			<div class="form-group">
				<div class="ceshi">
					<select class="form-control" style="appearance: none; -moz-appearance: none; -webkit-appearance: none;" id="loginType" name="loginType">
						<option style="display: none;" selected="selected" disabled="disabled" value="">手机号/邮箱</option>
						<option value="1">手机号</option>
						<option value="2">邮箱</option>
					</select>
				</div>
				<div class="ceshi2" >
					<input class="form-control" type="text" id="chare" name="chare" onfocus="this.placeholder=''"  autocomplete="off" /> 
				</div>
				<div class="verification">
					<input id="btn" style="margin-left: 310px;" name="btn" class="btn btn-default" value="点击获取验证码" onclick="sendEmail()" readonly="readonly" />
					<span id="emailerror" style="display:block;color: red; font-size: 18px;margin-left:25px;"></span>
				</div>
			</div>
		  	<div class="form-group">
		  		<div class="ceshi">	
					<input type="text" class="form-control" id="user_code" name="user_code" placeholder="验证码" data-toggle="tooltip" data-placement="right" title="<h5>请输入验证码</h5>" onfocus="this.placeholder=''" onblur="this.placeholder='验证码'" autocomplete="off" onkeyup="value=value.replace(/[^\d]/g,'') ">
				</div>
				<div class="verification">
					<span id="codeerror" style="display:block;color: red; font-size: 18px;margin-left:25px; "></span>
				</div>
			</div>
			<div class="verification">
				<div style="margin-left: 40px;">
					<label>
					<a onclick="openPassDlg()" role="button" ><input id="check" name="check" type="checkbox"><a onclick="openPassDlg()" role="button" ><span style="color: black;font-size: 14px;">阅读并接受</span>《注册条款》</a>
					</label>
				</div>
			</div>
			<div class="form-group">
				<div class="ceshi">
					<button type="submit" class="btn btn-primary" onclick="register();">立即注册</button>
					<button type="submit" class="btn btn-primary" onclick="toLogin()" >返回登录</button>
				</div>
			</div>
	</div>
</div>
<div class="fixed">
	<div align="center"> © 2019 www.zdcigo.com 版权所有</div>
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
						1.1. 买方点击本系统注册页面的同意注册按钮并完成注册程序、获得自动采购系统买方账号和密码时，视为买方与北京千瑞恒福科贸有限公司已达成本协议，
						就买方进入自动采购系统消费（即买方通过自动采购系统终端与卖方进行交易）达成本协议的全部约定。<br>
						1.2. 北京千瑞恒福科贸有限公司及买方均已认真阅读本协议中全部条款，及发布的其他全部服务条款和操作规则的内容，对本协议及前述服务条款和规则均以知晓、理解并接受，同意将其作为确定双方权利义务的依据。
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