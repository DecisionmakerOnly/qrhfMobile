<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)request.getSession().getAttribute("user");
	Integer companyId=user.getCompanyId();
	String projectId = request.getParameter("projectId");
	String projectPageId = request.getParameter("projectPageId");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>项目采购控制表详情</title>
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
<script type="text/javascript" src="<%=basePath%>common/js/jquery.regionselect2.js" ></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	$(function(){
		var tableHeight = $(window).height()-$("#title").height()-100;
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
				    projectId:<%=projectId%>,
				    isValid:1,
					projectUpdate:$("#updateTypeDate").val(),
				    updateType:$("#updateType").val(),
				    searchName:$("#searchName").val()
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
			/* function (row, index) {
			    var style = "";
			    if (row.name=="小红") {style='success';}
			    return { classes: style }
			}, */
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
					formatter:function(value, row, index) {
				        return [
				            '<input type="hidden" id="projectName'+row.goodsId+'" value="'+row.name+'"><a class="remove" href="javascript:projectGoodsDetail('+row.goodsId+')" title="项目采购控制表商品记录详情">'+row.name+'</a>',
				            
				        ].join('');
				    },
				    events: window.operateEvents,
	                align: "center"
				},
				{
					field : 'asName',
					title : '项目采购控制表商品名称',
					valign : 'middle',
					formatter:function(value, row, index) {
				        return [
				            '<input type="hidden" id="projectName'+row.goodsId+'" value="'+row.asName+'"><a class="remove" href="javascript:projectGoodsDetail('+row.goodsId+')" title="项目采购控制表商品记录详情">'+row.asName+'</a>',
				            
				        ].join('');
				    },
				    events: window.operateEvents,
	                align: "center"
				},
				{
					field : 'code',
					title : '商品编码',
					valign : 'middle'
				},
				{
					field : 'type',
					title : '规格',
					valign : 'middle'
				},
				{
					field : 'unit',
					title : '单位',
					align: "center",
					valign : 'middle'
				},
				{
					field : 'amount',
					title : '数量',
					align: "center",
					valign : 'middle'
				},
				{
					field : 'price',
					title : '单价',
					align: "center",
					valign : 'middle'
				},
				{
					field : 'total',
					title : '合计',
					align: "center",
					valign : 'middle'
				},
				{
					field : 'updateType',
					title : '类型',
					align: "center",
					valign : 'middle'
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
				    projectId:<%=projectId%>,
				    companyId:<%=companyId%>,
				    isValid:1,
				    projectUpdate:$("#updateTypeDate").val(),
				    updateType:$("#updateType").val(),
				    searchName:$("#searchName").val()
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
			/* function (row, index) {
			    var style = "";
			    if (row.name=="小红") {style='success';}
			    return { classes: style }
			}, */
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
					formatter:function(value, row, index) {
				        return [
				            '<input type="hidden" id="projectName'+row.goodsId+'" value="'+row.asName+'"><a class="remove" href="javascript:projectGoodsDetail('+row.goodsId+')" title="项目采购控制表商品记录详情">'+row.asName+'</a>',
				            
				        ].join('');
				    },
				    events: window.operateEvents,
	                align: "center"
				},
				{
					field : 'code',
					title : '商品编码',
					valign : 'middle'
				},
				{
					field : 'type',
					title : '规格',
					valign : 'middle'
				},
				{
					field : 'unit',
					title : '单位',
					align: "center",
					valign : 'middle'
				},
				{
					field : 'amount',
					title : '数量',
					align: "center",
					valign : 'middle'
				},
				{
					field : 'price',
					title : '单价',
					align: "center",
					valign : 'middle'
				},
				{
					field : 'total',
					title : '合计',
					align: "center",
					valign : 'middle'
				},
				{
					field : 'updateType',
					title : '类型',
					align: "center",
					valign : 'middle'
				}
			]
        })
        
        
 		$('#updateTypeDate').on('change',function(){
        	$('#data-table').bootstrapTable('refresh');
        	$('#data-tables').bootstrapTable('refresh');
        	
		})
        
        $('#updateType').on('change',function(){
        	$('#data-table').bootstrapTable('refresh');
        	$('#data-tables').bootstrapTable('refresh');
        	
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

	function search() {
		$('#data-table').bootstrapTable('refresh');
    	$('#data-tables').bootstrapTable('refresh'); 
    	
	}
	
	function toProjectList(){
		window.location.href="<%=basePath%>project/list.jsp?pageId=<%=projectPageId%>";
	}
	function projectGoodsDetail(goodsId){
		if($("#historyGoods").val()=="null"||$("#historyGoods").val()==""){
			$("#historyGoods").val(goodsId);
			initHistory();
		}else{
			$("#historyGoods").val(goodsId);
			$('#data-history-table').bootstrapTable('refresh');
		}
		$('#myModal').modal('show');
	}
	
	function initHistory(){
		$('#data-history-table').bootstrapTable({
			url: '<%=basePath%>project/singleProjectGoodsData',
			method: 'post',
			contentType: "application/x-www-form-urlencoded",
			/* queryParamsType的默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort  设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber */
		    queryParamsType:'', 
		    queryParams: function queryParams(params) {  
				var param = {
					pageNumber: params.pageNumber,    
		            pageSize: params.pageSize,
				    projectId:<%=projectId%>,
				    goodsId:$("#historyGoods").val()
				}; 
				return param;
		    }, 
			locale:'zh-CN',//中文支持
			pagination: true,//是否开启分页（*）
			pageNumber:1,//初始化加载第一页，默认第一页
		    pageSize: 10,//每页的记录行数（*）
		    pageList: [10,20,50],//可供选择的每页的行数（*）
		    height:350,//table的高度
		    sidePagination: "server", //分页方式：client客户端分页，server服务端分页（*）
		    showRefresh:false,//刷新按钮
		    showRefresh:false,//刷新按钮
		    //按需求设置不同的样式：5个取值代表5中颜色['active', 'success', 'info', 'warning', 'danger'];
			rowStyle:'success',
			columns : [
				{  
					title: '序号',//标题  可不加 
					valign : 'middle', 
					align: "center",
					formatter: function (value, row, index) {
						var pageSize=$('#data-history-table').bootstrapTable('getOptions').pageSize;//通过表的#id 可以得到每页多少条
						var pageNumber=$('#data-history-table').bootstrapTable('getOptions').pageNumber;//通过表的#id 可以得到当前第几页
						return pageSize * (pageNumber - 1) + index + 1;    //返回每条的序号： 每页条数 * （当前页 - 1 ）+ 序号
					}  
		                },
				{
					field : 'asName',
					title : '项目采购控制表商品名称',
					align: "center",
					valign : 'middle',
					sortable : false
				},
				{
					field : 'amount',
					title : '数量',
					align: "center",
					valign : 'middle',
					sortable : false,
					formatter:function(value,row,index){ 
					if (row.editStatus ==1 && row.amount !=0) {
			        	  var a = '<span style="color:red">+'+row.amount+'</span>';   
			        	  return a;
			         }else if (row.editStatus == 2) {
			        	  var a = '<span style="color:green">-'+row.amount+'</span>';
			        	  return a;
			         }else if (row.editStatus ==1 && row.amount ==0 ) {
			        	  var a = '<span >'+row.projectGoodsAmount+'</span>';   
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
					sortable : false,
						formatter: function (value, row, index) {
							return row.price.toFixed(2);    
						}  
				},
				{
					field : 'total',
					title : '合计',
					align: "center",
					valign : 'middle',
					sortable : false,
					formatter: function (value, row, index) {
						return row.total.toFixed(2);    
					}  
				},
				{
		            field: 'editCount',
		            title: '修改次数',
		            align: 'center',
		            valign: 'middle',
		            sortable : false,
		            formatter: function (value, row, index) {
						if(row.editCount == 0){
							return "<span style='color:red;'>原始采购控制表</span>";
						}else{
							return "第"+row.editCount+"次";
						}
					}  
		        },
		        {
					field : 'updateType',
					title : '类型',
					align: "center",
					valign : 'middle',
					sortable : false,
					formatter: function (value, row, index) {
						if(row.updateType == 0){
							return "清";
						}if(row.updateType == 1){
							return "变";
						}if(row.updateType == 2){
							return "漏";
						}if(row.updateType == 3){
							return "返";
						}if(row.updateType == 4){
							return "价";
						}
					}  
				},
		        {
					field : 'createDate',
					title : '修改时间',
					align: "center",
					valign : 'middle',
					events: window.operateEvents,
					//获取日期列的值进行转换
				    formatter: function (value, row, index) {
				        return changeDateFormat(value);
				    }
				}
				]
		})
	}
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
	function closeModal(){
		$('#myModal').modal('hide');
	}
	function selectTimeBatches(){
		if($("#updateType").val() !=0){
			$("#updateTypeDate").css('display','block');
			$("#updateTypeDate").css('display','inline');
			$.ajax({
				dataType : "json",
				type : "post",
				async: false,//同步
				url : "<%=basePath%>project/findProjectUpdateBatches.action?projectId=<%=projectId%>&updateType="+$("#updateType").val(),
				success : function(data) {
					var html = ''
					html +='<option value="0">==选择批次==</option>';
					for(var i=0;i<data.length;i++){
						html +='<option value="'+data[i].id+'">'+new Date(data[i].createDate).toLocaleString()+'</option>'
					}
					$("#updateTypeDate").html(html);
				}
			});		
		}else{
			$("#updateTypeDate").val(0);
			$("#updateTypeDate").css('display','none');
		}
	}
</script>
</head>
<body height="95%">
	<div id="title">
		<div align="center">
			<h1>项目采购控制表详情</h1>
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
		
		<li>
		<input type="hidden" id="historyGoods" name="historyGoods">
			<select class="form-control" onchange="selectTimeBatches();" style="width:110px;display:inline;" name="updateType" id="updateType">
				<option value="0">全部</option>
				<option value="1">变更洽商</option>
				<option value="2">漏项</option>
				<option value="3">返工</option>
				<option value="4">调价</option>
			</select>
			<select class="form-control"  style="width:205px;display:inline;display:none " name="updateTypeDate" id="updateTypeDate">
				<option value="0">==选择批次==</option>
			</select>
		</li>
		<div align="right" class="form-inline">
			<div class="form-group">
			    <input type="text" class="form-control" id="searchName" placeholder="请输入商品名称或编码">
			 </div>
			<button class="btn" onclick="search()">查询</button>
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
<!-- 采购控制表商品统计模态框 -->
	<div id="myModal" class="modal fade"  tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document" style="height:560px;width:1200px;">
		<div class="modal-content">
			<div class="modal-header">项目采购控制表商品修改统计</div>
			<div class="container">
			<div class="modal-body">
				<table id="data-history-table" ></table> 
			</div>
				<div class="modal-footer col-md-12">
					<button type="button" class="btn btn-default" onclick="closeModal()">关闭</button>
<!-- 					<button type="button" onclick="saveProjectGroup()" class="btn btn-default">申请</button> -->
				</div>
			</div>
		</div>
	</div>
	</div>
</body>
</html>