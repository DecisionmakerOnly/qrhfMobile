<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="zh-CN">
<head>
<base href="<%=basePath%>">
<title>用户到期日期</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="renderer" content="webkit">
<link href='<%=basePath%>common/css/bootstrap.css' rel='stylesheet'>
<link href='<%=basePath%>common/css/bootstrap-table.css' rel='stylesheet'>
<link href='<%=basePath%>common/css/bootstrap-treeview.css' rel='stylesheet'>
<script type='text/javascript' src='<%=basePath%>common/js/base.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/respond.min.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/jquery-3.2.1.min.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/bootstrap.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/bootstrap-table.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/bootstrap-table-zh-CN.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/bootstrap-treeview.js'></script>
<script src="<%=basePath%>common/plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	function zsy(){
		var yScroll = (window.parent.document.documentElement.scrollHeight >window.parent.document.documentElement.clientHeight) ? window.parent.document.documentElement.scrollHeight : window.parent.document.documentElement.clientHeight; 
		return yScroll;
	}
	$(function() {
		var h=zsy();
		$("#data-table").bootstrapTable('destroy'); 
		$('#data-table').bootstrapTable({
	    	url: '<%=basePath%>user/userExpirationDate.action',
			method: 'post',
			contentType: "application/x-www-form-urlencoded",
			//【查询设置】
			/* queryParamsType的默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort
			 设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber */
            queryParamsType:'', 
            queryParams: function queryParams(params) {  
              var param = {  
                  pageNumber: params.pageNumber,    
                  pageSize: params.pageSize,
                  companyName : $("#companyName").val()
              }; 
              return param;                   
            }, 
            pagination: true,//是否开启分页（*）
            pageNumber:1,//初始化加载第一页，默认第一页
            pageSize: 20,//每页的记录行数（*）
            pageList: [20,50,100],//可供选择的每页的行数（*）
            sidePagination: "server", //分页方式：client客户端分页，server服务端分页（*）
            showRefresh:false,//刷新按钮
            height:h-250,//table的高度
            //按需求设置不同的样式：5个取值代表5中颜色['active', 'success', 'info', 'warning', 'danger'];
			rowStyle: 'success',
			columns : [
				 {  
					title: '序号',//标题  可不加 
					valign : 'middle', 
					align: "center",
					formatter: function (value, row, index) {
						var pageSize=$('#data-table').bootstrapTable('getOptions').pageSize;//通过表的#id 可以得到每页多少条
						var pageNumber=$('#data-table').bootstrapTable('getOptions').pageNumber;//通过表的#id 可以得到当前第几页
						return pageSize * (pageNumber - 1) + index + 1;    //返回每条的序号： 每页条数 * （当前页 - 1 ）+ 序号
					}  
     			           }, 
				{
					field : 'companyName',
					title : '企业名称',
					valign : 'middle',
				    events: window.operateEvents,
				    align: "center"
				},
				{
					field : 'userName',
					title : '用户名称',
					valign : 'middle',
				    events: window.operateEvents,
				    align: "center"
				},
				{
					field : 'expiryDate',
					title : '到期日期',
					valign : 'middle',
					align: "center",
				    events: window.operateEvents,
					//获取日期列的值进行转换
				    formatter: function (value, row, index) {
				        return changeDateFormat(value);
				    }
				}
			]
        })
        
		function changeDateFormat(cellval) {
			var dateVal = cellval + "";
			if (cellval != null) {
			    var date = new Date(parseInt(dateVal.replace("/Date(", "").replace(")/", ""), 10));
			    var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
			    var currentDate = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
			    return date.getFullYear() + "-" + month + "-" + currentDate + " ";
			}
		}
		
        $("#listBody").height(h-100);
		//取到窗口的高度 
		var winH = $(window).height();
		//取到页面的高度 `
		var bodyH = $(document).height();
		if(bodyH > winH){ 
			window.parent.document.getElementById("mainFrame").height=bodyH;
		}else{ 
			window.parent.document.getElementById("mainFrame").height=winH; 
		}
	})
	
	function resetParam(){
		$("#companyName").val("");
		$('#data-table').bootstrapTable('refresh');
	}
	
</script>
</head>
<body id="listBody">
	<div align="center">
		<h1>用户到期日期</h1>
	</div>
	<div class="form-inline" align="right">
		<input type="text" class="form-control" id="companyName" placeholder="企业名称">
		<button class="btn" type="button" onclick="$('#data-table').bootstrapTable('refresh');">查询</button>
		<button class="btn" type="button" onclick="resetParam()">返回</button>
	</div>
	<table id="data-table"></table>
</body>
</html>