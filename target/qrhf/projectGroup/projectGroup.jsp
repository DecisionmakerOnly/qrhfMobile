<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
	Integer companyId=user.getCompanyId();
	String userName = user.getUserName();
	
	String projectName = new String(request.getParameter("projectName").getBytes("iso8859-1"),"utf-8");
	String sysFlowId=request.getParameter("sysFlowId");
	String projectId = request.getParameter("projectId");
	String projectPageId = request.getParameter("projectPageId");
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
	    	url: '<%=basePath%>projectGroup/projectGroup.action',
			method: 'post',
			contentType: "application/x-www-form-urlencoded",
			/* queryParamsType的默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort  设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber */
            queryParamsType:'', 
            queryParams: function queryParams(params) {  
				var param = {  
				    projectId:<%=projectId%>
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
					sortable : false,
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
					sortable : false
				},
				{
					field : 'asName',
					title : '项目采购控制表商品名称',
					valign : 'middle',
					sortable : false
				},
				{
					field : 'code',
					title : '商品编码',
					valign : 'middle',
					sortable : false
				},
				{
					field : 'type',
					title : '规格',
					valign : 'middle',
					sortable : false
				},
				{
					field : 'unit',
					title : '单位',
					align: "center",
					valign : 'middle',
					sortable : false
				},
				{
					field : 'price',
					title : '单价',
					align: "center",
					valign : 'middle',
					sortable : false
				},
				{
					field : 'amount',
					title : '数量',
					align: "center",
					valign : 'middle',
					sortable : false,
					formatter: function (value, row, index) {
						return [
						'<input type="text" name="projectGroupGoodss['+index+'].amount" id="amount'+index+'" autocomplete="off" maxValue="'+row.budgetAmount+'" value="'+row.budgetAmount+'">',
// 						'<input type="hidden" name="projectGroupGoodss['+index+'].projectId" id="projectId'+index+'" value="'+row.projectId+'">',
						'<input type="hidden" name="projectGroupGoodss['+index+'].goodsId" id="goodsId'+index+'" value="'+row.goodsId+'">'
// 						'<input type="hidden" name="projectGroupGoodss['+index+'].asName" id="goodsId'+index+'" value="'+row.asName+'">',
// 						'<input type="hidden" name="projectGroupGoodss['+index+'].price" id="price'+index+'" value="'+row.price+'">'
						].join('');
					}  
				},
				{
					field : 'budgetAmount',
					title : '最大可用数量',
					align: "center",
					valign : 'middle',
					sortable : false
				}
// 				,
// 				{
// 					field : 'total',
// 					title : '总价',
// 					align: "center",
// 					valign : 'middle',
// 					sortable : false
// 				}
				
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
		isExists();
	})

	//防止session过期，每25分钟发送一个空请求
	function isExists() {
 		setInterval(function(){ 
 			$.post(
 				"<%=basePath%>project/isExists"		
 			)	
		}, 25*60*1000);
	}
	
	function toProjectList(){
		window.location.href="<%=basePath%>project/list.jsp?pageId=<%=projectPageId%>";
	}
	
	function  save() {
		var startDate = String($("#startDate").val());
		var endDate = String($("#endDate").val());
		if(startDate == null || startDate == "" || endDate == null || endDate == ""){
			alert("请选择开始时间及结束时间！");
			return;
		}else if(endDate<startDate){
			alert("截至时间不可大于开始时间！");
			return;
		}
		var flag = true;
		var num = 0;
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
		if(flag && num>0){
            $.ajax({
                type: "POST",//方法类型
                dataType: "text",//预期服务器返回的数据类型
                url: "<%=basePath%>projectGroup/save",
                data: $('#form').serialize(),
                async: false,
                success: function (data) {
                    if (data == 1) {
                    	saveLog("<%=companyId%>","<%=userId%>",1,"<%=userName%>对《<%=projectName%>》项目进行了分批设置！");
                    	if(<%=sysFlowId%> !=null){
                        	$.post(
                    				"<%=basePath%>sysFlow/deleteNotice",	
                    				{id:<%=sysFlowId%>},
                    				function (data) {
                    					if(data==1){
                    					}
                    				}		
                    			) 
                    	}
                    	alert("保存成功！");
                    	location.reload();
                    }else if(data == 0){
                    	alert("时间冲突 保存失败！");
                    }
                }
            });
		}else{
			alert("至少有一项'数量'≥0且数量不可超过'最大可用数量'才可提交");
		}
	}
	
</script>
</head>
<body height="95%">
	<div id="title">
		<div align="center">
			<h1>项目分批设置</h1>
		</div>
		<div class="form-inline" align="right" style="height:7px;width: 100%;">
			<button class="btn" onClick="save();">保存</button>
			<button class="btn" onClick="toProjectList();return false;">返回项目列表</button>
		</div>
		<form id="form" method="post" action="">
			<div class="form-inline" align="right" style="margin-right:185px;" >
				<input type="hidden" name="projectId" id="projectId" value="<%=projectId%>">
				<input type="hidden" name="projectName" id="projectName" value="<%=projectName%>">
				<input type="hidden" name="projectPageId" id="projectPageId" value="<%=projectPageId%>">
				<input type="text" class="form-control input-sm Wdate" style="width:10%;" name="startDate" id="startDate" placeholder="开始时间" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="" readonly/>-
				<input type="text" class="form-control input-sm Wdate" style="width:10%;" name="endDate" id="endDate" placeholder="结束时间" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="" readonly/>
			</div>
			<br/>
			<table id="data-table"></table>
		</form>
	</div>
</body>
</html>