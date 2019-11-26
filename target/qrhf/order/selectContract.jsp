<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
	Integer companyId=user.getCompanyId();
	String userName=user.getUserName();
	
	String projectId = request.getParameter("projectId");
	String projectPageId = request.getParameter("projectPageId");
	String projectName = new String(request.getParameter("projectName").getBytes("iso8859-1"),"utf-8"); 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>材料订单页面</title>
<base href="<%=basePath%>">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="X-UA-Compatible" content="IE=edge"><!-- Bootstrap 不支持 IE 古老的兼容模式。为了让 IE 浏览器运行最新的渲染模式下，建议将此 <meta> 标签加入到你的页面中 -->
<meta name="renderer" content="webkit"><!-- 将下面的 <meta> 标签加入到页面中，可以让部分国产浏览器默认采用高速模式渲染页面 -->
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
<script type='text/javascript' src="<%=basePath%>common/plugin/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">

	function zsy(){
		var yScroll = (window.parent.document.documentElement.scrollHeight >window.parent.document.documentElement.clientHeight) ? window.parent.document.documentElement.scrollHeight : window.parent.document.documentElement.clientHeight; 
		return yScroll;
	}
	
	$(function() {
		var h=zsy();
		$('#data-table').bootstrapTable({
	    	url: '<%=basePath%>projectOrder/selectContractList.action',
			method: 'post',
			contentType: "application/x-www-form-urlencoded",
			//【查询设置】
			/* queryParamsType的默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort
			 设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber */
	        queryParamsType:'', 
	        queryParams: function queryParams(params) {  
				var param = {  
					companyId: <%=companyId%>
				}; 
				return param;                   
	        }, 
			locale:'zh-CN',//中文支持
			pagination: false,//是否开启分页（*）
	        showRefresh:false,//刷新按钮
	        height:h-250,//table的高度
	        //按需求设置不同的样式：5个取值代表5中颜色['active', 'success', 'info', 'warning', 'danger'];
			rowStyle: 'success',
			columns : [
				{  
					title: '序号',
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
					title : '合同名称',
					align: "center",
					valign : 'middle',
					sortable : true
				},
				{
					field : 'createDate',
					title : '合同创建时间',
					align: "center",
					valign : 'middle',
					sortable : true,
					//获取日期列的值进行转换
				    formatter: function (value, row, index) {
				        return changeDateFormat(value)
				    }
				},
				{
	                field: 'operate',
	                title: '操作',
	                align: 'center',
	                valign: 'middle',
	                formatter: operateFormatter
	            }
			]
	    })
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
	
	function operateFormatter(value, row, index) {
		return [
			'<a class="edit" title="edit" href="javascript:confirm('+row.id+')">选择合同</a>',
	        '&nbsp;&nbsp;&nbsp;&nbsp;'
		].join('');
	}
	
	function confirm(id){
		window.location.href="<%=basePath%>order/selectProjectGroup.jsp?projectId=<%=projectId%>&projectPageId=<%=projectPageId%>&projectName=<%=projectName%>&contractId="+id;
	}
	
	function toProjectList(){
		window.location.href="<%=basePath%>project/list.jsp?pageId=<%=projectPageId%>";
	}

</script>
</head>
<body id="listBody">
	<div align="center">
		<h1>选择合同</h1>
	</div>
	<div class="form-inline" align="right">
		<button class="btn" onClick="toProjectList()">返回项目列表</button>
	</div>
	<table id="data-table"></table>
</body>
</html>