<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	/* User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
	Integer companyId = user.getCompanyId(); */
	String parentId = request.getParameter("parentId");
	parentId = parentId==null?"-1":parentId;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="X-UA-Compatible" content="IE=edge"><!-- Bootstrap 不支持 IE 古老的兼容模式。为了让 IE 浏览器运行最新的渲染模式下，建议将此 <meta> 标签加入到你的页面中 -->
<meta name="renderer" content="webkit"><!-- 将下面的 <meta> 标签加入到页面中，可以让部分国产浏览器默认采用高速模式渲染页面 -->
<script type="text/javascript" src="<%=basePath%>common/js/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="<%=basePath%>common/css/bootstrap.css" type="text/css" />
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap.js"></script>
<link href="<%=basePath%>common/plugin/css/main.css" rel="stylesheet">
<script src="<%=basePath%>common/plugin/js/distpicker.data.min.js"></script>
<script src="<%=basePath%>common/plugin/js/distpicker.min.js"></script>
<script src="<%=basePath%>common/plugin/js/main.js"></script>
<script src="<%=basePath%>common/plugin/My97DatePicker/WdatePicker.js"></script>
</head>
<script>
    function editDepar() {
		$.post(
			"<%=basePath%>department/update",
			$("#depar").serialize(),
			function (depar) {
				if(depar==1){
					alert("修改成功")
					window.parent.location.href="<%=basePath%>department/tree.jsp?parentId="+<%=parentId%>;
				}else{
					alert("修改失败")
					return;
				}
			}
		)
	}
</script>
<body>
<div align="center">
    <h1>编辑部门信息</h1>
</div>
<div class="container-fluid" style="width: 100%;height: 100%;margin: auto;" >
    <div style="width: 40%;height: 40%;margin: auto;">
        <form id="depar">
        	<input type="hidden" name="id" value="${department.id }">
            <div class="form-group">
                <label for="condition">部门名称</label>
                <input type="text" class="form-control" name="name" placeholder="部门名称" value="${department.name }">
            </div>
            <div class="form-group">
                <label for="quality">部门编码</label>
                <input type="text" class="form-control" name="code" placeholder="部门编码" value="${department.code }">
            </div>
            <input type="button" class="btn btn-default pull-right" onclick="editDepar()" value="确定"/>
        </form>
    </div>
</div>
</body>
</html>