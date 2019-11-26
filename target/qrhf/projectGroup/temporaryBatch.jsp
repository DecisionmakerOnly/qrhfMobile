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
<title>临时分批</title>
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
	function saveProjectGroup(){
		var title=$("#remark").val();
		if(title==""||title==null){
			alert("申请原因不能为空！");
			return false;
		}else{
			$.ajax({
				url:'sysFlow/temporaryBatch.action',
				dataType:'json',
				type:'post',
				traditional:true,
				data:{
					pageId:<%=pageId%>,
					projectId:<%=recordId%>,
					buyerId:<%=userId%>,
					title:title,
					companyId:<%=companyId%>
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
	
	}
	
	function closeModal(){
		<%
			session.setAttribute("pageId",2);
		%>
		window.location.href="<%=basePath%>main.jsp";
	}
</script>
</head>
<body>
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
					<div class="alert alert-danger alert-dismissable" >
						<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
							有审批流程未完成或存在采购表，不能进行分批设置！如需修改分批设置请进入[采购分批列表]进行修改。如需新增分批设置请点击[申请]进行申请
						</div>
			</div>
			<div class="container">
				<div class="form-group">
					<textarea rows="5%" cols="78%" id="remark" ></textarea>
				</div>
				<div class="modal-footer col-md-6">
					<button type="button" class="btn btn-default" onclick="closeModal()">关闭</button>
					<button type="button" onclick="saveProjectGroup()" class="btn btn-default">申请</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
