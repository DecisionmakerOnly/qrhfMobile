<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
	
	String pageId = request.getParameter("pageId");
	String contractId = request.getParameter("contractId");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>合同付款</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
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

	function closeModal(){
		<%
			session.setAttribute("pageId",pageId);
		%>
		window.location.href="<%=basePath%>main.jsp";
	}
	
	function save(){
		var price = $("#price").val();
		var payDate=String($("#payDate").val());
		var isValid=0;
		if(price!=null&&price!=""){
			isValid = 1;
		}else{
			alert("请输入金额！");
			isValid = 2;
			return;
		}
		if(payDate!=null&&payDate!=""){
			isValid = 1;
		}else{
			alert("请选择时间！");
			isValid = 2;
			return;
		}
		if(isValid==1){
			$.ajax({
				dataType : "json",
				type : "post",
				url : "<%=basePath%>contract/contractPay.action?contractId=<%=contractId%>&userId=<%=userId%>&price="+price+"&payDate="+payDate,
				success : function(data) {
					closeModal();
				}
			})
		}
	}

</script>
</head>
<body>
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">合同付款</h4>
			</div>
			<div class="container">
				<div class="form-group" style="width:500px">
					<label class="col-md-2 control-label"></label>
					<input type="text" class="form-control" id="price" name="price" placeholder="金额" oninput = "value=value.replace(/[^\d]/g,'')" autocomplete="off">
					<br/>
					<input role="button" style="width: 100%; height: 50px; " type="text" class="form-control input-sm Wdate" style="width:10%;" name="payDate" id="payDate" placeholder="选择时间" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="" readonly/>
				</div>
				<div class="modal-footer col-md-6">
					<button type="button" class="btn btn-default" onclick="closeModal()">关闭</button>
					<button type="button" onclick="save()" class="btn btn-default">付款</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
