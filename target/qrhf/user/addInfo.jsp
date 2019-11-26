<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String couponId = request.getParameter("couponId");
	String userId = request.getParameter("userId");
	String companyId = request.getParameter("companyId");
	String withdrawMoney=request.getParameter("withdrawMoney");
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

     function addInfos() {
    	 var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;
    	 var phone = $('#phone').val();
    	 var bank = $('#bankName').val();
    	 var userName = $('#userName').val();
    	 var cardNumber = $('#cardNumber').val();
 		if(!myreg.test(phone)){
 			$("#emailerror").html("×请输入有效的手机号！");
 			return false;
 		}else if(bank == 0){
 			$("#bankerror").html("×请选择提现到账的银行！");
 			return false;
 		}else if(userName == ""||userName == null){
 			$("#nameerror").html("×请填写银行卡持有人姓名！");
 			return false;
 		}else if(cardNumber == ""||cardNumber == null){
 			$("#numbererror").html("×请填写银行卡号！");
 			return false;
 		}else{
			$.post(
				"<%=basePath%>user/addInfo",
				{"userName":userName, 
				 "bankName":bank,
				 "cardNumber":cardNumber,
				 "phone":phone,
				 "withdrawMoney":<%=withdrawMoney%>,
				 "couponId":<%=couponId%>,
				 "userId":<%=userId%>,
				 "companyId":<%=companyId%>},
				function (data) {
					if(data==1){
						alert("提交成功,提现款将在三个工作日内到达指定账户")
						window.location.href="<%=basePath%>project/list.jsp?pageId="+2;
					}else{
						alert("提交失败")
						return;
					}
				}
			)
 		}
	} 
</script>
<body>
<div align="center">
    <h1>输入信息</h1>
</div>
<div class="container-fluid" style="width: 100%;height: 100%;margin: auto;" >
    <div style="width: 40%;height: 40%;margin: auto;">
        <form id="infos"  onsubmit="return false" action="##">
          <div class="form-group">
                <label for="quality">提现金额</label>
                <input type="text" class="form-control" name="withdrawMoney" id="withdrawMoney" value="<%=withdrawMoney %>" style="" disabled>
            </div>
            <div class="form-group">
                <label for="condition">真实姓名</label>
                <input type="text" class="form-control" name="userName" id="userName" placeholder="请输入银行卡持有人姓名">
                <span id="nameerror" style="display:block;color: red; font-size: 18px;margin-left:25px;"></span>
            </div>
            <div class="form-group">
                <label for="quality">选择到账银行</label>
                <select class="form-control" name="bankName" id="bankName">
                	<option value="0" selected="selected">请选择银行
                	<option value="中国银行">中国银行
                	<option value="中国工商银行">中国工商银行
                	<option value="中国农业银行">中国农业银行
                	<option value="中国建设银行">中国建设银行
                	<option value="中国邮政储蓄银行">中国邮政储蓄银行
                	<option value="交通银行">交通银行
                </select>
                <span id="bankerror" style="display:block;color: red; font-size: 18px;margin-left:25px;"></span>
            </div>
            <div class="form-group">
                <label for="quality">银行卡账号</label>
                <input type="text" class="form-control" name="cardNumber" id="cardNumber" placeholder="请输入提现到账的银行卡账号">
                <span id="numbererror" style="display:block;color: red; font-size: 18px;margin-left:25px;"></span>
            </div>
            <div class="form-group">
                <label for="quality">联系方式</label>
                <input type="text" class="form-control" id="phone" placeholder="请输入银行预留联系方式">
            	<span id="emailerror" style="display:block;color: red; font-size: 18px;margin-left:25px;"></span>
            </div>
            <input type="button" class="btn btn-default pull-right" onclick="addInfos()" value="提交">
        </form>
    </div>
</div>
</body>
</html>