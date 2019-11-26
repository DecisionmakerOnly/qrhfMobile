<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>商品信息</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="renderer" content="webkit">
<link href="<%=basePath%>common/css/bootstrap.css" rel="stylesheet">
<link href="<%=basePath%>common/css/bootstrap-table.css" rel="stylesheet">
<link href="<%=basePath%>common/css/bootstrap-treeview.css" rel="stylesheet">
<script type="text/javascript" src="<%=basePath%>common/js/base.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/respond.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap-table.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap-table-zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap-treeview.js"></script>
<style type="text/css">
	body {background-color:#FFFFFF;}
</style>
<script type="text/javascript">
	$(function(){
		setH("tree",120);
		$.ajax({
			dataType : "json",
			type : "post",
			url : "<%=basePath%>goods/findGoodsTypeTree.action",
			success : function(data) {
				//加载部门树
				$('#tree').treeview({
					levels : 2, //设置继承树默认展开的级别 。默认为2展开第一级
					showBorder : false,
					data : [ data ]
				});
				//节点选中时触发
				$('#tree').on('nodeSelected', function(event, data) {
					if (data.parentId != undefined) {
						$("#mainFrame").attr("src", "<%=basePath%>goods/list.jsp?goodsType=" + data.id);
					} else {
						$("#mainFrame").attr("src", "<%=basePath%>/goods/list.jsp");
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
		iframe.src = "<%=basePath%>goods/list.jsp";
	}
	
	function zsy(){
		var yScroll = (window.parent.document.documentElement.scrollHeight >window.parent.document.documentElement.clientHeight) ? window.parent.document.documentElement.scrollHeight : window.parent.document.documentElement.clientHeight; 
		return yScroll;
	}

	$(function() {
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
	})
</script>
</head>
<body id="listBody">
	<div class="tree-container" style="overflow:auto">
		<div style="width:20%;float: left;height:100%;">
			<div class="panel panel-default panal-full-screen">
				<div class="panel-heading">
					<ol class="breadcrumb">
						<li>系统管理</li>
						<li class="active">商品类别</li>
					</ol>
				</div>
				<div class="panel-body">
					<div id="tree" style="width:100%;height:100%;overflow-y :auto;color:red"></div>
				</div>
			</div>
		</div>
		<div style="width:80%;float:left;height:100%;padding:0;" id="col-md-10"></div>
	</div>
</body>
</html>
