<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
	Integer companyId=user.getCompanyId();
	String projectId = request.getParameter("projectId");
	String projectPageId = request.getParameter("projectPageId");
	String projectUpdateId = request.getParameter("projectUpdateId");
	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>修改项目采购控制表</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" href="<%=basePath%>common/css/bootstrap.css" type="text/css" />
<link rel="stylesheet" href="<%=basePath%>common/css/bootstrap-table.css" type="text/css" />
<script type="text/javascript" src="<%=basePath%>common/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap-table.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap-table-zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap-table-locale-all.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/plugin/layer/layer.js"></script>
<script type="text/javascript">

	$(function(){
		findProjectUpdate();
		var tableHeight = $(window).height()-$("#title").height()-120;
		$('#public-goods-data-tables').bootstrapTable({
	    	url: '<%=basePath%>project/findProjectGoodsListNoPagination.action',
			method: 'post',
			contentType: "application/x-www-form-urlencoded",
			/* queryParamsType的默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort  设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber */
            queryParamsType:'', 
            queryParams: function queryParams(params) {  
				var param = {  
				    projectId:<%=projectId%>,
				    companyId:<%=companyId%>,
				    projectUpdateId:<%=projectUpdateId%>,
				    isSysGoods:1,
				    isValid:1,
				    searchName:$("#public-goods-searchName").val()
				}; 
				return param;
            }, 
			locale:'zh-CN',//中文支持
			pagination: false,//是否开启分页（*）
            showRefresh:false,//刷新按钮
            height:tableHeight,//table的高度
			rowStyle:'success',
			columns : [
				{  
					title: '序号',//标题  可不加 
					valign : 'middle', 
					align: "center",
					formatter: function (value, row, index) {
						var pageSize=$('#public-goods-data-tables').bootstrapTable('getOptions').pageSize;//通过表的#id 可以得到每页多少条
						var pageNumber=$('#public-goods-data-tables').bootstrapTable('getOptions').pageNumber;//通过表的#id 可以得到当前第几页
						return pageSize * (pageNumber - 1) + index + 1;    //返回每条的序号： 每页条数 * （当前页 - 1 ）+ 序号
					}  
                },
				{
					field : 'name',
					title : '系统商品名称',
					valign : 'middle',
					formatter: function (value, row, index) {
						if(row.status == 1){
							return "<span style='color:green;'>"+row.name + "(新增)</span>";
						}else if(row.status == -1){
							return "<span style='color:red;'>"+row.name + "(删除)</span>";
						}else{
							return row.name;
						}
					}  
				},
				{
					field : 'asName',
					title : '项目采购控制表商品名称',
					valign : 'middle',
					formatter: function (value, row, index) {
						if(row.status == 1){
							return "<span style='color:green;'>"+row.asName + "(新增)</span>";
						}else if(row.status == -1){
							return "<span style='color:red;'>"+row.asName + "(删除)</span>";
						}else{
							return row.asName;
						}
					}
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
					valign : 'middle',
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
							if(row.price!=null){
								return row.price.toFixed(2);
							}else{
								return 0;
							}
						}else{
							if (row.status ==3||row.status ==4) {
								var a = '<span style="color:red">'+row.tPrice==null?0:row.tPrice.toFixed(2)+'</span>';   
								return a;
							}else{
								if(row.price!=null){
									return row.price.toFixed(2);
								}else{
									return 0;
								}
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
 					formatter: function (value, row, index) {
 						if(row.price !=null && row.amount!=null){
	 						return row.total.toFixed(2);
 						}
 					}  
				},
				{
	                field: 'operate',
	                title: '操作',
	                align: 'center',
	                valign: 'middle',
	                width:120,
	               formatter: operateFormatter
	            }
			]
        })
		$('#custom-goods-data-tables').bootstrapTable({
	    	url: '<%=basePath%>project/findProjectGoodsListNoPagination.action',
			method: 'post',
			contentType: "application/x-www-form-urlencoded",
			/* queryParamsType的默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort  设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber */
            queryParamsType:'', 
            queryParams: function queryParams(params) {  
				var param = {  
				    projectId:<%=projectId%>,
				    companyId:<%=companyId%>,
				    projectUpdateId:<%=projectUpdateId%>,
				    isSysGoods:0,
				    isValid:1,
				    searchName:$("#custom-goods-searchName").val()
				}; 
				return param;
            }, 
			locale:'zh-CN',//中文支持
			pagination: false,//是否开启分页（*）
            showRefresh:false,//刷新按钮
            height:tableHeight-40,//table的高度
            //按需求设置不同的样式：5个取值代表5中颜色['active', 'success', 'info', 'warning', 'danger'];
			rowStyle:'success',
			columns : [
				{  
					title: '序号',//标题  可不加 
					valign : 'middle', 
					align: "center",
					formatter: function (value, row, index) {
						var pageSize=$('#custom-goods-data-tables').bootstrapTable('getOptions').pageSize;//通过表的#id 可以得到每页多少条
						var pageNumber=$('#custom-goods-data-tables').bootstrapTable('getOptions').pageNumber;//通过表的#id 可以得到当前第几页
						return pageSize * (pageNumber - 1) + index + 1;    //返回每条的序号： 每页条数 * （当前页 - 1 ）+ 序号
					}  
               			 },
				{
					field : 'asName',
					title : '项目采购控制表商品名称',
					valign : 'middle',
					formatter: function (value, row, index) {
						if(row.status == 1){
							return "<span style='color:green;'>"+row.asName + "(新增)</span>";
						}else if(row.status == -1){
							return "<span style='color:red;'>"+row.asName + "(删除)</span>";
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
							if(row.price!=null){
								return row.price.toFixed(2);
							}else{
								return 0;
							}
						}else{
							if (row.status ==3||row.status ==4) {
								var a = '<span style="color:red">'+row.tPrice==null?0:row.tPrice.toFixed(2)+'</span>';   
								return a;
							}else{
								if(row.price!=null){
									return row.price.toFixed(2);
								}else{
									return 0;
								}
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
 					formatter: function (value, row, index) {
 						if(row.price !=null && row.amount!=null){
	 						return row.total.toFixed(2);
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
        $('#system-goods-data-tables').bootstrapTable({
	    	url: '<%=basePath%>project/findSystemGoods.action',
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
                  projectId:<%=projectId%>,
				  projectUpdateId:<%=projectUpdateId%>,
				  searchName:$("#system-goods-searchName").val()
              }; 
              return param;                   
            }, 
			locale:'zh-CN',//中文支持
			pagination: true,//是否开启分页（*）
            pageNumber:1,//初始化加载第一页，默认第一页
            pageSize: 20,//每页的记录行数（*）
            pageList: [20,50,100],//可供选择的每页的行数（*）
            sidePagination: "server", //分页方式：client客户端分页，server服务端分页（*）
			clickToSelect: true, // 单击行即可以选中
			silent : true, //刷新事件必须设置
			striped : true,// 隔行加亮
            height:tableHeight-100,//table的高度
            //按需求设置不同的样式：5个取值代表5中颜色['active', 'success', 'info', 'warning', 'danger'];
			rowStyle: 'success',
			columns : [
				{  
					title: '序号',//标题  可不加 
					valign : 'middle', 
					align: "center",
					formatter: function (value, row, index) {
						var pageSize=$('#system-goods-data-tables').bootstrapTable('getOptions').pageSize;//通过表的#id 可以得到每页多少条
						var pageNumber=$('#system-goods-data-tables').bootstrapTable('getOptions').pageNumber;//通过表的#id 可以得到当前第几页
						return pageSize * (pageNumber - 1) + index + 1;    //返回每条的序号： 每页条数 * （当前页 - 1 ）+ 序号
					}  
                },
				{
					field : 'name',
					title : '系统商品名称',
					valign : 'middle',
					formatter: function (value, row, index) {
						if(row.status == 1){
							return "<span style='color:green;'>"+row.name + "(新增)</span>";
						}else if(row.status == -1){
							return "<span style='color:red;'>"+row.name + "(删除)</span>";
						}else{
							return row.name;
						}
					}  
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
	                field: 'operate',
	                title: '操作',
	                align: 'center',
	                valign: 'middle',
					formatter: function (value, row, index) {
						return [
					        '<a class="edit" href="javascript:toAdd('+row.id+')">添加</a>',
					    ].join('');
					}  
	            }
			]
        })
        $('#company-custom-goods-data-tables').bootstrapTable({
	    	url: '<%=basePath%>project/findCompanyCustomGoods.action',
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
				  companyId:<%=companyId%>,
				  projectId:<%=projectId%>,
				  projectUpdateId:<%=projectUpdateId%>,
				  searchName:$("#company-custom-goods-searchName").val()
              }; 
              return param;                   
            }, 
			locale:'zh-CN',//中文支持
			pagination: true,//是否开启分页（*）
            pageNumber:1,//初始化加载第一页，默认第一页
            pageSize: 20,//每页的记录行数（*）
            pageList: [20,50,100],//可供选择的每页的行数（*）
            sidePagination: "server", //分页方式：client客户端分页，server服务端分页（*）
			clickToSelect: true, // 单击行即可以选中
			silent : true, //刷新事件必须设置
			striped : true,// 隔行加亮
            height:tableHeight-100,//table的高度
            //按需求设置不同的样式：5个取值代表5中颜色['active', 'success', 'info', 'warning', 'danger'];
			rowStyle: 'success',
			columns : [
				{  
					title: '序号',//标题  可不加 
					valign : 'middle', 
					align: "center",
					formatter: function (value, row, index) {
						var pageSize=$('#company-custom-goods-data-tables').bootstrapTable('getOptions').pageSize;//通过表的#id 可以得到每页多少条
						var pageNumber=$('#company-custom-goods-data-tables').bootstrapTable('getOptions').pageNumber;//通过表的#id 可以得到当前第几页
						return pageSize * (pageNumber - 1) + index + 1;    //返回每条的序号： 每页条数 * （当前页 - 1 ）+ 序号
					}  
                },
				{
					field : 'name',
					title : '系统商品名称',
					valign : 'middle',
					formatter: function (value, row, index) {
						if(row.status == 1){
							return "<span style='color:green;'>"+row.name + "(新增)</span>";
						}else if(row.status == -1){
							return "<span style='color:red;'>"+row.name + "(删除)</span>";
						}else{
							return row.name;
						}
					}  
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
	                field: 'operate',
	                title: '操作',
	                align: 'center',
	                valign: 'middle',
					formatter: function (value, row, index) {
						return [
					        '<a class="edit" href="javascript:toAdd('+row.id+')">添加</a>',
					    ].join('');
					}
	            }
			]
        })
        
//         $('#update-goods-data-tables').bootstrapTable({
<%-- 	    	url: '<%=basePath%>project/findList.action', --%>
// 			method: 'post',
// 			contentType: "application/x-www-form-urlencoded",
// 			//【查询设置】
// 			/* queryParamsType的默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort
// 			 设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber */
//             queryParamsType:'', 
//             queryParams: function queryParams(params) {  
//               var param = {  
//                   pageNumber: params.pageNumber,    
//                   pageSize: params.pageSize
//               }; 
//               return param;                   
//             }, 
// 			locale:'zh-CN',//中文支持
// 			pagination: true,//是否开启分页（*）
//             pageNumber:1,//初始化加载第一页，默认第一页
//             pageSize: 20,//每页的记录行数（*）
//             pageList: [20,50,100],//可供选择的每页的行数（*）
//             sidePagination: "server", //分页方式：client客户端分页，server服务端分页（*）
// 			clickToSelect: true, // 单击行即可以选中
// 			silent : true, //刷新事件必须设置
// 			striped : true,// 隔行加亮
//             height:tableHeight-100,//table的高度
//             //按需求设置不同的样式：5个取值代表5中颜色['active', 'success', 'info', 'warning', 'danger'];
// 			rowStyle: 'success',
// 			columns : [
// 				{  
// 					title: '序号',//标题  可不加 
// 					valign : 'middle', 
// 					align: "center",
// 					formatter: function (value, row, index) {
// 						var pageSize=$('#public-goods-data-tables').bootstrapTable('getOptions').pageSize;//通过表的#id 可以得到每页多少条
// 						var pageNumber=$('#public-goods-data-tables').bootstrapTable('getOptions').pageNumber;//通过表的#id 可以得到当前第几页
// 						return pageSize * (pageNumber - 1) + index + 1;    //返回每条的序号： 每页条数 * （当前页 - 1 ）+ 序号
// 					}  
//                 },
// 				{
// 					field : 'name',
// 					title : '系统商品名称',
// 					valign : 'middle',
// 					formatter: function (value, row, index) {
// 						if(row.status == 1){
// 							return "<span style='color:green;'>"+row.name + "(新增)</span>";
// 						}else if(row.status == -1){
// 							return "<span style='color:red;'>"+row.name + "(删除)</span>";
// 						}else{
// 							return row.name;
// 						}
// 					}  
// 				},
// 				{
// 					field : 'asName',
// 					title : '项目采购控制表商品名称',
// 					valign : 'middle',
// 					formatter: function (value, row, index) {
// 						if(row.status == 1){
// 							return "<span style='color:green;'>"+row.asName + "(新增)</span>";
// 						}else if(row.status == -1){
// 							return "<span style='color:red;'>"+row.asName + "(删除)</span>";
// 						}else{
// 							return row.asName;
// 						}
// 					}
// 				},
// 				{
// 					field : 'code',
// 					title : '商品编码',
// 					valign : 'middle'
// 				},
// 				{
// 					field : 'type',
// 					title : '规格',
// 					valign : 'middle'
// 				},
// 				{
// 					field : 'unit',
// 					title : '单位',
// 					align: "center",
// 					valign : 'middle'
// 				},
// 				{
// 					field : 'amount',
// 					title : '数量',
// 					align: "center",
// 					valign : 'middle',
// 					formatter:function(value,row,index){ 
// 				          if (row.tpgId == null) {
// 				        	  return row.amount;
// 				          }else{
// 				        	  if (row.status ==2||row.status ==4) {
// 					        	  var a = '<span style="color:red">'+row.tAmount+'</span>';   
// 					        	  return a;
// 					          }else{
// 					        	  return row.tAmount;
// 					          }
// 				          }
// 				       } 
// 				},
// 				{
// 					field : 'price',
// 					title : '单价',
// 					align: "center",
// 					valign : 'middle',
// 					sortable : true,
// 					formatter:function(value,row,index){ 
// 						if (row.tpgId == null) {
// 							if(row.price!=null){
// 								return row.price.toFixed(2);
// 							}else{
// 								return 0;
// 							}
// 						}else{
// 							if (row.status ==3||row.status ==4) {
// 								var a = '<span style="color:red">'+row.tPrice==null?0:row.tPrice.toFixed(2)+'</span>';   
// 								return a;
// 							}else{
// 								if(row.price!=null){
// 									return row.price.toFixed(2);
// 								}else{
// 									return 0;
// 								}
// 							}
// 						}
// 					} 
// 				},
// 				{
// 					field : 'total',
// 					title : '合计',
// 					align: "center",
// 					valign : 'middle',
// 					sortable : true,
//  					formatter: function (value, row, index) {
//  						if(row.price !=null && row.amount!=null){
// 	 						return row.total.toFixed(2);
//  						}
//  					}  
// 				},
// 				{
// 	                field: 'operate',
// 	                title: '操作',
// 	                align: 'center',
// 	                valign: 'middle',
// 	               formatter: operateFormatter
// 	            }
// 			]
//         })
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
	        '<a class="edit" href="javascript:toAddOrEdit('+row.id+','+row.projectUpdateGoodsId+','+row.goodsId+')">修改</a>',
	        '<br/>',
	        '<a class="del" href="javascript:del('+row.id+')">删除</a>',
	    ].join('');
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
				{projectGoodsId:id,projectUpdateId:$("#projectUpdateId").val()},
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
		var index = layer.msg('处理中，请稍后', {
			  icon: 16,
			  shade: 0.1,
			  time: false
			});
		$.post(
				"<%=basePath%>sysRole/selectInvestorsCodeAndPay",	
				{userId:<%=userId%>},
				function (data) {
					for(var i=0;i<data.length;i++){	
						if(data[i].code == "TZRDB"){
							if($("#updateType").val() != 0){
// 								$.post(
<%-- 										"<%=basePath%>project/submitTable", --%>
<%-- 										{project:<%=projectId%>,id:$("#projectUpdateId").val(),code:$("#code").val(),updateType:$("#updateType").val()}, --%>
// 										function(data) {
											 $.post(
													"<%=basePath%>project/updateProjectGoodsByProjectUpdateGoods",
													{companyId:<%=companyId%>,projectId:<%=projectId%>,projectUpdateId:$("#projectUpdateId").val()},
													function(data) {
														if(data>=1){
															layer.close(index);
															/*layer.confirm('提交成功！', {
																  btn: ['确定'] //可以无限个按钮
																}, function(index){
																	toProjectList();  
																});*/
                                                            layer.msg('提交成功！', {icon: 1});
                                                            toProjectList();
														}
													}
												) 
// 										}
// 									)
								}else {
									layer.close(index);
									layer.confirm('请选择修改类别！', {
										  btn: ['确定'] //可以无限个按钮
										}, function(index){
											layer.close(index);
										});
								}
						}else{
							if($("#updateType").val() != 0){
								$.post(
									"<%=basePath%>sysFlow/submitTable",
									{project:<%=projectId%>,id:$("#projectUpdateId").val(),updateType:$("#updateType").val()},
									function(data) {
										if(data==1){
											layer.close(index);
											/*layer.confirm('提交成功！', {
												  btn: ['确定'] //可以无限个按钮
												}, function(index){
													toProjectList();  
												});*/
                                            layer.msg('提交成功！', {icon: 1});
                                            toProjectList();
										}else{
											layer.close(index);
											layer.confirm('提交失败！', {
												  btn: ['确定'] //可以无限个按钮
												}, function(index){
													layer.close(index);
												});
										}
									}
								)
							}else{
								layer.close(index);
								alert("请选择修改类别");
							}
						}
					}
				}		
			) 
	}
// 	function confirmed(){
// 		var num = 0;
// 		$.ajax({
// 			dataType : "json",
// 			type : "post",
// 			async: false,//同步
<%-- 			url : "<%=basePath%>sysFlow/confirmed.action?sysFlowId=<%=sysFlowId%>", --%>
// 			success : function(data) {
// 				num = data;
// 			}
// 		});
// 		return num;
// 	}
	function toAddOrEdit(projectGoodsId,projectUpdateGoodsId,goodsId){
		if(projectGoodsId == null){
			projectGoodsId = -1;
		}
		if(projectUpdateGoodsId == null){
			projectUpdateGoodsId = -1;
		}
		$.post(
			"<%=basePath%>project/getEditCount",
			{project:<%=projectId%>,goods:goodsId},
			function(data) {
				data = data+1;
				window.location.href="<%=basePath%>project/addOrEdit.jsp?projectId=<%=projectId%>&projectGoodsId="+projectGoodsId+"&projectUpdateId="+$("#projectUpdateId").val()+"&projectUpdateGoodsId="+projectUpdateGoodsId+"&editCount="+data;
			}
		) 
		
	}
	
	function toAdd(goodsId){
		window.location.href="<%=basePath%>project/projectUpdateGoodsAdd.jsp?projectId=<%=projectId%>&projectUpdateId="+$("#projectUpdateId").val()+"&goodsId="+goodsId;
	}
	
	function search() {
		$('#public-goods-data-tables').bootstrapTable('refresh');
    	$('#custom-goods-data-tables').bootstrapTable('refresh');
    	$('#data-history-table').bootstrapTable('refresh');
	}
	
	function preserve(){
		$.ajax({
			dataType : "json",
			type : "post",
			contentType:"application/x-www-form-urlencoded; charset=utf-8",
			data:$("#projectUpdate").serialize(),
			url : "<%=basePath%>project/submitTable.action",
			success : function(data) {
				$("#updateText").html("修改编号："+$("#codeTitle").val()+$("#code").val()+"/修改类型："+$("#updateType").find("option:selected").text());
				$('#myModal').modal('hide');
			}
		});
// 		$("#updateText").html("修改编号："+$("#code").val()+"/修改类型："+$("#updateType").find("option:selected").text());
// 		$('#myModal').modal('hide');
	}
	
	function findProjectUpdate(){
		$.ajax({
			dataType : "json",
			type : "post",
			contentType:"application/x-www-form-urlencoded; charset=utf-8",
			url : "<%=basePath%>project/findProjectUpdateById.action?projectUpdateId=<%=projectUpdateId%>",
			success : function(data) {
				$("#code").val(data.code);
				$("#updateType").val(data.updateType);
				if($("#code").val()=="" || $("#code").val()=="null"){
					$('#myModal').modal('show');
				}else{
					$("#updateText").html("修改编号："+$("#code").val()+"/修改类型："+$("#updateType").find("option:selected").text());
				}
			}
		});
	}
	
	function updateCodeTitle(obj){
		if(obj.value == 1){
			$("#codeTitle").val("B");
		}else if(obj.value == 2){
			$("#codeTitle").val("L");
		}else if(obj.value == 3){
			$("#codeTitle").val("F");
		}else if(obj.value == 4){
			$("#codeTitle").val("T");
		}else{
			$("#codeTitle").val();
		}
	}
	
	function addCompanyCustomGoods(){
		window.location.href="<%=basePath%>project/addCompanyCustomGoods.jsp";
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
			<a href="#public-goods" data-toggle="tab">
				 公共商品
			</a>
		</li>
		<li>
			<a href="#custom-goods" data-toggle="tab">
				自定义商品
			</a>
		</li>
		<li>
			<a href="#system-goods" data-toggle="tab">
				系统商品
			</a>
		</li>
		<li>
			<a href="#company-custom-goods" data-toggle="tab">
				企业自定义商品
			</a>
		</li>
		<li>
			<div class="form-inline">
				<span id="updateText"></span>
				<button class="btn" data-toggle="modal" data-target="#myModal">修改</button>
			</div>
		</li>
		<div align="right">
			<button class="btn" onClick="toSubmit()" id="toSubmit">提交</button>
			<button class="btn" onClick="toProjectList()">返回项目列表</button>
		</div>
	</ul>
	<div id="myTabContent" class="tab-content">
		<div class="tab-pane fade in active" id="public-goods" style="padding: 0">
			<div class="form-inline">
				<div class="form-group">
				    <input type="text" class="form-control" id="public-goods-searchName" placeholder="请输入要查询的商品名称">
				 </div>
				<button class="btn" onclick="$('#public-goods-data-tables').bootstrapTable('refresh');">查询</button>
			</div>
			<table id="public-goods-data-tables"></table> 
		</div>
		<div class="tab-pane fade" id="custom-goods"  style="padding: 0">
			<div class="form-inline">
				<div class="form-group">
				    <input type="text" class="form-control" id="custom-goods-searchName" placeholder="请输入要查询的商品名称">
				 </div>
				<button class="btn" onclick="$('#custom-goods-data-tables').bootstrapTable('refresh');">查询</button>
			</div>
			<table id="custom-goods-data-tables"></table> 
		</div>
		<div class="tab-pane fade" id="system-goods"  style="padding: 0">
			<div class="form-inline">
				<div class="form-group">
				    <input type="text" class="form-control" id="system-goods-searchName" placeholder="请输入要查询的商品名称">
				 </div>
				<button class="btn" onclick="$('#system-goods-data-tables').bootstrapTable('refresh');">查询</button>
			</div>
			<table id="system-goods-data-tables"></table> 
		</div>
		<div class="tab-pane fade" id="company-custom-goods"  style="padding: 0">
			<div class="form-inline">
				<div class="form-group">
				    <input type="text" class="form-control" id="company-custom-goods-searchName" placeholder="请输入要查询的商品名称">
				 </div>
				<button class="btn" onclick="$('#company-custom-goods-data-tables').bootstrapTable('refresh');">查询</button>
				<button class="btn" onClick="addCompanyCustomGoods()">添加商品</button>
			</div>
			<table id="company-custom-goods-data-tables"></table> 
		</div>
	</div>
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                <h4 class="modal-title" id="myModalLabel">修改</h4>
	            </div>
	            <form class="form-horizontal" action="" id="projectUpdate" method="post">
		            <div class="modal-body">
						<div class="form-group">
							<label class="col-md-3 control-label">修改类型：</label>
							<div class="col-md-8 input-group">
								<input type="hidden" name="project" id="project" value="<%=projectId%>">
								<input type="hidden" name="id" id="projectUpdateId" value="<%=projectUpdateId%>">
								<select class="form-control" style="width:200px;display:inline;" name="updateType" id="updateType" onchange="updateCodeTitle(this)">
									<option value="0">请选择</option>
									<option value="1">变更洽商</option>
									<option value="2">漏项</option>
									<option value="3">返工</option>
									<option value="4">调价</option>
								</select>
								<span class="input-group"></span>
							</div>
						</div>
		            	<div class="form-group">
							<label class="col-md-3 control-label">修改编号：</label>
							<div class="col-md-8 input-group">
								<input type="text" class="form-control" style="width:10%" name="codeTitle" id="codeTitle" autocomplete="off">
								<input type="text" class="form-control" style="width:40%" name="code" id="code" placeholder="修改编号" autocomplete="off">
								<span class="input-group"></span>
							</div>
						</div>
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		                <button type="button" class="btn btn-primary" onclick="preserve()">保存</button>
		            </div>
	            </form>
	        </div>
	    </div>
	</div>
</body>
</html>
