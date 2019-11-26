<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	
	String projectId = request.getParameter("projectId");
	String sysFlowId = request.getParameter("sysFlowId");
	String projectPageId = request.getParameter("projectPageId");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>选择负责人</title>
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
			url : "<%=basePath%>project/selectDutyUser.action?projectId="+<%=projectId%>,
			success : function(data) {
				//加载部门树
				$('#tree').treeview({
					levels : 9, //设置继承树默认展开的级别 。默认为2展开第一级
					showBorder : false,
					data : [ data ]
				});
				
				if($('#tree').treeview('getEnabled', 0).length==2){
					startFlow($('#tree').treeview('getEnabled', 0)[1].id);
				}
				
				//节点选中时触发
				$('#tree').on('nodeSelected', function(event, data) {
					if (data.id != undefined && data.id != -1) {
						startFlow(data.id);
					}
				});
			}
		});
	}
	
	function startFlow(dutyUserId){
		$.ajax({
				url:'<%=basePath%>sysFlow/startFlow.action?sysFlowId=<%=sysFlowId%>&dutyUserId='+dutyUserId,
			dataType:'json',
			type:'post',
			success:function(data){
				if(data != 0){
					window.location.href="<%=basePath%>main.jsp";
				}
			},
			error:function(){
				alert("请求失败！");
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
				<h4 class="modal-title" id="myModalLabel">选择负责人</h4>
			</div>
			<div class="container">
				<form class="form-horizontal" id="authForm" method="post">
					<div class="form-group">
						<a><label class="col-md-2 control-label">项目负责人：</label></a>
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
