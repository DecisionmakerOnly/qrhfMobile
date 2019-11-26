<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
	Integer companyId=user.getCompanyId();
	String pageId = request.getParameter("pageId");
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
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- Bootstrap 不支持 IE 古老的兼容模式。为了让 IE 浏览器运行最新的渲染模式下，建议将此 <meta> 标签加入到你的页面中 -->
<meta name="renderer" content="webkit">
<!-- 将下面的 <meta> 标签加入到页面中，可以让部分国产浏览器默认采用高速模式渲染页面 -->
<link href='<%=basePath%>common/css/bootstrap.css' rel='stylesheet'>
<link href='<%=basePath%>common/css/bootstrap-table.css' rel='stylesheet'>
<link href="<%=basePath%>common/css/sidenav.min.css" type="text/css" rel="stylesheet" >
<link rel='stylesheet' href='<%=basePath%>common/css/googleapis.css' type='text/css'>
<link href='<%=basePath%>common/css/bootstrap-treeview.css' rel='stylesheet'>
<script type='text/javascript' src='<%=basePath%>common/js/base.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/respond.min.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/jquery-3.2.1.min.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/bootstrap.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/bootstrap-table.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/bootstrap-table-zh-CN.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/bootstrap-treeview.js'></script>
<script type='text/javascript' src="<%=basePath%>common/js/sidenav.min.js"></script>
<style type="text/css">
	  .toggle {
	    display: block;
	    height: 72px;
	    line-height: 72px;
	    text-align: center;
	    width: 72px;
	    position: absolute; 
	  }
	.div-a{ float:left;width:2%;} 
	.div-b{ float:right;width:97%;} 
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
function zsy(){
	var yScroll = (window.parent.document.documentElement.scrollHeight >window.parent.document.documentElement.clientHeight) ? window.parent.document.documentElement.scrollHeight : window.parent.document.documentElement.clientHeight; 
	return yScroll;
}

$(function(){
	var yScroll = (window.parent.document.documentElement.scrollHeight >window.parent.document.documentElement.clientHeight) ? window.parent.document.documentElement.scrollHeight : window.parent.document.documentElement.clientHeight; 
	var xScroll = document.body.clientWidth-50;	//90 两边都有空出
	$("#fra").height(yScroll);
	$("#fra").width(xScroll);
	   $(".sidenav li").on("click",function(){
	         var address =$(this).attr("data-src");
	      $("iframe").attr("src",address);
	      if(address!=null && address!=""){  //address的值为空就是一级下拉菜单 除此之外点击后关闭
	      	$("nav").attr("class","sidenav");
	       	$(".sidenav-overlay").css('display','none'); 
	      }
	   });
	});
