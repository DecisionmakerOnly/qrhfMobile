<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>项目表列</title>
<script type="text/javascript">


window.onload = function (){//解决iframe在非IE、firefox浏览器下（如edge、chrome浏览器）重复刷新的问题
	var iframe = document.createElement('iframe');
	iframe.id="mainFrame";
	iframe.width="100%";
	iframe.frameborder="0";
	iframe.scrolling="no";
	iframe.style.border="0px";
	iframe.setAttribute('frameborder', '0', 0);
	iframe.onload = function(){
		iframe.onload = null;
	};
	document.getElementById("col-md-10").appendChild(iframe);
/* 	toSellerTree(); */
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

	<%-- function toSellerTree() {
		$("#mainFrame").attr('src',"<%=basePath%>/seller/tree.jsp");
	} --%>
	
	function editSeller() {
		window.location.href="<%=basePath%>seller/toUpdate";
	}
</script> 
<style type="text/css">
	/* 文字在表格中居中展示 */
	.table th, .table td {  
	text-align: center;  
	vertical-align: middle!important;  
	}
</style>
</head>
<body  id="listBody">
<div align="right">
		<button class="btn" onclick="editSeller()">修改供应商信息</button>
	</div>
<div align="center">
		<h1>${sell.name}</h1>
		<h4>供应商信息</h4>
		<div class="container-fluid" style="width: 100%;height: 100%;margin: 50px 0px;" >
   		<div style="width: 40%;height: 40%;margin: auto;font-size:20px">
		<table class="table table-bordered">
			<%-- <tr>
				<td>类型</td>
				<td>
					<c:if test="${sell.isFactory==1}">厂家</c:if>
					<c:if test="${sell.isFactory==2}">商家</c:if>
				</td>
			</tr> --%>
			<tr>
				<td>公司性质</td>
				<td>${sell.type}</td>
			</tr>
			<tr>
				<td>地址</td>
				<td>${sell.address}</td>
			</tr>
			<tr>
				<td>法定代表人</td>
				<td>${sell.representative}</td>
			</tr>
			<tr>
				<td>联系方式</td>
				<td>${sell.contact}</td>
			</tr>
			<tr>
				<td>经营范围</td>
				<td>${sell.infor}</td>
			</tr>
		</table>
		</div>
		</div>
	</div>
	<div style="width:100%;float:left;padding:0;overflow:auto" id="col-md-10"></div>
</body>
</html>