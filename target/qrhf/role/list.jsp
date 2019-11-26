<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+ path + "/";
	User user = (User) request.getSession().getAttribute("user");
	Integer userId = user.getId();
	Integer companyId=user.getCompanyId();
	Integer sysRoleId = user.getSysRoleId();
	String roleCode = user.getRoleCode();
	String pageId = request.getParameter("pageId");
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>角色列表</title>
<script type="text/javascript">

	function zsy(){
		var yScroll = (window.parent.document.documentElement.scrollHeight >window.parent.document.documentElement.clientHeight) ? window.parent.document.documentElement.scrollHeight : window.parent.document.documentElement.clientHeight; 
		return yScroll;
	}
	
	$(function() {
		var h=zsy();
		initBtn(<%=userId%>,<%=pageId%>);
		$('#data-table').bootstrapTable({
	    	url: '<%=basePath%>sysRole/findList.action',
			method: 'post',
			contentType: "application/x-www-form-urlencoded",
            queryParamsType:'', 
            queryParams: function queryParams(params) {  
              var param = {  
                  pageNumber: params.pageNumber,    
                  pageSize: params.pageSize,
                  companyId:<%=companyId%>
              }; 
              return param;                   
            }, 
			locale:'zh-CN',//中文支持
			pagination: true,//是否开启分页（*）
            pageNumber:1,//初始化加载第一页，默认第一页
            pageSize: 10,//每页的记录行数（*）
            pageList: [10, 20, 50, 100, 200, 500],//可供选择的每页的行数（*）
            sidePagination: "server", //分页方式：client客户端分页，server服务端分页（*）
            height:h-250,//table的高度
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
					title : '职位',
					valign : 'middle',
	                events: window.operateEvents,
	                align: "center",
					sortable : true
				},
// 				{
// 					field : 'code',
// 					title : '编码',
// 					valign : 'middle',
// 	                events: window.operateEvents,
// 	                align: "center",
// 					sortable : true
// 				},
				{
					field : 'createDate',
					title : '创建时间',
					align: "center",
					valign : 'middle',
					sortable : true,
					 events: window.operateEvents,
					//获取日期列的值进行转换
				    formatter: function (value, row, index) {
				        return changeDateFormat(value)
				    }
				}, 
				{
                    field: 'operate',
                    title: '操作',
                    align: 'center',
                    valign: 'middle',
 					events: window.operateEvents,
					formatter: function (value, row, index) {
						if(row.companyId != 0){
							return initOperationButtons(operationButtons,row,operationButtonsSelection);
						}
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
	
	function changeDateFormat(cellval) {
		var dateVal = cellval + "";
		if (cellval != null) {
		    var date = new Date(parseInt(dateVal.replace("/Date(", "").replace(")/", ""), 10));
		    var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
		    var currentDate = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
		    return date.getFullYear() + "-" + month + "-" + currentDate + " ";
		}
	}

	//权限
	function getAuth(obj) {
		if(("<%=roleCode%>" == "TZRDB") && "<%=sysRoleId%>" == obj.attr('value')){
			alert("成本控制人/成本主管/董事长/总经理权限不可修改！");
		}else{
			openModal("<%=basePath%>role/addRole.jsp?sysRoleId="+obj.attr('value'));
		}
	}
	//一次性权限addTemporaryAuthorityRange.jsp
	function temporaryAuthorityRange(obj){
		openModal("<%=basePath%>role/addRoleRange.jsp?sysRoleId="+obj.attr('value'));
	}
	function delRole(obj) {
		$.post(
			"<%=basePath%>sysRole/selectName",
			{"id":obj.attr('value')},
			function (data) {
				if(data==1){
					alert('成本控制人/成本主管/董事长/总经理不可删除');
				}else if(data==0){
					if (confirm("确定要删除吗？")) {
						$.post(
							"<%=basePath%>sysRole/deleteUserRoleById",
							{"id":obj.attr('value')},
							function () {
								window.location.href="<%=basePath%>/role/list.jsp?pageId="+<%=pageId%>;
							}
						)
					}
				}
			}
		)
	}
	function toRoleResource() {
		window.location.href = "<%=basePath%>role/resource.jsp";
	}
	function add() {
		openModal("<%=basePath%>role/add?pageId="+<%=pageId%>);
	}
	function toUpdateRole(obj) {
		if(checkRoleCode(obj.attr('value'))==1){
			alert("预设角色不可修改！");
    		return false;
		}else{
			window.location.href = "<%=basePath%>sysRole/getRoleById?id="+obj.attr('value')+"&pageId="+<%=pageId%>;
		}  
	}
	
	function checkRoleCode(id) {
		var num = 0;
		$.ajax({
			dataType : "json",
			type : "post",
			async: false,//同步
			url : "<%=basePath%>sysRole/checkRoleCode",
			data:{"id":id},
			success : function(data) {
				num = data;
			}
		});
		return num; 
	}
</script>
</head>
<body id="listBody">
	<div align="center">
		<h1>角色列表</h1>
	</div>
	<div align="right" id="buttons<%=pageId%>">
	</div>
	<table id="data-table"></table>
</body>
</html>