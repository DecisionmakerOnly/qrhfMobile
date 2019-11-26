<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
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
<script type="text/javascript" src="<%=basePath%>common/js/jquery-3.2.1.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/theme_trust.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/main.js"></script>
<style type="text/css">
html, body, wrapper {
	height: 100%;
}
</style>
<script>
	jQuery(document).ready(function() {
		jQuery('#openSidebar').click(function() {
			jQuery('.wrapper').toggleClass('openNav');

		});
		jQuery('#menu a').click(function() {
			jQuery('.wrapper').removeClass('openNav');
		});

	});
</script>
</head>
<body>
	<div class="pageMain">
		<div id="case" class="scrol-page">
			<div class="case k1120">
				<ul class="clearfix">
					<li>
						<div class="view-tenth">
							<img src="common/images/53a144b994b95.jpg"><a href="#"
								class="mask" target="_blank"><h2>案例测试九</h2>
								<p>测试</p></a>
						</div>
					</li>
					<li>
						<div class="view-tenth">
							<img src="common/images/53a144b994b95.jpg"><a href="#"
								class="mask" target="_blank"><h2>案例测试八</h2>
								<p>测试/ 浏览：190</p></a>
						</div>
					</li>
					<li>
						<div class="view-tenth">
							<img src="common/images/53a144b994b95.jpg"><a href="#"
								class="mask" target="_blank"><h2>案例测试七</h2>
								<p>测试/ 浏览：172</p></a>
						</div>
					</li>
					<li>
						<div class="view-tenth">
							<img src="common/images/53a144b994b95.jpg"><a href="#"
								class="mask" target="_blank"><h2>案例测试六</h2>
								<p>测试 / 浏览：94</p></a>
						</div>
					</li>
					<li>
						<div class="view-tenth">
							<img src="common/images/53a144b994b95.jpg"><a href="#"
								class="mask" target="_blank"><h2>案例测试五</h2>
								<p>测试 / 浏览：189</p></a>
						</div>
					</li>
					<li>
						<div class="view-tenth">
							<img src="common/images/53a144b994b95.jpg"><a href="#"
								class="mask" target="_blank"><h2>案例测试四</h2>
								<p>测试 / 浏览：127</p></a>
						</div>
					</li>
					<li>
						<div class="view-tenth">
							<img src="common/images/53a144b994b95.jpg"><a href="#"
								class="mask" target="_blank"><h2>案例测试三</h2>
								<p>测试/ 浏览：159</p></a>
						</div>
					</li>
					<li>
						<div class="view-tenth">
							<img src="common/images/53a144b994b95.jpg"><a href="#"
								class="mask" target="_blank"><h2>案例测试二</h2>
								<p>测试 / 浏览：137</p></a>
						</div>
					</li>
				</ul>
				<div class="paging">
					<a href='javascrpt:;' class='disabled'>上一页</a>
					<a href='list_1_2.html'>下一页</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
