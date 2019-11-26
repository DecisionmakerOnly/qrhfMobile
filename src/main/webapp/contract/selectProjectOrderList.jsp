<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>创建项目模态框</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link href='<%=basePath%>common/css/bootstrap.css' rel='stylesheet'>
<link href='<%=basePath%>common/css/bootstrap-table.css' rel='stylesheet'>
<link href='<%=basePath%>common/css/bootstrap-treeview.css' rel='stylesheet'>
<script type='text/javascript' src='<%=basePath%>common/js/base.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/respond.min.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/jquery-3.2.1.min.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/bootstrap.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/bootstrap-table.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/bootstrap-table-zh-CN.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/bootstrap-treeview.js'></script>
<script type="text/javascript">
</script>
</head>
<body>
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">创建项目</h4>
			</div>
			<div class="container">
				<form class="form-horizontal" id="person" method="post">
					<div class="form-group">
						<label class="col-md-2 control-label">选择项目：</label>
						<div class="col-md-3 ">
							<input type="text" class="form-control" name="name" id="name" placeholder="项目名称">
						</div>
						<span id="projecterror" style="color: red;"></span>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label">选择采购单：</label>
						<div class="col-md-3 ">
							<select class="form-control" name="jurisdiction"
								id="jurisdiction">
								<option value="">==请选择==</option>
								<option value="1">本公司</option>
								<option value="2">本部门</option>
								<option value="3">自己</option>
							</select>
						</div>
					</div>
					<span id="jurisdictionerror" style="color: red;"></span>
					<div class="modal-footer col-md-6">
						<button type="button" class="btn btn-default" onclick="closeModal()">关闭</button>
						<button type="button" onclick="add()" class="btn btn-primary">保存</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>