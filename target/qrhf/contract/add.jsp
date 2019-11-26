<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	User user = (User)request.getSession().getAttribute("user");
	String companyId = user.getCompanyId()+"";
	String contractId = request.getParameter("contractId");
	String contractPageId = request.getParameter("contractPageId");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>修改合同清单</title>
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
<script src="<%=basePath%>common/plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	$(function(){
		findProjectList();
		findProjectOrderGoodsList();
	})
	
	function updateProjectClass(obj,id){
		$(obj).parent().find('li').removeClass("active");
		$(obj).addClass("active");
		$("#projectId").val(id);
	}
	
	function updateProjectOrderClass(obj,id){
		$(obj).parent().find('li').removeClass("active");
		$(obj).addClass("active");
		$("#projectOrderId").val(id);
		$('#data-table').bootstrapTable("refresh",{silent: false});
	}
	
	function findProjectList(){
		$.ajax({
			dataType : "json",
			type : "post",
			url : "<%=basePath%>contract/findProjectList.action?contractId=<%=contractId%>",
			success : function(data) {
				var html = "<li class='active' onclick='findProjectOrderList("+data[0].id+");updateProjectClass(this,"+data[0].id+")'><a>"+data[0].name+"&nbsp;&nbsp;&nbsp;总金额："+data[0].sumAmount+"</a></li>";
				for(var i=1;i<data.length;i++){
					html += "<li onclick='findProjectOrderList("+data[i].id+");updateProjectClass(this,"+data[i].id+")'><a>"+data[i].name+"&nbsp;&nbsp;&nbsp;总金额："+data[i].sumAmount+"</a></li>";
				}
				$("#projectList").html(html);
				$("#projectId").val(data[0].id);
				findProjectOrderList(data[0].id);
			}
		});
	}
	
	function findProjectOrderList(projectId){
		$.ajax({
			dataType : "json",
			type : "post",
			url : "<%=basePath%>contract/findProjectOrderList.action?projectId="+projectId+"&contractId="+<%=contractId%>,
			success : function(data) {
				var html = "<li class='active' onclick='updateProjectOrderClass(this,"+data[0].id+")'><a>"+data[0].name+"</a></li>";
				for(var i=1;i<data.length;i++){
					html += "<li onclick='updateProjectOrderClass(this,"+data[i].id+")'><a>"+data[i].name+"</a></li>";
				}
				$("#projectOrderList").html(html);
				$("#projectOrderId").val(data[0].id);
				$('#data-table').bootstrapTable("refresh",{silent: false});
			}
		});
	}
	
	function findProjectOrderGoodsList(){
		var tableHeight = $(window).height()-$("#title").height()-100;
		$('#data-table').bootstrapTable({
	    	url: '<%=basePath%>contract/findProjectOrderGoodsList.action',
			method: 'post',
			contentType: "application/x-www-form-urlencoded",
			/* queryParamsType的默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort  设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber */
            queryParamsType:'', 
            queryParams: function queryParams(params) {  
				var param = {  
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
	
	function del(){
		var ids = "";
		$($("#data-table").bootstrapTable('getSelections')).each(function(){
			ids += this.id+",";
		})
		ids = ids.substr(0,ids.length-1);
		if(ids.length >0){
			if(confirm('您确定要删除？')){
	 			$.post(
	 				"<%=basePath%>contract/delContractListGoodsByIds.action",
	 				{"ids":ids},
	 				function () {
	 					location.reload();
					}
	 			)
			} else {
				return false;
			}
		}else{
			alert("请选中一行");
		}
	}
	
	function save() {
		var a= $("#data-table").bootstrapTable('getSelections');
		var flag = true;
		if(a.length<=0){                    
			alert("请选中一行");
			return false;                     
		}
		for(var i=0;i<a.length;i++){
			if(a[i].budgetAmount < $("#amount"+a[i].goodsId).val()){
				flag = false;
			}
			a[i].budgetAmount = $("#amount"+a[i].goodsId).val();
		}
		if(flag){
			var b=JSON.stringify(a);                            
			var url="<%=basePath%>contract/saves";
			$.ajax({
				dataType: "json",
				traditional:true,//这使json格式的字符不会被转码                                  
				data: {"datalist":b,"contractId":"<%=contractId%>","projectId":$("#projectId").val(),"projectOrderId":$("#projectOrderId").val()},
				type: "post",                                   
				url: url,                                  
				success : function (data) {
					if(data>0){
						alert("合同已生成！");  
						window.location.href="<%=basePath%>contract/detail2.jsp?detailPageId=26&contractId=<%=contractId%>&contractListId="+data;                                
					}else{
						alert("合同生成失败！"); 
					}                                      
				}                            
			}); 
		}else{
			alert("数量不可超过最大量！");
		}
	}
	function toContractList(){
		window.location.href="<%=basePath%>contract/list.jsp?pageId=<%=contractPageId%>";
	}
</script>
</head>
<body>
<h1 align="center">修改合同清单</h1>
<ul class="nav nav-pills nav-justified" id="projectList"></ul>
<ul class="nav nav-pills nav-justified" id="projectOrderList"></ul>
<div style="height:70%">
	<input type="hidden" name="projectId" id="projectId">
	<input type="hidden" name="projectOrderId" id="projectOrderId">
	<table id="data-table"></table> 
</div>
<div align="right">
	<button  type="button" class="btn btn-default" onClick="toContractList()">取消</button>
	<button  type="button" class="btn btn-default" onClick="del()">删除</button>
<!-- 	<button  type="button" class="btn btn-default" onClick="save()">保存</button> -->
</div>

</body>
</html>
