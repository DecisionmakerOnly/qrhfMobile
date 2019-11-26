<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type"
	content="multipart/form-data; charset=utf-8" />
<title>注册供应商</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- Bootstrap 不支持 IE 古老的兼容模式。为了让 IE 浏览器运行最新的渲染模式下，建议将此 <meta> 标签加入到你的页面中 -->
<meta name="renderer" content="webkit">
<!-- 将下面的 <meta> 标签加入到页面中，可以让部分国产浏览器默认采用高速模式渲染页面 -->
<link rel="stylesheet" href="<%=basePath%>common/css/bootstrap.css" type="text/css" />
<script type="text/javascript" src="<%=basePath%>common/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/jquery.form.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap.js"></script>
</head>

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
 	/* document.getElementById("col-md-10").appendChild(iframe);
	toSellerTree(); */
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

	function addSeller() {
		var name = $("#name").val();
		var type = $("#type").val();
		var address = $("#address").val();
		var infor = $("#infor").val();
		var file = $("#file").val();
		var myregPhone =/^1[0-9]{10}$/;
		var contact = $("#contact").val();
		
		var suffixIndex=file.lastIndexOf(".");  
		var suffix=file.substring(suffixIndex+1).toUpperCase();  
		
		if (name.length < 2 || name.length > 20) {
			$("#nameerror").css("color", "red");
			$("#nameerror").html("×供应商名称长度为2-20位");
			return false;
		} else {
			$("#nameerror").css("color", "green");
			$("#nameerror").html("√供应商名称验证通过！");
		}
		if (type=="") {
			$("#typeerror").css("color", "red");
			$("#typeerror").html("公司类型不能为空");
			return false;
		} else {
			$("#typeerror").css("color", "green");
			$("#typeerror").html("√公司类型验证通过！");
		}
		
		if (address=="") {
			$("#addresserror").css("color", "red");
			$("#addresserror").html("公司地址不能为空");
			return false;
		} else {
			$("#addresserror").css("color", "green");
			$("#addresserror").html("√公司地址验证通过！");
		}
		
		if(representative==""){
			$("#usererror").css("color", "red");
			$("#usererror").html("×法定代表人不能为空");
			return false;
		} else {
			$("#usererror").css("color", "green");
			$("#usererror").html("√法定代表人验证通过！");
		}
		
		if(!myregPhone.test(contact)){
			$("#phoneerror").css("color", "red");
			$("#phoneerror").html("×请输入有效的手机号码！");
			return false;
		}else {
			$("#phoneerror").css("color", "green");
			$("#phoneerror").html("√手机号码验证通过！");
		} 
		
		if (infor=="") {
			$("#inforerror").css("color", "red");
			$("#inforerror").html("经营范围不能为空");
			return false;
		} else {
			$("#inforerror").css("color", "green");
			$("#inforerror").html("√经营范围验证通过！");
		}
		
		if (file=="") {
			$("#fileerror").css("color", "red");
			$("#fileerror").html("请上传图片");
			return false;
		}else if(suffix!="BMP"&&suffix!="JPG"&&suffix!="JPEG"&&suffix!="PNG"){  
		    $("#fileerror").html("请上传图片（格式BMP、JPG、JPEG、PNG等）!");
			return false;
		}else {
			$("#fileerror").css("color", "green");
			$("#fileerror").html("√图片验证通过！");
		}
		
		 var isValid = 0;
		 $.ajax({
				type : "post",
				url : "<%=basePath%>seller/checkName",
				data : {
					"name" : name
				},
				dataType : "json",
				async: false,
				success : function(data) {
					if (data == "1") {
						isValid = data;
						$("#nameerror").css("color", "red");
						$("#nameerror").html('×该供应商已存在!');
					} else if (data == "2") {
						isValid = data;
						$("#nameerror").css("color", "green");
						$("#nameerror").html("√该名称可以注册");
					}
				}
			});
		
		if(isValid == 2){
			$.ajax({
				type : "post",
				url : "<%=basePath%>seller/checkContact",
				data : {
					"contact" : contact
				},
				dataType : "json",
				async: false,
				success : function(data) {
					if (data == "1") {
						isValid = data;
						$("#nameerror").css("color", "red");
						$("#nameerror").html('×该手机号已存在!');
					} else if (data == "2") {
						isValid = data;
						$("#nameerror").css("color", "green");
						$("#nameerror").html("√该手机号可以注册");
					}
				}
			});
		}
		
		if(isValid == 2){
				$("#seller").ajaxSubmit({
			        type:"post",
			        url:"<%=basePath%>seller/addSeller",
			        dataType:"json",
			        success:function(data){
			        	//使用ajaxsubmit必须要判断，否则不会执行成功回调函数
			        	if(data ==1){
			        		alert("添加成功")
				        	location.href="<%=basePath%>seller/compareSeller";
			        	}else{
			        		alert("添加失败")
			        		return;
			        	}
			        }
			    });
			} 
		}
</script>
<body>
	<div align="center">
		<h1>供应商信息</h1>
		<h4>一个供应商只能和一个账号绑定; 绑定后无法注销; 申请到正式开通预计需1~3个工作日。</h4>
	</div>
	
	<div class="container-fluid"
		style="width: 100%; height: 100%; margin: auto;">
		<div style="width: 30%; height: 30%; margin: auto;">
			<form id="seller" onsubmit="return false" action="##" method="post"
				enctype="multipart/form-data">

				<div class="form-group">
					<label for="name">名称</label> <input type="text"
						class="form-control" name="name" id="name" placeholder="请按照营业执照填写">
					<span id="nameerror" style="color: red;"></span>
				</div>
				<div class="form-group">
					<label for="type">类型</label> <input type="text"
						class="form-control" name="type" id="type" placeholder="请按照营业执照填写">
					<span id="typeerror" style="color: red;"></span>
				</div>
				<div class="form-group">
					<label for="address">地址</label> <input type="text"
						class="form-control" name="address" id="address"
						placeholder="请按照营业执照填写"> <span id="addresserror"
						style="color: red;"></span>
				</div>
				<div class="form-group">
					<label for="representative">法定代表人</label> <input type="text"
						class="form-control" name="representative" id="representative"
						placeholder="请按照营业执照填写">
					<span id="usererror" style="color: red;"></span>
				</div>
				<div class="form-group">
					<label for="contact">手机号码</label> <input type="text"
						class="form-control" name="contact" id="contact"
						placeholder="联系方式"> <span id="phoneerror"
						style="color: red;"></span>
				</div>
				<div class="form-group">
					<label for="infor">经营范围</label>
					<textarea class="form-control" rows="3" name="infor" id="infor"
						placeholder="请按照营业执照填写"></textarea>
					<span id="inforerror" style="color: red;"></span>
				</div>
				<div class="form-group">
					<label for="imgUrl">主页图片</label> <input type="file"
						class="form-control" name="file" id="file" placeholder="上传主页图片">
					<span id="fileerror" style="color: red;"></span>
				</div>
				<input type="button" class="btn btn-default pull-right" value="提交" onclick="addSeller()">
					<br><br><br><br><br><br><br><br><br>
			</form>
		</div>
	</div>
</body>
</html>