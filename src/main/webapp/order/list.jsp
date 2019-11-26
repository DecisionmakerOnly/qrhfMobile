<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
	Integer companyId=user.getCompanyId();
	String userName=user.getUserName();
	String projectId = request.getParameter("projectId");
	String projectOrderId = request.getParameter("projectOrderId");
	String projectPageId = request.getParameter("projectPageId");
	projectPageId = projectPageId==null?"2":projectPageId;
	String pageId = request.getParameter("pageId");
	session.setAttribute("orderPageId", pageId);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>材料订单页面</title>
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
<script type='text/javascript' src="<%=basePath%>common/plugin/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">

	function zsy(){
		var yScroll = (window.parent.document.documentElement.scrollHeight >window.parent.document.documentElement.clientHeight) ? window.parent.document.documentElement.scrollHeight : window.parent.document.documentElement.clientHeight; 
		return yScroll;
	}
	
	$(function() {
		var h=zsy();
		initBtn(<%=userId%>,<%=pageId%>);
		$('#data-table').bootstrapTable({
	    	url: '<%=basePath%>projectOrder/findList.action',
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
	              projectId: <%=projectId%>
	          }; 
	          return param;                   
	        }, 
			locale:'zh-CN',//中文支持
			pagination: true,//是否开启分页（*）
	        pageNumber:1,//初始化加载第一页，默认第一页
	        pageSize: 10,//每页的记录行数（*）
	        pageList: [10,20,50],//可供选择的每页的行数（*）
	        sidePagination: "server", //分页方式：client客户端分页，server服务端分页（*）
	        showRefresh:false,//刷新按钮
	        height:h-250,//table的高度
	        //按需求设置不同的样式：5个取值代表5中颜色['active', 'success', 'info', 'warning', 'danger'];
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
					field : 'name',
					title : '订单名称',
					align: "center",
					valign : 'middle',
					formatter:function(value, row, index) {
				        return [
				            '<input type="hidden" id="projectOrderName'+row.id+'" value="'+row.name+'">'+row.name+'',
				            
				        ].join('');
				    },
					sortable : true
				},
				{
					field : 'createDate',
					title : '订单创建时间',
					align: "center",
					valign : 'middle',
					sortable : true,
					//获取日期列的值进行转换
				    formatter: function (value, row, index) {
				        return changeDateFormat(value)
				    }
				},
				{
					field : 'status',
					title : '订单状态',
					align: "center",
					valign : 'middle',
					sortable : true,
					formatter:function(value,row,index){ 
				          if (row.status ==0) {
				        	  return "等待审批";
				          }else if(row.status == 1){
				        	  return "已通过";
				          }else if(row.status == -1){
				        	  return "未通过";
				          }
				        } 
				}, 
				{
	                field: 'operate',
	                title: '操作',
	                align: 'center',
	                valign: 'middle',
	                formatter: function (value, row, index) {
						return initOperationButtons(operationButtons,row,operationButtonsSelection);
					}
	            }
			]
	    })
		$("#listBody").height(h-100);
		//取到窗口的高度 
		var winH = $(window).height();
		//取到页面的高度 
		var bodyH = $(document).height();
		if(bodyH > winH){ 
			window.parent.document.getElementById("mainFrame").height=bodyH;
		}else{ 
			window.parent.document.getElementById("mainFrame").height=winH; 
		} 
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
	
	function toProjectList(){
		window.location.href="<%=basePath%>project/list.jsp?pageId=<%=projectPageId%>";
	}

	function toOrderDetail(obj){
		window.location.href="<%=basePath%>projectOrder/orderDetail?projectOrderId="+obj.attr('value')+"&projectId="+<%=projectId%>;
	}
	
	function detail(obj){
		window.location.href="<%=basePath%>order/detail.jsp?projectId=<%=projectId%>&pageId=<%=pageId%>&projectOrderId="+obj.attr('value');
	}
 	
	function del(obj){
 		if(confirm('此采购订单已经过审批，删除后无法找回，您确定要删除？')){
 			$.post(
 				"<%=basePath%>projectOrder/del?id="+obj.attr('value'),
 				{"projectOrderId":obj.attr('value'),"projectId":<%=projectId%>},
 				function () {
 					saveLog("<%=companyId%>","<%=userId%>",1,"<%=userName%>对《"+$('#projectOrderName'+obj.attr('value')).val()+"》进行了删除！");
 					location.reload();
				}
 			)
		} else {
			return false;
		}
	} 
	
	function exportExl(obj,name){
		window.location.href = "<%=basePath%>projectOrder/exportExl?projectOrderId="+obj.attr('value');
	}
	function toUploadProjectOrder(projectId){
		var startDate = String($("#startDate").val());
		var endDate = String($("#endDate").val());
		if(startDate == null || startDate == "" || endDate == null || endDate == ""){
			alert("请选择开始时间及结束时间！");
		}else{
			window.location.href = "<%=basePath%>projectOrder/projectOrderExportExl?projectId=" + projectId+"&startDate="+startDate+"&endDate="+endDate;
		}
	}
	function projectOrderGroup(projectId){
		var startDate = String($("#startDate").val());
		var endDate = String($("#endDate").val());
		if(startDate == null || startDate == "" || endDate == null || endDate == ""){
			alert("请选择开始时间及结束时间！");
		}else{
			for(;startDate.indexOf("-")>=0||endDate.indexOf("-")>=0;){
				startDate = startDate.replace("-","_$");
				endDate = endDate.replace("-","_$");
			}
			window.location.href = "<%=basePath%>order/statistics.jsp?projectId=" + projectId+"&startDate="+startDate+"&endDate="+endDate+"&pageId="+<%=pageId%>;
		}
	}
	
</script>
</head>
<body id="listBody">
	<div align="center">
		<h1>采购列表</h1>
	</div>
	<div class="form-inline" align="right">
		<input type="text" class="form-control input-sm Wdate" style="width:10%;" id="startDate" placeholder="开始时间" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})" value="" readonly/>-
		<input type="text" class="form-control input-sm Wdate" style="width:10%;" id="endDate" placeholder="结束时间" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})" value="" readonly/>
		<button class="btn" onClick="projectOrderGroup(<%=projectId%>)">统计</button>
		<button class="btn" onClick="toUploadProjectOrder(<%=projectId%>)">导出</button>
		<button class="btn" onClick="toProjectList()">返回项目列表</button>
	</div>
	<table id="data-table"></table>
</body>
</html>