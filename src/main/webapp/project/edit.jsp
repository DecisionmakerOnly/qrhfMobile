<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String projectUpdateGoodsId = request.getParameter("projectUpdateGoodsId");
	String projectId = request.getParameter("projectId");
	String goodsId = request.getParameter("goodsId");
	String editAmount = request.getParameter("editAmount");
	String pgAmount = request.getParameter("pgAmount");
	String oldEditStatus = request.getParameter("editStatus");
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
		$.ajax({
			dataType : "json",
			type : "post",
			url : "<%=basePath%>project/findProjectUpdateGoodsById.action?projectUpdateGoodsId=<%=projectUpdateGoodsId%>",
			success : function(data) {
				if(data != null){
					initProject(data);
				}
			}
		});
	})
	
	function initProject(obj){
		$("#name").val(obj.name);
		$("#asName").val(obj.asName);
		$("#code").val(obj.code);
		$("#type").val(obj.type);
		$("#unit").val(obj.unit);
		if(obj.amount!=null){
            $("#oldAmount").val(obj.amount);
		}else{
            $("#oldAmount").val(<%=pgAmount%>);
		}
		$("#oldPrice").val(obj.price);
	}


	function update() {
		var editAmount = <%=editAmount%>==null?0:<%=editAmount%>;
		$.ajax({
			dataType : "json",
			type : "post",
			async: false,//同步
			url : "<%=basePath%>project/projectUpdateGoodsUpdate",
			data:{id:$("#projectUpdateGoodsId").val(),
			price:$("#price").val(),amount:$("#amount").val(),
            oldAmount:$("#oldAmount").val(),oldPrice:$("#oldPrice").val(),
            editStatus:$("#editStatus").val(),projectId:<%=projectId%>,goodsId:<%=goodsId%>,
            editAmount:editAmount,oldEditStatus:<%=oldEditStatus%>},
			success : function (data) {
				if(data==1){
					window.history.back();
				}else if(data==2){
                    alert("减少的数量不能小于控制总量！");
					return false;
                }else if(data==3){
                    alert("数量不可小于本次分批的已采购量");
                    return false;
                }else{
					alert("修改失败！");
                    return false;
				}
			}
		});
	}
	
</script>
<body>
<div align="center">
    <h1>修改项目采购控制表信息</h1>
</div>
<div class="container-fluid" style="width: 100%;height: 100%;overflow:auto;" >
	<div style="width:50%;height:600px;margin: auto;overflow:auto;">
		<input type="hidden" name="projectUpdateGoodsId" id="projectUpdateGoodsId" value="<%=projectUpdateGoodsId%>">
		<div class="form-group">
			<label for="condition">系统商品名称</label>
			<input type="text" class="form-control" name="name" id="name" readonly="readonly">
		</div>
		<div class="form-group">
		    <label for="condition">项目采购控制表商品名称</label>
		    <input type="text" class="form-control" name="asName" id="asName" readonly="readonly">
		</div>
		<div class="form-group">
		    <label for="quality">编码</label>
		    <input type="text" class="form-control" name="code" id="code" readonly="readonly">
		</div>
		<div class="form-group">
		    <label for="quality">规格</label>
		    <input type="text" class="form-control" name="type" id="type" readonly="readonly">
		</div>
		<div class="form-group">
		    <label for="quality">单位</label>
		    <input type="text" class="form-control" name="unit" id="unit" readonly="readonly">
		</div>
		 <div class="form-group">
		    <label for="quality">数量</label>
		    <input type="text" class="form-control" readonly="readonly" name="oldAmount" id="oldAmount">
		</div>
		<div class="form-group">
		    <label for="quality">单价</label>
		    <input type="text" class="form-control" readonly="readonly" name="oldPrice" id="oldPrice">
		</div>
		<div id="editGoods">
			<h2>修改信息</h2>
			<div class="form-group">
				<label for="quality">本期增减数量&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
				<div class="input-group col-xs-12">
					<div class="input-group-btn">
						<select  id="editStatus" class="form-control" style="width: auto;">
							<option value="1">增加</option>
							<option value="2">减少</option>
						</select>
					</div>
					<input type="text" class="form-control" name="amount" id="amount" autocomplete="off" placeholder="在原有商品数量基础上进行修改">
				</div>
			</div>
			<div class="form-group">
				<label for="quality">本期修改单价</label>
				<input type="text" class="form-control" name="price" id="price" autocomplete="off" placeholder="商品的新价格">
			</div>
		</div>
		<input type="button" class="btn btn-default pull-right" onclick="update()" value="确定">
	</div>
</div>
</body>
</html>