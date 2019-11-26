<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String projectId = request.getParameter("projectId");
	String projectPageId = request.getParameter("projectPageId");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>修改项目采购控制表</title>
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
		var tableHeight = $(window).height()-$("#title").height()-100;
		var projectId = <%=projectId%>;
		if("${projectId}"!=null && "${projectId}" != "")projectId = "${projectId}";
		$('#data-table').bootstrapTable({
	    	url: '<%=basePath%>project/detail.action',
			method: 'post',
			contentType: "application/x-www-form-urlencoded",
			/* queryParamsType的默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort  设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber */
            queryParamsType:'', 
            queryParams: function queryParams(params) {  
				var param = {  
				    pageNumber: params.pageNumber,    
				    pageSize: params.pageSize,
				    projectId:projectId,
				    isValid:1
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
					sortable : true
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
				        	  return row.amount;
				          }else{
				        	  if (row.status ==2||row.status ==4) {
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
				        	  return row.price;
				          }else{
				        	  if (row.status ==3||row.status ==4) {
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
					sortable : true
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
        
        
		$('#data-tables').bootstrapTable({
	    	url: '<%=basePath%>project/mismatch.action',
			method: 'post',
			contentType: "application/x-www-form-urlencoded",
			/* queryParamsType的默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort  设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber */
            queryParamsType:'', 
            queryParams: function queryParams(params) {  
				var param = {  
				    pageNumber: params.pageNumber,    
				    pageSize: params.pageSize,
				    projectId:projectId,
				    isValid:1
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
            height:tableHeight-100,//table的高度
            //按需求设置不同的样式：5个取值代表5中颜色['active', 'success', 'info', 'warning', 'danger'];
			rowStyle:'success',
			columns : [
				{  
					title: '序号',//标题  可不加 
					valign : 'middle', 
					align: "center",
					formatter: function (value, row, index) {
						var pageSize=$('#data-tables').bootstrapTable('getOptions').pageSize;//通过表的#id 可以得到每页多少条
						var pageNumber=$('#data-tables').bootstrapTable('getOptions').pageNumber;//通过表的#id 可以得到当前第几页
						return pageSize * (pageNumber - 1) + index + 1;    //返回每条的序号： 每页条数 * （当前页 - 1 ）+ 序号
					}  
                },
				{
					field : 'asName',
					title : '项目采购控制表商品名称',
					valign : 'middle',
					sortable : true
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
				        	  return row.amount;
				          }else{
				        	  if (row.status ==2||row.status ==4) {
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
				        	  return row.price;
				          }else{
				        	  if (row.status ==3||row.status ==4) {
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
					sortable : true
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
	
	function toProjectList(){
		window.location.href="<%=basePath%>project/list.jsp?pageId=<%=projectPageId%>";
	}
	
	function edit(id) {
		window.location.href="<%=basePath%>project/selectProjectGoodsById?id="+id;
	}
	
	function del(id) {
		if(confirm('您确定要删除？')){
			$.post(
				"<%=basePath%>project/deleteProjectGoodsById",	
				{id:id},
				function(data) {
					if(data==1){
						alert("删除成功！")
						location.reload();
					}else{
						alert("删除失败！")
					}
				}
			)
		}
	}
	
	function toSubmit() {
		$.post(
			"<%=basePath%>sysFlow/submitTable",
			{projectId:<%=projectId%>},
			function(data) {
				if(data==1){
					alert("提交成功！")
					toProjectList();
				}else{
					alert("提交失败！")
				}
			}
		)
	}
	
</script>
</head>
<body height="95%">
	<div id="title">
		<div align="center">
			<h1>修改项目采购控制表</h1>
		</div>
	</div>
	<ul id="myTab" class="nav nav-tabs">
		<li class="active">
			<a href="#successful" data-toggle="tab">
				 公共商品
			</a>
		</li>
		<li>
			<a href="#failure" data-toggle="tab">
				自定义商品
			</a>
		</li>
		<div align="right">
			<button class="btn" onClick="toSubmit()">提交</button>
			<button class="btn" onClick="toProjectList()">返回项目列表</button>
		</div>
	</ul>
	<div id="myTabContent" class="tab-content">
		<div class="tab-pane fade in active" id="successful" style="padding: 0">
			<table id="data-table"></table> 
		</div>
		<div class="tab-pane fade" id="failure"  style="padding: 0">
			<table id="data-tables"></table> 
		</div>
	</div> 
</body>
</html>