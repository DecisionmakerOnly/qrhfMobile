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
    $("#distpicker5").distpicker({
        autoSelect: false
    });
</script>
<body>
<div align="center">
    <h1>采购清单</h1>
</div>
<div class="container-fluid" style="width: 100%;height: 100%;margin: auto;" >
    <div style="width: 40%;height: 40%;margin: auto;">
        <form>
            <div class="form-group">
                <label for="condition">采购条件</label>
                <input type="text" class="form-control" id="condition" placeholder="采购条件">
            </div>
            <div class="form-group">
                <label for="quality">产品质量</label>
                <input type="text" class="form-control" id="quality" placeholder="产品质量">
            </div>
            <div class="form-group">
                <label for="deliveryTime">交货时间</label>
                <input type="text" class="form-control" id="deliveryTime" placeholder="交货时间" onClick="WdatePicker()"/>
            </div>

            <label class="control-label">交货地址</label>
            <div id="distpicker5">
                <div class="form-group col-md-4">
                    <label class="sr-only" for="province10">Province</label>
                    <select class="form-control" id="province10"></select>
                </div>
                <div class="form-group col-md-4">
                    <label class="sr-only" for="city10">City</label>
                    <select class="form-control" id="city10"></select>
                </div>
                <div class="form-group col-md-4">
                    <label class="sr-only" for="district10">District</label>
                    <select class="form-control" id="district10"></select>
                </div>
            </div>

            <div class="form-group">
                <label for="deliveryAddress">详细地址</label>
                <input type="text" class="form-control" id="deliveryAddress" placeholder="建议您如实填写收货地址">
            </div>

            <div class="form-group">
                <label>货流方式</label>
                <select class="form-control">
                    <option value="1">物流</option>
                    <option value="2">快递</option>
                    <option value="3">顺丰</option>
                    <option value="4">物流</option>
                    <option value="5">快递</option>
                </select>
            </div>
            <div class="form-group">
                <label for="paymentTerms">付款条件</label>
                <input type="text" class="form-control" id="paymentTerms" placeholder="付款条件">
            </div>
            <div class="form-group">
                <label>付款方式</label><br>
                <label class="radio-inline">
                    <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1"> 转账
                </label>
                <label class="radio-inline">
                    <input type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option2"> 支票
                </label>
                <label class="radio-inline">
                    <input type="radio" name="inlineRadioOptions" id="inlineRadio3" value="option3"> 网银
                </label>
            </div>
            <div class="form-group">
                <label>票据</label><br>
                <label class="checkbox-inline">
                    <input type="checkbox" id="inlineCheckbox1" value="option1"> 发票
                </label>
                <label class="checkbox-inline">
                    <input type="checkbox" id="inlineCheckbox2" value="option2"> 货物清单
                </label>
                <label class="checkbox-inline">
                    <input type="checkbox" id="inlineCheckbox3" value="option3"> 买方签收清单
                </label>
            </div>

            <button type="submit" class="btn btn-default pull-right">提交</button>
        </form>
    </div>
</div>
</body>
</html>