<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
	String projectId=request.getParameter("projectId");
	String projectPageId = request.getParameter("projectPageId");
	session.setAttribute("pageId",projectPageId);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<title>删除</title>
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
	function deleteProjects(){
		$.post(
				"<%=basePath%>projectOrder/selectOrderQuantity.action",
				{"projectId":<%=projectId%>},
				function(data) {
					if(data==0){
						$.ajax({
							dataType : "json",
							type : "post",
							url : "<%=basePath%>project/projectGoodsDel?projectId="+<%=projectId%>,
							success : function(data) {
								alert("删除成功！");
								window.location.href="<%=basePath%>main.jsp";
							}
						});
					}else if(data==1){
						alert("已上传采购表，请先删除采购表再删除项目采购控制表");
					}else if(data==2){
						alert("有采购流程未完成，请先完成待办事项中的流程再删除项目采购控制表");
					}
				}
			)
	}
</script>
</head>
<body>
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">已上传项目采购控制表，如需要重新上传请申请删除。</h4>
			</div>
			<div class="container">
					<div class="modal-footer col-md-6">
						<button type="button" class="btn btn-default" onclick="closeModal()">确定</button>
<!-- 						<button type="button" onclick="deleteProjects()" class="btn btn-primary">删除</button> -->
					</div>
			</div>
		</div>
	</div>
</body>
</html>