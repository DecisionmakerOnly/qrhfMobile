<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String projectId = request.getParameter("projectId");
	String projectOrderId = request.getParameter("projectOrderId");
	String pageId = request.getParameter("pageId");
	session.setAttribute("orderPageId", pageId);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="<%=basePath%>common/css/bootstrap.css" type="text/css" />
<link rel="stylesheet" href="<%=basePath%>common/css/bootstrap-table.css" type="text/css" />
<script type="text/javascript" src="<%=basePath%>common/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap-table.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap-table-zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap-table-locale-all.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单详情</title>
<script type="text/javascript">
function zsy(){
	var yScroll = (window.parent.document.documentElement.scrollHeight >window.parent.document.documentElement.clientHeight) ? window.parent.document.documentElement.scrollHeight : window.parent.document.documentElement.clientHeight; 
	return yScroll;
}
$(function() {
	var h=zsy();
	contractName();
	var tableHeight = $(window).height()-$("#title").height()-110;
	$('#data-table').bootstrapTable({
    	url: '<%=basePath%>projectOrder/detail',
		method: 'post',
		contentType: "application/x-www-form-urlencoded",
		/* queryParamsType的默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort  设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber */
        queryParamsType:'', 
        queryParams: function queryParams(params) {  
			var param = {  
			    pageNumber: params.pageNumber,    
			    pageSize: params.pageSize,
			    projectId:<%=projectId%>,
			    projectOrderId:<%=projectOrderId%>
			}; 
			return param;
        }, 
		locale:'zh-CN',//中文支持
		pagination: true,//是否开启分页（*）
        pageNumber:1,//初始化加载第一页，默认第一页
        pageSize: 20,//每页的记录行数（*）
        pageList: [20,50,100],//可供选择的每页的行数（*）
        sidePagination: "server", //分页方式：client客户端分页，server服务端分页（*）
        showRefresh:false,//刷新按钮
        height:h-180,//table的高度
		rowStyle:'success',
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
				field : 'amount',
				title : '数量',
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
				field : 'total',
				title : '合计',
				align: "center",
				valign : 'middle',
				sortable : true,
                formatter:function(value,row,index) {
                    return row.total.toFixed(2);
                }
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
	
	function toProjectOrderList(projectId){
		window.location.href="<%=basePath%>order/list.jsp?projectId="+<%=projectId%>+"&pageId="+<%=pageId%>;
	}
	function contractName() {
	$.post(
		"<%=basePath%>contract/selectNameByProjectOrderId",
		{projectOrderId:<%=projectOrderId%>},
		function(data) {
			$("#cName").html('采购表所属合同：《'+data.name+'》') 
		}
	)
}
</script>
</head>
<body>
	<div align="center">
		<h1>订单详情</h1>
	</div>
	<div id="cName" style="float: left;"></div>
	<div align="right">
		<button class="btn" onClick="toProjectOrderList()">返回采购列表</button>
	</div>
	<table id="data-table"></table>
	<%-- <ul id="myTab" class="nav nav-tabs">
		<li class="active">
			<a href="#successful" data-toggle="tab">
				 审批成功
			</a>
		</li>
		
	</ul>
	<div id="myTabContent" class="tab-content" style="min-height:500px;overflow-y:auto;max-height:510px;">
		<div class="tab-pane fade in active" id="successful">
			<table class="table table-bordered table-hover">
				<tr>
					<th align="center">序号</th>
					<th align="center">系统商品名称</th>
					<th align="center">项目采购控制表商品名称</th>
					<th align="center">商品编码</th>
					<th align="center">规格</th>
					<th align="center">单位</th>
					<th align="center">数量</th>
					<th align="center">单价</th>
					<th align="center">合计</th>
				</tr>
				<c:forEach items="${list}" var="projectOrderGoods" varStatus="status">
					<c:if test="${projectOrderGoods.status == 0}">
						<tr>
							<td>${status.count}</td>
							<td>${projectOrderGoods.name}</td>
							<td>${projectOrderGoods.asName}</td>
							<td>${projectOrderGoods.code }</td>
							<td>${projectOrderGoods.type }</td>
							<td>${projectOrderGoods.unit }</td>
							<td>${projectOrderGoods.amount }</td>
							<td>${projectOrderGoods.price }</td>
							<td>${projectOrderGoods.total }</td>
						</tr>
					</c:if>
				</c:forEach>
			</table>
		</div>
	</div> --%>
</body>
</html>