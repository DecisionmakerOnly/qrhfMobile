<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String projectId = request.getParameter("projectId");
	String pageId = ""+session.getAttribute("orderPageId");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="<%=basePath%>common/css/bootstrap.min.css" type="text/css" />
<script type="text/javascript" src="<%=basePath%>common/js/jquery-3.2.1.min.js"></script>  
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap.js"></script>
<title>审批列表</title>
<script type="text/javascript">
	
	$(function() {
		deleteByProjectOrderId();
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
	
	function deleteByProjectOrderId() {
		$.post(
			"<%=basePath%>/projectOrder/deleteByProjectOrderId",
			{"projectOrderId":${poId}},
			function () {
				
			} 
		)
	}
	
	function toProjectOrderList(projectId){
		window.location.href="<%=basePath%>order/list.jsp?projectId="+projectId+"&pageId="+<%=pageId%>;
	}
</script>
</head>
<body>
	<div align="center">
		<h1>审批结果</h1>
	</div>
	
	<ul id="myTab" class="nav nav-tabs">
		<li class="active">
			<a href="#successful" data-toggle="tab">
				 审批成功
			</a>
		</li>
		<li>
			<a href="#failure" data-toggle="tab">
				审批失败
			</a>
		</li>
		<div align="right">
			<button class="btn" onClick="toProjectOrderList(${projectId})">返回采购列表</button>
		</div>
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
		<div class="tab-pane fade" id="failure">
			<table class="table table-bordered table-hover">
			<tr>
				<th>序号</th>
				<th>系统商品名称</th>
				<th>项目采购控制表商品名称</th>
				<th>商品编码</th>
				<th>规格</th>
				<th>单位</th>
				<th>数量</th>
				<th>单价</th>
				<th>合计</th>
			</tr>
			<c:forEach items="${list}" var="projectOrderGoods" varStatus="status">
				<c:if test="${projectOrderGoods.status != 0}">
					<tr>
						<td>${status.count}</td>
						<td>${projectOrderGoods.name}</td>
						<%-- <c:if test="${projectOrderGoods.status == -2}">
							<td style="color: red">${projectOrderGoods.asName}&nbsp;&nbsp;&nbsp;&nbsp;(项目采购控制表中不存在此商品)</td>
						</c:if>
						<td>${projectOrderGoods.asName}</td> --%>
						<c:choose>
					       <c:when test="${projectOrderGoods.status == -2}">
					            <td style="color: red">${projectOrderGoods.asName}&nbsp;&nbsp;&nbsp;&nbsp;(项目采购控制表中不存在此商品)</td>
					       </c:when>
					       <c:otherwise>
					            <td>${projectOrderGoods.asName}</td>
					       </c:otherwise>
						</c:choose> 
						<td>${projectOrderGoods.code }</td>
						<td>${projectOrderGoods.type }</td>
						<td>${projectOrderGoods.unit }</td>
						<td <c:if test="${projectOrderGoods.status == '2' || projectOrderGoods.status == '3'}"> style="color:red" </c:if> >${projectOrderGoods.amount}</td>
						<td <c:if test="${projectOrderGoods.status == '1' || projectOrderGoods.status == '3'}"> style="color:red" </c:if> >${projectOrderGoods.price}</td>
						<td>${projectOrderGoods.total }</td>
					</tr>
				</c:if>
			</c:forEach>
			</table>
		</div>
	</div>

</body>
</html>