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
	String pageId = request.getParameter("pageId");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
 <head>
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
				},
				{
					field : 'expiryDate',
					title : '到期时间',
					align: "center",
					valign : 'middle',
					sortable : true,
					//获取日期列的值进行转换
				    formatter: function (value, row, index) {
				        return changeDateFormat(value)
				    }
				}
			]
	    })
	})
		function changeDateFormat(cellval) {
	    var dateVal = cellval + "";
	    if (cellval != null) {
	        var date = new Date(parseInt(dateVal.replace("/Date(", "").replace(")/", ""), 10));
	        var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
	        var currentDate = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
	        return date.getFullYear() + "-" + month + "-" + currentDate + " ";
	    }
	}
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

</script>
</head>
<body>
   <div align="center">
		<h1>选择缴费员工</h1>
	</div>
	<div style="float:left;margin-left:30px;width:90%;text-align: right;">
		<table id="data-table"></table>
		<button class="btn btn-primary" onclick="nextStep()">下一步</button>
	</div>
</body>
</html>
