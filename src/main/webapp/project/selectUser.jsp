<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
	Integer companyId = user.getCompanyId();
	
	String projectId = request.getParameter("projectId");
	String sysFlowId = request.getParameter("sysFlowId");
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

	$(function() {
		$('#data-table').bootstrapTable({
	    	url: '<%=basePath%>user/findAllUserForCompany.action',
			method: 'post',
			contentType: "application/x-www-form-urlencoded",
			//【查询设置】
			/* queryParamsType的默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort
			 设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber */
	        queryParamsType:'', 
	        queryParams: function queryParams(params) {  
	          var param = {  
	              companyId:<%=companyId%>
	          }; 
	          return param;                   
	        }, 
			pagination: false,//是否开启分页（*）
	        pageNumber:1,//初始化加载第一页，默认第一页
	        pageSize: 20,//每页的记录行数（*）
	        pageList: [20,50,100],//可供选择的每页的行数（*）
	        sidePagination: "server", //分页方式：client客户端分页，server服务端分页（*）
	        showRefresh:false,//刷新按钮
	        height:500,//table的高度
	        //按需求设置不同的样式：5个取值代表5中颜色['active', 'success', 'info', 'warning', 'danger'];
			rowStyle: 'success',
			columns : [
				{
	                  checkbox: true
	            },
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
					field : 'userName',
					title : '员工姓名',
					valign : 'middle',
					sortable : true
				},
				{
					field : 'roleName',
					title : '职务',
					valign : 'middle',
					sortable : true
				}
			]
	    })
	})
	
	function nextStep(){
		var userIds = '';
		$('#data-table').bootstrapTable('getSelections').forEach(function(row){
			userIds += row.id + ",";
		})
		if(userIds.length<1){
			alert("至少选择一名用户！");
		}else{
			userIds = userIds.substr(0,userIds.length-1);
			window.location.href = "<%=basePath%>payment/selectDuration.jsp?userIds="+userIds;
		}
	}
	
	function saveConsultation(){
		var userIds = '';
		$('#data-table').bootstrapTable('getSelections').forEach(function(row){
			userIds += row.id + ",";
		})
		if(userIds.length<1){
			alert("至少选择一名用户！");
		}else{
			userIds = userIds.substr(0,userIds.length-1);
			$.ajax({
				dataType : "json",
				type : "post",
				async: false,//同步
				url : "<%=basePath%>sysFlow/saveConsultation.action?sysFlowId=<%=sysFlowId%>&userIds="+userIds,
				success : function(data) {
					if(data == 1){
						alert("保存成功");
						window.top.location.href="<%=basePath%>main.jsp";
					}else{
						alert("请求失败");
					}
				}
			});
		}
	}
// 	function toContrastSKB(){
<%-- 		window.location.href="<%=basePath%>project/contrastSKB.jsp?projectId=<%=projectId%>&sysFlowId=<%=sysFlowId%>"; --%>
// 	}
</script>
</head>
<body>
<div style="float:left;margin-left:30px;width:96%;text-align: right;">
	<div align="center">
		<h1>选择会商人员</h1>
	</div>
	<div class="form-inline" >
		<button class="btn" onClick="history.go(-1);">取消</button>
		<button class="btn" onClick="saveConsultation()">确认</button>
	</div>
	<table id="data-table"></table>
</div>
</body>
</html>
