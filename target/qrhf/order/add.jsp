<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	
	User user = (User)request.getSession().getAttribute("user");
	String userName = user.getName();
	Integer userId = user.getId();
	Integer companyId = user.getCompanyId();
	Integer departmentId = user.getDepartmentId();
	
	String projectId = request.getParameter("projectId");
	String projectGroupId = request.getParameter("projectGroupId");
	String projectName = new String(request.getParameter("projectName").getBytes("iso8859-1"),"utf-8"); 
	String projectPageId=request.getParameter("projectPageId");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<title>Insert title here</title>
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
<script src="<%=basePath%>common/plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	$(function(){
		var tableHeight = $(window).height()-$("#title").height()-50;
		$('#data-table').bootstrapTable({
	    	url: '<%=basePath%>projectOrder/findProjectGroupGoodsByprojectGroupId.action',
			method: 'post',
			contentType: "application/x-www-form-urlencoded",
			/* queryParamsType的默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort  设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber */
            queryParamsType:'', 
            queryParams: function queryParams(params) {  
				var param = {  
				    projectId:<%=projectId%>,
				    projectGroupId:<%=projectGroupId%>
				}; 
				return param;
            }, 
			locale:'zh-CN',//中文支持
			pagination: false,//是否开启分页（*）
            height:tableHeight,//table的高度
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
					valign : 'middle'
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
					field : 'price',
					title : '单价',
					align: "center",
					valign : 'middle'
				},
				{
					field : 'amount',
					title : '数量',
					align: "center",
					valign : 'middle',
					formatter: function (value, row, index) {
						return [
						'<input type="text" name="projectOrderGoodss['+index+'].amount" id="amount'+index+'" maxValue="'+row.sAmount+'" value="'+row.amount+'">',
						'<input type="hidden" name="projectOrderGoodss['+index+'].goodsId" id="goodsId'+index+'" value="'+row.goodsId+'">',
						'<input type="hidden" name="projectOrderGoodss['+index+'].asName" id="asName'+index+'" value="'+row.asName+'">',
						'<input type="hidden" name="projectOrderGoodss['+index+'].price" id="price'+index+'" value="'+row.price+'">'
						].join('');
					}  
				},
				{
					field : 'sAmount',
					title : '最大可用数量',
					align: "center",
					valign : 'middle'
				},
				{
					field : 'total',
					title : '总价',
					align: "center",
					valign : 'middle'
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

	function  save() {
		var flag = true;
		var num = 0;
		var isValid=0;
		$("input[name*='amount']").each(function(){
			var $this = $(this);
			if(parseInt($this.val())>parseInt($this.attr('maxValue'))){
				flag = false;
			}
			if($this.val()>0){
				num++;
			}
			if($this.val() == "" || $this.val() == null){
				$this.val(0);
			}
		})
		if(num==0){
			alert("请填写采购申请单的数量");
			return ;
		}
		if(flag && num>0){
            $.ajax({
                type: "POST",//方法类型
                dataType: "json",//预期服务器返回的数据类型
                url: "<%=basePath%>projectOrder/save",
                data: $('#form').serialize(),
                async: false,
                success: function (data) {
                    if(data.projectOrderId > 0) {
                    	saveLog("<%=companyId%>","<%=userId%>",1,"<%=userName%>创建了《<%=projectName%>》采购申请表！");
                    	alert("创建成功！");
                    	window.location.href = "<%=basePath%>order/preview.jsp?projectId=<%=projectId%>&projectPageId=2&projectOrderId=" + data.projectOrderId+"&sysFlowId="+data.sysFlowId+"&projectOrderName="+data.projectOrderName;
                    }else if(data == 0){
                    	alert("创建失败！");
                    }
                },
				error:function(){
					alert("请求失败！");
				}
            });
		}else{
			alert("至少有一项'数量'≥0且数量不可超过'最大可用数量'才可提交");
		}
	}
	function toProjectList(){
		window.location.href="<%=basePath%>project/list.jsp?pageId=<%=projectPageId%>";
	}
</script>
</head>
<body height="95%">
	<div id="title">
		<div align="center">
			<h1>创建采购申请单</h1>
		</div>
		<div class="form-inline" align="right" style="height:7px;width: 100%;">
			<button class="btn" onClick="save();">保存</button>
			<button class="btn" onClick="toProjectList();return false;">返回项目列表</button>
		</div>
		<form id="form" method="post" action="">
			<div class="form-inline" align="right" style="margin-right:185px;" >
				<input type="hidden" name="projectId" id="projectId" value="<%=projectId%>">
				<input type="hidden" name="userId" id="userId" value="<%=userId%>">
				<input type="hidden" name="name" id="name" value="<%=projectName%>">
			</div>
			<br/>
			<br/>
			<table id="data-table"></table>
		</form>
	</div>
</body>
</html>