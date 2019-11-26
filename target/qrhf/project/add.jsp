<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
	Integer companyId=user.getCompanyId();
	Integer departmentId=user.getDepartmentId();
	departmentId = departmentId==null||departmentId.equals("undefined")?0:departmentId;
	String projectPageId = request.getParameter("projectPageId");
	session.setAttribute("pageId",projectPageId);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>创建项目模态框</title>
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
<script type="text/javascript" src="<%=basePath%>common/js/jquery.regionselect2.js" ></script>
<script type="text/javascript">
$(function() {
		$("#province").regionselect2({
			url:'<%=basePath%>region/selectRegion'
		});
})
function add(){
	var isValid = 0;
	var name =$("#name").val();
	var province =$("#province").val();
	var city=$("#city").val();
	var area=$("#area").val();
	var contractPrice=$("#contractPrice").val();
	var manpowerPrice=$("#manpowerPrice").val();
	var materialPrice=$("#materialPrice").val();
	var machinePrice=$("#machinePrice").val();
	var jurisdiction = $("#jurisdiction").val();
	if(name!=null&&name!=""){
		isValid = 1;
	}else{
		alert("请填写项目名称");
		isValid = 2;
		return;
	}
	if(jurisdiction!=null&&jurisdiction!=""){
		isValid = 1;
	}else{
		alert("请指定项目可见范围");
		isValid = 2;
		return;
	}
	if(province!=null&&province!=""){
		isValid = 1;
	}else{
		alert("请选择省");
		isValid = 2;
		return;
	}
	if(city!=null&&city!=""){
		isValid = 1;
	}else{
		alert("请选择市");
		isValid = 2;
		return;
	}
	if(area!=null&&area!=""){
		isValid = 1;
	}else{
		alert("请选择县");
		isValid = 2;
		return;
	}
	if(contractPrice!=null&&contractPrice!=""){
		isValid = 1;
	}else{
		alert("请填写合同价");
		isValid = 2;
		return;
	}
	if(manpowerPrice!=null&&manpowerPrice!=""){
		isValid = 1;
	}else{
		alert("请填写人工费");
		isValid = 2;
		return;
	}
	if(materialPrice!=null&&materialPrice!=""){
		isValid = 1;
	}else{
		alert("请填写材料费");
		isValid = 2;
		return;
	}
	if(machinePrice!=null&&machinePrice!=""){
		isValid = 1;
	}else{
		alert("请填写机械费");
		isValid = 2;
		return;
	}
	if(isValid = 1){
		$.post(
				"<%=basePath%>project/addProject.action",
				$("#person").serialize(),
				function (person) {
					if(person==1){
						alert("添加成功")
						window.location.href="<%=basePath%>main.jsp";
					}else if(person==2){
						alert("项目已存在");
						return;
					}else{
						alert("添加失败");
						return;
					}
				}
			)	
		}
	}
function closeModal(){
	<%
		session.setAttribute("pageId",2);
	%>
	window.location.href="<%=basePath%>main.jsp";
}
</script>
</head>
<body>
	<div class="modal-dialog" role="document" style="width:600px;height:480px;overflow-y:scroll;" >
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">创建项目</h4>
			</div>
			<div class="container">
				<form class="form-horizontal" id="person" method="post">
					<input type="hidden" id="userId" name="userId" value="<%=userId%>">
					<input type="hidden" id="companyId" name="companyId" value="<%=companyId %>">
<%-- 					<input type="text" id="departmentId" name="departmentId" value="<%=departmentId %>">				 --%>
					<div class="form-group">
						<label class="col-md-2 control-label">项目名称：</label>
						<div class="col-md-3 input-group" style="width: 580px;">
							<input type="text" class="form-control" name="name" id="name" placeholder="项目名称" autocomplete="off">
							<span class="input-group"></span>
						</div>
						<span id="projecterror" style="color: red;"></span>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label">指定范围：</label>
						<div class="col-md-3 input-group" style="width: 580px;">
							<select class="form-control" name="jurisdiction"
								id="jurisdiction">
								<option value="">==请选择==</option>
								<option value="1">本公司</option>
								<option value="2">本部门</option>
								<option value="3">自己</option>
							</select>
							<span class="input-group"></span>
						</div>
					</div>
					<div class="form-group" >
						<label class="col-md-2 control-label">工程地址：</label>
							<div class=" col-md-3 input-group" style="width: 580px;">
				  				<input class="form-control" type="text" id="province" name="province" /> 
				 				<input class="form-control" type="text" id="city" name="city"/> 
				 				<input class="form-control" type="text" id="area" name="area" /> 
				 				<span class="input-group"></span>
							</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label">合同价：</label>
						<div class="col-md-3 input-group"  style="width: 580px;">
							<input type="text" class="form-control" id="contractPrice" name="contractPrice" oninput = "value=value.replace(/[^\d]/g,'')" placeholder="合同价"  autocomplete="off">
							<span class="input-group-addon">元</span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label">人工费：</label>
						<div class="col-md-3 input-group"style="width: 580px;">
							<input type="text" class="form-control" id="manpowerPrice" name="manpowerPrice" placeholder="人工费" oninput = "value=value.replace(/[^\d]/g,'')" autocomplete="off">
							<span class="input-group-addon">元</span>
						</div>
						<span id="projecterror" style="color: red;"></span>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label">材料费：</label>
						<div class="col-md-3 input-group" style="width: 580px;">
							<input type="text" class="form-control" id="materialPrice" name="materialPrice"  placeholder="材料费" oninput = "value=value.replace(/[^\d]/g,'')" autocomplete="off">
							<span class="input-group-addon">元</span>
						</div>
						<span id="projecterror" style="color: red;"></span>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label">机械费：</label>
						<div class="col-md-3 input-group" style="width: 580px;">
							<input type="text" class="form-control" id="machinePrice" name="machinePrice"  placeholder="机械费" autocomplete="off">
							<span class="input-group-addon">元</span>
						</div>
						<span id="projecterror" style="color: red;"></span>
					</div>
					<div class=" col-md-6 modal-footer" style="width: 580px;">
						<button type="button" class="btn btn-default" onclick="closeModal()">关闭</button>
						<button type="button" onclick="add()" class="btn btn-primary">保存</button>
					</div>
				</form>			
			</div>
		</div>
	</div>
</body>
</html>