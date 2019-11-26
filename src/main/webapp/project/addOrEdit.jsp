<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String projectId = request.getParameter("projectId");
	String projectGoodsId = request.getParameter("projectGoodsId");
	String projectUpdateId = request.getParameter("projectUpdateId");
	String projectUpdateGoodsId = request.getParameter("projectUpdateGoodsId");
	String editCount = request.getParameter("editCount");
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
		if("<%=projectGoodsId%>" == -1){
			findProjectUpdateGoodsById();
		}else if("<%=projectGoodsId%>" != 0){
			findProjectGoodsById();
		}else if("<%=projectGoodsId%>" == 0){
			$("#status").val(1);
			$("#editGoods").css("display","none");
			$('#code').on('change',function(){
				if($(this).val().trim() != ""){
					$.ajax({
						dataType : "json",
						type : "post",
						url : "<%=basePath%>project/findProjectGoodsByCode.action?projectId=<%=projectId%>&projectUpdateId=<%=projectUpdateId%>&companyId=<%=companyId%>&code="+$(this).val(),
						success : function(data) {
							initProject(data);
						},
						error : function(){
							$("#name").val("");
							$("#asName").val("");
							$("#type").val("");
							$("#unit").val("");
							$("#amount").val("");
							$("#price").val("");
							$("#goodsId").val("");
							$("#oldAmount").val("");
							$("#oldPrice").val("");
							$("#name").removeAttr("readonly");
							$("#asName").removeAttr("readonly");
							$("#code").removeAttr("readonly");
							$("#type").removeAttr("readonly");
							$("#unit").removeAttr("readonly");
							$("#oldAmount").removeAttr("readonly");
							$("#oldPrice").removeAttr("readonly");
							$("#editGoods").css("display","none");
							if($("#amount").val() == "" && $("#price").val() == ""){
								$("#status").val(1);
							}else{
								$("#status").val(0);
							}
						}
					});
				}
			})
		}
	})
	
	function findProjectGoodsById(){
		$.ajax({
			dataType : "json",
			type : "post",
			url : "<%=basePath%>project/findProjectGoodsById.action?projectGoodsId=<%=projectGoodsId%>&projectUpdateId=<%=projectUpdateId%>",
			success : function(data) {
				initProject(data);
			}
		});
	}
	
	function findProjectUpdateGoodsById(){
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
	}
	
	function initProject(obj){
		$("#goodsId").val("");
		$("#name").val(obj.name);
		$("#asName").val(obj.asName);
		$("#code").val(obj.code);
		$("#type").val(obj.type);
		$("#unit").val(obj.unit);
		$("#oldAmount").val(obj.amount);
		$("#oldPrice").val(obj.price);
		$("#goodsId").val(obj.goodsId);
		$("#projectGoodsAmount").val(obj.amount);
		$("#name").attr("readonly","readonly");
// 		$("#asName").attr("readonly","readonly");
		$("#type").attr("readonly","readonly");
		$("#unit").attr("readonly","readonly");
		$("#status").val(0);
		$("#editGoods").css("display","block");
		/* if($("#amount").val() == "" && $("#price").val() == ""){
			$("#status").val(1);
		}else{
			$("#status").val(0);
		} */
	}


	function saveOrUpdate() {
		var pgid = <%=projectGoodsId%>;
		var isValid = 0;
		var asName=$("#asName").val();
		var code=$("#code").val();
		var unit=$("#unit").val();
		var amount=$("#amount").val();
		var oldAmount=$("#oldAmount").val();
		var price=$("#price").val();
		var oldPrice=$("#oldPrice").val();
		var status=$("#status").val();
		var goodsId=$("#goodsId").val();
		var editStatus=$("#editStatus").val();
// 		var codeStyle=[1-9\.]*;
		if(asName!=null&&asName!=""){
			isValid = 1;
		}else{
			alert("项目采购控制表商品名称不可为空");
			isValid = 2;
			return;
		}
		if(code!=null&&code!=""){
			isValid = 1;
		}else if(codeStyle.test(code)){
			alert("编码不可为空");
			isValid = 2;
			return;
		}
		
		if(unit!=null&&unit!=""){
			isValid = 1;
		}else{
			alert("单位不可为空");
			isValid = 2;
			return;
		}
		if(pgid==0){
			if((oldAmount!=null&&oldAmount!="")||(oldPrice!=null&&oldPrice!="")){
				isValid = 1;
			}else{
				alert("请填写数量或价格");
				isValid = 2;
				return;
			}
		}else{
			if((amount!=null&&amount!="")||(price!=null&&price!="")){
				isValid = 1;
			}else{
				alert("请填写数量或价格");
				isValid = 2;
				return;
			}
		}
		
		/* if(price!=null&&price!=""){
			isValid = 1;
		}else{
			alert("单价不可为空");
			isValid = 2;
			return;
		} */
		//当前时间是否有分期，如果没有分批直接修改。
		$.ajax({
			dataType : "json",
			type : "post",
			url : "<%=basePath%>projectGroup/selectGroupDate.action?projectId=<%=projectId%>",
			success : function(data) {
				//没有分批并且是新增商品
				if(data ==0 &&(goodsId ==null ||goodsId==undefined || goodsId=="")){
					if(isValid = 1){
						$.post(
							"<%=basePath%>project/saveOrUpdateForProjectUpdateGoods?editCount=<%=editCount%>&editStatus="+editStatus+"&oldAmount="+oldAmount+"&oldPrice="+oldPrice,
							$('#goods').find('input').not('[value=""]').serialize(),
							
							function (data) {
								if(data==1){
//				 					alert("修改成功")
									window.history.back();
								}else{
									alert("修改失败！")
								}
							}
						) 
						}
				}else{
					if(isValid = 1){
								$.post(
									"<%=basePath%>project/saveOrUpdateForProjectUpdateGoods?editCount=<%=editCount%>&editStatus="+editStatus+"&oldAmount="+oldAmount+"&oldPrice="+oldPrice+"&goodsId="+goodsId+"&projectId="+<%=projectId%>,
										$('#goods').find('input').not('[value=""]').serialize(),
										function (data) {
											if(data==1){
//							 					alert("修改成功")
												window.history.back();
											}else if(data==2){
												alert("减少的数量不能小于控制总量！")
											}else if(data==3){
												alert("数量不可小于本次分批的已采购量");
											}
										}
									) 
								}
				}
			}
		});
	}
	
