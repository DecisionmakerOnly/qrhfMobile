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
	String pageId = request.getParameter("pageId");
	session.setAttribute("pageId",pageId);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增角色</title>
<base href="<%=basePath%>">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- Bootstrap 不支持 IE 古老的兼容模式。为了让 IE 浏览器运行最新的渲染模式下，建议将此 <meta> 标签加入到你的页面中 -->
<meta name="renderer" content="webkit">
<!-- 将下面的 <meta> 标签加入到页面中，可以让部分国产浏览器默认采用高速模式渲染页面 -->
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
</head>
<script type="text/javascript">


 $(function(){
	 $('input[name="roleId"]').change(function() {
	        if (this.value == '-1') {
	        	$("#newRoles").css('display','block'); 
	        }
	        else {
	        	$("#newRoles").css('display','none'); 
	        }
	    });
     });

     function add() {
    	var roleId = $('input[name="roleId"]:checked').val();
    	if(roleId=='-1'){
// 	    	var code = $("#code").val();
	    	var name =$("#name").val();
	    	var isValid = 0;
	    	if(name==""){
				alert("角色名称不可为空!");
	    		return;
	    	}
// 	    	if(code==""){
// 	    		alert("角色编码不可为空!");
// 	    		return;
// 	    	}
	    	if(checkRole(name)==1){
	    		alert("角色名称已存在！");
	    		return false;
	    	}
	    	var data =  checkRepeats(name,<%=companyId%>);
	    	if (data == "1") {
				isValid = data;
				alert('角色名称已存在!');
				return false;
			} else if (data == "2") {
				isValid = data;
			}
	    	<%-- $.ajax({
	    		type : "post",
	    		url : "<%=basePath%>sysRole/checkRepeat",
	    		url : "<%=basePath%>sysRole/checkCode",
	    		data : {
	    			"name":name,
	    			"code" : code,
	    			"companyId":<%=companyId%>
	    		},
	    		dataType : "json",
	    		async: false,
	    		success : function(data) {
	    			if (data == "1") {
	    				isValid = data;
	    				$("#codeerror").css("color", "red");
	    				$("#codeerror").html('×角色名称或编码已存在!');
	    			} else if (data == "2") {
	    				isValid = data;
	    				$("#codeerror").css("color", "green");
	    				$("#codeerror").html("√角色名称和编码可以使用！");
	    			}
	    		}
	    	}); --%>
	    	if(isValid==2){
			$.post(
					"<%=basePath%>sysRole/add.action",
					$("#person").serialize(),
					function (person) {
						if(person==1){
							alert("添加成功")
							window.location.href="<%=basePath%>main.jsp";
						}else{
							alert("添加失败")
							return;
						}
					}
				)
	    	}
	    }else{
	    	var name = $('input[name="roleId"]:checked').attr('names');
	 		var code = $('input[name="roleId"]:checked').attr('codes');
	 		var data =  checkRepeats(name,<%=companyId%>);
	 		if(name==null){
	 	         alert('请选择角色或添加自定义角色');
	 	         return;
	 	       }
	 		if (data == "1") {
				alert('角色名称已存在!');
			} else if (data == "2") {
				$.post(
						"<%=basePath%>sysRole/add.action",
						{"name":name,"code":code,"companyId":$("#companyId").val()},
						function (person) {
							if(person==1){
								alert("添加成功")
								window.location.href="<%=basePath%>main.jsp";
							}else{
								alert("添加失败")
								return;
							}
						}
					)
			}
	    	
	    }
    } 
     
     function checkRepeats(name,companyId){
    	 var num = 0;
    	 $.ajax({
	    		type : "post",
	    		url : "<%=basePath%>sysRole/checkRepeat",
	    		data : {
	    			"name":name,
	    			"companyId":<%=companyId%>
	    		},
	    		dataType : "json",
	    		async: false,
	    		success : function(data) {
	    			num = data;
	    		}
	    	});
    	 return num;
     }
     
     
	function toRoleList() {
		window.location.href="<%=basePath%>/role/list.jsp?pageId="+<%=pageId%>;
	}
	
	 function checkRole(name) {
		var num = 0;
		$.ajax({
			dataType : "json",
			type : "post",
			async: false,//同步
			url : "<%=basePath%>role/checkRole",
			data:{"name":name},
			success : function(data) {
				num = data;
			}
		});
		
		return num;
	} 
	
</script>
<body>

<div class="modal-dialog" role="document">
	<div class="modal-content">
		<div class="modal-header">
			<h4 class="modal-title" id="myModalLabel">新增角色</h4>
		</div>
		<div class="container" style="padding-left: 100px">
     		<div class="form-group">
     			<c:forEach items="${roleList }" var="role">
     				<div>
	     				<input type="radio" name="roleId"  names="${role.name }" codes="${role.code }" value="${role.id }">${role.name }
     				</div>
     			</c:forEach>
     			<input type="radio" name="roleId" value="-1" id="ziding">自定义角色
     		</div>
	    </div>
			<form class="form-horizontal" id="person" method="post">
			<div class="container">
				 <input type="hidden" id="userId" name="userId" value="<%=userId%>"/>
				 <input type="hidden" id="companyId" name="companyId" value="<%=companyId%>"/>
				<div style="display: none" id="newRoles">
					<div class="form-group">
						<label class="col-md-2 control-label">角色名称：</label>
						<div class="col-md-3">
							<input type="text" class="form-control" name="name" id="name" placeholder="角色名称" autocomplete="off">
						</div>
						 <span id="usererror" style="color: red;"></span>
					</div>
<!-- 					<div class="form-group"> -->
<!-- 						<label class="col-md-2 control-label">角色编码：</label> -->
<!-- 						<div class="col-md-3 "> -->
<!-- 							<input type="text" class="form-control" id="code" name="code" placeholder="角色编码" autocomplete="off"> -->
<!-- 						</div> -->
<!-- 					 	<span id="codeerror" style="color: red;"></span> -->
<!-- 					</div> -->
				</div>
				<div class="modal-footer col-md-6">
					<button type="button" onclick="add()" class="btn btn-primary">保存</button>
					<button type="button" class="btn btn-default" onclick="closeModal()">关闭</button>
					<span id="isValiderror" style="color: red;"></span>
				</div>
			</div>
		</form> 
	</div>
</div> 
</body>
</html>