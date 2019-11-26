<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
	Integer companyId = user.getCompanyId();
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="X-UA-Compatible" content="IE=edge"><!-- Bootstrap 不支持 IE 古老的兼容模式。为了让 IE 浏览器运行最新的渲染模式下，建议将此 <meta> 标签加入到你的页面中 -->
<meta name="renderer" content="webkit"><!-- 将下面的 <meta> 标签加入到页面中，可以让部分国产浏览器默认采用高速模式渲染页面 -->
<link href='common/css/bootstrap.css' rel='stylesheet'>
<link href='common/css/bootstrap-table.css' rel='stylesheet'>
<link href='common/css/bootstrap-treeview.css' rel='stylesheet'>
<script type='text/javascript' src='common/js/base.js'></script>
<script type='text/javascript' src='common/js/respond.min.js'></script>
<script type='text/javascript' src='common/js/jquery-3.2.1.min.js'></script>
<script type='text/javascript' src='common/js/bootstrap.js'></script>
<script type='text/javascript' src='common/js/bootstrap-table.js'></script>
<script type='text/javascript' src='common/js/bootstrap-table-zh-CN.js'></script>
<script type='text/javascript' src='common/js/bootstrap-treeview.js'></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	function zsy(){
		var yScroll = (window.parent.document.documentElement.scrollHeight >window.parent.document.documentElement.clientHeight) ? window.parent.document.documentElement.scrollHeight : window.parent.document.documentElement.clientHeight; 
		return yScroll;
	}
	
	$(function() {
		var h=zsy();
		$('#data-table').bootstrapTable({
	    	url: '<%=basePath%>paymentOrder/findInvoicList.action',
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
	              companyId: <%=companyId%>
              }; 
              return param;                   
            }, 
			pagination: true,//是否开启分页（*）
            pageNumber:1,//初始化加载第一页，默认第一页
            pageSize: 20,//每页的记录行数（*）
            pageList: [20,50,100],//可供选择的每页的行数（*）
            sidePagination: "server", //分页方式：client客户端分页，server服务端分页（*）
            showRefresh:false,//刷新按钮
            height:h-150,//table的高度
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
					field : 'id',
					title : '发票总数',
					valign : 'middle',
					sortable : true
				},
				{
					field : 'invoiceId',
					title : '已开发票数',
					valign : 'middle',
					sortable : true
				},
				{
					field : 'surplus',
					title : '未开发票数',
					valign : 'middle',
					sortable : true
				}
// 				,{
// 					field : 'createDate',
// 					title : '创建时间',
// 					valign : 'middle',
// 					sortable : true,
// 					formatter: function (value, row, index) {
// 				        return changeDateFormat(value)
// 				    }
// 				},
// 				{
// 		            field: 'operate',
// 		            title: '操作',
// 		            align: 'center',
// 		            valign: 'middle',
// 		           formatter: operateFormatter,
// 		        }
			],
			formatNoMatches: function(){
			    return "还没有发票";
			 }
        })
			 
        $("#listBody").height(h-50);
		//取到窗口的高度 
		var winH = $(window).height()/2;
		//取到页面的高度 
		var bodyH = $(document).height()/2;
		if(bodyH > winH){ 
			window.parent.document.getElementById("departmentFrame").height=bodyH;
		}else{ 
			window.parent.document.getElementById("departmentFrame").height=winH; 
		} 
	})
	 function operateFormatter(value, row, index) {
		if(row.orderStatus != 1){
			 return [
			        '<a class="edit" title="edit" href="javascript:cancelOrder('+row.id+')">取消订单</a>',
			        '&nbsp;&nbsp;&nbsp;&nbsp;'
			    ].join('');
		}
	} 
	
	//转换日期格式(时间戳转换为datetime格式)
	function changeDateFormat(cellval) {
	    var dateVal = cellval + "";
	    if (cellval != null) {
	        var date = new Date(parseInt(dateVal.replace("/Date(", "").replace(")/", ""), 10));
	        var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
	        var currentDate = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
	        var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
	        var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
	        var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
	        return date.getFullYear() + "-" + month + "-" + currentDate + " " + hours + ":" + minutes + ":" + seconds;
	    }
	}
	
	function cancelOrder(id) {
		
	}
	
</script>
</head>
<body id="listBody">
	<div align="center">
		<h1>发票管理</h1>
	</div>
	<table id="data-table"></table>
</body>
</html>