<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
	String quotaPageId = request.getParameter("quotaPageId");
	String id=request.getParameter("id");
	Integer companyId=user.getCompanyId();
	String quotaId=request.getParameter("id");
	String quotaName=request.getParameter("quotaName");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<base href="<%=basePath%>">
<title>工程详情</title>
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
	function toExport(){
		window.location.href = "<%=basePath%>quota/toExport?id=<%=id%>&companyId=<%=companyId%>&quotaId=<%=quotaId%>";
		closeModal();
	}
</script>
</head>
<body>
<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">工程详情</h4>
			</div>
			<div class="container">
				<form class="form-horizontal" id="contractForm" method="post">
					<div class="form-group">
						<div class="col-md-3" style="width:600px">
				<ul class="list-group">
					<c:forEach items="${list}" var="quota" varStatus="status">
					<li class="list-group-item">项目分类：${quota.linkageName}</li>
					<li class="list-group-item">项目描述：${quota.name}</li>
					<li class="list-group-item">施工地址：${quota.region}</li>
					<li class="list-group-item">技工人数：${quota.seniorWorker}</li>
					<li class="list-group-item">技工金额/天：${quota.seniorWorkerWages}元</li>
					<li class="list-group-item">普工人数：${quota.primaryWorker}</li>
					<li class="list-group-item">普工金额/天：${quota.primaryWorkerWages}元</li>
					<li class="list-group-item">机械数：${quota.mechanics}</li>
					<li class="list-group-item">机械金额/天：${quota.mechanicsWages}元</li>
					<li class="list-group-item">完成工程量：${quota.workloadUnit}</li>
					<li class="list-group-item">有机定额：${quota.organicQuota}</li>
					</c:forEach>
				</ul>
			</div>
					</div>
					<div class="modal-footer col-md-6">
						<button type="button" class="btn btn-default" onclick="closeModal()">关闭</button>
						<button type="button" class="btn btn-primary" onclick="toExport()">导出此工程方案</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>