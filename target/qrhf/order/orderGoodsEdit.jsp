<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<script src="<%=basePath%>common/plugin/js/main.js"></script>
</head>
<script>
   <%-- function editProjectOrderGoods() {
  	 $.post(	//不能直接修改 把修改的数据放到临时表中 原表不动 把修改的数据提交给项目经理审批 通过后把修改的数据覆盖原表
  	 		"<%=basePath%>projectOrder/editProjectOrderGoods",
  	 		$("#goods").serialize(),
  	 		function (data) {
  	 			if(data==1){
  	 				alert("修改成功")
  	  	 			window.history.back();
  	 			}else{
  	 				alert("修改失败！")
  	 			}
  	 		}
  	 	) 
  	 } --%>
   
   function editProjectOrderGoods() {
  	 $.post(	
  	 		"<%=basePath%>project/updateTemporaryProjectGoods",
  	 		$("#goods").serialize(),
  	 		function (data) {
  	 			if(data==1){
  	 				alert("修改成功")
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
    <h1>修改采购表信息</h1>
</div>
<div class="container-fluid" style="width: 100%;height: 100%;margin: auto;" >
    <div style="width: 30%;height: 40%;margin: auto;">
        <form id="goods">
        	<input type="hidden" name="id" value="${tpg.id }">
            <div class="form-group">
                <label for="condition">系统商品名称</label>
                <input type="text" class="form-control" name="name" value="${tpg.name }" readonly="readonly">
            </div>
<!--             <div class="form-group"> -->
<!--                 <label for="condition">项目采购控制表商品名称</label> -->
<%--                 <input type="text" class="form-control" name="asName" value="${tpg.asName }" readonly="readonly"> --%>
<!--             </div> -->
            <div class="form-group">
                <label for="quality">编码</label>
                <input type="text" class="form-control" name="code" value="${tpg.code }" readonly="readonly">
            </div>
            <div class="form-group">
                <label for="quality">规格</label>
                <input type="text" class="form-control" name="type" value="${tpg.type }" readonly="readonly">
            </div>
            <div class="form-group">
                <label for="quality">单位</label>
                <input type="text" class="form-control" name="type" value="${tpg.unit }" readonly="readonly">
            </div>
            <div class="form-group">
                <label for="quality">数量</label>
                <input type="text" class="form-control" name="amount" value="${tpg.amount }">
            </div> 
            <div class="form-group">
               <label for="quality">单价</label>
               <input type="text" class="form-control" name="price" value="${tpg.price }">
           </div>
            <%-- <c:set var="status" value="${tpg.status }"/>
            <c:set var="sfStatus" value="${tpg.sfStatus }"/>
            	<c:choose>
            		
            		 <c:when test="${sfStatus==-1 or sfStatus==-3}">
	            		<div class="form-group">
			                <label for="quality">数量</label>
			                <input type="text" class="form-control" name="amount" value="${tpg.amount }">
			            </div>
            		</c:when> 
            		<c:when test="${status==2 ||status==3}">
	            		<div class="form-group">
			                <label for="quality">数量</label>
			                <input type="text" class="form-control" name="amount" value="${tpg.amount }">
			            </div>
            		</c:when>
            		<c:otherwise>
            			<div class="form-group">
			                <label for="quality">数量</label>
			                <input type="text" class="form-control" name="amount" value="${tpg.amount }" readonly="readonly">
			            </div> 
            		</c:otherwise>
            	</c:choose>
            	<c:choose>
            		 <c:when test="${sfStatus==-1 or sfStatus==-3}">
            			 <div class="form-group">
			                <label for="quality">价格</label>
			                <input type="text" class="form-control" name="price" value="${tpg.price }">
			            </div>
            		</c:when> 
            		<c:when test="${status==1 ||status==3}">
            			 <div class="form-group">
			                <label for="quality">价格</label>
			                <input type="text" class="form-control" name="price" value="${tpg.price }">
			            </div>
            		</c:when>
            		<c:otherwise>
            			  <div class="form-group">
			                <label for="quality">价格</label>
			                <input type="text" class="form-control" name="price" value="${tpg.price }" readonly="readonly">
			            </div>
            		</c:otherwise>
            	</c:choose> --%>
           
            
            <input type="button" class="btn btn-default pull-right" onclick="editProjectOrderGoods()" value="确定">
        </form>
    </div>
</div>
</body>
</html>