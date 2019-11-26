<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)request.getSession().getAttribute("user");
	int userId = user.getId();
	int companyId = user.getCompanyId();
	String paymentOrderId = request.getParameter("paymentOrderId");
	int isInvoice = Integer.valueOf(request.getParameter("isInvoice"));
	String money=request.getParameter("money");
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
<style type="text/css">
.bac {
	background-color: red;
}
.bac2 {
	background-color: red;
}
</style>
<script type="text/javascript">
	$(function(){
		$.ajax({
			dataType : "json",
			type : "post",
			url : "<%=basePath%>paymentOrder/findPaymentOrderById.action?paymentOrderId=<%=paymentOrderId%>",
			success : function(data) {
				init(data);
			}
		});
		findCoupons();
		var isInvoice = "<%=isInvoice%>";
		if(isInvoice == 1){
			$.ajax({
				dataType : "json",
				type : "post",
				url : "<%=basePath%>invoice/findInvoiceAndAddressManagement.action?companyId=<%=companyId%>",
				success : function(data) {
					var html = "";
					if(data[0] != null){
						html += '<input type="hidden" name="invoiceId" id="invoiceId" value="'+data[0].id+'"></input>'
						html += "单位名称："+data[0].unitName;
						html += "<br>纳税人识别码："+data[0].taxpayerId;
						html += "<br>注册地址："+data[0].registeredAddress;
						html += "<br>注册电话："+data[0].registeredPhone;
						html += "<br>开户银行："+data[0].openingBank;
						html += "<br>银行账户："+data[0].bankAccount;
					}
					$("#invoice").html(html);
						html = "";
					if(data[1] != null){
						html += "收票人姓名："+data[1].recipientName;
						html += "<br>收票人手机："+data[1].recipientPhone;
						html += "<br>详细地址："+data[1].recipientAddress;
					}
					$("#addressManagement").html(html);
				}
			});
		}else{
			$("#invoice").html("未选择发票！");
			$("#addressManagement").html("未选择地址！");
		}
		
	})
	
	function init(obj){
		$("#userNumber").val(obj.users.split(",").length);
		$("#timeNumber").val(obj.timeLength);
		$("#total").val(obj.payAmount);
		$("#totalText").html("需支付金额："+<%=money%>+"元");
		$("#paymentOrderId").val(obj.id);
		$("#remark").val(obj.remark);
		$("#payType").val(obj.payType);
	}
	function cc(){
		 $("button").click(function(){
				$("[name=coupon]").removeClass("bac");
				$("[name=orderAmount]").removeClass("bac2");
				if($(".bac2").attr("orderAmount")==undefined ||$(".bac").attr("couponId") ==undefined){
					var totalAmount =<%=money%>
					$("#totalText").text("需支付金额："+totalAmount+"元");
					$("#total").val(totalAmount);
				}
		 });
	}
	function findCoupons(){
		$.ajax({
			dataType : "json",
			type : "post",
			url : "<%=basePath%>coupon/findCouponList.action?isValid=1&userId=<%=userId%>",
			success : function(data) {
				var html = "";
				for(var i=0;i<data.length;i++){
					html += "<ul class='list-group col-md-2' role='button' name='coupon' couponId='"+data[i].id+"'>";
					html += "<li class='list-group-item' name='orderAmount' orderAmount='"+data[i].orderAmount+"'>"+data[i].orderAmount+"元<input type='hidden' name='orderAmount' id='orderAmount' value='data[i].orderAmount'></li>";
					html += "</ul>";
				}
				if(html !=""){
					html +="<button type='button' onclick='cc()' class='btn btn-default'>不使用代金券</button>";
				}
				$("#coupons").html(html);
				$("[name=orderAmount]").click(function(){
					$("[name=orderAmount]").removeClass("bac2");
					$(this).addClass("bac2");
					$(".bac2").attr("orderAmount")
					if(parseInt($(".bac2").attr("orderAmount"))>parseInt(<%=money%>)){
						var totalAmount =parseInt(0)
						totalAmount = totalAmount.toFixed(2);
						$("#totalText").text("需支付金额："+totalAmount+"元");
						$("#total").val(totalAmount);
					}else{
						var totalAmount =parseInt(<%=money%>)-$(".bac2").attr("orderAmount")
						totalAmount = totalAmount.toFixed(2);
						$("#totalText").text("需支付金额："+totalAmount+"元");
						$("#total").val(totalAmount);
					}
				})
				$("[name=coupon]").click(function(){
					$("[name=coupon]").removeClass("bac");
					$(this).addClass("bac");
					$(".bac").attr("couponId")
				})
			}
		});
	}
	
	function alipay(){
		var invoiceId=$("#invoiceId").val();
		var payType = $("#payType").val();
		var couponId=$(".bac").attr("couponId");
		if(payType != null){
			if(couponId != undefined){
				$.ajax({
					type : "post",
					url : "<%=basePath%>coupon/updateCouponIsValud.action?couponId="+couponId+"&isValid=0"
				});
				$.ajax({
					type : "post",
					url : "<%=basePath%>paymentOrder/firmOrder.action?paymentOrderId="+<%=paymentOrderId%>+"&couponId="+couponId+"&orderAmount="+<%=money%>+"&payAmount="+$("#total").val()
				});
			}else{
				$.ajax({
					type : "post",
					url : "<%=basePath%>paymentOrder/firmOrder.action?paymentOrderId="+<%=paymentOrderId%>+"&orderAmount="+<%=money%>+"&payAmount="+$("#total").val()
				});
			}
			if(payType == "1"){
				window.location.href = "<%=basePath%>payment/alipay.jsp?paymentOrderId="+$("#paymentOrderId").val()+"&total="+$("#total").val()+"&remark=充值";
			}else if(payType == "99"){
				window.location.href = "<%=basePath%>payment/pay99.jsp?paymentOrderId="+$("#paymentOrderId").val()+"&total="+$("#total").val()+"&remark="+$("#remark").val()+"&invoiceId=invoiceId";
			}
		}
	}
	
