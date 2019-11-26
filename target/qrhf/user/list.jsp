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
	Integer sysRoleId=user.getSysRoleId();
	String departmentId = request.getParameter("parentId");
	departmentId = departmentId==null?"-1":departmentId;
	String pageId = request.getParameter("pageId");
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="X-UA-Compatible" content="IE=edge"><!-- Bootstrap 不支持 IE 古老的兼容模式。为了让 IE 浏览器运行最新的渲染模式下，建议将此 <meta> 标签加入到你的页面中 -->
<meta name="renderer" content="webkit"><!-- 将下面的 <meta> 标签加入到页面中，可以让部分国产浏览器默认采用高速模式渲染页面 -->
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
<script type="text/javascript">
	function zsy(){
		var yScroll = (window.parent.document.documentElement.scrollHeight >window.parent.document.documentElement.clientHeight) ? window.parent.document.documentElement.scrollHeight : window.parent.document.documentElement.clientHeight; 
		return yScroll;
	}
	$(function() {
		var h=zsy();
		initBtn(<%=userId%>,<%=pageId%>);
		$('#data-table').bootstrapTable({
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
                  departmentId: <%=departmentId%>,
                  companyId:<%=companyId%>
              }; 
              return param;                   
            }, 
			pagination: true,//是否开启分页（*）
            pageNumber:1,//初始化加载第一页，默认第一页
            pageSize: 20,//每页的记录行数（*）
            pageList: [20,50,100],//可供选择的每页的行数（*）
            sidePagination: "server", //分页方式：client客户端分页，server服务端分页（*）
            showRefresh:false,//刷新按钮
            height:180,//table的高度
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
					field : 'userName',
					title : '员工姓名',
					valign : 'middle', 
					align: "center"
				},
				{
					field : 'roleName',
					title : '角色',
					valign : 'middle', 
					align: "center"
				},
				{
					field : 'expiryDate',
					title : '到期日期',
					valign : 'middle', 
					align: "center",
					events: window.operateEvents,
					//获取日期列的值进行转换
				    formatter: function (value, row, index) {
				        return changeDateFormat(value);
				    }
				},
				{
	                field: 'operate',
	                title: '操作',
	                align: 'center',
					valign: 'middle',
					formatter: function (value, row, index) {
						return initOperationButtons(operationButtons,row,operationButtonsSelection);
					}
	            }
			],
			 formatNoMatches: function(){
			        return "本部门还未添加员工，如需添加员工，请点击右上角添加员工按钮";
			    }
        })
        $("#listBody").height(h-50);
		//取到窗口的高度 
		var winH = $(window).height()/2;
		//取到页面的高度 
		var bodyH = $(document).height()/2;
		if(bodyH > winH){ 
			window.parent.document.getElementById("userFrame").height=bodyH;
		}else{ 
			window.parent.document.getElementById("userFrame").height=winH; 
		} 
	})
	function add(obj){
		if(obj !=null){
			$.ajax({
				dataType : "json",
				type : "post",
				url : "<%=basePath%>user/getUserRoleId?userId="+obj.attr('value'),
				success : function(data) {
					if(data==1){
						var id = obj==null?"":obj.attr('value');
						openModal("<%=basePath%>user/addUser.jsp?departmentId="+<%=departmentId%>+"&id="+id+"&pageId="+<%=pageId%>+"&divDisplay="+1);
					}else if(data ==2){
						var id = obj==null?"":obj.attr('value');
						openModal("<%=basePath%>user/addUser.jsp?departmentId="+<%=departmentId%>+"&id="+id+"&pageId="+<%=pageId%>);
					}
				}
			});
		}else if(obj == null){
			var id = obj==null?"":obj.attr('value');
			openModal("<%=basePath%>user/addUser.jsp?departmentId="+<%=departmentId%>+"&id="+id+"&pageId="+<%=pageId%>);
		}
		
	}
	function modifyJob(obj){
		openModal("<%=basePath%>user/replaceUser.jsp?departmentId="+<%=departmentId%>+"&companyId="+<%=companyId%>+"&pageId="+<%=pageId%>);
	}
	function del(obj){
		$.ajax({
			dataType : "json",
			type : "post",
			url : "<%=basePath%>user/getUserRoleId?userId="+obj.attr('value'),
			success : function(data) {
				if(data==1){
					if (confirm("是否想解散本组织或单位？")) {
						$.post(
								"<%=basePath%>company/del?companyId="+<%=companyId%> ,	
								function(person){
									if(person==1){
										alert("解散成功！")
										parent.top.location.href = "<%=basePath%>/user/clearSession";
									}else{
										alert("解散失败！")
										return;
									}
								}
							)
					}
				}else if(data==2){
					if(confirm("确定要删除吗？")){
						$.post(
							"<%=basePath%>user/del?id="+obj.attr('value'),	
							function(person){
								if(person==1){
									alert("删除成功！")
									location.reload();
								}else{
									alert("删除失败！")
									return;
								}
							}
						)
					} 		
				}
		}
		});
					
	}
	function updateDepartment(obj){
		openModal("<%=basePath%>/user/addDepartment.jsp?companyId=<%=companyId%>&userId="+obj.attr('value'));
	}
	
</script>
</head>
<body id="listBody">
	<div align="center">
		<h1>员工列表</h1>
	</div>
	<div align="right" id="buttons<%=pageId%>">
	</div>
	<table id="data-table"></table>
</body>
</html>