<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
	Integer sysFlowId = 0;
	String consultationId = request.getParameter("consultationId");
	String projectId = request.getParameter("projectId");
	String projectUpdateId = request.getParameter("projectUpdateId");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>会商</title>
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
<script type="text/javascript">
	
	$(function(){
		var tableHeight = $(window).height()-$("#title").height()-110;
		$('#data-table').bootstrapTable({
	    	url: '<%=basePath%>project/findListForUpdate.action',
			method: 'post',
			contentType: "application/x-www-form-urlencoded",
			/* queryParamsType的默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort  设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber */
            queryParamsType:'', 
            queryParams: function queryParams(params) {  
				var param = {  
				    projectId:<%=projectId%>,
				    projectUpdateId:<%=projectUpdateId%>,
				    sysFlowId:<%=sysFlowId%>
				}; 
				return param;
            }, 
			locale:'zh-CN',//中文支持
			pagination: false,//是否开启分页（*）
            showRefresh:false,//刷新按钮
            height:tableHeight-100,//table的高度
            //按需求设置不同的样式：5个取值代表5中颜色['active', 'success', 'info', 'warning', 'danger'];
			rowStyle:'success',
			columns : [
				{  
					title: '序号',//标题  可不加 
					formatter: function (value, row, index) {
						var pageSize=$('#data-table').bootstrapTable('getOptions').pageSize;//通过表的#id 可以得到每页多少条
						var pageNumber=$('#data-table').bootstrapTable('getOptions').pageNumber;//通过表的#id 可以得到当前第几页
						return pageSize * (pageNumber - 1) + index + 1;    //返回每条的序号： 每页条数 * （当前页 - 1 ）+ 序号
					}  
                },
				{
					field : 'name',
					title : '系统商品名称',
					formatter:function(value,row,index){ 
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
					valign : 'middle'
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
					field : 'defaultAmount',
					title : '控制数量',
					align: "center",
					valign : 'middle'
				},
				{
					field : 'amount',
					title : '会商数量',
					align: "center",
					valign : 'middle',
					formatter:function(value,row,index){ 
						if (row.amount != row.defaultAmount) {
							var a = '<span style="color:red">'+row.amount+'</span>';   
							return a;
						}else{
							return row.amount;
						}
					} 
				},
				{
					field : 'defaultPrice',
					title : '控制单价',
					align: "center",
					valign : 'middle'
				},
				{
					field : 'price',
					title : '会商单价',
					align: "center",
					valign : 'middle',
					formatter:function(value,row,index){ 
						if (row.price != row.defaultPrice) {
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
					valign : 'middle'
				},
				{
	                field: 'operate',
	                title: '意见',
	                align: 'center',
	                valign: 'middle',
					formatter: function (value, row, index) {
						return [
						'<input type="text" name="consultationGoodss['+index+'].idea" id="idea'+index+'" autocomplete="off">',
						'<input type="hidden" name="consultationGoodss['+index+'].goodsId" id="goodsId'+index+'" value="'+row.goodsId+'">',
						'<input type="hidden" name="consultationGoodss['+index+'].consultationId" id="consultationId'+index+'" value="<%=consultationId%>">'
						].join('');
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
 	
	function save() {
		$.ajax({
			type: "POST",//方法类型
			dataType: "text",//预期服务器返回的数据类型
			url: "<%=basePath%>sysFlow/saveConsultationGoods",
			data: $('#form').serialize(),
			async: false,
			success: function (data) {
				if(data == 1){
					alert("保存成功");
					window.top.location.href="<%=basePath%>main.jsp";
				}
			}
		});
	}
	
</script>
</head>
<body height="95%">
	<div id="title">
		<div align="center">
			<h1>会商</h1>
		</div>
	</div>
	<div class="form-inline" align="right" style="width: 100%;">
		<button class="btn" onClick="save();">保存</button>
	</div>
	<form id="form" method="post" action="">
		<table id="data-table"></table> 
	</form>
</body>
</html>
