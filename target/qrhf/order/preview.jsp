<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
	Integer companyId=user.getCompanyId();
	String userName = user.getUserName();
	
	String projectId = request.getParameter("projectId");
	String projectOrderId = request.getParameter("projectOrderId");
	String projectPageId = request.getParameter("projectPageId");
	String projectOrderName = new String(request.getParameter("projectOrderName").getBytes("iso8859-1"),"utf-8"); 
	String sysFlowId = request.getParameter("sysFlowId");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>预览</title>
<link rel="stylesheet" href="<%=basePath%>common/css/bootstrap.css" type="text/css" />
<link rel="stylesheet" href="<%=basePath%>common/css/bootstrap-table.css" type="text/css" />
<script type="text/javascript" src="<%=basePath%>common/js/base.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap-table.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap-table-zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap-table-locale-all.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
					sortable : true,
                    formatter:function(value,row,index) {
						return row.total.toFixed(2);
                    }
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

	$(function() {
		contractName();
	})
	
	function contractName() {
		$.post(
			"<%=basePath%>contract/selectNameByProjectOrderId",
			{projectOrderId:<%=projectOrderId%>},
			function(data) {
				$("#cName").html('采购表所属合同：《'+data.name+'》') 
			}
		)
	}
	
	function deleteProUseless() {
		$.post(
			"<%=basePath%>projectOrder/deleteProUseless?projectOrderId=<%=projectOrderId%>",
					function name() {
						
					}
		)
	}
	
	function save(){
		deleteProUseless();			//删除采购表和项目采购控制表对不上的数据
		$.post(
			"<%=basePath%>project/selectDutyCount.action",
			{projectId:<%=projectId%>},
			function(data) {
				$.ajax({
					dataType : "json",
					type : "post",
					url : "<%=basePath%>project/selectDutyUserNum.action?projectId="+<%=projectId%>,
					success : function(data) {
						saveLog("<%=companyId%>","<%=userId%>",1,"<%=userName%>上传了<%=projectOrderName%>");
						if(data.length == 2){
							startFlow(data[1].id);
						}else{
							openModal("<%=basePath%>/project/selectDutyUser.jsp?projectId=<%=projectId%>&sysFlowId=<%=sysFlowId%>&projectPageId=<%=projectPageId%>");
						}
					}
				});
			}
		)
	}
	
	function startFlow(dutyUserId){
		$.ajax({
			url:'<%=basePath%>sysFlow/startFlow.action?sysFlowId=<%=sysFlowId%>&dutyUserId='+dutyUserId,
			dataType:'json',
			type:'post',
			success:function(data){
				if(data != 0){
<%-- 					window.location.href="<%=basePath%>main.jsp"; --%>
					toProjectList();
				}
			},
			error:function(){
				alert("请求失败！");
			}
		});
	}
	
	function toProjectList(){
		window.location.href="<%=basePath%>project/list.jsp?pageId=<%=projectPageId%>";
	}
	
	function deleteGoodsAll(){
		if(confirm('您确定要删除？')){
			$.post(
				"<%=basePath%>projectOrder/deleteGoodsAll.action",
				{"projectOrderId":<%=projectOrderId%>},
				function(data) {
					if(data==1){
						alert("操作成功！");
						toProjectList();
					}else{
						alert("操作失败！")
					}
				}
			)
		} else {
			return false;
		}
	}
	
</script>
</head>
<body height="95%">
	<div id="title">
		<div align="center">
			<h1>预览</h1>
		</div>
	</div>
	<div id="cName" style="float: left;"></div>
	<div style="float: right;">
		<button class="btn" onClick="save()">保存</button>
		<button class="btn" onClick="deleteGoodsAll()">删除</button>
	</div>
	<div id="myTabContent" class="tab-content">
		<table id="data-table"></table> 
	</div>
</body>
</html>