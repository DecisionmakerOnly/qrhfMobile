<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<base href="<%=basePath%>">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="X-UA-Compatible" content="IE=edge"><!-- Bootstrap 不支持 IE 古老的兼容模式。为了让 IE 浏览器运行最新的渲染模式下，建议将此 <meta> 标签加入到你的页面中 -->
<meta name="renderer" content="webkit"><!-- 将下面的 <meta> 标签加入到页面中，可以让部分国产浏览器默认采用高速模式渲染页面 -->
<link href='<%=basePath%>common/css/bootstrap.css' rel='stylesheet'>
<link href='<%=basePath%>common/css/bootstrap-table.css' rel='stylesheet'>
<link href='<%=basePath%>common/css/bootstrap-treeview.css' rel='stylesheet'>
<script type='text/javascript' src='<%=basePath%>common/js/base.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/respond.min.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/jquery-3.2.1.min.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/bootstrap.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/bootstrap-table.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/bootstrap-table-zh-CN.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/bootstrap-treeview.js'></script>
<script type="text/javascript">
	function zsy() {
		var yScroll = (window.parent.document.documentElement.scrollHeight > window.parent.document.documentElement.clientHeight) ? window.parent.document.documentElement.scrollHeight : window.parent.document.documentElement.clientHeight;
		return yScroll;
	}
	
	$(function() {
		var h = zsy();
		//取到窗口的高度 
		var winH = $(window).height();
		//取到页面的高度 
		var bodyH = $(document).height();
		if (bodyH > winH) {
			window.parent.document.getElementById("userFrame").height = bodyH;
		} else {
			window.parent.document.getElementById("userFrame").height = winH;
		}
	})
	
</script>
<body id="listBody">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div align="center">
			    <h1>添加发票</h1>
			</div>
			
			<form class="form-horizontal" role="form" action="<%=basePath%>invoice/add.action">
		        <div class="form-group">
		            <label for="firstname" class="col-sm-3 control-label">单位名称</label>
		            <div class="col-sm-8">
		           		<input type="text" class="form-control" name="unitName" id="unitName" placeholder="单位名称">
		            </div>
		        </div>
		        <div class="form-group">
		            <label for="firstname" class="col-sm-3 control-label">纳税人识别码</label>
		            <div class="col-sm-8">
		           		<input type="text" class="form-control" name="taxpayerId" id="taxpayerId" placeholder="纳税人识别码">
		            </div>
		        </div>
		        <div class="form-group">
		            <label for="firstname" class="col-sm-3 control-label">注册地址</label>
		            <div class="col-sm-8">
		           		<input type="text" class="form-control" name="registeredAddress" id="registeredAddress" placeholder="注册地址">
		            </div>
		        </div>
		        <div class="form-group">
		            <label for="firstname" class="col-sm-3 control-label">注册电话</label>
		            <div class="col-sm-8">
		           		<input type="text" class="form-control" name="registeredPhone" id="registeredPhone" placeholder="注册电话">
		            </div>
		        </div>
		        <div class="form-group">
		            <label for="firstname" class="col-sm-3 control-label">开户银行</label>
		            <div class="col-sm-8">
		           		<input type="text" class="form-control" name="openingBank" id="openingBank" placeholder="开户银行">
		            </div>
		        </div>
		        <div class="form-group">
		            <label for="firstname" class="col-sm-3 control-label">银行账户</label>
		            <div class="col-sm-8">
		           		<input type="text" class="form-control" name="bankAccount" id="bankAccount" placeholder="银行账户">
		            </div>
		        </div>
		        <br>
		        <div class="form-group">
		            <label for="firstname" class="col-sm-3 control-label">收票人姓名</label>
		            <div class="col-sm-8">
		           		<input type="text" class="form-control" name="recipientName" id="recipientName" placeholder="收票人姓名">
		            </div>
		        </div>
		        <div class="form-group">
		            <label for="firstname" class="col-sm-3 control-label">收票人手机</label>
		            <div class="col-sm-8">
		           		<input type="text" class="form-control" name="RecipientPhone" id="RecipientPhone" placeholder="收票人手机">
		            </div>
		        </div>
		        <div class="form-group">
		            <label for="firstname" class="col-sm-3 control-label">收票人省份</label>
		            <div class="col-sm-8">
		           		<input type="text" class="form-control" name="userName" id="userName" placeholder="收票人省份">
		            </div>
		        </div>
		        <div class="form-group">
		            <label for="firstname" class="col-sm-3 control-label">详细地址</label>
		            <div class="col-sm-8">
		           		<input type="text" class="form-control" name="RecipientAddress" id="RecipientAddress" placeholder="详细地址">
		            </div>
		        </div>
		        <div class="form-group">
		        	<div class="col-sm-8">
			       		<input type="submit" class="btn btn-primary pull-right" value="确定"/>
			        	<input type="button" class="btn btn-default pull-right" onclick="window.close()" value="取消">
		       		</div>
		        </div>
			</form>
			
		</div>
	</div>
</body>
</html>