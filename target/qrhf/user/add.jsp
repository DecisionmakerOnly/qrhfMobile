<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)request.getSession().getAttribute("user");
	Integer companyId = user.getCompanyId();
	String departmentId = request.getParameter("departmentId");
	departmentId = departmentId==null?"-1":departmentId;
	String id = request.getParameter("id");
	id = id==null||id.equals("undefined")?"":id;
	String pageId = request.getParameter("pageId");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
<script type="text/javascript">
	function zsy() {
		var yScroll = (window.parent.document.documentElement.scrollHeight > window.parent.document.documentElement.clientHeight) ? window.parent.document.documentElement.scrollHeight : window.parent.document.documentElement.clientHeight;
		return yScroll;
	}
	
	$(function() {
		var h = zsy();
		//取到窗口的高度 
		var winH = $(window).height();
		//取到页面的高度 
		var bodyH = $(document).height();
		if (bodyH > winH) {
			window.parent.document.getElementById("userFrame").height = bodyH;
		} else {
			window.parent.document.getElementById("userFrame").height = winH;
		}
		initUserRole();
		if($("#id").val()!="" && $("#id").val()!=undefined && $("#id").val()!="undefined"){
			findUserById($("#id").val());
		}
	})

    function add() {
		$.post(
			"<%=basePath%>user/add.action",
			$("#person").serialize(),
			function (person) {
				if(person==1){
					alert("添加成功！")
					window.location.href="<%=basePath%>user/list.jsp?parentId="+<%=departmentId%>+"&pageId="+<%=pageId%>;
				}else if(person==-1){
					alert("邮箱重复！");
				}else{
					alert("添加失败！")
					return;
				}
			}
		)
	}
	function cancel(){
		parent.top.location.href = "<%=basePath%>/daohang2.jsp";
	}
	function initUserRole(){
		$.ajax({
			dataType : "json",
			type : "post",
			url : "<%=basePath%>sysRole/findMyCompanyRole.action?companyId="+<%=companyId%>,
			success : function(data) {
				var html = '';
				for(var i=0;i<data.length;i++){
					html +='<option value="'+data[i].id+'">'+data[i].name+'</option>'
				}
				$("#sysRoleId").append(html);
			}
		});
	}
	
	function findUserById(id){
		$.ajax({
			dataType : "json",
			type : "post",
			url : "<%=basePath%>user/findUserById.action?id="+id,
			success : function(data) {
				initUser(data);
			}
		});
	}
	
	function initUser(obj){
		$("#companyId").val(obj.companyId);
		$("#departmentId").val(obj.departmentId);
		$("#userName").val(obj.userName);
		$("#email").val(obj.email);
		$("#sysRoleId").val(obj.sysRoleId);
	}
	
</script>
<body id="listBody">
	<div align="center">
	    <h1>添加员工</h1>
	</div>
	<div class="container-fluid" style="width: 100%;height: 100%;margin: auto;" >
	    <div style="width: 40%;margin: auto;">
	        <form id="person">
	        	<input type="hidden" name="companyId" id="companyId" value="<%=companyId%>" />
	        	<input type="hidden" name="departmentId" id="departmentId" value="<%=departmentId%>" />
	        	<input type="hidden" name="id" id="id" value="<%=id%>">
		        <div class="form-group">
		            <label for="condition">员工姓名</label>
		            <input type="text" class="form-control" name="userName" id="userName" placeholder="员工姓名">
		        </div>
		        <div class="form-group">
		            <label for="condition">
		            	<select name="loginType" id="loginType">
		            		<option value="2">邮箱</option>
		            	</select>
		            </label>
		            <input type="text" class="form-control" name="email" id="email" placeholder="邮箱">
		        </div>
		        <div class="form-group">
		            <label>职务</label>
		            <select class="form-control" name="sysRoleId" id="sysRoleId">
		            	<option value="">==请选择==</option>
		            </select>
		        </div>
		        <input type="button" class="btn btn-default pull-right" onclick="cancel()" value="取消">
		        <input type="button" class="btn btn-default pull-right" onclick="add()" value="确定"/>
		    </form>
		</div>
	</div>
	<div id="authDlg" class="modal fade" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					
					<h4 class="modal-title" id="myModalLabel">选择部门</h4>
				</div>
				<div class="container">
					<form class="form-horizontal" id="authForm" method="post">
						<div class="form-group">
							<label class="col-md-2 control-label">角色权限：</label>
							<div class="col-md-3 ">
								<div id="tree"></div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>