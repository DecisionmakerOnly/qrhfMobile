<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
	
	String pageId = request.getParameter("pageId");
	String contractId = request.getParameter("contractId");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>合同列表</title>
<base href="<%=basePath%>">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="X-UA-Compatible" content="IE=edge"><!-- Bootstrap 不支持 IE 古老的兼容模式。为了让 IE 浏览器运行最新的渲染模式下，建议将此 <meta> 标签加入到你的页面中 -->
<meta name="renderer" content="webkit"><!-- 将下面的 <meta> 标签加入到页面中，可以让部分国产浏览器默认采用高速模式渲染页面 -->
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
<script type="text/javascript" src="pageoffice.js"  id="po_js_main"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	function zsy(){
		var yScroll = (window.parent.document.documentElement.scrollHeight >window.parent.document.documentElement.clientHeight) ? window.parent.document.documentElement.scrollHeight : window.parent.document.documentElement.clientHeight; 
		return yScroll;
	}

	$(function() {
		var h=zsy();
		$('#data-table').bootstrapTable({
	    	url: '<%=basePath%>contract/contractPayList',
			method: 'post',
			contentType: "application/x-www-form-urlencoded",
			//【查询设置】
			/* queryParamsType的默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort
			 设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber */
	        queryParamsType:'', 
	        queryParams: function queryParams(params) {  
	          var param = {  
	              contractId:<%=contractId%>
	          }; 
	          return param;                   
	        }, 
			locale:'zh-CN',//中文支持
			pagination: false,//是否开启分页（*）
	        showRefresh:false,//刷新按钮
	        height:h-250,//table的高度
			rowStyle: 'success',
			columns : [
				{  
					title: '序号',
					valign : 'middle', 
					align: "center",
					formatter: function (value, row, index) {
						var pageSize=$('#data-table').bootstrapTable('getOptions').pageSize;//通过表的#id 可以得到每页多少条
						var pageNumber=$('#data-table').bootstrapTable('getOptions').pageNumber;//通过表的#id 可以得到当前第几页
						return pageSize * (pageNumber - 1) + index + 1;    //返回每条的序号： 每页条数 * （当前页 - 1 ）+ 序号
					}  
                },
				{
					field : 'price',
					title : '金额（元）',
					align: "center",
					valign : 'middle'
				},
				{
					field : 'dPayDate',
					title : '付款时间',
					align: "center",
					valign : 'middle',
					//获取日期列的值进行转换
				    formatter: function (value, row, index) {
				        return changeDateFormat(value)
				    }
				},
				{
	                field: 'operate',
	                title: '操作',
	                align: 'center',
	                valign: 'middle',
	                formatter: operateFormatter
	            }
			]
	    })
	})
	
	function operateFormatter(value, row, index) {
		return ['<a role="button" onclick="del('+row.id+')">删除</a>'].join(''); 
	}
	function changeDateFormat(cellval) {
	    var dateVal = cellval + "";
	    if (cellval != null) {
	        var date = new Date(parseInt(dateVal.replace("/Date(", "").replace(")/", ""), 10));
	        var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
	        var currentDate = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
	        return date.getFullYear() + "-" + month + "-" + currentDate + " ";
	    }
	}
	function del(id){
		$.ajax({
			dataType : "json",
			type : "post",
			url : "<%=basePath%>contract/contractPayDel.action?contractPayId="+id,
			success : function(data) {
				if(data == 1){
					alert("删除成功");
					$('#data-table').bootstrapTable("refresh",{silent: true});
				}else{
					alert("删除失败");
				}
			}
		});
	}
	
	function toContractList(){
		window.location.href="<%=basePath%>contract/list.jsp?pageId=<%=pageId%>";
	}
</script>
</head>
<body>
	<div align="center">
		<h1>合同付款记录</h1>
	</div>
	<div align="right">
		<button class="btn" onClick="toContractList()">返回合同列表</button>
	</div>
	<table id="data-table"></table>
</body>
</html>