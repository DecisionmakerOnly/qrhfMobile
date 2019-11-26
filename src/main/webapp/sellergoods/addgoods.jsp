<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
<script src="<%=basePath%>common/plugin/js/distpicker.data.min.js"></script>
<script src="<%=basePath%>common/plugin/js/distpicker.min.js"></script>
<script src="<%=basePath%>common/plugin/js/main.js"></script>
<script src="<%=basePath%>common/plugin/My97DatePicker/WdatePicker.js"></script>
</head>
<script>
     function addgoods() {
		$.post(
			"<%=basePath%>sellerGoods/addGoods",
			{"price":$('#price').val(),
			 "amount":$('#amount').val(),
			 "goodsId":$('#goodsId').val(),
			 "sellerId":$('#sellerId').val()},
			function (data) {
				if(data==1){
					alert("添加成功")
					location.href="<%=basePath%>seller/list.jsp";
				}else{
					alert("添加失败")
					return;
				}
			}
		)
	} 
</script>
<body>
<div align="center">
    <h1>上架商品</h1>
</div>
<div class="container-fluid" style="width: 100%;height: 100%;margin: auto;" >
    <div style="width: 40%;height: 40%;margin: auto;">
        <form id="goods"  onsubmit="return false" action="##">
        	<input type="hidden" id="goodsId" value="${goods.id }">
        	<input type="hidden" id="sellerId" value="${seller.id }">
            <div class="form-group">
                <label for="condition">产品名称</label>
                <input type="text" class="form-control" name="name" value="${goods.name }" readonly="readonly">
            </div>
            <div class="form-group">
                <label for="quality">产品编码</label>
                <input type="text" class="form-control" name="code" value="${goods.code }" readonly="readonly">
            </div>
            <div class="form-group">
                <label for="quality">产品规格</label>
                <input type="text" class="form-control" name="type" value="${goods.type }" readonly="readonly">
            </div>
            <div class="form-group">
                <label for="quality">产品价格</label>
                <input type="text" class="form-control" id="price" placeholder="请输入产品价格">
            </div>
            <div class="form-group">
                <label for="quality">产品库存</label>
                <input type="text" class="form-control" id="amount" placeholder="请输入产品库存">
            </div>
            <input type="button" class="btn btn-default pull-right" onclick="addgoods()" value="确定">
        </form>
    </div>
</div>
</body>
</html>