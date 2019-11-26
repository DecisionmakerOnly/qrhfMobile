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
	Integer sysRoleId=user.getSysRoleId();
	String userIds = request.getParameter("userIds");
	Integer userNumber = userIds.split(",").length;
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	$(function(){
		$("#userNumber").val("<%=userNumber%>");
		computeTotal($("#timeNumber"));
// 		selectInvoice();
		$("button[name=payType]").click(function(){
			$("button[name=payType]").removeClass("btn-primary");
			$("#payTypeVal").attr("id","");
			$(this).attr("id","payTypeVal");
			$(this).addClass("btn-primary");
		});
	})
	
	function computeTotal(obj){
		var totalAmount = $(obj).val() * $("#userNumber").val()*99;
		$("#discountText").html("优惠率：0折");
		if($(obj).val() == 6){
			totalAmount = totalAmount * 0.85;
			$("#discountText").html("优惠率：8.5折");
		}else if($(obj).val()==12){
			totalAmount = totalAmount * 0.7;
			$("#discountText").html("优惠率：7折");
		}else if($(obj).val()==24){
			totalAmount = totalAmount * 0.5;
			$("#discountText").html("优惠率：5折");
		}
		totalAmount = totalAmount.toFixed(2);
		$("#totalText").text("预计金额："+totalAmount+"元");
		$("#total").val(totalAmount);
	}
	
	function save(){
		if($("#payTypeVal").val()!=null && $("#payTypeVal").val()!="" && $("#payTypeVal").val() !=0){
			var paymentOrder = initPaymentOrder();
			$.ajax({
				dataType : "json",
				type : "post",
				url : "<%=basePath%>paymentOrder/save.action?"+paymentOrder+"&userIds=<%=userIds%>&timeLength="+$("#timeNumber").val(),
				success : function(data) {
					window.location.href = "<%=basePath%>payment/firmOrder.jsp?paymentOrderId="+data+"&isInvoice="+$("input[name='isInvoice']:checked").val()+"&money="+$("#total").val();
				}
			});
		}else{
			alert("请选择支付方式！");
		}
		
	}
	function initPaymentOrder(){
		var paymentOrder = "companyId=<%=companyId%>";
		paymentOrder += "&userId=<%=userId%>";
		paymentOrder += "&orderCode="+getNowFormatDate();
		paymentOrder += "&orderName=aaa";
		paymentOrder += "&orderAmount="+$("#total").val();
		paymentOrder += "&payAmount="+$("#total").val();
		paymentOrder += "&payType="+$("#payTypeVal").val();
		if($("input[name='isInvoice']:checked").val() == 1){
			paymentOrder += "&invoiceId="+$("#invoiceListId").val();
		}
		return paymentOrder;
	}
	
	function addInvoice(num){
		if(num == 1){
			findInvoice();
			$('#myModal').modal('show');
		}
	}
	
	function findInvoice(){
		$.ajax({
			dataType : "json",
			type : "post",
			url : "<%=basePath%>invoice/findInvoiceAndAddressManagement.action?companyId=<%=companyId%>",
			success : function(data) {
				if(data[0] != null){
					$("#invoiceId").val(data[0].id);
					$("#unitName").val(data[0].unitName);
					$("#taxpayerId").val(data[0].taxpayerId);
					$("#registeredAddress").val(data[0].registeredAddress);
					$("#registeredPhone").val(data[0].registeredPhone);
					$("#openingBank").val(data[0].openingBank);
					$("#bankAccount").val(data[0].bankAccount);
				}
				if(data[1] != null){
					$("#addressManagementId").val(data[1].id);
					$("#recipientName").val(data[1].recipientName);
					$("#recipientPhone").val(data[1].recipientPhone);
					$("#recipientAddress").val(data[1].recipientAddress);
				}
			}
		});
	}
	
	function saveInvoice(){
		var param = initInvoice();
		$.ajax({
			data:param,
			dataType : "json",
			type : "post",
			contentType: "application/x-www-form-urlencoded;charset=UTF-8",
			url : "<%=basePath%>invoice/saveInvoiceList.action",
			success : function(data) {
				$("#invoiceListId").val(data);
				$.ajax({
					data:param,
					dataType : "json",
					type : "post",
					contentType: "application/x-www-form-urlencoded;charset=UTF-8",
					url : "<%=basePath%>invoice/save.action",
					success : function(data) {
						if(data == 1){
							$('#myModal').modal('hide');
						}
					}
				});
			}
		});
	}
	
	function initInvoice(){
		var invoiceId = ($("#invoiceId").val() == "" || $("#invoiceId").val() == null || $("#invoiceId").val() == undefined ? 0 : $("#invoiceId").val());
		var addressManagementId = ($("#addressManagementId").val() == "" || $("#addressManagementId").val() == null || $("#addressManagementId").val() == undefined ? 0 : $("#addressManagementId").val());
		var param = "companyId=<%=companyId%>";
			param += "&userId=<%=userId%>";
			param += "&invoiceId=" + invoiceId;
			param += "&invoiceListId=" + invoiceListId;
			param += "&addressManagementId=" + addressManagementId;
			param += "&unitName="+decodeURI($("#unitName").val());
			param += "&taxpayerId="+decodeURI($("#taxpayerId").val());
			param += "&registeredAddress="+decodeURI($("#registeredAddress").val());
			param += "&registeredPhone="+decodeURI($("#registeredPhone").val());
			param += "&openingBank="+decodeURI($("#openingBank").val());
			param += "&bankAccount="+decodeURI($("#bankAccount").val());
			param += "&recipientName="+decodeURI($("#recipientName").val());
			param += "&recipientPhone="+decodeURI($("#recipientPhone").val());
			param += "&recipientAddress="+decodeURI($("#recipientAddress").val());
		return param;
	}
	
	function getNowFormatDate() {
	    var date = new Date();
	    var month = date.getMonth() + 1;
	    var strDate = date.getDate();
	    var M = date.getMinutes();
			M = M > 9 ? M : "0" + M;
	    if (month >= 1 && month <= 9) {
	        month = "0" + month;
	    }
	    if (strDate >= 0 && strDate <= 9) {
	        strDate = "0" + strDate;
	    }
	    var currentdate = date.getFullYear() + month + strDate + date.getHours() + M + date.getSeconds();
	    return currentdate;
	} 
	
