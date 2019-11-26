<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
	Integer companyId = user.getCompanyId();
	String parentId = request.getParameter("parentId");
	parentId = parentId==null?"-1":parentId;
	String pageId = request.getParameter("pageId");
	session.removeAttribute("pageId");
	session.removeAttribute("parentId");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title></title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="renderer" content="webkit">
<link href='common/css/bootstrap.css' rel='stylesheet'>
<link href='common/css/bootstrap-table.css' rel='stylesheet'>
<link href='common/css/bootstrap-treeview.css' rel='stylesheet'>
<script type='text/javascript' src='common/js/base.js'></script>
<script type='text/javascript' src='common/js/respond.min.js'></script>
<script type='text/javascript' src='common/js/jquery-3.2.1.min.js'></script>
<script type='text/javascript' src='common/js/bootstrap.js'></script>
<script type='text/javascript' src='common/js/bootstrap-table.js'></script>
<script type='text/javascript' src='common/js/bootstrap-table-zh-CN.js'></script>
<script type='text/javascript' src='common/js/bootstrap-treeview.js'></script>
<script type="text/javascript">
	function zsy(){
		var yScroll = window.parent.document.documentElement.clientHeight; 
		return yScroll;
	}

	window.onload = function() { //解决iframe在非IE、firefox浏览器下（如edge、chrome浏览器）重复刷新的问题
		var iframe = document.createElement('iframe');
		iframe.id = "departmentFrame";
		iframe.width = "100%";
		iframe.frameborder = "0";
		iframe.scrolling = "no";
		iframe.style.border = "0px";
		iframe.setAttribute('frameborder', '0', 0);
		iframe.onload = function() {
			iframe.onload = null;
		};
		document.getElementById("departmentList").appendChild(iframe);
		iframe.src = "<%=basePath%>/department/list.jsp?parentId="+<%=parentId%>+"&pageId="+<%=pageId%>;

		var iframe2 = document.createElement('iframe');
		iframe2.id = "userFrame";
		iframe2.width = "100%";
		iframe2.frameborder = "0";
		iframe2.scrolling = "no";
		iframe2.style.border = "0px";
		iframe2.setAttribute('frameborder', '0', 0);
		iframe2.onload = function() {
			iframe2.onload = null;
		};
		document.getElementById("userList").appendChild(iframe2);//pageId+1区分一个页面上的两个按钮
		iframe2.src = "<%=basePath%>/user/list.jsp?parentId="+<%=parentId%>+"&pageId="+<%=Integer.valueOf(pageId)+1%>; 
	}
	
	$(function(){
		var h=zsy();
		$("#listBody").height(h);
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
</script>
</head>
<body id="listBody">
	<div class="tree-container">
		<div style="width:80%;float:left;height:50%;padding:0;overflow:auto;" id="departmentList"></div>
		<div style="width:80%;float:left;height:50%;padding:0;overflow:auto;" id="userList"></div>
	</div>
</body>
</html>
