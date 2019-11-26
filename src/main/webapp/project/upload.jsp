<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
	Integer companyId=user.getCompanyId();
	String userName = user.getUserName();
	
	String projectId = request.getParameter("projectId");
	String projectName = new String(request.getParameter("projectName").getBytes("iso8859-1"),"utf-8"); 
	String projectPageId = request.getParameter("projectPageId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>项目采购控制表上传</title>
<script type='text/javascript' src='<%=basePath%>common/js/base.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/jquery-3.2.1.min.js'></script>
<script type="text/javascript" src="<%=basePath%>common/plugin/layer/layer.js"></script>
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
		$("#uploadExl").attr("disabled", true);
         var index = layer.msg('正在上传，请稍后', {
				  icon: 16,
				  shade: 0.1,
				  time: false
				});
			$.ajax({
				url:'<%=basePath%>project/upload.action',
				dataType:'json',
				type:'post',
				data:new FormData($("#importForm")[0]),
				contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 
	            processData: false, //必须false才会自动加上正确的Content-Type
				success:function(data){
					if(data == 1){	
						saveLog("<%=companyId%>","<%=userId%>",1,"<%=userName%>上传了《<%=projectName%>》项目的项目采购控制表！");
                        layer.close(index);
                        /*layer.confirm('导入成功！', {
                            btn: ['确定'] //可以无限个按钮
                        }, function(index){

                        });*/
                        layer.msg('导入成功！', {icon: 1});
                        window.location.href="<%=basePath%>project/preview.jsp?projectId=<%=projectId%>&projectPageId=<%=projectPageId%>";
                    }else if(data ==3){
                        layer.close(index);
                        layer.confirm('上传数据有重复项！', {
                            btn: ['确定'] //可以无限个按钮
                        }, function(index){
                            layer.close(index);
                        });
						 $("#uploadExl").attr("disabled", false);
                    }else{
                        layer.close(index);
                        layer.confirm('导入失败！', {
                            btn: ['确定'] //可以无限个按钮
                        }, function(index){
                            layer.close(index);
                        });
                    }
				},
				error:function(){
                    layer.close(index);
                    layer.confirm('请求失败！', {
                        btn: ['确定'] //可以无限个按钮
                    }, function(index){
                        layer.close(index);
                    });
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
	<form  id="importForm" method="post" class="form-horizontal" enctype="multipart/form-data">
		<div class="wrapper wrapper-content animated fadeInRight">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
							<h5>
								导入项目采购控制表信息
							</h5>
							<div class="ibox-tools">
								<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
								</a>
							</div>
						</div>
						<div class="ibox-content">
							<div class="form-group">
								<label class="col-sm-2 control-label">选择Excel文件</label>
								<div class="col-sm-5">
									<input type="hidden" name="projectId" value="<%=projectId%>">
									<input type="hidden" name="companyId" value="<%=companyId%>">
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
<!-- 								<button type="button" onclick="location.reload()" class="btn btn-primary">重置</button> -->
								<button type="button" onClick="toProjectList()" class="btn btn-primary">返回项目列表</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>