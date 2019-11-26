<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	User user = (User)request.getSession().getAttribute("user");
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String projectId = request.getParameter("projectId");
	String projectPageId = request.getParameter("projectPageId");
	String projectName = new String(request.getParameter("projectName").getBytes("iso8859-1"),"utf-8");
	Integer userId = user.getId();
	Integer companyId=user.getCompanyId();
	String userName=user.getUserName();
	String projectOrderId = request.getParameter("projectOrderId");
	projectPageId = projectPageId==null?"2":projectPageId;
	String pageId = request.getParameter("pageId");
	session.setAttribute("orderPageId", pageId);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="zh-CN">
<head>
<base href="<%=basePath%>">
<title>分批列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
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
<script type="text/javascript">
	function zsy(){
		var yScroll = (window.parent.document.documentElement.scrollHeight >window.parent.document.documentElement.clientHeight) ? window.parent.document.documentElement.scrollHeight : window.parent.document.documentElement.clientHeight; 
		return yScroll;
	}

	$(function() {
		var h=zsy();
		initBtn(<%=userId%>,<%=pageId%>);
		$('#data-table').bootstrapTable({
			url: '<%=basePath%>projectGroup/findList.action',
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
				    projectId:<%=projectId%>
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
            height:h-150,//table的高度
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
					field : 'startDate',
					title : '开始时间',
					valign : 'middle',
					align: "center"
				},
				{
					field : 'endDate',
					title : '结束时间',
					valign : 'middle',
					align: "center"
				},
				{
				    title: '操作',
				    align: 'center',
				    valign: 'middle',
// 				   formatter: operateFormatter,
// 				   events: window.operateEvents
				 	formatter: function (value, row, index) {
						return initOperationButtons(operationButtons,row,operationButtonsSelection);
					}
				}
				
			]
        })
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
// 	function operateFormatter(value, row, index) {
//         return [
//         	/* '<a class="edit" title="详情" href="javascript:detail('+row.id+')">详情</a>',
//         	'&nbsp;&nbsp;&nbsp;&nbsp;', */
//         	'<a class="edit" title="删除" href="javascript:del('+row.id+')">删除</a>'
//         ].join('');
//     }
	function updateGroup(obj){
		$.post(
				"<%=basePath%>projectGroup/selectProjectGroupDate.action",
				{"projectGroupId":obj.attr('value')},
				function(data) {
					if(data==1){
						window.location.href = "<%=basePath%>projectGroup/updateProjectGroup.jsp?groupPageId=<%=pageId%>&projectId=<%=projectId%>&projectGroupId=" + obj.attr('value')+"&projectName=<%=projectName%>";
					}else{
						alert("这个分批已完成，不可修改");
					}
				}
			)
		}
    function delGroup(obj){
		$.post(
				"<%=basePath%>projectGroup/delProjectGroupDate.action",
				{"projectGroupId":obj.attr('value')},
				function(data) {
		    		if(data==1){
		    			alert("这个分批已进行,不可刪除");
		        	}else{
						
					   	if(confirm('是否要删除分批列表？')){
		    	    		$.ajax({
		    				dataType : "json",
		    				type : "post",
		    				url : "<%=basePath%>projectGroup/del.action?projectGroupId="+obj.attr('value'),
		    				success : function(data) {
		    					if(data == "1"){
		    						alert("删除成功！");
		    						$('#data-table').bootstrapTable('refresh');
		    					}else{
		    						alert("删除失败！");
		    					}
		    				}
		    			});
		    	    }
					}
				}
			)
    }
	function detail(projectGroupId){
		window.location.href = "<%=basePath%>projectGroup/detail.jsp?projectPageId=<%=projectPageId%>&projectId=<%=projectId%>&projectGroupId=" + projectGroupId;
	}
	function toProjectList(){
		window.location.href="<%=basePath%>project/list.jsp?pageId=<%=projectPageId%>";
	}
</script>
</head>
<body id="listBody">
	<div align="center">
		<h1>分批列表</h1>
	</div>
	<div align="right">
		<button class="btn" onClick="toProjectList()">返回项目列表</button>
	</div>
	<table id="data-table"></table> 
</body>
</html>