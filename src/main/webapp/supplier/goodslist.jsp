<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String filePath = request.getSession().getServletContext().getRealPath("image\\brand");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>采购供应商</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link href="<%=basePath%>common/css/style1.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=basePath%>common/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/main.js"></script>
<link href="<%=basePath%>common/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap.min.js"></script>
</head>
<style>
	 #div2 {
            position: absolute;
            top: 500px;
            left: 600px;
        }
</style>
<body>
<div align="center" style="margin:30px;">
    <h1>供应商商品信息</h1>
</div>
<form action="<%=basePath%>sellerGoods/view?sellerId=${sellerId}" method="post"> 
	<div class="form-inline" align="center">
		<label class="form-inline">商品名称:
		<input type="text" name="name" id="name" class="form-control input-sm" style="width:140px;" value="${name}">&emsp;
		<label class="form-inline">价格区间:
		<input type="text" name="price1" id="price1" class="form-control input-sm" style="width:50px;" value="${price1}" placeholder="￥" title="最低价">-
		<input type="text" name="price2" id="price2" class="form-control input-sm" style="width:50px;" value="${price2}" placeholder="￥" title="最高价">&emsp;&emsp;
		<input type="submit" value="查询"> 
	</div>
</form>
<div class="container-fluid" style="width: 100%;height: 100%;margin: auto;" >
    <div style="width: 85%;height: 100%;margin: auto;" >
		 <c:forEach items="${pageInfo.list }" var="goods">
			<div style="width:280px; height:280px; padding:20px 20px 0px 20px;float: left;">
				<div style="margin: auto;" >
					<img width='240px' height='200px' src='image/${goods.imageUrl}' style="margin: 0px 20px 0px 20px;"/><br>
					<h3>价格：￥${goods.price}</h3>
					<p>名称：${goods.name }</p>
					<p>型号：${goods.type }</p>
				</div>
			</div>
		</c:forEach> 
	<div class="row" >
			<!--  分页文字信息  
			<div class="col-md-6">
				当前${pageInfo.pageNum}页,总${pageInfo.pages}页,总${pageInfo.total }条记录
			</div>-->
			<!-- 分页条信息 -->
			<div class="col-md-6" id="div2">
				<nav aria-label="Page navigation">
				 <ul class="pagination">
				 <li><a href="<%=basePath%>sellerGoods/view?pageNum=1&name=${name}&price1=${price1}&price2=${price2}&sellerId=${sellerId}">首页</a></li>
				 	<c:if test="${pageInfo.hasPreviousPage }">
				 		<li>
					      <a href="<%=basePath%>sellerGoods/view?pageNum=${pageInfo.pageNum-1}&name=${name}&price1=${price1}&price2=${price2}&sellerId=${sellerId}" aria-label="Previous">
					        <span aria-hidden="true">上一页&laquo;</span>
					      </a>
					     </li>
				 	</c:if>
				 	
				    <c:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
				    	<c:if test="${page_Num==pageInfo.pageNum }">
				    		<li class="active"><a href="#">${page_Num }</a></li>
				    	</c:if>
				    	<c:if test="${page_Num!=pageInfo.pageNum }">
				    		<li><a href="<%=basePath%>sellerGoods/view?pageNum=${page_Num }&sellerId=${sellerId}&name=${name}&price1=${price1}&price2=${price2}">${page_Num }</a></li>
				    	</c:if>	
				    </c:forEach>
				    <c:if test="${pageInfo.hasNextPage }">
				 		<li>
					      <a href="<%=basePath%>sellerGoods/view?pageNum=${pageInfo.pageNum+1}&name=${name}&price1=${price1}&price2=${price2}&sellerId=${sellerId}" aria-label="Next">
					        <span aria-hidden="true">下一页&raquo;</span>
					      </a>
					     </li>
				 	</c:if>
				    <li><a href="<%=basePath%>sellerGoods/view?pageNum=${pageInfo.pages}&name=${name}&price1=${price1}&price2=${price2}&sellerId=${sellerId}">末页</a></li>
				  </ul>
				</nav>
			</div>
		</div>
	</div>
</div>
</body>
</html>
