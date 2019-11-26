<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	User user = (User) request.getSession().getAttribute("user");
	Integer userId = user.getId();
	Integer companyId=user.getCompanyId();
	Integer departmentId=user.getDepartmentId();
	String quotaPageId=request.getParameter("quotaPageId");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>统计</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=basePath%>common/js/echarts.js"></script>
<link href='<%=basePath%>common/css/bootstrap.css' rel='stylesheet'>
</head>
<body>
 	<div align="right" >
		<button type="button" onclick="list()" class="btn">返回工程详情</button>	
	</div>
	<div id="main" ></div>
    <script type="text/javascript">
    function list(){
    	window.location.href = "<%=basePath%>quota/list.jsp?pageId="+<%=quotaPageId%>;
    }
    var echartsWarp= document.getElementById('main');     
    var resizeWorldMapContainer = function () {//用于使chart自适应高度和宽度,通过窗体高宽计算容器高宽  
        echartsWarp.style.width = window.innerWidth-30+'px';  
        echartsWarp.style.height = window.innerHeight-30+'px';  
    };        
    resizeWorldMapContainer ();//设置容器高宽  
    var myChart = echarts.init(echartsWarp);

    option = {
    	    title : {
    	        text: '工程统计',
    	        subtext: '工程统计数据'
    	    },
    	    tooltip : {
    	        trigger: 'axis'
    	    },
    	    legend: {
    	        data:[
    	        	'金额/天/组', '完成工作量/天/组'
    	        ]
    	    },
    	    toolbox: {
    	        show : true,
    	        feature : {
    	            mark : {show: true},
    	            dataView : {show: true, readOnly: false},
    	            magicType : {show: true, type: ['line', 'bar']},
    	            restore : {show: true},
    	            saveAsImage : {show: true}
    	        }
    	    },
    	    calculable : true,
    	    grid: {y: 70, y2:30, x2:20},
    	    xAxis : [
    	        {
    	            type : 'category',
    	       		data : [${linkageCount}]
    	        },
    	        {
    	            type : 'category',
    	            axisLine: {show:false},
    	            axisTick: {show:false},
    	            axisLabel: {show:false},
    	            splitArea: {show:false},
    	            splitLine: {show:false},
    	            data : [${linkageCount}]
    	        }
    	    ],
    	    yAxis : {
				min : 0,
				title : {
					text : '工程统计图'
				}
			},
    	    series : [ 	
    	        {
    	            name:'金额/天/组',
    	            type:'bar',
    	            itemStyle: {normal: {color:'#F08080', label:{show:true}}},
    	            data:[${wages}]
    	        },
    	        {
    	            name:'完成工作量/天/组',
    	            type:'bar',
    	            itemStyle: {normal: {color:'red', label:{show:true,textStyle:{color:'#1A1A1A'}}}},
    	            data:[${workload}]
    	        } 
    	    ]
    	};
    myChart.setOption(option);
    </script>
</body>
</html>