<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
	Integer companyId = user.getCompanyId();
	String parentId = request.getParameter("parentId");
	parentId = parentId==null?"-1":parentId;
	String id = request.getParameter("id");
	id = id==null||id.equals("undefined")?"":id;
	String pageId = request.getParameter("pageId");
	session.setAttribute("parentId", parentId);
	session.setAttribute("pageId", pageId); 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>添加编辑部门模态框</title>
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
$(function() {
	if($("#id").val()!="" && $("#id").val()!=undefined && $("#id").val()!="undefined"){
		findDepartmentById($("#id").val());
	}
})
<%-- function save() {
	var code = $("#code").val();
	var name =$("#name").val();
	var companyId =$("#companyId").val();
	$.ajax({
		type : "post",
		url : "<%=basePath%>department/checkCode",
		data : {
			"code" : code,
			"companyId":companyId,
			"name":name
		},
		dataType : "json",
		async: false,
		success : function(data) {
			if (parseInt(data)>0) {
				$("#codeerror").css("color", "red");
				$("#codeerror").html('×已存在!');
			}else{
				$("#codeerror").html('');
				saveOrUpdate();
			}
		}
	});
} --%>

function saveOrUpdate(){
	var isValid = 0;
	var name =$("#name").val();
	var code = $("#code").val();
	var status = $('input[type=radio][name=status]:checked').val();
	if(name!=null&&name!=""){
		isValid = 1;
	}else{
		alert("请填写部门名称");
		isValid = 2;
		return;
	}
	if(code!=null&&code!=""){
		isValid = 1;
	}else{
		alert("请填写部门编号");
		isValid = 2;
		return;
	}
	if(isValid = 1){
		$.post(
			"<%=basePath%>department/saveOrUpdate.action",
			$("#department").serialize(),
			function (dep) {
				if(dep==1){
					alert("添加成功");
					window.location.href="<%=basePath%>main.jsp";
				}else if(dep==-1){
					alert("编码已存在");
					return;
				}else{
					alert("添加失败");
					return;
				}
			}
		)
	}
}

function findDepartmentById(id){
	$.ajax({
		dataType : "json",
		type : "post",
		url : "<%=basePath%>department/findDepartmentById.action?id="+id,
		success : function(data) {
			initDepartment(data);
		}
	});
}

		function initDepartment(obj){
			$("#companyId").val(obj.companyId);
			$("#departmentId").val(obj.departmentId);
			$("#name").val(obj.name);
			$("#code").val(obj.code);
			if(obj.status==0){
				$("input:radio[name='status']").eq(0).attr("checked",true);
			}else{
				$("input:radio[name='status']").eq(1).attr("checked",true);
			}
		}

</script>
</head>

<body>
	<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">创建部门</h4>
					<div class="alert alert-danger alert-dismissable" >
							<button type="button" class="close" data-dismiss="alert"
								aria-hidden="true">
								&times;
							</button>
							<p>部门创建说明：</p>
							<p>一、资金层:投资人。</p>
							<p>二、企业管理层:投资人代表；公司成本主管；公司财务主管。</p>
							<p>三、工程项目管理层：项目经理；材料员。</p>
						</div>
				</div>
				<div class="container">
					<form class="form-horizontal" id="department" method="post">
						<input type="hidden" name="companyId" id="companyId" value="<%=companyId%>" />
	        			<input type="hidden" name="departmentId" id="departmentId" value="<%=parentId%>" />
	        			<input type="hidden" name="id" id="id" value="<%=id%>">
						<div class="form-group">
							<label class="col-md-2 control-label">部门名称：</label>
							<div class="col-md-3 ">
								<input type="text" class="form-control" name="name" id="name" placeholder="部门名称" autocomplete="off">
							</div>
							 <span id="usererror" style="color: red;"></span>
						</div>
						<div class="form-group">
							<label class="col-md-2 control-label">部门编号：</label>
							<div class="col-md-3 ">
								<input type="text" class="form-control" name="code" id="code" placeholder="部门编码" autocomplete="off">
							</div>
							<span id="codeerror" style="color: red;"></span>
						</div>
						<div class="form-group">
						<label class="col-md-2 control-label">部门类型：</label>
						<div class="col-md-3 ">
							<label class="radio-inline">
								<input type="radio" name="status"  value="0" checked> 公司部门
							</label>
							<label class="radio-inline">
								<input type="radio" name="status"  value="1"> 项目部门
							</label>
						</div>
						</div>
						<div class="modal-footer col-md-6">
							<button type="button" class="btn btn-default" onclick="closeModal()">关闭</button>
							<button type="button" onclick="saveOrUpdate()" class="btn btn-primary">保存</button>
						</div>
					</form>
				</div>
			</div>
		</div>
</body>
</html>