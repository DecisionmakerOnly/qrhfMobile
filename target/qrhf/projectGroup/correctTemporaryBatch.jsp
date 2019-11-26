<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=utf-8"%> 
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)request.getSession().getAttribute("user");
	int userId = user.getId();
	int companyId = user.getCompanyId();
	String userName = user.getUserName();
	
	String taId = request.getParameter("taId");
	
	String projectName=new String(request.getParameter("projectName").getBytes("iso8859-1"),"utf-8"); 
	String applicantName=new String(request.getParameter("applicantName").getBytes("iso8859-1"),"utf-8"); 
	String title = new String(request.getParameter("title").getBytes("iso8859-1"),"utf-8"); 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>临时分批（同意、拒绝）</title>
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
	function save(num){
		$.ajax({
		    type: "POST",//方法类型
		    dataType: "json",//预期服务器返回的数据类型
		    url: "<%=basePath%>sysFlow/updateTemporaryBatch.action",
		    data: {
				sysFlowId:<%=taId%>,
				num:num
			},
		    async: false,
		    success: function (data) {
		    	if(num==1){
		    		saveLog("<%=companyId%>","<%=userId%>",1,"投资人代表同意了<%=applicantName%>对《<%=projectName%>》项目进行分批设置","");
		    	}
		    	location.href="<%=basePath%>main.jsp";
		    }
		});  
	}	
	
</script>
</head>
<body>
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">申请分批操作</h4>
			</div>
			<div class="container">
				<div class="form-group">
					<%=title%>
					<input type="hidden" id="taText" value="<%=title%>">
				</div>
				<div class="modal-footer col-md-6">
					<button type="button" class="btn btn-default" onclick="save(0)">拒绝</button>
					<button type="button" class="btn btn-default" onclick="save(1)">同意</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
