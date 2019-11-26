<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
	Integer companyId = user.getCompanyId();
	String departmentId = request.getParameter("parentId");
	departmentId = departmentId==null?"-1":departmentId;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
</head>
<script>
    function editPerson() {
		$.post(
			"<%=basePath%>personnel/updatePersonnel",
			$("#person").serialize(),
			function (person) {
				if(person==1){
					alert("修改成功")
					window.location.href="<%=basePath%>personnel/personnelList.jsp";
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
    <h1>编辑员工信息</h1>
</div>
<div class="container-fluid" style="width: 100%;height: 100%;margin: auto;" >
    <div style="width: 40%;height: 40%;margin: auto;">
        <form id="person">
        <input type="hidden" name="id" value="${person.id }">
        <div class="form-group">
                <label for="condition">所在部门</label>
                <c:set value="${person.departmentId}"  var="departid" scope="request"/>
                <select class="form-control" name="departmentId">
	                <option value="">==请选择==</option>
	                <c:forEach items="${departmentName }" var="depar">
	                    <option value="${depar.id }" <c:if test="${depar.id==departid}">selected</c:if> >${depar.name }</option>
	                </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label for="condition">员工姓名</label>
                <input type="text" class="form-control" name="name" placeholder="员工姓名"  value="${person.name }">
            </div>
            <div class="form-group">
                <label>职务</label>
                <c:set value="${person.position}"  var="position" scope="request"/>
                <select class="form-control" name="position" value="${person.position }">
               		<option value="">==请选择==</option>
                    <option value="1" <c:if test="${position==1}">selected</c:if>>部门经理</option>
                    <option value="2" <c:if test="${position==2}">selected</c:if>>部门主管</option>
                    <option value="3" <c:if test="${position==3}">selected</c:if>>职员</option>
                </select>
            </div>
            <div class="form-group">
                <label for="quality">工作内容</label>
                <input type="text" class="form-control" name="content" placeholder="工作内容" value="${person.content }">
            </div>
            <input type="button" class="btn btn-default pull-right" onclick="editPerson()" value="确定"/>
        </form>
    </div>
</div>
</body>
</html>