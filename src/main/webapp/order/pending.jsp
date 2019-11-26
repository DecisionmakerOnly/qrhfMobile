<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
	Integer companyId = user.getCompanyId();
	String userName = user.getUserName();
	
	
	String rejectReason=new String(request.getParameter("rejectReason").getBytes("ISO-8859-1"),"utf-8"); 
	String title=new String(request.getParameter("title").getBytes("ISO-8859-1"),"utf-8"); 
	String name=new String(request.getParameter("name").getBytes("ISO-8859-1"),"utf-8"); 
	String sysFlowId = request.getParameter("sysFlowId");
	String projectId = request.getParameter("projectId");
	String projectOrderId = request.getParameter("projectOrderId");
	String orderPageId = ""+session.getAttribute("orderPageId");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%=basePath%>common/css/bootstrap.css" type="text/css" />
<link rel="stylesheet" href="<%=basePath%>common/css/bootstrap-table.css" type="text/css" />
<script type="text/javascript" src="<%=basePath%>common/js/base.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap-table.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap-table-zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap-table-locale-all.min.js"></script>
<script type="text/javascript">
	$(function(){
		var tableHeight = $(window).height()-$("#title").height()-110;
		$('#data-table').bootstrapTable({
	    	url: '<%=basePath%>projectOrder/orderDetail.action',
			method: 'post',
			contentType: "application/x-www-form-urlencoded",
			/* queryParamsType的默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort  设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber */
            queryParamsType:'', 
            queryParams: function queryParams(params) {  
				var param = {  
				    pageNumber: params.pageNumber,    
				    pageSize: params.pageSize,
				    projectOrderId:<%=projectOrderId%>
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
					sortable : true
				},
				{
					field : 'price',
					title : '单价',
					align: "center",
					valign : 'middle',
					sortable : true
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
        
		$('#data-tables').bootstrapTable({
	    	url: '<%=basePath%>projectOrder/modifiedData.action',
			method: 'post',
			contentType: "application/x-www-form-urlencoded",
			/* queryParamsType的默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort  设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber */
            queryParamsType:'', 
            queryParams: function queryParams(params) {  
				var param = {  
				    pageNumber: params.pageNumber,    
				    pageSize: params.pageSize,
				    projectOrderId:<%=projectOrderId%>
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
						var pageSize=$('#data-tables').bootstrapTable('getOptions').pageSize;//通过表的#id 可以得到每页多少条
						var pageNumber=$('#data-tables').bootstrapTable('getOptions').pageNumber;//通过表的#id 可以得到当前第几页
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
				        	  if (row.status ==2||row.status ==3) {
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
				        	  if (row.status ==3||row.status ==1) {
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
		window.location.href="<%=basePath%>projectOrder/toUpdate?projectOrderGoodsId="+id;
	}
	
	function del(id) {//新增一项状态为0的数据
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
												deleteByProjectOrderId();
												toProjectList();
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
		window.location.href="<%=basePath%>order/list.jsp?projectId="+<%=projectId%>+"&pageId="+<%=orderPageId%>;
	}
	
	function pass() { /* 第一次提交，项目经理同意审批 */
		if(confirm("确定通过此采购表么?")){
			if(updateStatus(1)==1){
				saveLog("<%=companyId%>","<%=userId%>",1,"<%=userName%>（项目经理）通过了<%=title%>","");
				window.location.href="<%=basePath%>projectOrder/compareGoods?projectOrderId="+<%=projectOrderId%>+"&projectId="+<%=projectId%>;
			}
		}
	}
	
	function toSubmit() { /* 被退回后再次提交 */
		if(selectPogCount()>=1){
			if(confirm("确定再次提交此采购表么?")){
				if(updateStatus(2)==1){
					saveLog("<%=companyId%>","<%=userId%>",1,"<%=userName%>再次提交了<%=title%>","");
					alert("提交成功！");
					parent.top.location.href = "<%=basePath%>main.jsp";
				}else{
					alert("提交失败！");
					toProjectList();
				}
			}
		}else{
			alert("被退回的采购表至少修改一项才能再次提交");
			return;
		}
	}
<%-- 	
	function toSubmit() { /* 被退回后再次提交 */
		if(confirm("确定再次提交此采购表么?")){
			if(updateStatus(2)==1){
 				if(emptyReason()==1){
					saveLog("<%=companyId%>","<%=userId%>",1,"<%=userName%>再次提交了<%=title%>","");
					alert("提交成功！");
					parent.top.location.href = "<%=basePath%>main.jsp";
  				}
			}else{
				alert("提交失败！");
				toProjectList();
			}
		}
	} --%>
	
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
	
	function emptyReason(){
		var num = 0;
		$.ajax({
			dataType : "json",
			type : "post",
			async: false,//同步
			url : "<%=basePath%>sysFlow/emptyReason?sysFlowId=<%=sysFlowId%>",
			success : function(data) {
				num = data;
			}
		});
		return num;
	}  
	
	function selectPogCount(){
		var num = 0;
		$.ajax({
			dataType : "json",
			type : "post",
			async: false,//同步
			url : "<%=basePath%>projectOrder/selectCountPoId?projectOrderId=<%=projectOrderId%>",
			success : function(data) {
				num = data;
			}
		});
		return num;
	}  
	
	function reject() { /* 项目经理确定退回 */
		var rejectReason = $('#rejectReason').val();
		if(rejectReason==""||rejectReason==null){
			alert("退回原因不能为空！");
			return false;
		}else{
			$.post(
				"<%=basePath%>sysFlow/reject",
				{id:<%=sysFlowId%>,rejectReason:rejectReason},	
				function(data){
					if(data==1){
						saveLog("<%=companyId%>","<%=userId%>",1,"<%=userName%>（项目经理）退回了<%=title%>",rejectReason);
						alert("退回成功！");
						parent.top.location.href = "<%=basePath%>/main.jsp";
					}else if(data==0){
						alert("退回失败！");
					}
				}
			) 
		}
	}
	
	function deleteProjectOrder() { /* 被退回撤销采购申请表 */
		if(confirm("确定删除整个采购表么?删除后将无法找回")){
			$.post(
				"<%=basePath%>projectOrder/deleteProjectOrder",
				{projectOrderId:<%=projectOrderId%>},
				function(data) {
					if(data>=1){
						saveLog("<%=companyId%>","<%=userId%>",1,"<%=userName%>删除了<%=title%>","");
						alert("删除成功");
						toProjectList();
					}else{
						alert("删除失败");
					}
				}
			)
		}
	}
</script>
</head>
<body height="95%">
	<c:set var="rejectReason" value="<%=rejectReason%>"></c:set>
	<c:choose>
		<c:when test="${rejectReason==null || rejectReason eq ''}"><!-- 第一次提交 -->
			<div id="title">
				<div align="center">
					<h1>采购待办</h1>
				</div>
			</div>
			<ul id="myTab" class="nav nav-tabs">
				<div style="float: left;">采购表所属合同：《<%=name %>》</div>
				<div style="float: right;">
					<button class="btn" onClick="pass()">确认</button>
					<button class="btn" data-toggle="modal" data-target="#myModal">退回</button>
					<button class="btn" onClick="toProjectList()">返回采购列表</button>
				</div>
			</ul>
			<table id="data-table"></table>
		</c:when>
		<c:otherwise>
			<div id="title">
				<div align="center">
					<h1>采购退回</h1>
				</div>
			</div>
			<ul id="myTab" class="nav nav-tabs">
				<div style="float: left;">采购表所属合同：《<%=name %>》</div>
				<div style="float: right;">
					<button class="btn" onClick="toSubmit()">提交</button>
					<button class="btn" onClick="deleteProjectOrder()">删除采购表</button>
					<button class="btn" onClick="toProjectList()">返回采购列表</button>
				</div>
			</ul>
			<table id="data-tables"></table>
			<div>
				<font color="red">
					退回原因：<%=rejectReason %>
				</font>
			</div>
		</c:otherwise>
	</c:choose>
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