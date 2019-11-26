<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
	Integer companyId = user.getCompanyId();
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>慧用法-法院智能办公系统</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="renderer" content="webkit">
<script src="<%=basePath%>common/js/base.js"></script>
<style type="text/css">
	body {background-color:#FFFFFF;}
</style>
<script type="text/javascript">
	$(function(){
		setH("tree", 50);
		$.ajax({
			dataType : "json",
			type : "post",
			url : "<%=basePath%>user/tree.action?companyId="+<%=companyId%>,
			success : function(data) {
				$('#tree').treeview({
					levels : 9, //设置继承树默认展开的级别 。默认为2展开第一级
					showBorder : false,
					data : [ data ]
				});
				//节点选中时触发
				$('#tree').on('nodeSelected', function(event, data) {
					if (data.parentId != undefined) {
						$("#mainFrame").attr("src", "<%=basePath%>user/list.jsp?departmentId=" + data.id);
					} else {
						$("#mainFrame").attr("src", "<%=basePath%>user/list.jsp");
					}
				});
			}
		});
	});
	window.onload = function() { //解决iframe在非IE、firefox浏览器下（如edge、chrome浏览器）重复刷新的问题
		var iframe = document.createElement('iframe');
		iframe.id = "mainFrame";
		iframe.height = "100%";
		iframe.width = "100%";
		iframe.frameborder = "0";
		iframe.scrolling = "no";
		iframe.style.border = "0px";
		iframe.setAttribute('frameborder', '0', 0);
		iframe.onload = function() {
			iframe.onload = null;
		};
		document.getElementById("col-md-10").appendChild(iframe);
		iframe.src = "<%=basePath%>user/list.jsp";
	}
</script>
</head>
<body>
	<div class="tree-container">
		<div style="width:20%;float: left;height:100%;">
			<div class="panel panel-default panal-full-screen">
				<div class="panel-heading">
					<ol class="breadcrumb">
						<li>系统管理</li>
						<li class="active">用户管理</li>
					</ol>
				</div>
				<div class="panel-body">
					<div id="tree" style="width:100%;height:100%;overflow-y: auto;color:red"></div>
				</div>
			</div>
		</div>
		<div style="width:80%;float:left;height:100%;padding:0;" id="col-md-10"></div>
	</div>
</body>
</html>
