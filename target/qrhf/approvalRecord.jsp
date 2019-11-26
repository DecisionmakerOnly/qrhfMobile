<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String id = request.getParameter("id");
	String taText = new String(request.getParameter("taText").getBytes("iso8859-1"),"utf-8");
	String opinion = new String(request.getParameter("opinion").getBytes("iso8859-1"),"utf-8"); 
	String userName = new String(request.getParameter("userName").getBytes("iso8859-1"),"utf-8"); 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>临时权限</title>
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

function pass(status) {
	$.post(
			"<%=basePath%>sysFlow/updateApprovalStatus",
			{id:<%=id%>,status:status},
			function() {
 				location.reload(); 
			}
		)
}

	
</script>
</head>
<body>
	
	<div class="modal-dialog" id="record" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">投资人建议</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						投资人<%=userName%>对<%=taText%>的建议：<%=opinion%>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" onclick="pass(3)">已读</button>
				</div>
			</div>
		</div>
</body>
</html>
