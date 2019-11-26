<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String goodsId = request.getParameter("goodsId");
	String projectId = request.getParameter("projectId");
	String projectUpdateId = request.getParameter("projectUpdateId");
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
	$(function(){
		findGoodsById();
	})
	
	function findGoodsById(){
		$.ajax({
			dataType : "json",
			type : "post",
			url : "<%=basePath%>goods/findGoodsById.action?goodsId=<%=goodsId%>",
			success : function(data) {
				initGoods(data);
			}
		});
	}
	
	function initGoods(obj){
		$("#goodsId").val("");
		$("#name").val(obj.name);
		$("#asName").val(obj.asName);
		$("#code").val(obj.code);
		$("#type").val(obj.type);
		$("#unit").val(obj.unit);
		$("#goodsId").val(obj.id);
		$("#status").val(0);
		$("#editGoods").css("display","block");
	}


	function saveOrUpdate() {
		var amount=$("#amount").val();
		var price=$("#price").val();
		if(amount==null || amount=="" || price==null || price==""){
			alert("请填写数量或价格");
			return;
		}
		$.post("<%=basePath%>project/saveForProjectUpdateGoods",$('#goods').find('input').not('[value=""]').serialize(),
			function (data) {
				if(data==1){
					window.history.back();
				}else{
					alert("修改失败！")
				}
			}
		) 
	}
	
</script>
<body>
<div align="center">
    <h1>修改项目采购控制表信息</h1>
</div>
<div class="container-fluid"  style="width:700px;height:600px;overflow-y:scroll;">
    <div style="width:660px;height:670px;margin: auto;">
        <form id="goods">
        	<input type="hidden" name="project" id="project" value="<%=projectId%>">
        	<input type="hidden" name="projectId" id="projectId" value="<%=projectId%>">
        	<input type="hidden" name="companyId" id="companyId" value="<%=companyId%>">
        	<input type="hidden" name="projectUpdate" id="projectUpdate" value="<%=projectUpdateId%>">
        	<input type="hidden" name="goods" id="goodsId">
        	<input type="hidden" name="status" id="status">
        	<input type="hidden" name="projectGoodsAmount" id="projectGoodsAmount">
            <h2>原始信息</h2>
            <div class="form-group">
                <label for="condition">系统商品名称</label>
                <input type="text" class="form-control" name="name" id="name" autocomplete="off" readonly="readonly">
            </div>
            <div class="form-group">
                <label for="condition">项目采购控制表商品名称</label>
                <input type="text" class="form-control" name="asName" id="asName" autocomplete="off">
            </div>
            <div class="form-group">
                <label for="quality">编码</label>
                <input type="text" class="form-control" name="code" id="code" autocomplete="off" readonly="readonly">
            </div>
            <div class="form-group">
                <label for="quality">规格</label>
                <input type="text" class="form-control" name="type" id="type" autocomplete="off" readonly="readonly">
            </div>
            <div class="form-group">
                <label for="quality">单位</label>
                <input type="text" class="form-control" name="unit" id="unit" autocomplete="off" readonly="readonly">
            </div>
             <div class="form-group">
                <label for="quality">数量</label>
                <input type="text" class="form-control" name="amount" id="amount" autocomplete="off">
            </div>
            <div class="form-group">
                <label for="quality">单价</label>
                <input type="text" class="form-control" name="price" id="price" autocomplete="off">
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