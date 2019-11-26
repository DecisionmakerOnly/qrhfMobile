<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
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
	font-family: 'Noto Serif CJK SC', 'Noto Serif CJK', 'Source Han Serif SC', ‘Source Han Serif’, source-han-serif-sc, serif;
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
}
.ceshi button {
	height: 45px;
	width: 300px;
}
</style>
<script type="text/javascript">
$(function () { $("[data-toggle='tooltip']").tooltip({html : true });
});
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
		var loginName=$("#loginName").val();
		var password=$("#password").val()
		$.ajax({
			type:'post',
			dataType:'json',
			url:'<%=basePath%>admin/login.action',
			data:$("#form").serialize(),
			success:function(data){
				if(data.i ==0){
						location.href="<%=basePath%>admin/daohang.jsp";
				}else if(data.i ==1){
					alert("密码不正确");
				}else if(data.i==2){
					alert("此账号不存在！");
				}
			},
			error:function(){
				alert("请求失败！");
			}
		});
	}else{
		return false;
	}
}
	// 登录的回车事件
	$(window).keydown(function(event) {
	    if (event.keyCode == 13) {
	    	$('.log-btn').trigger('click');
	    	}
	   });
</script>
</head>
<body style="font-family: 'Noto Serif CJK SC', 'Noto Serif CJK', 'Source Han Serif SC', ‘Source Han Serif’, source-han-serif-sc, serif;">
	<form id="form" class="form-horizontal" method="post" style="margin-left:505px; width: 470px;">
		<div style="padding:30px 100px 10px;">
			<br/><br/><br/><br/><br/>
		  	<div class="form-group" >
		  		<div class="ceshi" >
		  			<input class="form-control" type="text" name="loginName" id="loginName" data-toggle="tooltip" data-placement="right" title="<h4>请输入您的手机号/账号</h4>" placeholder="手机号/账号" oncontextmenu="return false" onfocus="this.placeholder=''" onblur="this.placeholder='手机号/账号'" autocomplete="off" />
		  		</div>
		  	</div>
		  	<div class="form-group">
		  		<div class="ceshi">
		  			<input class="form-control" data-toggle="tooltip" data-placement="right" title="<h4>请输入您的密码</h4>" type="password" name="password" id="password" placeholder="密码" onfocus="this.placeholder=''" onblur="this.placeholder='密码'" oncontextmenu="return false" onpaste="return false" />
		  		</div>
		  	</div>
			<div class="form-group has-feedback">
				<div class="ceshi">
					<button type="submit" class="btn btn-primary log-btn" onclick="doLogin()" >登     录</button>
				</div>
			</div>
		</div>
	</form>
</body>
</html>