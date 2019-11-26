<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String goodsType = request.getParameter("goodsType") == null ? "0" : request.getParameter("goodsType");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="zh-CN">
<head>
<base href="<%=basePath%>">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- Bootstrap 不支持 IE 古老的兼容模式。为了让 IE 浏览器运行最新的渲染模式下，建议将此 <meta> 标签加入到你的页面中 -->
<meta name="renderer" content="webkit">
<!-- 将下面的 <meta> 标签加入到页面中，可以让部分国产浏览器默认采用高速模式渲染页面 -->
<link href="<%=basePath%>common/css/bootstrap.css" rel="stylesheet">
<link href="<%=basePath%>common/css/bootstrap-table.css" rel="stylesheet">
<link href="<%=basePath%>common/css/bootstrap-treeview.css" rel="stylesheet">
<script type="text/javascript" src="<%=basePath%>common/js/base.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/respond.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap-table.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap-table-zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/bootstrap-treeview.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>项目表列</title>
<script type="text/javascript">
	function zsy(){
		var yScroll = (window.parent.document.documentElement.scrollHeight >window.parent.document.documentElement.clientHeight) ? window.parent.document.documentElement.scrollHeight : window.parent.document.documentElement.clientHeight; 
		return yScroll;
	}

	$(function() {
		var h=zsy();
		$('#data-table').bootstrapTable({
	    	url: '<%=basePath%>goods/list.action',
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
				    goodsType:<%=goodsType%>,
				    goodsName:$("#goodsName").val(),
				    goodsCode:$("#goodsCode").val()
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
            height:h-250,//table的高度
            //按需求设置不同的样式：5个取值代表5中颜色['active', 'success', 'info', 'warning', 'danger'];
			rowStyle: 'success',
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
					title : '名称',
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
	                field: 'operate',
	                title: '操作',
	                align: 'center',
	                valign: 'middle',
	               formatter: operateFormatter,
	            }
			]
        })
        $("#listBody").height(h-100);
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
	        '<a class="edit" href="javascript:add('+row.id+')">添加</a>',
	        '&nbsp;&nbsp;&nbsp;&nbsp;',
	    ].join('');
	}
	
	function add(id) {
		window.location.href="<%=basePath%>goods/getGoodsById?id="+id;
	}
	
	//查询按钮执行查询方法
	function query(){
		$('#data-table').bootstrapTable("refresh",{silent: true});
	}
</script>
</head>
<body id="listBody">
	<div align="center">
		<h2>商品列表</h2>
	</div>
	<div class="form-inline" align="center">
		<label class="form-inline">商品名称:
		<input type="text" name="goodsName" id="goodsName" class="form-control input-sm" style="width:140px;" value="">
		<label class="form-inline">商品编码:
		<input type="text" name="goodsCode" id="goodsCode" class="form-control input-sm" style="width:140px;" value="">&emsp;&emsp;
		<button class="btn" onclick="query()">查询</button>&emsp;&emsp;&emsp;&emsp;
	</div>
	<table id="data-table"></table>
</body>
</html>