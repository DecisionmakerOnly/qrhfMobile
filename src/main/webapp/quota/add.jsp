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
	String quotaPageId=request.getParameter("quotaPageId");
	String id = request.getParameter("id");
	id = id==null||id.equals("undefined")?"":id;
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
	//下拉级联
 	$("#linkageId").regionselect({
 			url:'<%=basePath%>linkage/selectLinkage'
 	});
	$("#province").regionselect2({
			url:'<%=basePath%>region/selectRegion'
	});
});
function clearNoNum(obj){ 
    obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符  
    obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的  
    obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$","."); 
    obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3');//只能输入两个小数  
    if(obj.value.indexOf(".")< 0 && obj.value !=""){//以上已经过滤，此处控制的是如果没有小数点，首位不能为类似于 01、02的金额 
        obj.value= parseFloat(obj.value); 
    } 
} 
function add(){
	var id=$("#id").val();
	var linkageId =$("#linkageId").val();
	var linkagePid=$("#linkagePid").val();
	var linkageSonId=$("#linkageSonId").val();
	var province =$("#province").val();
	var city=$("#city").val();
	var area=$("#area").val();
	var name=$("#name").val();
	var region=$("#region").val();
	var seniorWorker=$("#seniorWorker").val();
	var seniorWorkerWages=$("#seniorWorkerWages").val();
	var primaryWorkerWages=$("#primaryWorkerWages").val();
	var primaryWorker=$("#primaryWorker").val();
	var mechanics=$("#mechanics").val();
	var mechanicsWages=$("#mechanicsWages").val();
	var wages=$("#wages").val();
	var workload=$("#workload").val();
	var unitId=$("#unitId").val();
	if(linkageId=="" || linkageId==null){
		$("#linkageIderror").css("color", "red");
		$("#linkageIderror").html("×请选择工程");
		return false;
	} else {
		$("#linkageIderror").css("color", "green");
		$("#linkageIderror").html("");
	}
	if(linkagePid=="" || linkagePid==null){
		$("#linkagePiderror").css("color", "red");
		$("#linkagePiderror").html("×请选择工程");
		return false;
	} else {
		$("#linkagePiderror").css("color", "green");
		$("#linkagePiderror").html("");
	}
	if(linkageSonId=="" || linkageSonId==null){
		$("#linkageSonIderror").css("color", "red");
		$("#linkageSonIderror").html("×请选择工程");
		return false;
	} else {
		$("#linkageSonIderror").css("color", "green");
		$("#linkageSonIderror").html("");
	}
	if(name=="" || name==null){
		$("#nameerror").css("color", "red");
		$("#nameerror").html("×请输入工作描述");
		return false;
	} else {
		$("#nameerror").css("color", "green");
		$("#nameerror").html("");
	}
	if(province=="" || province==null){
		$("#provinceeerror").css("color", "red");
		$("#provinceeerror").html("×请选择省份");
		return false;
	} else {
		$("#provinceeerror").css("color", "green");
		$("#provinceeerror").html("");
	}
	if(city=="" || city==null){
		$("#cityerror").css("color", "red");
		$("#cityerror").html("×请选择市区");
		return false;
	} else {
		$("#cityerror").css("color", "green");
		$("#cityerror").html("");
	}
	if(area=="" || area==null){
		$("#areaeerror").css("color", "red");
		$("#areaeerror").html("×请选择县区");
		return false;
	} else {
		$("#areaeerror").css("color", "green");
		$("#areaeerror").html("");
	}
	if(region=="" || region==null){
		$("#regionerror").css("color", "red");
		$("#regionerror").html("×输入具体地址");
		return false;
	} else {
		$("#regionerror").css("color", "green");
		$("#regionerror").html("");
	}
	if(workload=="" || workload ==null){
		$("#workloaderror").css("color", "red");
		$("#workloaderror").html("×请输入完成工程量");
		return false;
	} else {
		$("#workloaderror").css("color", "green");
		$("#workloaderror").html("");
	}
	if(unitId=="" || unitId==null){
		$("#unitIderror").css("color", "red");
		$("#unitIderror").html("×请选择单位");
		return false;
	} else {
		$("#unitIderror").css("color", "green");
		$("#unitIderror").html("");
	}
	var addData = {
			"id":id,
			"userId":<%=userId%>,
			"companyId":<%=companyId%>,
			"departmentId":<%=departmentId%>,
			"linkageId":linkageId,
			"linkagePid":linkagePid,
			"linkageSonId":linkageSonId,
			"province":province,
			"city":city,
			"area":area,
			"name":name,
			"region":region,
			"seniorWorker":seniorWorker,
			"seniorWorkerWages":seniorWorkerWages,
			"primaryWorkerWages":primaryWorkerWages,
			"primaryWorker":primaryWorker,
			"mechanics":mechanics,
			"mechanicsWages":mechanicsWages,
			"workload":workload,
			"unitId":unitId
		};
	
	$.ajax({
		url: '<%=basePath%>quota/saveQuota.action',
		type: 'post',
		data: addData,
		dataType: 'text',
		success:function(date){
			if(date == "1"){
				if($("#id").val(<%=id%>)==null || $("#id").val(<%=id%>)=="" || $("#id").val(<%=id%>)==undefined || $("#id").val(<%=id%>)=="undefined"){
					alert("添加成功!");
				}else{
					alert("操作成功")																																	
				}
				window.location.href = "<%=basePath%>quota/list.jsp?pageId="+<%=quotaPageId%>;
			}else{
				alert("error!");
			}
		}
	})
	
}