</script>
</head>
<body  style="height: 800px;">
	<div class="form-horizontal">
		<div class="zn  col-md-6" style="text-align	:right;">
			<div align="center" >
				<h1>确认订单</h1>
			</div>
			<input type="hidden" name="paymentOrderId" id="paymentOrderId">
			<input type="hidden" name="remark" id="remark">
			<input type="hidden" name="total" id="total">
			<input type="hidden" name="1total" id="1total">
			<input type="hidden" name="2total" id="2total">
			<input type="hidden" name="payType" id="payType">
	  		<div class="form-group" >
				<label class="col-sm-2 control-label">人数：</label>
				<div class="col-md-4">
				 <div class="input-group">
					<input type="text" id="userNumber" name="userNumber" class="form-control" disabled>
					<span class="input-group-addon">人</span>
				</div>
			</div>
	  		</div>
	  		<div class="form-group" >
				<label class="col-sm-2 control-label">时长：</label>
				<div class="col-md-4">
					 <div class="input-group">
					 	<input type="text" id="timeNumber" name="timeNumber" class="form-control" disabled>
						<span class="input-group-addon">月</span>
					</div>
	   			 </div>
	  		</div>
	  		<div class="form-group" >
				<label class="col-sm-2 control-label">代金券：</label>
				<div class="col-md-10" id="coupons">
	   			</div>
	  		</div>
	  		<div class="form-group" >
				<label class="col-md-2 control-label">确认金额：</label>
				<div class="col-md-10">
					<div class="well well-lg" name="totalText" id="totalText"></div>
	   			</div>
	   			<c:if test="<%=isInvoice == 1 %>">
		   			<label class="col-md-2 control-label">确认发票：</label>
					<div class="col-md-10">
						<div class="well well-lg" name="invoice" id="invoice" align="left"></div>
		   			</div>
		   			<label class="col-md-2 control-label">确认地址：</label>
					<div class="col-md-10">
						<div class="well well-lg" name="addressManagement" id="addressManagement" align="left"></div>
		   			</div>
	   			</c:if>
	  		</div>
	  		
<!-- 	  		<div class="form-group" > -->
<!-- 				<label class="col-md-2 control-label">确认发票：</label> -->
<!-- 				<div class="col-md-10"> -->
<!-- 					<div class="well well-lg" name="invoice" id="invoice" align="left"></div> -->
<!-- 	   			</div> -->
<!-- 	   			<label class="col-md-2 control-label">确认地址：</label> -->
<!-- 				<div class="col-md-10"> -->
<!-- 					<div class="well well-lg" name="addressManagement" id="addressManagement" align="left"></div> -->
<!-- 	   			</div> -->
<!-- 	  		</div> -->
<!-- 	  		<div class="form-group" > -->
<!-- 				<label class="col-md-2 control-label">确认地址：</label> -->
<!-- 				<div class="col-md-10"> -->
<!-- 					<div class="well well-lg" name="addressManagement" id="addressManagement" align="left"></div> -->
<!-- 	   			 </div> -->
<!-- 	  		</div> -->
	  		
	  		<div class="modal-footer col-md-12">
<!-- 	  			<button type="button" onclick="list()" class="btn btn-default">取消</button> -->
				<button type="button" onclick="alipay()" class="btn btn-primary">确认并支付</button>
			</div>
		</div>
	</div>
</body>
</html>