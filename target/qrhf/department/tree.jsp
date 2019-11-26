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
	String parentId = request.getParameter("parentId");
	parentId = parentId==null?"-1":parentId;
	String pageId = request.getParameter("pageId");
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title></title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="renderer" content="webkit">
<link href='common/css/bootstrap.css' rel='stylesheet'>
<link href='common/css/bootstrap-table.css' rel='stylesheet'>
<link href='common/css/bootstrap-treeview.css' rel='stylesheet'>
<script type='text/javascript' src='common/js/base.js'></script>
<script type='text/javascript' src='common/js/respond.min.js'></script>
<script type='text/javascript' src='common/js/jquery-3.2.1.min.js'></script>
<script type='text/javascript' src='common/js/bootstrap.js'></script>
<script type='text/javascript' src='common/js/bootstrap-table.js'></script>
<script type='text/javascript' src='common/js/bootstrap-table-zh-CN.js'></script>
<script type='text/javascript' src='common/js/bootstrap-treeview.js'></script>
<style type="text/css">
	body {background-color:#FFFFFF;}
</style>
<script type="text/javascript">
	function zsy(){
		var yScroll = (window.parent.document.documentElement.scrollHeight >window.parent.document.documentElement.clientHeight) ? window.parent.document.documentElement.scrollHeight : window.parent.document.documentElement.clientHeight; 
		return yScroll;
	}
	
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
		iframe.src = "<%=basePath%>/department/test.jsp?parentId="+<%=parentId%>+"&pageId="+<%=pageId%>;
	}
	
	$(function(){
		setH("tree",100);
		$.ajax({
			dataType : "json",
			type : "post",
			url : "<%=basePath%>department/tree.action?companyId="+<%=companyId%>,
			success : function(data) {
				//加载部门树
				$('#tree').treeview({
					levels : 9, //设置继承树默认展开的级别 。默认为2展开第一级
					showBorder : false,
					data : [ data ]
				});
				//节点选中时触发
				$('#tree').on('nodeSelected', function(event, data) { 
					if (data.id != undefined) { 
						$("#mainFrame").attr("src", "<%=basePath%>department/test.jsp?parentId="+data.id+"&pageId="+<%=pageId%>+"&parentId="+data.parentId);
					} else {
						$("#mainFrame").attr("src", "<%=basePath%>department/test.jsp?pageId="+<%=pageId%>);
					}
				});
			}
		});
		
		var h=zsy();
		$("#listBody").height(h-100);
		//取到窗口的高度 
		var winH = $(window).height();
		//取到页面的高度 
		var bodyH = $(document).height();
		if(bodyH > winH){ 
			window.parent.document.getElementById("mainFrame").height=bodyH;
		}else{ 
			window.parent.document.getElementById("mainFrame").height=winH; 
		} 
	});
</script>
</head>
<body id="listBody">
	<div class="tree-container">
		<div style="width:20%;float:left;height:100%;">
			<div class="panel panel-default panal-full-screen">
				<div class="panel-heading">
					<ol class="breadcrumb">
						<li>系统管理</li>
						<li class="active">部门管理</li>
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
