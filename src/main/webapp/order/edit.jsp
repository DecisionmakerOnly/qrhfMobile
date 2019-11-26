<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String projectOrderId = request.getParameter("projectOrderId");
	String projectId = request.getParameter("projectId");
	//String name = new String(request.getParameter("name").getBytes("iso8859-1"),"utf-8"); 
	String name = request.getParameter("name"); 
	String sysFlowId = request.getParameter("sysFlowId");
	String projectPageId = request.getParameter("projectPageId");
	projectPageId = projectPageId==null?"2":projectPageId;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>未通过审批的材料列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%=basePath%>common/css/bootstrap.css" type="text/css" />
<link rel="stylesheet" href="<%=basePath%>common/css/bootstrap-table.css" type="text/css" />
<script type="text/javascript" src="<%=basePath%>common/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap-table.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap-table-zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap-table-locale-all.min.js"></script>
<script type="text/javascript">
	$(function(){
		var tableHeight = $(window).height()-$("#data-table").height()-170;
		$('#data-table').bootstrapTable({
	    	url: '<%=basePath%>projectOrder/notPass.action',
			method: 'post',
			contentType: "application/x-www-form-urlencoded",
			/* queryParamsType的默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort  设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber */
            queryParamsType:'', 
            queryParams: function queryParams(params) {
				var param = {  
				    projectOrderId:<%=projectOrderId%>
				}; 
				return param;
            }, 
			locale:'zh-CN',//中文支持
			pagination: false,//是否开启分页（*）
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
					sortable : true
				},
				{
					field : 'asName',
					title : '项目采购控制表商品名称',
					valign : 'middle',
					sortable : true,
					formatter:function(value,row,index){ 
				          if (row.status == -2) {
				        	  var a = '<span style="color:red">'+row.asName+'&nbsp;&nbsp;&nbsp;&nbsp;(项目采购控制表中不存在此商品，请删除。)</span>';   
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
				          if (row.tpgId == null) {
				        	  if (row.status ==2||row.status ==3) {
					        	  var a = '<span style="color:red">'+row.amount+'</span>';   
					        	  return a;
					          }else{
					        	  return row.amount;
					          }
				          }else{
				        	  if (row.tStatus ==2||row.tStatus ==3) {
					        	  var a = '<span style="color:red">'+row.tAmount+'</span>';   
					        	  return a;
					          }else{
					        	  return row.tAmount;
					          }
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
				          if (row.tpgId == null) {
				        	  if (row.status ==1||row.status ==3) {
					        	  var a = '<span style="color:red">'+row.price+'</span>';   
					        	  return a;
					          }else{
					        	  return row.price;
					          }
				          }else{
				        	  if (row.tStatus ==1||row.tStatus ==3) {
					        	  var a = '<span style="color:red">'+row.tPrice+'</span>';   
					        	  return a;
					          }else{
					        	  return row.tPrice;
					          }
				          }
				       } 
				},
				{
					field : 'total',
					title : '合计',
					align: "center",
					valign : 'middle',
					sortable : true,
					formatter:function(value,row,index){ 
				          if (row.tpgId == null) {
					        return row.total;
				          }else{
					        return row.tTotal;
				          }
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

	function operateFormatter(value, row, index) {
	    return [
	        '<a class="edit" href="javascript:edit('+row.id+')">修改</a>',
	        '&nbsp;&nbsp;&nbsp;&nbsp;',
	        '<a class="del" href="javascript:del('+row.id+')">删除</a>',
	        '&nbsp;&nbsp;&nbsp;&nbsp;',
	    ].join('');
	} 
	
	function edit(id) {
		if(selectStatus(id)!=-2){
			window.location.href="<%=basePath%>projectOrder/toUpdate?projectOrderGoodsId="+id;
		}else{
			alert("请删除项目采购控制表中不存在的商品！");
			return false;
		}
	}
	function del(id) {
		if(confirm("确定删除此项数据吗？")){
			$.post(
				"<%=basePath%>project/addTemporaryProjectGoods",
				{projectOrderGoodsId:id},
				function(data) {
					if(data==1){
						if(selectDelPass()==1){
							$.post(
									"<%=basePath%>projectOrder/deleteProjectOrderAll",		
									{"projectOrderId":<%=projectOrderId%>,"projectId":<%=projectId%>,"name":"<%=name%>"},
									function (data) {
										if(data>=1){
											if(updateStatus(1)==1){
												deleteByProjectOrderId();
												toProjectList();
											}
										}
									}
								)
						}else{
							if(havePassedDel()==1){
								$.ajax({
									dataType : "json",
									type : "post",
									async: false,//同步
									url : "<%=basePath%>projectOrder/delpog.action?projectOrderId=<%=projectOrderId%>",
									success : function(data) {
											if(updateStatus(1)==1){
												deleteByProjectOrderId();
												toProjectList();
											}
									}
								});
							}else{
								location.reload();
							}
							
						}
					}
				}
			)
		}

// 		if(selectDelPass()==1){
// 			if(confirm("采购表无通过项，是否删除整个采购表？")){
// 				$.post(
<%-- 					"<%=basePath%>projectOrder/deleteProjectOrderAll",		 --%>
<%-- 					{"projectOrderId":<%=projectOrderId%>,"projectId":<%=projectId%>,"name":"<%=name%>"}, --%>
// 					function (data) {
// 						if(data>=1){
// 							toProjectList();
// 						}
// 					}
// 				)
// 			}
// 		}else{
// 			if(confirm("确定删除此项数据吗？")){
// 				$.post(
<%-- 					"<%=basePath%>project/addTemporaryProjectGoods", --%>
// 					{projectOrderGoodsId:id},
// 					function(data) {
// 						if(data==1){
// 							location.reload();
// 						}
// 					}
// 				)
// 			}	
// 		}
	
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
	function selectDelPass(){
		var num = 0;
		$.ajax({
			dataType : "json",
			type : "post",
			async: false,//同步
			url : "<%=basePath%>projectOrder/selectDelPass.action?projectOrderId=<%=projectOrderId%>",
			success : function(data) {
				num = data;
			}
		});
		return num;
	}
	function havePassedDel(){
		var num = 0;
		$.ajax({
			dataType : "json",
			type : "post",
			async: false,//同步
			url : "<%=basePath%>projectOrder/havePassedDel.action?projectOrderId=<%=projectOrderId%>",
			success : function(data) {
				num = data;
			}
		});
		return num;
	} 
	function toProjectList(){
		window.location.href="<%=basePath%>project/list.jsp?pageId=<%=projectPageId%>";
	}
	
	function pass() {
		if(selectNotPass()==1){	
			if(selectPogExtra()==0){
				if(checkIsUpdateGoodsAll()==0){
					if(confirm("确定再次提交此采购表么?")){
						if(updateStatus(2)==1){
							toProjectList();
						}else{
							alert("提交失败！");
							toProjectList();
						}
					}
				}else{
					alert("未全部修改完商品");
				}
			}else{
				alert("请删除项目采购控制表中不存在的商品再提交！");
				return false;
			}
		}else{
			if(selectPogExtra()==0){
				if(checkIsUpdateGoodsAll()==0){
					if(confirm("确定再次提交此采购表么?")){
						if(updateStatus(2)==1){
							toProjectList();
						}else{
							alert("提交失败！");
							toProjectList();
						}
					}
				}else{
					alert("未全部修改完商品");
				}
			}else{
				alert("请删除项目采购控制表中不存在的商品再提交！");
				return false;
			}
// 			$.post(
<%-- 				"<%=basePath%>projectOrder/deleteProjectOrderAll",		 --%>
<%-- 				{"projectOrderId":<%=projectOrderId%>,"projectId":<%=projectId%>,"name":"<%=name%>"}, --%>
// 				function (data) {
// 					if(data>=1){
// 						toProjectList();
// 					}
// 				}
// 			)
		}
		
		
	}
	
	function checkIsUpdateGoodsAll(projectOrderId){
		var num = 0;
		$.ajax({
			dataType : "json",
			type : "post",
			async: false,//同步
			url : "<%=basePath%>sysFlow/checkIsUpdateGoodsAll.action?projectOrderId=<%=projectOrderId%>",
			success : function(data) {
				num = data;
			}
		});
		return num;
	}
	
	function selectPogExtra(){
		var num = 0;
		$.ajax({
			dataType : "json",
			type : "post",
			async: false,//同步
			url : "<%=basePath%>projectOrder/selectPogExtra?projectOrderId=<%=projectOrderId%>",
			success : function(data) {
				num = data;
			}
		});
		return num;
	}
	
	function selectStatus(id){
		var num = 0;
		$.ajax({
			dataType : "json",
			type : "post",
			async: false,//同步
			url : "<%=basePath%>projectOrder/selectStatus?id="+id,
			success : function(data) {
				num = data;
			}
		});
		return num;
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
	
	function deleteAll() {
		if(selectNotPass()==1){		//采购表至少有一条通过项
			if(confirm("删除后不可恢复！确定删除所有数据吗?")){
				$.post(
					"<%=basePath%>projectOrder/deleteAll",		
					{"projectOrderId":<%=projectOrderId%>},
					function (data) {
						if(data>=1){
							if(havePassedDel()==1){
								$.ajax({
									dataType : "json",
									type : "post",
									async: false,//同步
									url : "<%=basePath%>projectOrder/delpog.action?projectOrderId=<%=projectOrderId%>",
									success : function(data) {
											if(updateStatus(1)==1){
												deleteByProjectOrderId();
												toProjectList();
											}
									}
								});
							}else{
								location.reload();
							}
						}
					}
				)
				
			}
		}else{		//整个采购表都没通过
			if(confirm("采购表无通过项，是否删除整个采购表？")){
				$.post(
					"<%=basePath%>projectOrder/deleteProjectOrderAll",		
					{"projectOrderId":<%=projectOrderId%>,"projectId":<%=projectId%>,"name":"<%=name%>"},
					function (data) {
						if(data>=1){
							toProjectList();
						}
					}
				)
				
			}
		}
	}
	
	function selectNotPass(){
		var num = 0;
		$.ajax({
			dataType : "json",
			type : "post",
			async: false,//同步
			url : "<%=basePath%>projectOrder/selectNotPass.action?projectOrderId=<%=projectOrderId%>",
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
			<h1>未通过审批的材料列表</h1>
		</div>
	</div>
	<div align="right">
		<button class="btn" onClick="pass()">提交</button>
		<button class="btn" onClick="deleteAll()">全部删除</button> 
		<button class="btn" onClick="toProjectList()">返回项目列表</button>
	</div>
	<div id="myTabContent" class="tab-content">
	<table id="data-table"></table> 
	</div>
</body>
</html>