// 	function selectInvoice(){
// 		$.ajax({
// 			dataType : "json",
// 			type : "post",
<%-- 			url : "<%=basePath%>invoice/select.action?userId=<%=userId%>", --%>
// 			success : function(data) {
// 				var html = "";
// 				for(var i=0;i<data.length;i++){
// 					html += "<button class='btn btn-default' name='invoiceNames' >"+data[i].unitName+"</button>";
// 				}
// 				html += "<button class='btn btn-default' data-toggle='modal' data-target='#myModal'>添加发票</button>";
// 				$("#invoices").html(html);
// 				initInvoiceClass();
// 			}
// 		});
// 	}
	
// 	function initInvoiceClass(){
// 		$("button[name=invoiceNames]").click(function(){
// 			$("button[name=invoiceNames]").removeClass("btn-primary");
// 			$(this).addClass("btn-primary");
// 		});
// 	}
	function list(){
		window.location.href ="<%=basePath%>payment/selectUser.jsp";
	}
</script>	
</head>
<body>
	<div class="form-horizontal" style="overflow: auto;">
		<div class="zn  col-md-6" style="text-align	:right;">
			<div align="center" >
				<h1>选择服务</h1>
			</div>
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
					 	<select id="timeNumber" name="timeNumber" class="form-control" onchange="computeTotal(this)">
					 		<option value="1">1个月</option>
					 		<option value="2">2个月</option>
					 		<option value="3">3个月</option>
					 		<option value="6">6个月</option>
					 		<option value="12">1年</option>
					 		<option value="24">2年</option>
					     </select>
