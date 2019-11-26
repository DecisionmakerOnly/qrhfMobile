<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>合同列表</title>
<base href="<%=basePath%>">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="X-UA-Compatible" content="IE=edge"><!-- Bootstrap 不支持 IE 古老的兼容模式。为了让 IE 浏览器运行最新的渲染模式下，建议将此 <meta> 标签加入到你的页面中 -->
<meta name="renderer" content="webkit"><!-- 将下面的 <meta> 标签加入到页面中，可以让部分国产浏览器默认采用高速模式渲染页面 -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<script type="text/javascript" src="pageoffice.js"  id="po_js_main"></script>
<style type="text/css">
	div{ 
		width:25%;
		float:left;
	}
	span{
		cursor:pointer;
	}
</style>
<script type="text/javascript">

	function zsy(){
		var yScroll = (window.parent.document.documentElement.scrollHeight >window.parent.document.documentElement.clientHeight) ? window.parent.document.documentElement.scrollHeight : window.parent.document.documentElement.clientHeight; 
		return yScroll;
	}
	
	function addFeedback(text){
		openModal("<%=basePath%>feedback/addFeedback.jsp?sysResourceName="+text);
	}
	
</script>
</head>
<body id="listBody">
	<h1 width="100%" align="center">意见反馈</h1>
	<div>
		<ul class="list-group" >
		    <li class="list-group-item">项目</li>
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('项目-创建工程项目')">反馈</span>创建工程项目</li>
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('项目-项目统计')">反馈</span>项目统计</li>
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('项目-项目删除')">反馈</span>项目删除</li>
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('项目-项目详情')">反馈</span>项目详情</li>
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('项目-修改项目采购控制表')">反馈</span>修改项目采购控制表</li>
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('项目-删除项目采购控制表')">反馈</span>删除项目采购控制表</li>
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('项目-项目采购控制表分批设置')">反馈</span>项目采购控制表分批设置</li>
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('项目-项目采购控制表分批列表')">反馈</span>项目采购控制表分批列表</li>
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('项目-项目采购控制表分批详情')">反馈</span>项目采购控制表分批详情</li>
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('项目-申请一次性操作')">反馈</span>申请一次性操作</li>
		</ul>
	</div>
	<div>
		<ul class="list-group" >
		    <li class="list-group-item">采购</li>
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('采购-采购列表')">反馈</span>采购列表</li>
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('采购-上传采购控制表')">反馈</span>上传采购控制表</li>
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('采购-采购详情')">反馈</span>采购详情</li>
		</ul>
	</div>
	<div>
		<ul class="list-group" >
		    <li class="list-group-item">合同</li>
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('合同-合同详情')">反馈</span>合同详情</li>
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('合同-添加合同清单')">反馈</span>添加合同清单</li>
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('合同-删除')">反馈</span>删除</li>
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('合同-导出合同')">反馈</span>导出合同</li>
		</ul>
	</div>
	<div>
		<ul class="list-group" >
		    <li class="list-group-item">角色管理</li>
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('角色管理-新增角色')">反馈</span>新增角色</li>
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('角色管理-权限')">反馈</span>权限</li>
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('角色管理-删除')">反馈</span>删除</li>
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('角色管理-修改')">反馈</span>修改</li>
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('角色管理-一次性权限')">反馈</span>一次性权限</li>
		</ul>
	</div>
	<div>
		<ul class="list-group" >
		    <li class="list-group-item">部门管理</li>
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('部门管理-创建部门')">反馈</span>创建部门</li>
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('部门管理-编辑')">反馈</span>编辑</li>
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('部门管理-删除')">反馈</span>删除</li>
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('部门管理-绑定项目')">反馈</span>绑定项目</li>
		</ul>
	</div>
	<div>
		<ul class="list-group" >
		    <li class="list-group-item">员工管理</li>
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('员工管理-添加员工')">反馈</span>添加员工</li>
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('员工管理-更改部门')">反馈</span>更改部门</li>
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('员工管理-编辑')">反馈</span>编辑</li>
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('员工管理-删除')">反馈</span>删除</li>
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('员工管理-变更投资人代表')">反馈</span>变更投资人代表</li>
		</ul>
	</div>
	<div>
		<ul class="list-group" >
		    <li class="list-group-item"><span class="badge" onclick="addFeedback('其他')">反馈</span>其他</li>
		</ul>
	</div>
	<div style="width: 100%;float: left; padding: 0; overflow: auto;" id="col-md-10"></div>
</body>
</html>