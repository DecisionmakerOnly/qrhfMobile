<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String projectId = request.getParameter("projectId");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<base href="<%=basePath%>">
<title>数据分析</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="renderer" content="webkit">
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
<script src="<%=basePath%>common/plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/echarts.js"></script>
<script type="text/javascript">
	function toProjectList(){
		window.location.href="<%=basePath%>project/list.jsp?pageId=2";
	}
</script>
</head>
<body>
<div id="title">
		<div align="center">
			<h3>数据分析</h3>
		</div>
		
		<ul id="myTab" class="nav nav-tabs">
		<li class="active">
			<a href="#feature" data-toggle="tab">
				数据特点
			</a>
		</li>
		<li>
			<a href="#app" data-toggle="tab">
				数据应用
			</a>
		</li>
		
		<div class="form-inline" align="right">
			<!-- <input type="hidden" class="form-control input-sm Wdate" style="width:10%;" id="startDate" placeholder="开始时间" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})" value="" readonly/>
			<input type="text" class="form-control input-sm Wdate" style="width:10%;" id="endDate" placeholder="统计截止日期" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})" value="" readonly/>
			<input type="text" class="form-control" style="width:10%;" id="name" placeholder="商品名称">
			<button class="btn" type="button" name="searchAmount" onclick="searchAmount()">查询</button>
			<button class="btn" type="button" name="searchAmount" onclick="findTotal()">资金查询</button> -->
			<button class="btn" onClick="toProjectList()">返回项目列表</button>
		</div>
		
	</ul>
	<div id="myTabContent" class="tab-content">
		<div class="tab-pane fade in active" id="feature" style="padding: 0">
			<div id="featureMain" style="width: 1530px;height:580px;">
				<h2>该功能正在开发，敬请期待...</h2>
			</div>
		</div>
		<div class="tab-pane fade" id="app" style="padding: 0">
			<div id="appMain" style="width: 1530px;height:580px;">
				<h2>该功能正在开发，敬请期待...</h2>
			</div>
		</div>
	</div>
</div>
</body>
</html>