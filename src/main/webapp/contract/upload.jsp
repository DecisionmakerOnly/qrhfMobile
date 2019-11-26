<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String contractPageId = request.getParameter("contractPageId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>合同上传</title>
<script type='text/javascript' src='<%=basePath%>common/js/jquery-3.2.1.min.js'></script>
<link href="<%=basePath%>common/css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
<link href="<%=basePath%>common/css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
<link href="<%=basePath%>common/css/custom.css" rel="stylesheet">
<link href="<%=basePath%>common/css/animate.min.css" rel="stylesheet">
<link href="<%=basePath%>common/css/style.min862f.css?v=4.1.0" rel="stylesheet">
<link href="<%=basePath%>common/css/validfromStyle.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	function upload(){
		
		var files = document.getElementById('files').files;  
	    var fileSize = 0;
	    if(files.length!=0){
	        fileSize = files[0].size;
	    }else{
	    	alert("请选择文件！");
	    	 return false;
	    }
	    if(fileSize >4194304){
	        alert("文件不能大于4M ");
	        return false;
	    }else{

			$("#uploadExl").attr("disabled", "disabled");
			$.ajax({
				url:'<%=basePath%>contract/upload.action',
				dataType:'json',
				type:'post',
				data:new FormData($("#importForm")[0]),
				contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 
	            processData: false, //必须false才会自动加上正确的Content-Type
				success:function(data){
					if(data == 1){
						alert("导入成功！");
						javascript:history.go(-1);
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
	function toContractList(){
		window.location.href="<%=basePath%>contract/list.jsp?pageId=<%=contractPageId%>";
	}
</script>
</head>
<body class="gray-bg">
	<form  id="importForm" method="post" class="form-horizontal" enctype="multipart/form-data">
		<div class="wrapper wrapper-content animated fadeInRight">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
							<h5>
								上传合同
							</h5>
						</div>
						<div class="ibox-content">
							<div class="form-group">
								<label class="col-sm-2 control-label">选择文件</label>
								<div class="col-sm-5">
									<input type="file" name="file" id="files">
								</div>
							</div>
							<div class="hr-line-dashed"></div>
							<div class="form-group">
								<div class="col-sm-4 col-sm-offset-2">
									<button type="button" onclick="upload()" id="uploadExl" class="btn btn-primary">导入</button>
									<button type="button" onClick="toContractList()" class="btn btn-primary">返回项目列表</button>
								</div>
							</div>
							<div style="color: red;font-size: 20px;padding-left:180px" class="form-group">请将word合同文件大小控制在4M之内</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>