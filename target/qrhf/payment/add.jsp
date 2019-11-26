<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User) request.getSession().getAttribute("user");
	Integer userId = user.getId();
	Integer companyId=user.getCompanyId();
	Integer departmentId=user.getDepartmentId();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
<script type="text/javascript" src="<%=basePath%>common/js/jquery.regionselect.js" ></script>
<script type="text/javascript" src="<%=basePath%>common/js/jquery.regionselect2.js" ></script>
<script src="<%=basePath%>common/plugin/My97DatePicker/WdatePicker.js"></script>
<style type="text/css">
  .zn{ 
  	width: 800px; 
  	float: center; 
  	margin: auto; 
  	margin-top: 40px; 
  } 
</style>
<script type="text/javascript">
function zsy(){
	var yScroll = (window.parent.document.documentElement.scrollHeight >window.parent.document.documentElement.clientHeight) ? window.parent.document.documentElement.scrollHeight : window.parent.document.documentElement.clientHeight; 
	return yScroll;
}
$(function() {
	initQuotaUnit();
	var h=zsy();
	$("#listBody").height(h-200);
	//取到窗口的高度 
	var winH = $(window).height();
	//取到页面的高度 `
	var bodyH = $(document).height();
	if(bodyH > winH){ 
		window.parent.document.getElementById("mainFrame").height=bodyH;
	}else{ 
		window.parent.document.getElementById("mainFrame").height=winH; 
	} 
	if($("#id").val(<%=id%>)!="" && $("#id").val(<%=id%>)!=undefined && $("#id").val(<%=id%>)!="undefined"){
		quotaById(<%=id%>);
	} 
});
function list(){
	window.location.href="<%=basePath%>quota/list.jsp?companyId=<%=companyId%>&pageId="+<%=quotaPageId%>;
}
</script>
<title>智能定额</title>
</head>
<body id="listBody">
	<div class="zn">
		<form class="form-horizontal" id="addForm" >
			<input type="hidden" name="companyId" id="companyId" value="<%=companyId%>" />
			<input type="hidden" name="id" id="id" value="<%=id%>">
	  		<div class="form-group" >
				<label class="col-sm-2 control-label">技工人数:</label>
					<div class="col-sm-4">
						 <div class="input-group">
							<input type="text" id="seniorWorker" name="seniorWorker" class="form-control" autocomplete="off" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" >
							<span class="input-group-addon">人</span>
						</div>
	    			 </div>
	    			 <div class="col-sm-6">
						<div class="input-group">
							<span class="input-group-addon">金额</span>
							<input type="text" id="seniorWorkerWages" name="seniorWorkerWages" class="form-control"  autocomplete="off"  onkeyup="clearNoNum(this)">
							<span class="input-group-addon">元/人</span>
						</div>
					</div>
	  		</div>
	  		<div class="form-group" >
				<label class="col-sm-2 control-label">普工人数:</label>
					<div class="col-sm-4">
						<div class="input-group">
							<input type="text" id="primaryWorker" name="primaryWorker" class="form-control" autocomplete="off" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" >
							<span class="input-group-addon">人</span>
						</div>
	    			 </div>
		    		<div class="col-sm-6">
						<div class="input-group">
							<span class="input-group-addon">金额</span>
							<input type="text" id="primaryWorkerWages" name="primaryWorkerWages" class="form-control"  autocomplete="off"  onkeyup="clearNoNum(this)">
							<span class="input-group-addon">元/人</span>
						</div>
					</div>
	  		</div>
	  	<div class="form-group" >
				<label class="col-sm-2 control-label">机械:</label>
					<div class="col-sm-4">
							<input type="text" id="mechanics" name="mechanics" class="form-control" autocomplete="off"  onkeyup="clearNoNum(this)">
	    			 </div>
		    		<div class="col-sm-6">
						<div class="input-group">
							<span class="input-group-addon">金额</span>
							<input type="text" id="mechanicsWages" name="mechanicsWages" class="form-control"  autocomplete="off"  onkeyup="clearNoNum(this)">
							<span class="input-group-addon">元</span>
						</div>
					</div>
	  		</div>
	  		<div class="form-group" >
				<label class="col-sm-2 control-label">完成工程量:</label>
				<div class="col-sm-4">
						<input type="text" id="workload" name="workload" class="form-control"  autocomplete="off"  onkeyup="clearNoNum(this)">
				</div>
					<div class="col-sm-6">
						<div class="input-group">
							 <span class="input-group-addon">单位</span>
							 <select id="unitId" name="unitId" class="form-control">
							     <option value="">==请选择==</option>
						     </select>
					     </div>
	    			 </div>
	  		</div>
	  		<span id="workloaderror" style="display:block;color: red; font-size: 18px; margin-left: 150px"></span>
	  		<span id="unitIderror" style="display:block;color: red; font-size: 18px; margin-left: 480px"></span>
	  		<div class="modal-footer col-md-12">
	  			<button type="button" onclick="list()" class="btn btn-default">返回工程详情</button>
				<button type="button" onclick="add()" class="btn btn-primary">保存</button>
			</div>
		</form>
	</div>
</body>
</html>