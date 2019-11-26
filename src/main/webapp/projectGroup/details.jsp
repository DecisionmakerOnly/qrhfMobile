<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String projectId = request.getParameter("projectId");
	String projectPageId = request.getParameter("projectPageId");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<title>Insert title here</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<script src="<%=basePath%>common/plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">

	function initNav(){
		$.ajax({
			dataType : "json",
			type : "post",
			url : "<%=basePath%>projectGroup/findProjectGroupDetailsNav.action?projectId=<%=projectId%>",
			success : function(data) {
				var html = "<li class='active' href='jacascript::void(0);'><a data-toggle='tab' onclick='refreshTable("+data[0].id+")'>"+data[0].startDate+"至"+data[0].endDate+"</a></li>";
				for(var i=1;i<data.length;i++){
					html += "<li href='jacascript::void(0);'><a data-toggle='tab' onclick='refreshTable("+data[i].id+")'>"+data[i].startDate+"至"+data[i].endDate+"</a></li>";
				}
				html+='<li align="right"><button class="btn" onClick="toProjectList()">返回项目列表</button></li>';
				$("#projectGroupList").html(html);
 				$("#projectGroupId").val(data[0].id);
				findProjectGroupGoodsListById();
			}
		});
	}
	
	function refreshTable(projectGroupId){
		$("#projectGroupId").val(projectGroupId);
		$('#data-table').bootstrapTable("refresh",{silent: false});
	}
	
	function findProjectGroupGoodsListById(){
		var tableHeight = $(window).height()-$("#title").height()-50;
		$('#data-table').bootstrapTable({
			url: '<%=basePath%>projectGroup/detail.action',
 			method: 'post',
 			contentType: "application/x-www-form-urlencoded",
 			/* queryParamsType的默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort  设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber */
             queryParamsType:'', 
             queryParams: function queryParams(params) {  
 				var param = { 
					projectGroupId:$("#projectGroupId").val()
 				}; 
 				return param;
             }, 
 			locale:'zh-CN',//中文支持
 			pagination: false,//是否开启分页（*）
			height:tableHeight,//table的高度
 			columns : [
 				{  
 					title: '序号',//标题  可不加 
 					valign : 'middle', 
 					align: "center",
 					formatter: function (value, row, index) {
 						var pageSize=$('#data-table').bootstrapTable('getOptions').pageSize;//通过表的#id 可以得到每页多少条
 						var pageNumber=$('#data-table').bootstrapTable('getOptions').pageNumber;//通过表的#id 可以得到当前第几页
 						return pageSize * (pageNumber - 1) + index + 1;    //返回每条的序号： 每页条数 * （当前页 - 1 ）+ 序号
 					}  
                },
 				{
 					field : 'name',
 					title : '系统商品名称',
 					valign : 'middle',
 					sortable : true
 				},
 				{
 					field : 'asName',
 					title : '项目采购控制表商品名称',
 					valign : 'middle',
 					sortable : true
 				},
 				{
 					field : 'code',
 					title : '商品编码',
 					valign : 'middle',
 					sortable : true
 				},
 				{
 					field : 'type',
 					title : '规格',
 					valign : 'middle',
 					sortable : true
 				},
 				{
 					field : 'unit',
 					title : '单位',
 					align: "center",
 					valign : 'middle',
 					sortable : true
 				},
 				{
 					field : 'price',
 					title : '单价',
 					align: "center",
 					valign : 'middle',
 					sortable : true
 				},
 				{
 					field : 'amount',
 					title : '数量',
 					align: "center",
 					valign : 'middle',
 					sortable : true
 				},
 				{
 					field : 'amount2',
 					title : '已采购数量',
 					align: "center",
 					valign : 'middle',
 					sortable : true
 				},
 				{
 					title : '剩余数量',
 					align: "center",
 					valign : 'middle',
 					sortable : true,
 					formatter: function (value, row, index) {
 						return (row.amount - row.amount2).toFixed(3);    //返回每条的序号： 每页条数 * （当前页 - 1 ）+ 序号
 					}  
 				}
 			]
		})
	}


	$(function(){
		initNav();
	})
	
	function toProjectList(){
		window.location.href="<%=basePath%>project/list.jsp?pageId=<%=projectPageId%>";
	}
	
</script>
</head>
<body height="95%">
	<div id="title">
		<div align="center">
			<h1>项目采购控制表分批详情</h1>
		</div>
		<div align="right">
			<ul class="nav nav-tabs" id="projectGroupList">
			</ul>
			<input type="hidden" id="projectGroupId">
		</div>
	</div>
	<table id="data-table"></table>
</body>
</html>