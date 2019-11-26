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
<title>提现记录</title>
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
<script type="text/javascript">
	function zsy(){
		var yScroll = (window.parent.document.documentElement.scrollHeight >window.parent.document.documentElement.clientHeight) ? window.parent.document.documentElement.scrollHeight : window.parent.document.documentElement.clientHeight; 
		return yScroll;
	}
	$(function() {
		var h=zsy();
		$("#data-table").bootstrapTable('destroy'); 
		$('#data-table').bootstrapTable({
	    	url: '<%=basePath%>refund/selectAll.action',
			method: 'post',
			contentType: "application/x-www-form-urlencoded",
			//【查询设置】
			/* queryParamsType的默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort
			 设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber */
            queryParamsType:'', 
            queryParams: function queryParams(params) {  
              var param = {  
                  pageNumber: params.pageNumber,    
                  pageSize: params.pageSize
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
					title : '所属企业',
					valign : 'middle',
				    events: window.operateEvents,
				    align: "center",
					sortable : true
				},
				{
					field : 'userNames',
					title : '提现人',
					valign : 'middle',
				    events: window.operateEvents,
				    align: "center",
					sortable : true
				},
				{
					field : 'userName',
					title : '提现姓名',
					valign : 'middle',
				    events: window.operateEvents,
				    align: "center",
					sortable : true
				},
				{
					field : 'withdrawMoney',
					title : '提现金额',
					valign : 'middle',
				    events: window.operateEvents,
				    align: "center",
					sortable : true
				},
				{
					field : 'bankName',
					title : '银行',
					valign : 'middle',
				    events: window.operateEvents,
				    align: "center",
					sortable : true
				},
				{
					field : 'cardNumber',
					title : '银行卡号',
					valign : 'middle',
				    events: window.operateEvents,
				    align: "center",
					sortable : true
				},
				{
					field : 'phone',
					title : '联系方式',
					valign : 'middle',
				    events: window.operateEvents,
				    align: "center",
					sortable : true
				},
				{
					field : 'businessType',
					title : '业务类型',
					valign : 'middle',
				    events: window.operateEvents,
				    align: "center",
					sortable : true,
					formatter:function(value,row,index){ 
				          if (row.businessType ==1) {
				        	  return "提现";
				          }else if(row.businessType == 2){
				        	  return "退款";
				          }
				     } 
				},
				{
					field : 'status',
					title : '状态',
					valign : 'middle',
					align: "center",
					sortable : true,
					formatter:function(value,row,index){ 
				          if (row.status ==0) {
				        	  return "提现中";
				          }else if (row.status ==1) {
				        	  return "提现成功";
				          }else if(row.status == -1){
				        	  return "提现失败";
				          }
				     } 
				},
				{
		            field: 'operate',
		            title: '操作',
		            align: 'center',
		            valign: 'middle',
		           formatter: operateFormatter,
		        }  
			],
        })
          function operateFormatter(value, row, index) {
			if (row.status ==0) {
				return ['<a role="button" onclick="updSuccess('+row.id+')">提现成功</a>&nbsp;&nbsp;&nbsp;',
	                 '<a role="button" onclick="updFail('+row.id+')">提现失败</a>',
	                 '&nbsp;&nbsp;&nbsp;'
	                 ].join(''); 
			}else if(row.status == -1){
				return ['<a role="button" onclick="updSuccess('+row.id+')">提现成功</a>&nbsp;&nbsp;&nbsp;',
	                 '&nbsp;&nbsp;&nbsp;'
	                 ].join(''); 
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
	
 	  function updSuccess(id) {
		$.post(
			"<%=basePath%>refund/updateStatus",
			{"id":id,"status":1},
			function(data) {
				if(data==1){
					location.reload();
				}
			}
		) 
	}
	
	function updFail(id) {
		$.post(
			"<%=basePath%>refund/updateStatus",
			{id:id,status:-1},
			function(data) {
				if(data==1){
					location.reload();
				}
			}
		)
	} 
	
</script>
</head>
<body id="listBody">
	<div align="center">
		<h1>用户提现记录</h1>
	</div>
	<table id="data-table"></table>
	
</body>
</html>