function initQuotaUnit(){
	$.ajax({
		dataType : "json",
		type : "post",
		async: false,//同步
		url : "<%=basePath%>quota/findByUnit.action",
		success : function(data) {
			var html = '';
			for(var i=0;i<data.length;i++){
				html +='<option value="'+data[i].id+'">'+data[i].name+'</option>'
			}
			$("#unitId").append(html);
		}
	});
	
	
}
function quotaById(id){
	$.ajax({
		dataType : "json",
		type : "post",
		url : "<%=basePath%>quota/getQuotaById.action?id="+id,
		success : function(data) {
			initQuota(data);
		}
	});
}
function initQuota(obj){
	$("#userId").val(obj.userId);
	$("#companyId").val(obj.companyId);
	$("#departmentId").val(obj.departmentId);
	$("#linkageId").val(obj.linkageId);
	$("#linkagePid").val(obj.linkagePid);
	$("#linkageSonId").val(obj.linkageSonId);
	$("#province").val(obj.regionId);
	$("#city").val(obj.regionPid); 
	$("#area").val(obj.regionSonId);
	$("#name").val(obj.name);
	$("#region").val(obj.region);
	$("#seniorWorker").val(obj.seniorWorker);
	$("#seniorWorkerWages").val(obj.seniorWorkerWages);
	$("#primaryWorkerWages").val(obj.primaryWorkerWages);
	$("#primaryWorker").val(obj.primaryWorker);
	$("#mechanics").val(obj.mechanics);
	$("#mechanicsWages").val(obj.mechanicsWages);
	$("#workload").val(obj.workload);
	$("#unitId").val(obj.unitId);
}
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
			<div class="form-group">
				<label class="col-sm-2 control-label">选择工程:</label>
				<div class="col-sm-4">
		  			<input class="form-control" type="text" id="linkageId" name="linkageId" placeholder="一级" /> 
	 			</div>
	 			<div class="col-sm-3">
		 			<input class="form-control" type="text" id="linkagePid" name="linkagePid"/> 
			 	</div>
			 	<div class="col-sm-3">
		 			<input class="form-control" type="text" id="linkageSonId" name="linkageSonId" /> 
				</div>
			</div>
			<span id="linkageIderror" style="display:block;color: red; font-size: 18px; margin-left: 200px"></span>
			<span id="linkagePiderror" style="display:block;color: red; font-size: 18px; margin-left: 200px"></span>
			<span id="linkageSonIderror" style="display:block;color: red; font-size: 18px; margin-left: 200px"></span>
	  		<div class="form-group" >
				<label class="col-sm-2 control-label">描述:</label>
				<div class="col-sm-10">
					<textarea class="form-control" id="name" name="name" placeholder="工作描述"></textarea>
	    		</div>
	  		</div>
	  		<span id="nameerror" style="display:block;color: red; font-size: 18px; margin-left: 200px"></span>
	  		<div class="form-group">
				<label class="col-sm-2 control-label">工程地址:</label>
					<div class="col-sm-4">
		  				<input class="form-control" type="text" id="province" name="province" /> 
	 				</div>
	 				<div class="col-sm-3">
		 				<input class="form-control" type="text" id="city" name="city"/> 
			 		</div>
			 		<div class="col-sm-3">
		 				<input class="form-control" type="text" id="area" name="area" /> 
					</div>
			</div>
			<span id="provinceerror" style="display:block;color: red; font-size: 18px; margin-left: 200px"></span>
			<span id="cityerror" style="display:block;color: red; font-size: 18px; margin-left: 200px"></span>
			<span id="areaerror" style="display:block;color: red; font-size: 18px; margin-left: 200px"></span>
			<div class="form-group" >
				<label class="col-sm-2 control-label">详细地址:</label>
					<div class="col-sm-10">
						<input type="text" id="region" name="region" class="form-control" autocomplete="off" >
	    			 </div>
	  		</div>
	  		<span id="regionerror" style="display:block;color: red; font-size: 18px; margin-left: 200px"></span>
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