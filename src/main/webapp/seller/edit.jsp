<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
<link rel="stylesheet" href="<%=basePath%>common/css/bootstrap.css" type="text/css" />
<script type="text/javascript" src="<%=basePath%>common/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap.js"></script>
</head>
<script type="text/javascript">
function editSeller() {
$.post(
		"<%=basePath%>seller/update",
		$("#seller").serialize(),
		function () {
			alert("修改成功")
			location.href="<%=basePath%>seller/compareSeller";
		}
	) 
}


</script>
<body>
<div align="center">
    <h1>供应商信息</h1>
</div>
<div class="container-fluid" style="width: 100%;height: 100%;margin: auto;" >
    <div style="width: 40%;height: 40%;margin: auto;">
        <form id="seller" onsubmit="return false" action="##" method="post">
        	<input type="hidden" name="id" value="${seller.id }">
            <div class="form-group">
                <label for="name">名称</label>
                <input type="text" class="form-control" name="name" placeholder="供应商名称" value="${seller.name }">
            </div>
            <div class="form-group">
                <label for="infor">经营范围</label>
                <textarea class="form-control" rows="3" name="infor" placeholder="供应商主营商品等" >${seller.infor }</textarea>
            </div>

            <button type="submit" class="btn btn-default pull-right" onclick="editSeller()">提交</button>
        </form>
    </div>
</div>
</body>
</html>