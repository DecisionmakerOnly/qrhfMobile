<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
	Integer sysRoleId=user.getSysRoleId();
	Integer companyId = user.getCompanyId();
	String userName=user.getUserName();
	String departmentId = request.getParameter("departmentId");
	String pageId = request.getParameter("pageId");
	session.setAttribute("pageId", Integer.valueOf(pageId)-1);
	session.setAttribute("parentId", departmentId);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>替换投资人代表</title>
<base href="<%=basePath%>">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="X-UA-Compatible" content="IE=edge"><!-- Bootstrap 不支持 IE 古老的兼容模式。为了让 IE 浏览器运行最新的渲染模式下，建议将此 <meta> 标签加入到你的页面中 -->
<meta name="renderer" content="webkit"><!-- 将下面的 <meta> 标签加入到页面中，可以让部分国产浏览器默认采用高速模式渲染页面 -->
<link href='<%=basePath%>common/css/bootstrap.css' rel='stylesheet'>
<link href='<%=basePath%>common/css/bootstrap-table.css' rel='stylesheet'>
<link href='<%=basePath%>common/css/bootstrap-treeview.css' rel='stylesheet'>
<script type='text/javascript' src='<%=basePath%>common/js/base.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/respond.min.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/jquery-3.2.1.min.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/bootstrap.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/bootstrap-table.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/bootstrap-table-zh-CN.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/bootstrap-treeview.js'></script></head>
<script type="text/javascript">
$(function() {
	initTree();
})
function initTree() {
	$.ajax({
		dataType : "json",
		type : "post",
		url : "<%=basePath%>user/findUserTree.action?companyId="+<%=companyId%>,
		success : function(data) {
			//加载部门树
			$('#tree').treeview({
				levels : 9, //设置继承树默认展开的级别 。默认为2展开第一级
				showBorder : false,
				data : [ data ]
			});
			//节点选中时触发
			$('#tree').on('nodeSelected', function(event, data) {  
		 		if (data.grade == "c") {
		 			if(confirm('您确定要变更投资人代表身份吗？变更后不可恢复！')){
			 			$.ajax({
							dataType : "json",
							type : "post",
							url : "<%=basePath%>user/updateUser.action?companyId=<%=companyId%>&userId="+data.id,
							success : function(data) {
								alert("变更投资人代表身份成功!");
								parent.top.location.href = "<%=basePath%>/user/clearSession";
							}
						}); 
				 	} else {
							return false;
					}
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
<body>
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">选择员工</h4>
			</div>
			<div class="container">
				<form class="form-horizontal" id="authForm" method="post">
					<div class="form-group">
						<a><label class="col-md-2 control-label"></label></a>
						<div class="col-md-3 ">
							<div id="tree"></div>
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