</script>
</head>
<body>
<!--  <div class="jq22-container">
		<h3 style="text-align: center;">点击左侧的汉堡包按钮打开侧边栏菜单。</h3>
	</div> -->
	
	 <nav class="sidenav" data-sidenav data-sidenav-toggle="#sidenav-toggle">
	    <div class="sidenav-brand">
	     	 测试侧边栏
	    </div>

	    <div class="sidenav-header">
	    	  主标题
	      <small>副标题</small>
	    </div>

	    <ul class="sidenav-menu">
	      <li>
	        <a href="javascript:;" data-sidenav-dropdown-toggle class="active">
	          <span class="sidenav-link-icon">
	            <i class="material-icons">store</i>
	          </span>
	          <span class="sidenav-link-title">一级下拉菜单</span>
	          <span class="sidenav-dropdown-icon show" data-sidenav-dropdown-icon>
	            <i class="material-icons">arrow_drop_down</i>
	          </span>
	          <span class="sidenav-dropdown-icon" data-sidenav-dropdown-icon>
	            <i class="material-icons">arrow_drop_up</i>
	          </span>
	        </a>

	        <ul class="sidenav-dropdown" data-sidenav-dropdown>
	          <li data-src="project/list.jsp"><a href="javascript:;">二级菜单1</a></li>
	          <li data-src="project/add.jsp"><a href="javascript:;">二级菜单2</a></li>
	          <li><a href="javascript:;">二级菜单4</a></li>
	        </ul>
	      </li>
	      <li>
	        <a href="javascript:;" data-sidenav-dropdown-toggle>
	          <span class="sidenav-link-icon">
	            <i class="material-icons">payment</i>
	          </span>
	          <span class="sidenav-link-title">Sed do eiusmod</span>
	          <span class="sidenav-dropdown-icon show" data-sidenav-dropdown-icon>
	            <i class="material-icons">arrow_drop_down</i>
	          </span>
	          <span class="sidenav-dropdown-icon" data-sidenav-dropdown-icon>
	            <i class="material-icons">arrow_drop_up</i>
	          </span>
	        </a>

	        <ul class="sidenav-dropdown" data-sidenav-dropdown>
	          <li><a href="javascript:;">Tempor incididunt</a></li>
	          <li><a href="javascript:;">Labore</a></li>
	        </ul>
	      </li>
	      <li>
	        <a href="javascript:;" data-sidenav-dropdown-toggle>
	          <span class="sidenav-link-icon">
	            <i class="material-icons">shopping_cart</i>
	          </span>
	          <span class="sidenav-link-title">Dolore magna</span>
	          <span class="sidenav-dropdown-icon show" data-sidenav-dropdown-icon>
	            <i class="material-icons">arrow_drop_down</i>
	          </span>
	          <span class="sidenav-dropdown-icon" data-sidenav-dropdown-icon>
	            <i class="material-icons">arrow_drop_up</i>
	          </span>
	        </a>

	        <ul class="sidenav-dropdown" data-sidenav-dropdown>
	          <li><a href="javascript:;">Aliqua</a></li>
	          <li><a href="javascript:;">Exercitation</a></li>
	          <li><a href="javascript:;">Minim veniam</a></li>
	        </ul>
	      </li>
	      <li  data-src="project/list.jsp">
	        <a href="javascript:;">
	          <span class="sidenav-link-icon">
	            <i class="material-icons">list</i>
	          </span>
	          <span class="sidenav-link-title">列表页面</span>
	        </a>
	      </li>
	      <li>
	        <a href="javascript:;">
	          <span class="sidenav-link-icon">
	            <i class="material-icons">alarm</i>
	          </span>
	          <span class="sidenav-link-title">Commodo</span>
	        </a>
	      </li>
	    </ul>

	    <div class="sidenav-header">
	      Another Section Header
	    </div>

	    <ul class="sidenav-menu">
	      <li>
	        <a href="javascript:;" data-sidenav-dropdown-toggle>
	          <span class="sidenav-link-icon">
	            <i class="material-icons">date_range</i>
	          </span>
	          <span class="sidenav-link-title">Reprehenderit</span>
	          <span class="sidenav-dropdown-icon show" data-sidenav-dropdown-icon>
	            <i class="material-icons">arrow_drop_down</i>
	          </span>
	          <span class="sidenav-dropdown-icon" data-sidenav-dropdown-icon>
	            <i class="material-icons">arrow_drop_up</i>
	          </span>
	        </a>

	        <ul class="sidenav-dropdown" data-sidenav-dropdown>
	          <li><a href="javascript:;">Voluptate</a></li>
	          <li><a href="javascript:;">Excepteur</a></li>
	        </ul>
	      </li>
	      <li>
	        <a href="javascript:;">
	          <span class="sidenav-link-icon">
	            <i class="material-icons">backup</i>
	          </span>
	          <span class="sidenav-link-title">Occaecat</span>
	        </a>
	      </li>
	      <li>
	        <a href="javascript:;">
	          <span class="sidenav-link-icon">
	            <i class="material-icons">settings</i>
	          </span>
	          <span class="sidenav-link-title">Deserunt</span>
	        </a>
	      </li>
	    </ul>
	  </nav>

	<div class="div-a" style="padding-top: 25px">
	  <a href="javascript:;" class="toggle" id="sidenav-toggle">
	    <i class="material-icons">menu</i>
	  </a>
	</div>
	
	
  	<script>$('[data-sidenav]').sidenav();</script>
  	 <div class="div-b">
	    <iframe src="project/list.jsp" frameborder="0"  style="float: left" id="fra"></iframe>
  	 </div>
</body>
</html>