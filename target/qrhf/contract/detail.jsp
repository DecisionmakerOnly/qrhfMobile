<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)request.getSession().getAttribute("user");
	String companyId = user.getCompanyId()+"";
	String contractId = request.getParameter("contractId");
	String contractPageId = request.getParameter("contractPageId");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>合同详情</title>
<link rel="stylesheet" href="<%=basePath%>common/css/bootstrap.css" type="text/css" />
<link rel="stylesheet" href="<%=basePath%>common/css/bootstrap-table.css" type="text/css" />
<script type="text/javascript" src="<%=basePath%>common/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap-table.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap-table-zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap-table-locale-all.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">

	$(function() {
		$("#projectId").val(0);
		$("#projectOrderId").val(0);
		findProjectList();
		findProjectOrderGoodsList();
        findContractFilePath();
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
	
	
	
	
	function findProjectList(){
		$.ajax({
			dataType : "json",
			type : "post",
			async:false,
			url : "<%=basePath%>contract/findProjectList.action?contractId=<%=contractId%>",
			success : function(data) {
				var html = "<li class='active' onclick='findProjectOrderList(0);updateProjectClass(this,0)'><a>该合同项目清单&nbsp;&nbsp;&nbsp;</a></li>";
// 				var html = "<li class='active' onclick='findProjectOrderList("+data[0].id+");updateProjectClass(this,"+data[0].id+")'><a>"+data[0].name+"&nbsp;&nbsp;&nbsp;总金额："+data[0].sumAmount+"</a></li>";
				for(var i=0;i<data.length;i++){
					html += "<li onclick='findProjectOrderList("+data[i].id+");updateProjectClass(this,"+data[i].id+")'><a>"+data[i].name+"&nbsp;&nbsp;&nbsp;&nbsp;总金额："+data[i].sumAmount+"</a></li>";
				}
				$("#projectList").html(html);
// 				findProjectOrderList(data[0].id);
			}
		});
	}
	
	function updateProjectClass(obj,id){
		$(obj).parent().find('li').removeClass("active");
		$(obj).addClass("active");
		$("#projectId").val(id);
		$('#data-table').bootstrapTable("refresh",{silent: false});
	}
	
	function findProjectOrderList(projectId){
		var html = "";
		if(projectId != 0){
			$.ajax({
				dataType : "json",
				type : "post",
				async:false,
				url : "<%=basePath%>contract/findProjectOrderList.action?projectId="+projectId+"&contractId="+<%=contractId%>,
				success : function(data) {
						html = "<li class='active' onclick='updateProjectOrderClass(this,0)'><a>该项目清单</a></li>";
	// 				var html = "<li class='active' onclick='updateProjectOrderClass(this,"+data[0].id+")'><a>"+data[0].name+"</a></li>";
					for(var i=0;i<data.length;i++){
						html += "<li onclick='updateProjectOrderClass(this,"+data[i].id+")'><a>"+data[i].name+"</a></li>";
					}
				}
			});
		}
		$("#projectOrderList").html(html);
	}
	
	function updateProjectOrderClass(obj,id){
		$(obj).parent().find('li').removeClass("active");
		$(obj).addClass("active");
		$("#projectOrderId").val(id);
		$('#data-table').bootstrapTable("refresh",{silent: false});
	}
	
	function findContractFilePath(){
		$.ajax({
			dataType : "text",
			type : "post",
			url : "<%=basePath%>contract/findContractFilePath.action?contractId=<%=contractId%>",
			success : function(data) {
				$("#fileIframe").attr("src","https://view.officeapps.live.com/op/view.aspx?src=http://zdcigo.com/file/upload/contract/"+data);
			}
		});
	}
	
	function toContractList(){
		window.location.href="<%=basePath%>contract/list.jsp?pageId=<%=contractPageId%>";
	}
	
	function findProjectOrderGoodsList(){
		var tableHeight = $(window).height()-$("#title").height()-100;
		$('#data-table').bootstrapTable({
	    	url: '<%=basePath%>contract/findGoods.action',
			method: 'post',
			contentType: "application/x-www-form-urlencoded",
			/* queryParamsType的默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort  设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber */
            queryParamsType:'', 
            queryParams: function queryParams(params) {  
				var param = {
					contractId:<%=contractId%>,
					projectId:$("#projectId").val(),
				    projectOrderId:$("#projectOrderId").val()
				}; 
				return param;
            }, 
			locale:'zh-CN',//中文支持
			pagination: false,//是否开启分页（*）
            showRefresh:false,//刷新按钮
            height:450,//table的高度
			rowStyle:'success',
			columns : [
				{
	                  checkbox: true  
	            },
				{
					title: '序号',//标题  可不加 
					align: "center",
					formatter: function (value, row, index) {
						var pageSize=$('#data-table').bootstrapTable('getOptions').pageSize;//通过表的#id 可以得到每页多少条
						var pageNumber=$('#data-table').bootstrapTable('getOptions').pageNumber;//通过表的#id 可以得到当前第几页
						return pageSize * (pageNumber - 1) + index + 1;    //返回每条的序号： 每页条数 * （当前页 - 1 ）+ 序号
					}  
                },
				{
					field : 'name',
					title : '系统商品名称'
				},
				{
					field : 'asName',
					title : '项目采购控制表商品名称'
				},
				{
					field : 'code',
					title : '商品编码'
				},
				{
					field : 'type',
					title : '规格'
				},
				{
					field : 'unit',
					title : '单位',
					align: "center"
				},
				{
					field : 'price',
					title : '单价',
					align: "center"
				},
				{
					field : 'amount',
					title : '数量',
					align: "center"
				}
			]
        })
	}
	
</script>
</head>
<body id="listBody">
	<input type="hidden" name="projectId" id="projectId" value="0">
	<input type="hidden" name="projectOrderId" id="projectOrderId">
	<div id="title">
		<div align="center">
			<h1>合同详情</h1>
		</div>
	</div>
	<ul class="nav nav-pills nav-justified" id="projectList"></ul>
	<ul class="nav nav-pills nav-justified" id="projectOrderList"></ul>
	<ul id="myTab" class="nav nav-tabs">
		<li class="active">
			<a href="#successful" data-toggle="tab">
				 合同清单
			</a>
		</li>
		<li>
			<a href="#failure" data-toggle="tab">
				合同内容
			</a>
		</li>
		<div align="right">
			<button class="btn" onClick="toContractList()">返回合同列表</button>
		</div>
	</ul>
	<div id="myTabContent" class="tab-content">
		<div class="tab-pane fade in active" id="successful" style="padding: 0">
			<table id="data-table"></table> 
		</div>
		<div class="tab-pane fade" id="failure"  style="padding: 0">
			<div>
				<iframe id="fileIframe" width='100%' height='600px' frameborder='1'></iframe>
			</div>
		</div>
	</div>
</body>
</html>