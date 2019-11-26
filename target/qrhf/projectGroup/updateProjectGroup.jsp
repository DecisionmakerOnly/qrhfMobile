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
	
	
	String projectId = request.getParameter("projectId");
	String projectGroupId=request.getParameter("projectGroupId");
	String projectName = new String(request.getParameter("projectName").getBytes("iso8859-1"),"utf-8");
	String pageId = request.getParameter("groupPageId");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<title>修改项目分批设置</title>
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
		$.ajax({
			dataType : "json",
			type : "post",
			url : "<%=basePath%>projectGroup/findProjectGroupIdDetailsNav.action?projectGroupId=<%=projectGroupId%>",
			success : function(data) {
				var curTime = new Date().getTime();
				if(curTime>=new Date(Date.parse(data[0].startDate)).getTime() && curTime<=new Date(Date.parse(data[0].endDate)).getTime()+24*60*60*1000-1){
					var html ='<input type="text" class="form-control input-sm Wdate" style="width:10%;" name="startDate" id="startDate" placeholder="开始时间" disabled="disabled"  onClick="WdatePicker()" value="'+data[0].startDate+'" readonly/>-<input type="text" class="form-control input-sm Wdate" style="width:10%;" name="endDate" id="endDate" placeholder="结束时间" disabled="disabled"  onClick="WdatePicker()" value="'+data[0].endDate+'" readonly/>';
				}else{
					var html ='<input type="text" class="form-control input-sm Wdate" style="width:10%;" name="startDate" id="startDate" placeholder="开始时间" onClick="WdatePicker()" value="'+data[0].startDate+'" readonly/>-<input type="text" class="form-control input-sm Wdate" style="width:10%;" name="endDate" id="endDate" placeholder="结束时间" onClick="WdatePicker()" value="'+data[0].endDate+'" readonly/>';
				}
				
				$("#projectGroupList").html(html+$("#projectGroupList").html());
				
			}
		});
		var tableHeight = $(window).height()-$("#title").height()-50;
		$('#data-table').bootstrapTable({
	    	url: '<%=basePath%>projectGroup/projectGroupById.action',
			method: 'post',
			contentType: "application/x-www-form-urlencoded",
			/* queryParamsType的默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort  设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber */
            queryParamsType:'', 
            queryParams: function queryParams(params) {  
				var param = {  
					projectGroupId:<%=projectGroupId%>,
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
					title : '本期分批数量',
					align: "center",
					valign : 'middle',
					sortable : false,
					formatter: function (value, row, index) {
						return [
						'<input type="text" name="projectGroupGoodss['+index+'].amount" id="amount'+index+'" mixValue="'+row.smallAmount+'" maxValue="'+row.budgetAmount+'" value="'+row.amount+'" autocomplete="off">',
						'<input type="hidden" name="projectGroupGoodss['+index+'].projectGroupId" id="projectGroupId'+index+'" value="'+row.projectGroupId+'">',
						'<input type="hidden" name="projectGroupGoodss['+index+'].goodsId" id="goodsId'+index+'" value="'+row.goodsId+'">',
						'<input type="hidden" name="projectGroupGoodss['+index+'].asName" id="goodsId'+index+'" value="'+row.asName+'">',
						'<input type="hidden" name="projectGroupGoodss['+index+'].price" id="price'+index+'" value="'+row.price+'">'
						].join('');
					}  
				},
				{
					field : 'budgetAmount',
					title : '最大可修改分批设置的数量',
					align: "center",
					valign : 'middle',
					sortable : false
				},
				{
					field : 'smallAmount',
					title : '本次分批采购量',
					align: "center",
					valign : 'middle',
					sortable : false
				}
// 				,{
// 				    title: '操作',
// 				    align: 'center',
// 				    valign: 'middle',
// 					formatter: operateFormatter,
// 					events: window.operateEvents
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
	})
// 	function operateFormatter(value, row, index) {
//         return [
//         	'<a class="edit" title="删除" href="javascript:del('+row.projectGroupId+')">删除</a>'
//         ].join('');
//     }
	function toProjectList(){
		window.location.href = "<%=basePath%>projectGroup/list.jsp?&projectId=" +<%=projectId%>+"&pageId="+<%=pageId%>+"&projectName=<%=projectName%>";
	}
	function del(projectGroupId){
		$.post(
				"<%=basePath%>projectGroup/findProjectOrderGroupId.action",
				{"projectGroupId":<%=projectGroupId%>},
				function(data) {
					if(data==1){
						if(confirm('本次分批已上传采购表，是否要删除分批项')){
							$.post(
									"<%=basePath%>projectGroup/findProjectGroupId.action",
									{"projectGroupId":<%=projectGroupId%>},
									function(data) {
										if(data==1){
											if(confirm('您确定要删除本次分批设置的最后一项？删除后本次分批将被删除！')){
												$.ajax({
													dataType : "json",
													type : "post",
													url : "<%=basePath%>projectGroup/del.action?projectGroupId="+<%=projectGroupId%>,
													success : function(data) {
														if(data == "1"){
															$.ajax({
																dataType : "json",
																type : "post",
																url : "<%=basePath%>projectGroup/delBatchGoods.action?projectGroupId="+projectGroupId,
																success : function(data) {
																	if(data == "1"){
																		alert("删除成功！");
																		window.location.href = "<%=basePath%>projectGroup/list.jsp?&projectId=" +<%=projectId%>+"&pageId="+<%=pageId%>;
																	}else{
																		alert("删除失败！");
																	}
																}
															});
														}else{
															alert("删除失败！");
														}
													}
												});
											} else {
												return false;
											}
										}else if(data==2){
											$.ajax({
												dataType : "json",
												type : "post",
												url : "<%=basePath%>projectGroup/delBatchGoods.action?projectGroupId="+projectGroupId,
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
								)
						} else {
							return false;
						}
					}else if(data==2){
						$.post(
								"<%=basePath%>projectGroup/findProjectGroupId.action",
								{"projectGroupId":<%=projectGroupId%>},
								function(data) {
									if(data==1){
										if(confirm('您确定要删除本次分批设置的最后一项？删除后本次分批将被删除！')){
											$.ajax({
												dataType : "json",
												type : "post",
												url : "<%=basePath%>projectGroup/del.action?projectGroupId="+<%=projectGroupId%>,
												success : function(data) {
													if(data == "1"){
														$.ajax({
															dataType : "json",
															type : "post",
															url : "<%=basePath%>projectGroup/delBatchGoods.action?projectGroupId="+projectGroupId,
															success : function(data) {
																if(data == "1"){
																	alert("删除成功！");
																	window.location.href = "<%=basePath%>projectGroup/list.jsp?&projectId=" +<%=projectId%>+"&pageId="+<%=pageId%>;
																}else{
																	alert("删除失败！");
																}
															}
														});
													}else{
														alert("删除失败！");
													}
												}
											});
										} else {
											return false;
										}
									}else if(data==2){
										$.ajax({
											dataType : "json",
											type : "post",
											url : "<%=basePath%>projectGroup/delBatchGoods.action?projectGroupId="+projectGroupId,
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
							)
					}
				}
			)
		
	}
	function update(){
		var flag = true;
		var num = 0;
		var mix=2;
		var startDate = String($("#startDate").val());
		var endDate = String($("#endDate").val());
		if(endDate<startDate){
			alert("截至时间不可大于开始时间！");
			return;
		}
		
		$("input[name*='amount']").each(function(){
			var $this = $(this);
			
			if(parseInt($this.val())>parseInt($this.attr('maxValue'))){
				mix = 1;
				flag = false;
			}
			if(parseInt($this.val())<parseInt($this.attr('mixValue'))){
				mix = 2;
				flag = false;
			}
			if($this.val()== "" || $this.val()==undefined || $this.val()==null){
				$this.val(0);
			}
			if($this.val()>0){
				num++;
			}
		})
		if(flag && num>0){
            $.ajax({
                type: "post",//方法类型
                dataType: "text",//预期服务器返回的数据类型
                url: "<%=basePath%>projectGroup/updateAmount",
                data: $('#form').serialize(),
                success: function (data) {
                    if (data == 1) {
                    	$.post(
								"<%=basePath%>projectGroup/updateGroupDate.action",
								{"projectGroupId":<%=projectGroupId%>,startDate:startDate,endDate : endDate}
							)
                    	saveLog("<%=companyId%>","<%=userId%>",1,"<%=userName%>对《<%=projectName%>》项目进行了分批设置！");
                    	alert("保存成功！");
                    	window.location.href = "<%=basePath%>projectGroup/list.jsp?&projectId=" +<%=projectId%>+"&pageId="+<%=pageId%>+"&projectName=<%=projectName%>";
                    }else if(data == 0){
                    	alert("时间段已有分批 保存失败！");
                    }
                }
            });
		}else if(flag ==false && mix==1){
			alert("本期分批数量不可以超过最大可修改分批设置的数量");
		}else if(flag ==false && mix==2){
			alert("本期分批数量不可以小于本次分批采购量");
		}
	}
</script>
</head>
<body height="95%">
	<div id="title">
		<div align="center">
			<h1>修改项目分批设置</h1>
		</div>
		<form id="form">
			<div class="form-inline" align="right"  id="projectGroupList">
				<input type="hidden" name="id" id="id" value="<%=projectGroupId%>">
				<input type="hidden" name="projectName" id="projectName" value="<%=projectName%>">
				<input type="hidden" name="projectId" id="projectId" value="<%=projectId%>">
				<button class="btn" onClick="update();return false;">保存</button>
				<button class="btn" onClick="toProjectList();return false;">返回分批列表</button>
			</div>
			<table id="data-table"></table>
		</form>
	</div>
</body>
</html>