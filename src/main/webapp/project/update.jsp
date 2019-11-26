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
	$(function(){
		var tableHeight = $(window).height()-$("#title").height()-50;
		$('#data-table').bootstrapTable({
	    	url: '<%=basePath%>projectGroup/findProjectUpdateResourceList.action',
			method: 'post',
			contentType: "application/x-www-form-urlencoded",
			/* queryParamsType的默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort  设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber */
            queryParamsType:'', 
            queryParams: function queryParams(params) {  
				var param = {  
				    projectId:<%=projectId%>
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
						return [
						index + 1,
						'<input type="hidden" name="projectGoodss['+index+'].id" id="id'+index+'" value="'+row.pgId+'">',
						].join('');
					}  
                },
				{
					field : 'name',
					title : '名称',
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
					sortable : true,
					formatter: function (value, row, index) {
						return [
							row.isUpdatePrice==1?'<input type="text" name="projectGoodss['+index+'].price" id="price'+index+'" /* maxValue="'+row.budgetAmount+'" */ value="'+row.price+'">':row.price+'<input type="hidden" name="projectGoodss['+index+'].price" value="'+row.price+'">'
						].join('');
					} 
				},
				{
					field : 'amount',
					title : '数量',
					align: "center",
					valign : 'middle',
					sortable : true,
					formatter: function (value, row, index) {
						return [
							row.isUpdateAmount==1?'<input type="text" name="projectGoodss['+index+'].amount" id="amount'+index+'" /* maxValue="'+row.budgetAmount+'" */ value="'+row.amount+'">':row.amount+'<input type="hidden" name="projectGoodss['+index+'].amount" value="'+row.amount+'">'
						].join('');
					}  
				},
				{
					field : 'total',
					title : '总价',
					align: "center",
					valign : 'middle',
					sortable : true
				}
			]
        })
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

	function toProjectList(){
		window.location.href="<%=basePath%>project/list.jsp?pageId=<%=projectPageId%>";
	}
	
	function save(){
		$.ajax({
		    type: "POST",//方法类型
		    dataType: "text",//预期服务器返回的数据类型
		    url: "<%=basePath%>project/updateProjectGoodsAll.action",
		    data: $('#form').serialize(),
		    async: false,
		    success: function (data) {
		        if (data == 1) {
		        	alert("保存成功！");
		            window.location.href="<%=basePath%>project/list.jsp?pageId=<%=projectPageId%>";
		        }else if(data == 0){
		        	alert("时间冲突 保存失败！");
		        }
		    }
		});
	}
	
</script>
</head>
<body height="95%">
	<div id="title">
		<div align="center">
			<h1>修改项目项</h1>
		</div>
		<div align="right">
			<button class="btn" onClick="save()">保存</button>
			<button class="btn" onClick="toProjectList()">返回项目列表</button>
		</div>
		<form id="form" action="">
			<div class="form-inline" align="right">
				<input type="text" class="form-control input-sm Wdate" style="width:10%;" name="startDate" id="startDate" placeholder="开始时间" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="" readonly/>-
				<input type="text" class="form-control input-sm Wdate" style="width:10%;" name="endDate" id="endDate" placeholder="结束时间" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="" readonly/>
				<input type="hidden" name="projectId" id="projectId" value="<%=projectId%>">
			</div>
			<table id="data-table"></table>
		</form>
	</div>
</body>
</html>