<!-- 					     <span class="input-group-addon">月</span> -->
					</div>
	   			 </div>
	  		</div>
	  		<div class="form-group" >
				<label class="col-md-2 control-label">确认金额：</label>
				<div class="col-md-10">
					<input type="hidden" name="total" id="total">
					<div class="well well-lg" id="totalText"></div>
					<div class="well well-sm" style="color:red;" id="discountText">提示：6个月8.5折、1年7折优惠、2年5折优惠</div>
	   			 </div>
	  		</div>
	  		<div class="form-group" >
				<label class="col-sm-2 control-label">支付方式：</label>
				<div class="col-md-4">
					 <div class="input-group">
					 	<button class="btn btn-default" name="payType" value="1">支付宝</button>
					 	<button class="btn btn-default" name="payType" value="99">工号转账</button>
					</div>
	   			 </div>
	  		</div>
	  		<div class="form-group" >
				<label class="col-sm-2 control-label">选择发票：</label>
				<div class="col-md-10">
					 <div class="input-group">
					 	<input type="radio" name="isInvoice" id="isInvoice" onclick="addInvoice(1)" value="1">是
					 	<input type="radio" name="isInvoice" id="isInvoice" onclick="addInvoice(0)" value="0" checked="checked">否
					</div>
	   			 </div>
	  		</div>
	  		
	  		<!-- 模态框（Modal） -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			    <div class="modal-dialog">
			        <div class="modal-content">
			            <div class="modal-header">
			                <h4 class="modal-title" id="myModalLabel" align="center">发票信息</h4>
			            </div>
			            <div class="modal-body">
			            	<input type="hidden" name="invoiceId" id="invoiceId">
			            	<input type="hidden" name="invoiceListId" id="invoiceListId">
			            	<input type="hidden" name="addressManagementId" id="addressManagementId">
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
					        <div class="modal-header">
				                <h4 class="modal-title" id="myModalLabel" align="center">邮寄信息</h4>
				            </div>
					        <div class="form-group">
					            <label for="firstname" class="col-sm-3 control-label">收票人姓名</label>
					            <div class="col-sm-8">
					           		<input type="text" class="form-control" name="recipientName" id="recipientName" placeholder="收票人姓名">
					            </div>
					        </div>
					        <div class="form-group">
					            <label for="firstname" class="col-sm-3 control-label">收票人手机</label>
					            <div class="col-sm-8">
					           		<input type="text" class="form-control" name="recipientPhone" id="recipientPhone" placeholder="收票人手机">
					            </div>
					        </div>
<!-- 					        <div class="form-group"> -->
<!-- 					            <label for="firstname" class="col-sm-3 control-label">收票人省份</label> -->
<!-- 					            <div class="col-sm-8"> -->
<!-- 					           		<input type="text" class="form-control" name="userName" id="userName" placeholder="收票人省份"> -->
<!-- 					            </div> -->
<!-- 					        </div> -->
					        <div class="form-group">
					            <label for="firstname" class="col-sm-3 control-label">详细地址</label>
					            <div class="col-sm-8">
					           		<input type="text" class="form-control" name="recipientAddress" id="recipientAddress" placeholder="详细地址">
					            </div>
					        </div>
			            </div>
			            <div class="modal-footer">
			                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			                <button type="button" class="btn btn-primary" onclick="saveInvoice()">保存</button>
			            </div>
			        </div>
			    </div>
			</div>
			
	  		<div class="modal-footer col-md-12">
	  			<button type="button" onclick="list()" class="btn btn-default">上一步</button>
				<button type="button" onclick="save()" class="btn btn-primary">创建订单</button>
			</div>
		</div>
	</div>
</body>
</html>
