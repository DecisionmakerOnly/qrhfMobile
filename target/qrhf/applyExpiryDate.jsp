<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageId = request.getParameter("pageId");
	String recordId = request.getParameter("recordId");
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
	Integer companyId=user.getCompanyId();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>申请延长试用期</title>
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
	function applyExpiryDate(){
		$.ajax({
			url:'applyExpiryDate/addApplyExpiryDate.action',
			dataType:'json',
			type:'post',
			traditional:true,
			data:{
				companyId:<%=companyId%>,
				userId:<%=userId%>,
				reason:$("#reason").val()
			},
			success:function(data){
				if(data){
					alert("申请成功！");
				}else{
					alert("申请失败！");
				}
				window.location.href="<%=basePath%>main.jsp";
			}
		})
	}
	function closeWindow(){
		location.href="<%=basePath%>main.jsp";
	}
</script>
</head>
<body>
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">申请延期</h4>
			</div>
			<div class="container">
				<div class="form-group" id="btnData">
				</div>
				<div class="form-group">
					<textarea rows="5%" cols="78%" id="reason" ></textarea>
				</div>
				<div class="modal-footer col-md-6">
					<button type="button" class="btn btn-default" onclick="closeWindow()">关闭</button>
					<button type="button" onclick="applyExpiryDate()" class="btn btn-default">申请</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
