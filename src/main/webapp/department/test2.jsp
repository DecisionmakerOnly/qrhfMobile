<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
	Integer companyId = user.getCompanyId();
	String parentId = request.getParameter("parentId");
	parentId = parentId==null?"-1":parentId;
	String pageId = request.getParameter("pageId");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>My JSP 'test2.jsp' starting page</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta name="renderer" content="webkit"><!-- 将下面的 <meta> 标签加入到页面中，可以让部分国产浏览器默认采用高速模式渲染页面 -->
<link href='common/css/bootstrap.css' rel='stylesheet'>
<link href='common/css/bootstrap-table.css' rel='stylesheet'>
<link href='common/css/bootstrap-treeview.css' rel='stylesheet'>
<script type='text/javascript' src='common/js/base.js'></script>
<script type='text/javascript' src='common/js/respond.min.js'></script>
<script type='text/javascript' src='common/js/jquery-3.2.1.min.js'></script>
<script type='text/javascript' src='common/js/bootstrap.js'></script>
<script type='text/javascript' src='common/js/bootstrap-table.js'></script>
<script type='text/javascript' src='common/js/bootstrap-table-zh-CN.js'></script>
<script type='text/javascript' src='common/js/bootstrap-treeview.js'></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	function zsy(){
		var yScroll = window.parent.document.documentElement.clientHeight; 
		return yScroll;
	}

	$(function(){
		var h=zsy();
		$("#listBody").height(h);
		//取到窗口的高度 
		var winH = $(window).height();
		//取到页面的高度 
		var bodyH = $(document).height();
		if(bodyH > winH){ 
			window.parent.document.getElementById("mainFrame").height=bodyH;
		}else{ 
			window.parent.document.getElementById("mainFrame").height=winH; 
		} 
		h=h/2-120;
		initDepartmentTable(h);
		initUserTable(h);
	})
	
	function initDepartmentTable(h){
		initBtn(<%=userId%>,<%=pageId%>);
		$('#department-table').bootstrapTable({
	    	url: '<%=basePath%>department/findList.action',
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
                  parentId:<%=parentId%>
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
            height:h,//table的高度
            //按需求设置不同的样式：5个取值代表5中颜色['active', 'success', 'info', 'warning', 'danger'];
			rowStyle: 'success',
			columns : [
				{  
					title: '序号',//标题  可不加 
					valign : 'middle', 
					align: "center",
					formatter: function (value, row, index) {
						var pageSize=$('#department-table').bootstrapTable('getOptions').pageSize;//通过表的#id 可以得到每页多少条
						var pageNumber=$('#department-table').bootstrapTable('getOptions').pageNumber;//通过表的#id 可以得到当前第几页
						return pageSize * (pageNumber - 1) + index + 1;    //返回每条的序号： 每页条数 * （当前页 - 1 ）+ 序号
					}  
                },
				{
					field : 'name',
					title : '部门名称',
					valign : 'middle',
					sortable : true
				},
				{
					field : 'code',
					title : '部门编码',
					valign : 'middle',
					sortable : true
				},
				{
	                field: 'operate',
	                title: '操作',
	                align: 'center',
	                valign: 'middle',
	               formatter: initDepartmentOperate,
	            }
			]
        })
	}
	
	function initUserTable(h){
		initBtn(<%=userId%>,<%=Integer.valueOf(pageId)+1%>);
		$('#user-table').bootstrapTable({
	    	url: '<%=basePath%>user/findList.action',
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
                  departmentId: <%=parentId%>,
                  companyId:<%=companyId%>
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
            height:h,//table的高度
            //按需求设置不同的样式：5个取值代表5中颜色['active', 'success', 'info', 'warning', 'danger'];
			rowStyle: 'success',
			columns : [
				{  
					title: '序号',//标题  可不加 
					valign : 'middle', 
					align: "center",
					formatter: function (value, row, index) {
						var pageSize=$('#user-table').bootstrapTable('getOptions').pageSize;//通过表的#id 可以得到每页多少条
						var pageNumber=$('#user-table').bootstrapTable('getOptions').pageNumber;//通过表的#id 可以得到当前第几页
						return pageSize * (pageNumber - 1) + index + 1;    //返回每条的序号： 每页条数 * （当前页 - 1 ）+ 序号
					}  
                },
				{
					field : 'userName',
					title : '员工姓名',
					valign : 'middle',
					sortable : true
				},
				{
					field : 'roleName',
					title : '职务',
					valign : 'middle',
					sortable : true
				},
				{
	                field: 'operate',
	                title: '操作',
	                align: 'center',
					valign: 'middle',
					formatter: initUserOperate,
	            }
			]
        })
	}
	
	function initDepartmentOperate(value, row, index) {
	    return [
	        '<a class="edit" title="edit" href="javascript:addOrEdit('+row.id+')">编辑</a>',
	        '&nbsp;&nbsp;&nbsp;&nbsp;',
	        '<a class="remove" href="javascript:del('+row.id+')" title="Remove">删除</a>',
	        '&nbsp;&nbsp;&nbsp;&nbsp;',
	    ].join('');
	}
	
	function initUserOperate(value, row, index) {
	    return [
	    	'<a class="edit" title="edit" href="javascript:updateDepartment('+row.id+')">更改部门</a>',
	        '&nbsp;&nbsp;&nbsp;&nbsp;',
	        '<a class="edit" title="edit" href="javascript:add('+row.id+')">编辑</a>',
	        '&nbsp;&nbsp;&nbsp;&nbsp;',
	        '<a class="remove" href="javascript:del('+row.id+')" title="Remove">删除</a>',
	        '&nbsp;&nbsp;&nbsp;&nbsp;',
	    ].join('');
	}

</script>
</head>
<body id="listBody">
	<div style="height:100%;width:100%">
		<div style="height:42%;width:100%;">
			<div align="center">
				<h1>部门列表</h1>
			</div>
			<div align="right" id="buttons<%=pageId%>"></div>
			<table id="department-table"></table>
		</div>
		<div style="height:58%;width:100%;">
			<div align="center">
				<h1>员工列表</h1>
			</div>
			<div align="right" id="buttons<%=Integer.valueOf(pageId)+1%>"></div>
			<table id="user-table"></table>
		</div>
	</div>
</body>
</html>
