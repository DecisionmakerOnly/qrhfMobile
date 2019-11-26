<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String projectId = request.getParameter("projectId");
	String projectPageId = request.getParameter("projectPageId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>采购表上传</title>
<script type='text/javascript' src='<%=basePath%>common/js/base.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/jquery-3.2.1.min.js'></script>
<link href="<%=basePath%>common/css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
<link href="<%=basePath%>common/css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
<link href="<%=basePath%>common/css/custom.css" rel="stylesheet">
<link href="<%=basePath%>common/css/animate.min.css" rel="stylesheet">
<link href="<%=basePath%>common/css/style.min862f.css?v=4.1.0" rel="stylesheet">
<link href="<%=basePath%>common/css/validfromStyle.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">

function upload(){
	if($("#files").val()==""){
		alert("请选择文件！");
	}else{
		$("#uploadExl").attr("disabled", "disabled");
		$.ajax({
			url:'<%=basePath%>projectOrder/upload.action?projectId=<%=projectId%>',
			dataType:'json',
			type:'post',
			data:new FormData($("#importForm")[0]),
			contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 
	        processData: false, //必须false才会自动加上正确的Content-Type
			success:function(data){
				if(data != 0){
					alert("导入成功！");
					window.location.href = "<%=basePath%>order/preview.jsp?projectId=<%=projectId%>&projectPageId=<%=projectPageId%>&projectOrderId=" + data.projectOrderId+"&sysFlowId="+data.sysFlowId+"&projectOrderName="+data.projectOrderName;
				}else{
					alert("导入失败！");
				}
			},
			error:function(){
				alert("请求失败！");
			}
		});
	}
}
function toProjectList(){
	window.location.href="<%=basePath%>project/list.jsp?pageId=<%=projectPageId%>";
}
</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>批量导入采购表信息</h5>
						<div class="ibox-tools">
							<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
							</a>
						</div>
					</div>
					<div class="ibox-content">
						<form  id="importForm" method="post" class="form-horizontal" enctype="multipart/form-data">
							<div class="form-group">
								<label class="col-sm-2 control-label">选择Excel文件</label>
								<div class="col-sm-5">
									<input type="file" name="file" id="files">
								</div>
								<div class="col-sm-2">
									<div class="Validform_checktip"></div>
								</div>
							</div>
							<div class="hr-line-dashed"></div>
							<div class="form-group">
								<div class="col-sm-4 col-sm-offset-2">
									<button type="button" onclick="upload()" id="uploadExl" class="btn btn-primary">导入</button>
<!-- 									<button type="button" onclick="location.reload()" class="btn btn-primary">重置</button> -->
								<button type="button" onClick="toProjectList()" class="btn btn-primary">返回项目列表</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
