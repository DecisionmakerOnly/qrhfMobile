<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>下载模板</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link href="<%=basePath%>common/css/style1.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=basePath%>common/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/theme_trust.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/main.js"></script>
<style type="text/css">
	html, body, wrapper {
		height: 100%;
	}
</style>
</head>
<body>
	<div class="pageMain" style="margin-top: -80px;">
		<div id="case" class="scrol-page">
			<div class="case k1120">
				<ul class="clearfix">
<!-- 					<li> -->
<!-- 						<div class="view-tenth"> -->
<%-- 							<img src="<%=basePath%>common/images/15.jpg"><a href="<%=basePath%>file/download/2.xlsx" --%>
<!-- 								class="mask" target="_blank"><h2>项目采购表模板</h2><h3>Excel .xlsx</h3> -->
<!-- 								<p>点击下载</p></a> -->
<!-- 						</div> -->
<!-- 					</li> -->
					<li>
						<div class="view-tenth">
							<img src="<%=basePath%>common/images/15.jpg"><a href="<%=basePath%>file/download/1.xlsx"
								class="mask" target="_blank"><h2>项目采购控制表模板</h2><h3>Excel .xlsx</h3>
								<p>点击下载</p></a>
						</div>
					</li>
					
<!-- 					<li> -->
<!-- 						<div class="view-tenth"> -->
<%-- 							<img src="<%=basePath%>common/images/15.jpg"><a href="<%=basePath%>file/download/2.xlsx" --%>
<!-- 								class="mask" target="_blank"><h2>项目采购表模板</h2><h3>Excel .xls</h3> -->
<!-- 								<p>点击下载</p></a> -->
<!-- 						</div> -->
<!-- 					</li> -->
					<li>
						<div class="view-tenth">
							<img src="<%=basePath%>common/images/15.jpg"><a href="<%=basePath%>file/download/1.xlsx"
								class="mask" target="_blank"><h2>项目采购控制表模板</h2><h3>Excel .xls</h3>
								<p>点击下载</p></a>
						</div>
					</li>
					
<!-- 					<li> -->
<!-- 						<div class="view-tenth"> -->
<%-- 							<img src="<%=basePath%>common/images/15.jpg"><a href="<%=basePath%>file/download/2.xlsx" --%>
<!-- 								class="mask" target="_blank"><h2>项目采购表模板</h2><h3>WPS .xlsx</h3> -->
<!-- 								<p>点击下载</p></a> -->
<!-- 						</div> -->
<!-- 					</li> -->
					<li>
						<div class="view-tenth">
							<img src="<%=basePath%>common/images/15.jpg"><a href="<%=basePath%>file/download/1.xlsx" 
								class="mask" target="_blank"><h2>项目采购控制表模板</h2><h3>WPS .xlsx</h3>
							<p>点击下载</p></a>
						</div>
					</li>
			<!-- 	start -->

<!-- 					<li> -->
<!-- 						<div class="view-tenth"> -->
<%-- 							<img src="<%=basePath%>common/images/15.jpg"><a href="<%=basePath%>file/download/2.xlsx" --%>
<!-- 								class="mask" target="_blank"><h2>项目采购表模板</h2><h3>WPS .xls</h3> -->
<!-- 								<p>点击下载</p></a> -->
<!-- 						</div> -->
<!-- 					</li> -->
					<li>
						<div class="view-tenth">
							<img src="<%=basePath%>common/images/15.jpg"><a href="<%=basePath%>file/download/1.xlsx" 
								class="mask" target="_blank"><h2>项目采购控制表模板</h2><h3>WPS .xls</h3>
							<p>点击下载</p></a>
						</div>
					</li>

			<!-- end -->
					<li>
						<div class="view-tenth">
							<img src="<%=basePath%>common/images/xnht.png"><a href="<%=basePath%>file/download/xnht.docx"
								class="mask" target="_blank"><h2>虚拟买卖合同</h2><h3>Word</h3>
								<p>点击下载</p></a>
						</div>
					</li>
					<li>
						<div class="view-tenth">
							<img src="<%=basePath%>common/images/xnht.png"><a href="<%=basePath%>file/download/xnht.docx"
								class="mask" target="_blank"><h2>虚拟买卖合同</h2><h3>Word</h3>
								<p>点击下载</p></a>
						</div>
					</li>
							<li>
						<div class="view-tenth">
							<img src="<%=basePath%>common/images/xnht.png"><a href="<%=basePath%>file/download/xnht.docx"
								class="mask" target="_blank"><h2>虚拟买卖合同</h2><h3>Word</h3>
								<p>点击下载</p></a>
						</div>
					</li>
					
					<li>
						<div class="view-tenth">
							<img src="<%=basePath%>common/images/xnht.png"><a href="<%=basePath%>file/download/xnht.docx"
								class="mask" target="_blank"><h2>虚拟买卖合同</h2><h3>Word</h3>
								<p>点击下载</p></a>
						</div>
					</li>
					
				</ul>
				<!-- <div class="paging">
					<a href='javascrpt:;' class='disabled'>上一页</a>
					<a href='list_1_2.html'>下一页</a>
				</div> -->
			</div>
		</div>
	</div>
</body>
</html>