</script>
<body>
<div align="center">
    <h1>修改项目采购控制表信息</h1>
</div>
<div class="container-fluid" style="width:700px;height:600px;overflow-y:scroll;" >
    <div style="width:660px;height:900px;margin: auto;overflow-y:auto;">
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
                <input type="text" class="form-control" name="name" id="name" autocomplete="off" readonly="readonly" <c:if test="<%=Integer.valueOf(projectGoodsId) != 0%>" ></c:if>>
            </div>
            <div class="form-group">
                <label for="condition">项目采购控制表商品名称</label>
                <input type="text" class="form-control" name="asName" readonly="readonly" autocomplete="off" id="asName" <c:if test="<%=Integer.valueOf(projectGoodsId) != 0%>"></c:if>>
            </div>
            <div class="form-group">
                <label for="quality">编码</label>
                <input type="text" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" autocomplete="off" class="form-control" name="code" id="code" <c:if test="<%=Integer.valueOf(projectGoodsId) != 0%>">readonly="readonly"</c:if> >
            </div>
            <div class="form-group">
                <label for="quality">规格</label>
                <input type="text" class="form-control" name="type" id="type" autocomplete="off" readonly="readonly" <c:if test="<%=Integer.valueOf(projectGoodsId) != 0%>"></c:if>>
            </div>
            <div class="form-group">
                <label for="quality">单位</label>
                <input type="text" class="form-control" name="unit" id="unit" autocomplete="off" readonly="readonly" <c:if test="<%=Integer.valueOf(projectGoodsId) != 0%>"></c:if>>
            </div>
             <div class="form-group">
                <label for="quality">数量&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                <input type="text" class="form-control" readonly="readonly" name="oldAmount" id="oldAmount" autocomplete="off">
            </div>
            <div class="form-group">
                <label for="quality">单价</label>
                <input type="text" class="form-control" readonly="readonly" name="oldPrice" id="oldPrice" autocomplete="off">
            </div>
            <div id="editGoods">
	            <h2>修改信息</h2>
	             <div class="form-group">
		            <label for="quality">本期增减数量&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
<!-- 		            <span><font color="red" size="3">提示：输入增减后的商品数量</font></span> -->
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
            <div align="right">
	            <input type="button" class="btn btn-default" onclick="window.history.back('-1')" value="返回">
	            <input type="button" class="btn btn-primary" onclick="saveOrUpdate()" value="确定">
            </div>
        </form>
    </div>
</div>
</body>
</html>