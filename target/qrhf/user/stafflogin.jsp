<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	User user = (User) request.getSession().getAttribute("user");
	Integer id = user.getId();
	String loginName = user.getLoginName();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- Bootstrap 不支持 IE 古老的兼容模式。为了让 IE 浏览器运行最新的渲染模式下，建议将此 <meta> 标签加入到你的页面中 -->
<meta name="renderer" content="webkit">
<!-- 将下面的 <meta> 标签加入到页面中，可以让部分国产浏览器默认采用高速模式渲染页面 -->
<link href='<%=basePath%>common/css/bootstrap.css'
	rel='stylesheet'>
<link
	href='<%=basePath%>common/css/bootstrap-table.css'
	rel='stylesheet'>
<link
	href='<%=basePath%>common/css/bootstrap-treeview.css'
	rel='stylesheet'>
<script type='text/javascript'
	src='<%=basePath%>common/js/base.js'></script>
<script type='text/javascript'
	src='<%=basePath%>common/js/jquery.form.js'></script>
<script type='text/javascript'
	src='<%=basePath%>common/js/respond.min.js'></script>
<script type='text/javascript'
	src='<%=basePath%>common/js/jquery-3.2.1.min.js'></script>
<script type='text/javascript'
	src='<%=basePath%>common/js/bootstrap.js'></script>
<script type='text/javascript'
	src='<%=basePath%>common/js/bootstrap-table.js'></script>
<script type='text/javascript'
	src='<%=basePath%>common/js/bootstrap-table-zh-CN.js'></script>
<script type='text/javascript'
	src='<%=basePath%>common/js/bootstrap-treeview.js'></script>
</head>
<script type="text/javascript">

	function addStaff() {
		var password = $("#passwords").val();
		var rePassword = $("#repassword").val();
		var reg=/^(?![^a-zA-Z]+$)(?!\D+$)/;
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
			$("#repassworderror").html("×两次输入密码不一致");
			return false;
		} else {
			$("#repassworderror").css("color", "green");
			$("#repassworderror").html("");
		} 
		$.post(
				"<%=basePath%>user/addStaff",
				/* $("#staff").serialize(), */
				{"id":$("#id").val(),
				 "loginName":$("#loginName").val(),
				"password":$("#passwords").val()},
				function (staff) {
					if(staff==1){
						alert("添加成功");
						closeModal(); 
					}else{
						alert("添加失败");
						return;
					}
				}
			)
			 
	}
</script>
<body>
	<div class="modal-dialog" role="document">
		<div class="modal-content" >
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">完善信息</h4>
			</div>
			<div class="container">
				<form class="form-horizontal" id="staff" onsubmit="return false"
					action="##" method="post">
					<input type="hidden" id="id" name="id" value="<%=id%>">
					<div class="form-group" style="width:80%">
						<label class="col-md-2 control-label" for="loginName">账号</label>
						<div class="col-md-3 ">
							<input type="text" class="form-control" name="loginName"
								id="loginName" value="<%=loginName%>" readonly="readonly">
						</div>
					</div>

					<div class="form-group" style="width:80%">
						<label class="col-md-2 control-label" for="passwords">密码</label>
						<div class="col-md-3 ">
							<input type="password" class="form-control" name="passwords"
								id="passwords" placeholder="请填写密码(必填)"
								onkeyup="this.value=this.value.replace(/\s+/g,'')">
							<span id="passworderror" style="color: red;"></span>
						</div>
					</div>
					<div class="form-group" style="width:80%">
						<label class="col-md-2 control-label" for="repassword">再次确认密码</label>
						<div class="col-md-3 ">
							<input type="password" class="form-control" name="repassword"
								id="repassword" placeholder="请再次填写密码(必填)"
								onkeyup="this.value=this.value.replace(/\s+/g,'')">
							<span id="repassworderror" style="color: red;"></span>
						</div>
					</div>
				</form>
			</div>
				<div class="modal-footer">
					<input type="button" class="btn btn-default pull-right" value="提交"
						onclick="addStaff()">
				</div>
		</div>
	</div>

	<%-- <div align="center">
    <h1>完善信息</h1>
</div>
    <div class="container-fluid" style="width: 100%; height: 100%; margin: auto;">
		<div style="width: 30%; height: 100%; margin: auto;"> 
        <form class="form-horizontal" id="staff" onsubmit="return false" action="##" method="post"> 
        <input type="hidden" id = "id" name="id" value="<%=id %>">
        	<div class="form-group">
				<label class="col-md-2 control-label" for="loginName">账号</label> 
				<input type="text" class="form-control" name="loginName" id="loginName" value="<%=loginName %>" readonly="readonly">
		    </div>
		    
		    <div class="form-group">
				<label class="col-md-2 control-label" for="password">密码</label> 
				<input type="password" class="form-control" name="password" id="password" 
				placeholder="请填写密码(必填)" onkeyup="this.value=this.value.replace(/\s+/g,'')">
			</div>
				<span id="passworderror" style="color: red;"></span>
		    <div class="form-group">
				<label class="col-md-2 control-label" for="repassword">再次确认密码</label> 
				<input type="password" class="form-control" name="repassword" id="repassword" 
				placeholder="请再次填写密码(必填)" onkeyup="this.value=this.value.replace(/\s+/g,'')">
			</div>
				<span id="repassworderror" style="color: red;"></span>
         </form> 
        <input type="button" class="btn btn-default pull-right" value="提交" onclick="addStaff()">
    </div>
</div> --%>
</body>
</html>