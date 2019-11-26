<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)request.getSession().getAttribute("user");
	String loginName=user.getLoginName();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>微信分享</title>
<link href="<%=basePath%>/common/css/kefu.css" rel="stylesheet" type="text/css" media="all" />
<link href="<%=basePath%>/common/css/daohang.css" rel="stylesheet" type="text/css" media="all" />
<link href="<%=basePath%>/common/css/bootstrap.css" rel="stylesheet" type="text/css" media="all">
<link href="<%=basePath%>/common/css/style2.css" rel="stylesheet" type="text/css" media="all" />
<script src="<%=basePath%>/common/js/jquery-3.2.1.min.js"></script>
<script src="<%=basePath%>/common/js/bootstrap.js"></script>
</head>
<body>
	<br><br><br><br><br><br><br>
	<div align="center" class="container">
		<img src="http://qr.liantu.com/api.php?text=http://www.zdcigo.com/user/register.jsp?shareCode=<%=loginName%>" class="img-responsive" alt="Cinque Terre" width="304" height="236"> 
		<h3>打开微信，扫一扫分享注册页面，有机会赢得大礼包。</h3>
	</div>
</body>
</html>