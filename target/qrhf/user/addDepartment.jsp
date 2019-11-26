<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String companyId = request.getParameter("companyId");
	String userId = request.getParameter("userId");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>修改部门</title>
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
	$(function(){
		initTree();
	})
	
	function initTree(){
		$.ajax({
			dataType : "json",
			type : "post",
			url : "<%=basePath%>department/tree.action?companyId="+<%=companyId%>,
			success : function(data) {
				//加载部门树
				$('#tree').treeview({
					levels : 9, //设置继承树默认展开的级别 。默认为2展开第一级
					showBorder : false,
					data : [ data ]
				});
				//节点选中时触发
				$('#tree').on('nodeSelected', function(event, data) {  
					if (data.id != undefined) {
						$.ajax({
							dataType : "json",
							type : "post",
							url : "<%=basePath%>user/updateUserDepartment.action?userId=<%=userId%>&departmentId="+data.id,
							success : function(data) {
								alert("更改部门成功!");
								closeModal();
							}
						}); 
					}
				});
			}
		});
	}

	//关闭模态框
	function closeDlg(){
		closeModal();
	};
</script>
</head>
<body>
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">选择部门</h4>
			</div>
			<div class="container">
				<form class="form-horizontal" id="authForm" method="post">
					<div class="form-group">
						<a><label class="col-md-2 control-label">角色权限：</label></a>
						<div class="col-md-3 ">
							<div id="tree" style="height:500px;overflow: auto;"></div>
						</div>
					</div>
					<div class="modal-footer col-md-6">
						<button type="button" class="btn btn-default" onclick="closeDlg()">关闭</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
