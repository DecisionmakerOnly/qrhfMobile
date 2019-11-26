<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
	Integer companyId = user.getCompanyId();
	String sysResourceName = new String(request.getParameter("sysResourceName").getBytes("iso8859-1"),"utf-8");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>意见反馈</title>
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
	function feedback(){
		var opinion =$("#opinion").val();
		if(opinion == null || opinion ==""){
			alert("请填写意见");
			return;
		}
		$.ajax({
			type: "POST",//方法类型
			dataType: "text",//预期服务器返回的数据类型
			url: "<%=basePath%>feedback/saveFeedback.action",
			data: $('#feedback').serialize(),
			async: false,
			success: function (data) {
				if (data == 1){
					alert("提交成功");
					window.location.href="<%=basePath%>main.jsp";
				}
			}
		});
	}
</script>
</head>
<body>
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<form class="form-horizontal" id="feedback" method="post">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">意见反馈</h4>
				</div>
				<div class="container">
					<div class="form-group">
						<input type="hidden" name="userId" id="userId" value="<%=userId%>"/>
						<input type="hidden" name="companyId" id="companyId" value="<%=companyId%>"/>
						<input type="hidden" name="sysResourceName" id="sysResourceName" value="<%=sysResourceName%>"/>
						<textarea style="margin-left:10px;" rows="5%" cols="78%" id="opinion" name="opinion"></textarea>
					</div>
					<div class="modal-footer col-md-6">
						<button type="button" class="btn btn-default" onclick="closeModal()">关闭</button>
						<button type="button" class="btn btn-default" onclick="feedback()">提交</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>