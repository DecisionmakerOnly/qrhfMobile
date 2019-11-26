<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String companyId = request.getParameter("companyId");
	String departmentId = request.getParameter("departmentId");
	String isProject = request.getParameter("isProject");
	boolean isProjectFlag = isProject.equals("1")?true:false;
	String parentId = request.getParameter("parentId");
	parentId = parentId==null?"-1":parentId;
	String pageId = request.getParameter("pageId");
	session.setAttribute("parentId", parentId);
	session.setAttribute("pageId", pageId); 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>My JSP 'addDepartment.jsp' starting page</title>
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
	$("#companyId").val(<%=companyId%>);
	projectName();
})
function projectName(){
	$("#departmentId").val(<%=departmentId%>);
	$.ajax({
        type: "post",
        url: "<%=basePath%>project/returnCheckBox.action",
        dataType: "json",
        type : 'post',
        data:{companyId:<%=companyId%>,departmentId:<%=isProject.equals("1")?departmentId:0%>},
        success: function(data){
       	 $('#tree').treeview({
       		levels : 9, //设置继承树默认展开的级别 。默认为2展开第一级
			showBorder : false,
			onhoverColor: "#F5F5DC",//鼠标悬浮颜色 
			borderColor: "red",//边框颜色 
			highlightSelected: true,//高亮选中 
			selectedColor: "red",//选中颜色 
			selectedBackColor: "#D3D3D3",//选中背景色 
			color: "#00BFFF", 
			data : [ data ]
			});
       		var id=$("#departmentId").val();
	       	$('#tree').on('nodeSelected', function(event, data) {
	       		if("1"=="<%=isProject%>"){
	       			$.ajax({
						dataType : "json",
						type : "post",
						url : "<%=basePath%>project/updateDepartmentId.action",
						data:{
							departmentId:0,
							projectId:data.id,
							companyId:<%=companyId%>
						},
						success : function(data) {
							alert("解除绑定成功!");
							window.location.href="<%=basePath%>main.jsp";
						}
					}); 
	       		}else{
	       			$.ajax({
						dataType : "json",
						type : "post",
						url : "<%=basePath%>project/updateDepartmentId.action",
						data:{
							departmentId:id,
							projectId:data.id,
							companyId:<%=companyId%>
						},
						success : function(data) {
							alert("绑定项目成功!");
							window.location.href="<%=basePath%>main.jsp";
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
	
	function unbind(){
		$.ajax({
			dataType : "json",
			type : "post",
			url : "<%=basePath%>project/updateDepartmentId.action",
			data:{
				departmentId:0,
				projectId:$("#tree").treeview('getNode','0').id,
				companyId:<%=companyId%>
			},
			success : function(data) {
				alert("解除绑定成功!");
				window.location.href="<%=basePath%>main.jsp";
			}
		}); 
	}
</script>
</head>
<body>
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">绑定项目</h4>
			</div>
			<div class="container">
				<form class="form-horizontal" id="authForm" method="post">
						<div class="form-group">
							<label class="col-md-2 control-label">项目：</label>
							<div class="col-md-3 ">
								<input type="hidden" id="departmentId" value="<%=departmentId %>>">
								<div id="tree" style="width:350px;height:300px;overflow: auto;"></div>
							</div>
						</div>
						<div class="modal-footer col-md-6">
							<!--用来清空表单数据-->
							<input type="reset" name="reset" style="display: none;" />
							<c:if test="<%=isProjectFlag%>">
								<button type="button" class="btn btn-default" onclick="unbind()">解除绑定</button>
							</c:if>
							
							<button type="button" class="btn btn-default" onclick="closeModal()">关闭</button>
						</div>
					</form>
			</div>
		</div>
	</div>
</body>
</html>
