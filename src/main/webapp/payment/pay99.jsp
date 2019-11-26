<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.config.*"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)request.getSession().getAttribute("user");
	String loginName = user.getLoginName();
	String paymentOrderId = request.getParameter("paymentOrderId");
	String total = request.getParameter("total");
	String companyCode = user.getCompanyCode();
	String remark = request.getParameter("remark");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
	function complete(){
		$.ajax({
			dataType : "json",
			type : "post",
			url : "<%=basePath%>paymentOrder/pay99.action?paymentOrderId=<%=paymentOrderId%>&remark="+$("#remark").val(),
			success : function(data) {
				window.location.href = "<%=basePath%>sysMain/homePage.action";
			}
		});
	}
</script>
</head>
<body>
	<div class="form-horizontal">
		<div class="zn col-md-6">
			<div class="form-group" >
				<label class="col-sm-2 control-label"></label>
				<div class="col-md-8">
					<div align="center" class="input-group col-md-8">
						<h1>公司汇款信息</h1>
					</div>
				</div>
			</div>
	  		<div class="form-group" >
				<label class="col-sm-2 control-label">单位名称：</label>
				<div class="col-md-8">
					<div class="input-group col-md-8">
						<input type="text" class="form-control" value="<%=SystemAttributes.COMPANY_NAME%>" disabled>
					</div>
				</div>
			</div>
<!-- 			<div class="form-group" > -->
<!-- 				<label class="col-sm-2 control-label">税号：</label> -->
<!-- 				<div class="col-md-8"> -->
<!-- 					<div class="input-group col-md-8"> -->
<%-- 						<input type="text" class="form-control" value="<%=SystemAttributes.DUTY_PARAGRAPH%>" disabled> --%>
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 			<div class="form-group" > -->
<!-- 				<label class="col-sm-2 control-label">地址：</label> -->
<!-- 				<div class="col-md-8"> -->
<!-- 					<div class="input-group col-md-8"> -->
<%-- 						<input type="text" class="form-control" value="<%=SystemAttributes.ADDRESS%>" disabled> --%>
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 			<div class="form-group" > -->
<!-- 				<label class="col-sm-2 control-label">手机号：</label> -->
<!-- 				<div class="col-md-8"> -->
<!-- 					<div class="input-group col-md-8"> -->
<%-- 						<input type="text" class="form-control" value="<%=SystemAttributes.PHONE%>" disabled> --%>
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
			<div class="form-group" >
				<label class="col-sm-2 control-label">开户银行：</label>
				<div class="col-md-8">
					<div class="input-group col-md-8">
						<input type="text" class="form-control" value="<%=SystemAttributes.OPENING_BANK%>" disabled>
					</div>
				</div>
			</div>
			<div class="form-group" >
				<label class="col-sm-2 control-label">账号：</label>
				<div class="col-md-8">
					<div class="input-group col-md-8">
						<input type="text" class="form-control" value="<%=SystemAttributes.ACCOUNT_NUMBER%>" disabled>
					</div>
				</div>
			</div>
<!-- 			<div class="form-group" > -->
<!-- 				<label class="col-sm-2 control-label">卡号：</label> -->
<!-- 				<div class="col-md-8"> -->
<!-- 					<div class="input-group col-md-8"> -->
<%-- 						<input type="text" class="form-control" value="<%=SystemAttributes.CARD_NUMBER%>" disabled> --%>
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
			<div class="form-group" >
				<label class="col-sm-2 control-label">行号：</label>
				<div class="col-md-8">
					<div class="input-group col-md-8">
						<input type="text" class="form-control" value="<%=SystemAttributes.LINE_NUMBER%>" disabled>
					</div>
				</div>
			</div>
			<br>
			<div class="form-group" >
				<label class="col-sm-2 control-label">缴费金额：</label>
				<div class="col-md-8">
					<div class="input-group col-md-8">
						<input type="text" class="form-control" id="total" value="<%=total%>" disabled>
						<span class="input-group-addon">元</span>
					</div>
				</div>
			</div>
			<div class="form-group" >
				<label class="col-sm-2 control-label">缴费备注码：</label>
				<div class="col-md-8">
					<div class="input-group col-md-8">
						<input type="text" class="form-control" id="remark" value="<%=remark%>" disabled>
					</div>
				</div>
			</div>
			<div class="form-group" >
				<label class="col-sm-2 control-label"></label>
				<div class="col-md-8">
					<div class="input-group col-md-8" style="color:red">
						通过网银汇款时，请将“缴费备注码”粘贴到汇款单“备注”栏中。
					</div>
				</div>
			</div>
	  		<div class="modal-footer col-md-12">
				<button type="button" onclick="complete()" class="btn btn-primary">完成</button>
			</div>
		</div>
	</div>
</body>
</html>
