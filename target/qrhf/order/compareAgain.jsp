<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String projectOrderId = request.getParameter("projectOrderId");
	String projectId = request.getParameter("projectId");
	String name=new String(request.getParameter("name").getBytes("ISO-8859-1"),"utf-8"); 
	String sysFlowId = request.getParameter("sysFlowId");
	String projectPageId = request.getParameter("projectPageId");
	projectPageId = projectPageId==null?"2":projectPageId;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" href="<%=basePath%>common/css/bootstrap.css" type="text/css" />
<link rel="stylesheet" href="<%=basePath%>common/css/bootstrap-table.css" type="text/css" />
<script type="text/javascript" src="<%=basePath%>common/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap-table.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap-table-zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap-table-locale-all.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	$(function(){
		var tableHeight = $(window).height()-$("#data-table").height()-110;
		$('#data-table').bootstrapTable({
	    	url: '<%=basePath%>projectOrder/edit.action',
	    	method: 'post',
			contentType: "application/x-www-form-urlencoded",
			/* queryParamsType的默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort  设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber */
            queryParamsType:'',  
            queryParams: function queryParams(params) {  
				var param = {  
					pageNumber: params.pageNumber,    
				    pageSize: params.pageSize,
				    projectOrderId:<%=projectOrderId%>,
				    projectId:<%=projectId%>
				}; 
				return param;
            }, 
            locale:'zh-CN',//中文支持
			pagination: true,//是否开启分页（*）
            pageNumber:1,//初始化加载第一页，默认第一页
            pageSize: 20,//每页的记录行数（*）
            pageList: [20,50,100],//可供选择的每页的行数（*）
            sidePagination: "server", //分页方式：client客户端分页，server服务端分页（*）
            showRefresh:false,//刷新按钮
            height:tableHeight,//table的高度
            //按需求设置不同的样式：5个取值代表5中颜色['active', 'success', 'info', 'warning', 'danger'];
            rowStyle:'success',
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
					field : 'name',
					title : '系统商品名称',
					valign : 'middle',
					sortable : true,
					formatter:function(value,row,index){ 
				          if (row.status == 0) {
				        	  var a = '<span style="color:red">'+row.name+'&nbsp;&nbsp;&nbsp;&nbsp;(删除项)</span>';   
				        	  return a;
				          }else{
				        	  return row.name;
				          }
				       } 
				},
				{
					field : 'asName',
					title : '项目采购控制表商品名称',
					valign : 'middle',
					sortable : true,
					formatter:function(value,row,index){ 
				          if (row.status == 0) {
				        	  var a = '<span style="color:red">'+row.asName+'&nbsp;&nbsp;&nbsp;&nbsp;(删除项)</span>';   
				        	  return a;
				          }else if (row.status == -2) {
				        	  var a = '<span style="color:red">'+row.asName+'&nbsp;&nbsp;&nbsp;&nbsp;(项目采购控制表中不存在此商品，已删除。)</span>';   
				        	  return a;
				          }else{
				        	  return row.asName;
				          }
				       } 
				},
				{
					field : 'code',
					title : '商品编码',
					valign : 'middle',
					sortable : true
				},
				{
					field : 'type',
					title : '规格',
					valign : 'middle',
					sortable : true
				},
				{
					field : 'unit',
					title : '单位',
					align: "center",
					valign : 'middle',
					sortable : true
				},
				{
					field : 'amount',
					title : '数量',
					align: "center",
					valign : 'middle',
					sortable : true,
					formatter:function(value,row,index){ 
				          if (row.status ==2||row.status ==3) {
				        	  var a = '<span style="color:red">'+row.amount+'</span>';   
				        	  return a;
				          }else{
				        	  return row.amount;
				          }
				       } 
				},
				{
					field : 'price',
					title : '单价',
					align: "center",
					valign : 'middle',
					sortable : true,
					formatter:function(value,row,index){ 
				          if (row.status ==1||row.status ==3) {
				        	  var a = '<span style="color:red">'+row.price+'</span>';   
				        	  return a;
				          }else{
				        	  return row.price;
				          }
				       } 
				},
				{
					field : 'total',
					title : '合计',
					align: "center",
					valign : 'middle',
					sortable : true
				}
			]
        })
        
      
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
	
	function toProjectList(){
		window.location.href="<%=basePath%>project/list.jsp?pageId=<%=projectPageId%>";
	}
	
	 function pass() {
		if(selectZero()>=1){
			if(confirm("确定再次提交此采购表么?")){
				if(selectCountPoId()>=1){
					if(merge()>=1){
						if(updateStatus(1)==1){
							window.location.href="<%=basePath%>projectOrder/compareGoods?projectOrderId=<%=projectOrderId%>&projectId=<%=projectId%>";
						}
					}
				}else{
					if(updateStatus(1)==1){
						window.location.href="<%=basePath%>projectOrder/compareGoods?projectOrderId=<%=projectOrderId%>&projectId=<%=projectId%>";
					}
				}
			}
		}else{
// 			if(confirm("提交后将直接通过此采购表")){
// 				$.post(
<%-- 					"<%=basePath%>projectOrder/orderPass", --%>
<%-- 					{projectOrderId:<%=projectOrderId%>,sysFlowId:<%=sysFlowId%>}, --%>
// 					function (data) {
// 						if(data>=1){
// 							toProjectList();
// 						}
// 					}
// 				)
// 			}
			if(confirm("确定再次提交此采购表么?")){
				if(selectCountPoId()>=1){
					if(merge()>=1){
						if(updateStatus(1)==1){
						window.location.href="<%=basePath%>projectOrder/compareGoods?projectOrderId=<%=projectOrderId%>&projectId=<%=projectId%>";
						}
					}
				}else{
					if(updateStatus(1)==1){
						window.location.href="<%=basePath%>projectOrder/compareGoods?projectOrderId=<%=projectOrderId%>&projectId=<%=projectId%>";
					}
				}
			}
		}
	}
	 
	 function reject() {
		 var rejectReason = $('#rejectReason').val();
			if(rejectReason==""||rejectReason==null){
				alert("退回原因不能为空！");
				return false;
			}else{
				$.post(
					"<%=basePath%>sysFlow/AgainReject.action?id=<%=sysFlowId%>&rejectReason="+$('#rejectReason').val(),
					function(data){
						if(data==1){
							deleteByProjectOrderId();
							alert("退回成功！");
							parent.top.location.href = "<%=basePath%>/main.jsp";
						}else if(data==0){
							alert("退回失败！");
						}
					}
				) 
			}
	}
	 function updateStatus(status){
			var num = 0;
			$.ajax({
				dataType : "json",
				type : "post",
				async: false,//同步
				url : "<%=basePath%>sysFlow/updateStatus.action?sysFlowId=<%=sysFlowId%>&status="+status,
				success : function(data) {
					num = data;
				}
			});
			return num;
		}  
	 
	 	function merge(){
			var num = 0;
			$.ajax({
				dataType : "json",
				type : "post",
				async: false,//同步
				url : "<%=basePath%>projectOrder/merge?projectOrderId=<%=projectOrderId%>",
				success : function(data) { 
					num = data;
				}
			});
			return num;
		}  
	 
	 	function selectCountPoId(){
			var num = 0;
			$.ajax({
				dataType : "json",
				type : "post",
				async: false,//同步
				url : "<%=basePath%>project/selectByPoId?projectOrderId=<%=projectOrderId%>",
				success : function(data) {
					num = data;
				}
			});
			return num;
		}  
	 
	 //清除被删除的项
	 function delpog(status) {
		 $.post(
			"<%=basePath%>projectOrder/delpog",
			{projectOrderId:<%=projectOrderId%>,
			status:status}
		 )
	}
	 

	function selectZero(){
		var num = 0;
		$.ajax({
			dataType : "json",
			type : "post",
			async: false,//同步
			url : "<%=basePath%>project/selectZero?projectOrderId=<%=projectOrderId%>",
			success : function(data) {
				num = data;
			}
		});
		return num;
	}
	function deleteByProjectOrderId() {
		var num = 0;
		$.ajax({
			dataType : "json",
			type : "post",
			async: false,//同步
			url : "<%=basePath%>/projectOrder/deleteByProjectOrderId.action?projectOrderId=<%=projectOrderId%>",
			success : function(data) {
				num = data;
			}
		});
		return num;
	} 
</script>
</head>
<body height="95%">
	<div id="title">
		<div align="center">
			<h1>修改后的采购表</h1>
		</div>
	</div>
	<div style="float: left;">采购表所属合同：《<%=name %>》</div>
	<div style="float: right;">
		<button class="btn" onClick="pass()">提交</button>
		<button class="btn" data-toggle="modal" data-target="#myModal">退回</button>
		<button class="btn" onClick="toProjectList()">返回项目列表</button>
	</div>
	<div id="myTabContent" class="tab-content">
	<table id="data-table"></table>	
	</div>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">
						请填写退回采购表的原因
					</h4>
				</div>
				<div class="modal-body">
					<textarea class="form-control" rows="3" name="rejectReason" id="rejectReason" placeholder="退回原因"></textarea>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="reject()">确定</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>