<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+ path + "/";
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
	Integer companyId=user.getCompanyId();
	String pageId = request.getParameter("pageId");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- Bootstrap 不支持 IE 古老的兼容模式。为了让 IE 浏览器运行最新的渲染模式下，建议将此 <meta> 标签加入到你的页面中 -->
<meta name="renderer" content="webkit">
<!-- 将下面的 <meta> 标签加入到页面中，可以让部分国产浏览器默认采用高速模式渲染页面 -->
<script type="text/javascript" src="<%=basePath%>common/js/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="<%=basePath%>common/css/bootstrap.css" type="text/css" />
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap.js"></script>
<link href="<%=basePath%>common/plugin/css/main.css" rel="stylesheet">
<script src="<%=basePath%>common/plugin/js/distpicker.data.min.js"></script>
<script src="<%=basePath%>common/plugin/js/distpicker.min.js"></script>
<script src="<%=basePath%>common/plugin/js/main.js"></script>
<script
	src="<%=basePath%>common/plugin/My97DatePicker/WdatePicker.js"></script>
</head>
<script>
function edit() {
		var name = $("#name").val();
		var isValid = 0;
		if(name==""){
			alert("角色名称不可为空!");
			return;
		}
		if(checkRole(name)==1){
			alert("角色名称已存在!");
			return false;
		}
		var data =  checkRepeats(name,<%=companyId%>);
	  	if (data == "1") {
			isValid = data;
			alert('角色名称已存在!');
			return false;
		} else if (data == "2") {
			isValid = data;
		}
		if(isValid==2){
		$.post(
				"<%=basePath%>sysRole/updateRole",
				$("#sysRole").serialize(),
				function () {
					alert("修改成功")
					window.location.href="<%=basePath%>/role/list.jsp?pageId="+<%=pageId%>;
				}
			) 
		}
}
	function checkRepeats(name,companyId){
		 var num = 0;
		 $.ajax({
	   		type : "post",
	   		url : "<%=basePath%>sysRole/checkRepeat",
	   		data : {
	   			"name":name,
	   			"companyId":<%=companyId%>
	   		},
	   		dataType : "json",
	   		async: false,
	   		success : function(data) {
	   			num = data;
	   		}
	   	});
		 return num;
	}
	function checkRole(name) {
			var num = 0;
			$.ajax({
				dataType : "json",
				type : "post",
				async: false,//同步
				url : "<%=basePath%>role/checkRole",
				data:{"name":name},
				success : function(data) {
					num = data;
				}
			});
			
			return num;
	 } 
    function roleList(){
    	window.location.href="<%=basePath%>/role/list.jsp?pageId="+<%=pageId%>;
	}
</script>
<body>
	<div align="center">
		<h1>修改角色信息</h1>
	</div>
	<div class="container-fluid"
		style="width: 100%; height: 100%; margin: auto;">
		<div style="width: 40%; height: 40%; margin: auto;">
			<form id="sysRole">
			<input type="hidden" name="id" value="${sysRole.id }">
				<div class="form-group">
					<label for="condition">职位</label> 
					<input type="text" class="form-control" name="name" id="name" value="${sysRole.name }" autocomplete="off">
				</div>
<!-- 				<div class="form-group"> -->
<!-- 					<label for="condition">编码</label> <input type="text" -->
<!-- 						class="form-control" name="code" id="code" -->
<%-- 						value="${sysRole.code }" autocomplete="off"> --%>
<!-- 				</div> -->
<!-- 				<span id="codeerror" style="color: red;"></span> -->
				<input type="button" class="btn btn-default pull-right" onclick="roleList()" value="取消" /> 
				<input type="button" class="btn btn-default pull-right" onclick="edit()" value="确定" />
			</form>
		</div>
	</div>
</body>
</html>