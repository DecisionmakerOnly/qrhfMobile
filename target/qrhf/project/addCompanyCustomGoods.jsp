<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)request.getSession().getAttribute("user");
	Integer companyId=user.getCompanyId();
%>
<!DOCTYPE html>
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
<script src="<%=basePath%>common/plugin/js/main.js"></script>
</head>
<script>

	function saveOrUpdate() {
		$.post("<%=basePath%>goods/addCompanyCustomGoods.action",$('#goods').find('input').not('[value=""]').serialize(),
			function (data) {
				if(data==1){
					window.history.back();
				}else{
					alert("添加失败！")
				}
			}
		) 
	}
	
</script>
<body>
<div align="center">
    <h1>添加企业自定义商品</h1>
</div>
<div class="container-fluid" style="width: 100%;height: 100%;overflow:auto;" >
    <div style="width:50%;height:600px;margin: auto;overflow-y:auto;">
        <form id="goods">
        	<input type="hidden" name="companyId" id="companyId" value="<%=companyId%>">
            <div class="form-group">
                <label for="condition">系统商品名称</label>
                <input type="text" class="form-control" name="name" id="name" autocomplete="off">
            </div>
            <div class="form-group">
                <label for="quality">编码</label>
                <input type="text" class="form-control" name="code" id="code" autocomplete="off">
            </div>
            <div class="form-group">
                <label for="quality">规格</label>
                <input type="text" class="form-control" name="type" id="type" autocomplete="off">
            </div>
            <div class="form-group">
                <label for="quality">单位</label>
                <input type="text" class="form-control" name="unit" id="unit" autocomplete="off">
            </div>
            <div align="right">
	            <input type="button" class="btn btn-default" onclick="window.history.back('-1')" value="返回">
	            <input type="button" class="btn btn-primary" onclick="saveOrUpdate()" value="确定">
            </div>
        </form>
    </div>
</div>
</body>
</html>