<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String quotaPageId=request.getParameter("quotaPageId");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type='text/javascript' src='<%=basePath%>common/js/jquery-3.2.1.min.js'></script>
</head>
<body>
<script type="text/javascript">
	$(function() {
		alert("还没有数据");
		window.location.href = "<%=basePath%>quota/list.jsp?pageId="+<%=quotaPageId%>;
	});
</script>
</body>
</html>