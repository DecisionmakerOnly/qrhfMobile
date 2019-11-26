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
		initBtn(<%=userId%>,<%=pageId%>);
// 		selectProject();
		$('#data-table').bootstrapTable({
	    	url: '<%=basePath%>contract/findList',
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
	              projectId:$("#projectId").val()==""?null:$("#projectId").val(),
	              projectOrderId:$("#projectOrderId").val()==""?null:$("#projectOrderId").val()
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
					title : '合同名称',
					align: "center",
					valign : 'middle'
				},
				{
					field : 'createDate',
					title : '合同创建时间',
					align: "center",
					valign : 'middle',
					//获取日期列的值进行转换
				    formatter: function (value, row, index) {
				        return changeDateFormat(value)
				    }
				},
				{
					field : 'status',
					title : '合同状态',
					align: "center",
					valign : 'middle',
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
					field : 'price',
					title : '合同金额',
					align: "center",
					valign : 'middle'
				}, 
				{
					field : 'payPrice',
					title : '已付金额',
					align: "center",
					valign : 'middle'
				}, 
				{
					title : '未付金额',
					align: "center",
					valign : 'middle',
					formatter:function(value,row,index){ 
						return (row.price - row.payPrice).toFixed(2);
					} 
				},
				{
					field : 'invoicePrice',
					title : '发票金额',
					align: "center",
					valign : 'middle'
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
	
	function toContractDetail(obj){
		window.location.href="<%=basePath%>contract/detail.jsp?contractPageId=<%=pageId%>&contractId="+obj.attr('value');
	}
	
	function edit(obj){
		POBrowser.openWindowModeless('<%=basePath%>word.jsp?url='+obj.attr("filePath"),'width=1200px;height=800px;');
	}
	
	function selectProject(obj){
		$.ajax({
			dataType : "json",
			type : "post",
			url : "<%=basePath%>contract/selectProject.action?userId=<%=userId%>",
			success : function(data) {
				var html = "<option value=''>选择项目</option>";
				for(var i=0;i<data.length;i++){
					html += "<option value='"+data[i].id+"'>"+data[i].name+"</option>";
				}
				$("#projectId").append(html);
			}
		});
	}
	
	function selectProjectOrder(obj){
		var objVal = obj.val();
		$("#projectOrderId").empty();
		query();
		if(objVal == "选择项目"){
			var html = "<option value=''>无数据</option>";
			$("#projectOrderId").append(html);
		}else{
			$.ajax({
				dataType : "json",
				type : "post",
				url : "<%=basePath%>contract/selectProjectOrder.action?projectId="+obj.val(),
				success : function(data) {
					var html = "<option value=''>选择采购</option>";
					for(var i=0;i<data.length;i++){
						html += "<option value='"+data[i].id+"'>"+data[i].name+"</option>";
					}
					$("#projectOrderId").append(html);
				}
			});
		}
	}
	
 	function del(obj){
 		if(confirm('您确定要删除？')){
 			$.post(
 				"<%=basePath%>contract/del.action",
 				{"contractId":obj.attr('value')},
 				function () {
 					location.reload();
				}
 			)
		} else {
			return false;
		}
	}
	
	//查询按钮执行查询方法
	function query(){
		$('#data-table').bootstrapTable("refresh",{silent: true});
	}
	
	function exportContract(obj){
		window.location.href="<%=basePath%>contract/exportContract.action?contractId="+obj.attr('value');
	}
	
	function upload(){
		window.location.href = "<%=basePath%>contract/upload.jsp?contractPageId=<%=pageId%>";
	}
	
	function add(obj){
		window.location.href = "<%=basePath%>contract/add.jsp?contractPageId=<%=pageId%>&contractId="+obj.attr('value');
	}
	
	function temporaryAuthority(obj){
		openModal("<%=basePath%>temporaryAuthority.jsp?pageId=<%=pageId%>&recordId="+obj.attr('value'));
	}
	
	function contractPay(obj){
		openModal("<%=basePath%>contract/contractPay.jsp?pageId=<%=pageId%>&contractId="+obj.attr('value'));
	}
	
	function contractPayList(obj){
		window.location.href = "<%=basePath%>contract/contractPayList.jsp?pageId=<%=pageId%>&contractId="+obj.attr('value');
	}
	
	function contractInvoice(obj){
		openModal("<%=basePath%>contract/contractInvoice.jsp?pageId=<%=pageId%>&contractId="+obj.attr('value'));
	}
	
	function contractInvoiceList(obj){
		window.location.href = "<%=basePath%>contract/contractInvoiceList.jsp?pageId=<%=pageId%>&contractId="+obj.attr('value');
	}
	
	
</script>
</head>
<body id="listBody">
	<div align="center">
		<h1>合同列表</h1>
	</div>
	<div align="right" id="buttons<%=pageId%>"></div>
	<table id="data-table"></table>
</body>
</html>