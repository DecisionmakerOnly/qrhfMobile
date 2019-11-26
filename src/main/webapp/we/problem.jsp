<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>常见问题</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
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
<link rel="stylesheet" href="<%=basePath%>/common/css/amazeui.min.css"/>
<style type="text/css">
.fixed{
		 position:fixed;
		 left:0px;
		 bottom:0px;
	   	 width:100%; 
	   	 height:50px;
	  	 z-index:9999;
	  	 font-size:12px;
	  	 color:black;
	  	 text-align: center; 
	  	 line-height: 28px; 
       	}
</style>
<script type="text/javascript">
function zsy() {
	var yScroll = (window.parent.document.documentElement.scrollHeight > window.parent.document.documentElement.clientHeight) ? window.parent.document.documentElement.scrollHeight : window.parent.document.documentElement.clientHeight;
	return yScroll;
}
$(function() {
	var h = zsy();
	$("#listBody").height(h - 600);
	//取到窗口的高度 
	var winH = $(window).height();
	//取到页面的高度 
	var bodyH = $(document).height();
	if (bodyH > winH) {
		window.parent.document.getElementById("mainFrame").height = bodyH;
	} else {
		window.parent.document.getElementById("mainFrame").height = winH;
	}
})
</script>
</head>
<body style="font-family: 'Noto Serif CJK SC', 'Noto Serif CJK', 'Source Han Serif SC', ‘Source Han Serif’, source-han-serif-sc, serif;">
	  <br>
	  <div align="center"><h1 >常见问题</h1></div>
	  <br>
	 <div style="position: absolute; margin-left:100px; width: 1400px; height: 600px;">
		 <div class="row">
		    <div class="col-sm-6 col-md-3" style="width: 450px; height: 300px;">
		    	  <div  style="margin-left: 180px;"> <img alt="审批" src="<%=basePath%>common/images/sp.png"></div>
			      <h2 align="center">如何使用自动审批功能</h2>
			      <h4 align="center">填写项目采购控制表/采购表上传表格系统自动完成审批</h4> 
		    </div>
		    <div class="col-sm-6 col-md-3" style="width: 450px; height: 300px;">
		    	  <div style="margin-left: 180px;"> <img alt="下载项目采购控制表/采购表" src="<%=basePath%>common/images/cg.png"></div>
			      <h2 align="center">如何下载项目采购控制表</h2>
			      <h4 align="center">登录后点击下载按钮下载项目采购控制表</h4> 
		    </div>
		    <div class="col-sm-6 col-md-3" style="width: 450px; height: 300px;">
		    	  <div  style="margin-left: 180px;"> <img alt="收不到验证码" src="<%=basePath%>common/images/yzm.png"></div>
			      <h2 align="center">注册时收不到验证码</h2>
			      <h4 align="center">如果长时间收不到验证码查看是否被放在垃圾箱</h4> 
		    </div>
		    <div class="col-sm-6 col-md-3" style="width: 450px; height: 300px;">
		    	  <div  style="margin-left: 180px;"> <img alt="下载excel" src="<%=basePath%>common/images/execel.png"></div>
			      <h2 align="center">如何下载excel表格</h2>
			      <h4 align="center">需要先登录才能下载excel表格</h4> 
		    </div>
		    <div class="col-sm-6 col-md-3" style="width: 450px; height: 300px; ">
		    	  <div style="margin-left: 180px;"> <img alt="商家入驻" src="<%=basePath%>common/images/sj.png"></div>
			      <h2 align="center">商家入驻</h2>
			      <h4>注册成功后，登录选择卖家，进入卖家页面填写卖家信息后进行添加商品。</h4> 
		    </div>
		</div>
</div>
</body>
</html>