<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageId = request.getParameter("pageId");
	String recordId = request.getParameter("recordId");
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>临时权限</title>
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
		initData();
		$(".btn").click(function(){
			$(".btn").removeClass("btn-primary");
			$(this).addClass("btn-primary");
		});
	}); 
	
	function initData(){
		$.ajax({
		    type: "POST",//方法类型
		    dataType: "json",//预期服务器返回的数据类型
		    url: "<%=basePath%>sysResource/findTemporaryAuthorityList.action",
		    data: {
				pageId:<%=pageId%>,
				userId:<%=userId%>
			},
		    async: false,
		    success: function (data) {
		    	var html = "";
		    		html+= "<select class='form-control' style='width:580px;' name='sysResourceId' id='sysResourceId'>";
		    	for(var i=0;i<data.length;i++){
		    		html+= "<option value='"+data[i].id+"'>"+data[i].alias+"</option>";
// 		    		html += "<button class='btn' value='"+data[i].id+"'>"+data[i].name+"</button>";
		    	}
		    		html+= "</select>";
		    	$("#btnData").append(html);
		    }
		});
	}

	function save(){
		$.ajax({
			url:'sysResource/temporaryAuthority.action',
			dataType:'json',
			type:'post',
			traditional:true,
			data:{
				pageId:<%=pageId%>,
				recordId:<%=recordId%>,
				userId:<%=userId%>,
				sysResourceId:$("#sysResourceId").val(),
				remark:$("#remark").val()
			},
			success:function(data){
				if(data){
					alert("申请成功！");
				}else{
					alert("申请失败！");
				}
				window.location.href="<%=basePath%>main.jsp";
			}
		})
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
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">申请临时操作</h4>
			</div>
			<div class="container">
				<div class="form-group" id="btnData">
				</div>
				<div class="form-group">
					<textarea rows="5%" cols="78%" id="remark" ></textarea>
				</div>
				<div class="modal-footer col-md-6">
					<button type="button" class="btn btn-default" onclick="closeModal()">关闭</button>
					<button type="button" onclick="save()" class="btn btn-default">申请</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
