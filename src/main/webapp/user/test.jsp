<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>My JSP 'test.jsp' starting page</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
</head>
<body>
	<div class="modal-header">
		
		<h4 class="modal-title" id="myModalLabel">选择部门</h4>
	</div>
	<div class="container">
		<form class="form-horizontal" id="authForm" method="post">
			<div class="form-group">
				<label class="col-md-2 control-label">角色权限：</label>
				<div class="col-md-3 ">
					<div id="tree"></div>
				</div>
			</div>
		</form>
	</div>
</body>
</html>
