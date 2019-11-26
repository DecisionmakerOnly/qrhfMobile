<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
	String userName=user.getUserName();
	Integer departmentId = user.getDepartmentId();
	Integer companyId=user.getCompanyId();
	String roleCode = user.getRoleCode();
	String pageId = request.getParameter("pageId");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="zh-CN">
<head>
<base href="<%=basePath%>">
<title>项目列表</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="renderer" content="webkit">
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
<script type="text/javascript" src="<%=basePath%>common/js/jquery.regionselect2.js" ></script>
<script type="text/javascript">
	function zsy(){
		var yScroll = (window.parent.document.documentElement.scrollHeight >window.parent.document.documentElement.clientHeight) ? window.parent.document.documentElement.scrollHeight : window.parent.document.documentElement.clientHeight; 
		return yScroll;
	}
	$(function() {
		var h=zsy();
		initBtn(<%=userId%>,<%=pageId%>);
		$("#data-table").bootstrapTable('destroy'); 
		$('#data-table').bootstrapTable({
	    	url: '<%=basePath%>project/findList.action',
			method: 'post',
			contentType: "application/x-www-form-urlencoded",
			//【查询设置】
			/* queryParamsType的默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort
			 设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber */
            queryParamsType:'', 
            queryParams: function queryParams(params) {  
              var param = {  
                  pageNumber: params.pageNumber,    
                  pageSize: params.pageSize
              }; 
              return param;                   
            }, 
			locale:'zh-CN',//中文支持
			pagination: true,//是否开启分页（*）
            pageNumber:1,//初始化加载第一页，默认第一页
            pageSize: 20,//每页的记录行数（*）
            pageList: [20,50,100],//可供选择的每页的行数（*）
            sidePagination: "server", //分页方式：client客户端分页，server服务端分页（*）
			clickToSelect: true, // 单击行即可以选中
			silent : true, //刷新事件必须设置
			striped : true,// 隔行加亮
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
					title : '项目名称',
					valign : 'middle',
					formatter:function(value, row, index) {
				        return [
				            '<input type="hidden" id="projectName'+row.id+'" value="'+row.name+'"><a class="remove" href="javascript:projectDetail('+row.id+')" title="项目采购控制表详情">'+row.name+'</a>',
				            
				        ].join('');
				    },
	                events: window.operateEvents,
	                align: "center"
				},
				{
					field : 'budgetAmount',
					title : '控制总金额（元）',
					valign : 'middle',
					align: "center"
				},
				{
					field : 'consumptionAmount',
					title : '已采购金额（元）',
					valign : 'middle',
					align: "center"
				},
				{
					field : 'percentage',
					title : '百分比',
					align: "center",
					valign : 'middle'
				},
				{
					field : 'userName',
					title : '创建人',
					align: "center",
					valign : 'middle'
				},
				{
					field : 'dutyUserName',
					title : '项目经理',
					align: "center",
					valign : 'middle'
				},
				{
					field : 'jurisdiction',
					title : '可视范围',
					align: "center",
					valign : 'middle',
					formatter:function(value,row,index){ 
				          if (row.jurisdiction ==1) {
				        	  return "本公司";
				          }else if(row.jurisdiction == 2){
				        	  return "本部门";
				          }else if(row.jurisdiction == 3){
				        	  return "自己";
				          }
					} 
				},
				{
					field : 'createdate',
					title : '创建时间',
					align: "center",
					valign : 'middle',
					events: window.operateEvents,
					//获取日期列的值进行转换
				    formatter: function (value, row, index) {
				        return changeDateFormat(value);
				    }
				}, {
					field: 'operate',
					title: '操作',
					align: 'center',
					valign: 'middle',
					events: window.operateEvents,
					formatter: function (value, row, index) {
						if(checkUserDepartmentIsCorrect(row.departmentId,"<%=departmentId%>",row.userId,"<%=userId%>","<%=roleCode%>")){
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
		
		if(!checkUserDepartmentIsCorrect(11,<%=departmentId%>)){

		}
		
	})
	
	function projectGoodsDel(obj){//删除项目采购控制表
		$.post(
			"<%=basePath%>projectOrder/selectOrderQuantity.action",
			{"projectId":obj.attr('value')},
			function(data) {
				if(data==0){
					if(confirm('您确定要删除？')){
						$.ajax({
							dataType : "json",
							type : "post",
							url : "<%=basePath%>project/projectGoodsDel?projectId="+obj.attr('value'),
							success : function(data) {
								saveLog("<%=companyId%>","<%=userId%>",1,"<%=userName%>对《"+$('#projectName'+obj.attr('value')).val()+"》项目采购控制表进行了删除！");
								alert("删除成功！");
								location.reload();
							}
						});
					} else {
						return false;
					}
				}else if(data==1){
					alert("已上传采购表，请先删除采购表再删除项目采购控制表");
				}else if(data==2){
					alert("已上传采购表或有采购流程未完成，请先完成待办事项中的流程,删除采购表再删除项目采购控制表");
				}
			}
		)
	}
	
	function del(obj) {//删除项目
		$.post( 
			"<%=basePath%>projectOrder/selectOrderQuantity.action",
			{"projectId":obj.attr('value')},
			function(data) {
				if(data==0){
			 		if(confirm('您确定要删除？')){
			 			$.ajax({
			 				dataType : "json",
			 				type : "post",
							url : "<%=basePath%>project/del?projectId="+obj.attr('value'),
			 				success : function(data) {
			 					alert("删除成功！");
			 					saveLog("<%=companyId%>","<%=userId%>",2,"<%=userName%>对《"+$('#projectName'+obj.attr('value')).val()+"》项目进行了删除！");
			 					location.reload();
			 					//$('#data-table').bootstrapTable('refresh');
			 				}
			 			});
			 		} else {
			 			return false;
			 		}
				}else if(data==2){
					alert("有审批流程未完成或存在采购表，请询问项目经理和材料员是否有未完成审批的材料采购表并删除所有采购表");
				}
			}
		)
	}
	
	function add() {
		openModal("<%=basePath%>project/add.jsp?projectPageId="+<%=pageId%>);
	}
	
	function toUpdateProject(obj) {
		$.post(
				"<%=basePath%>project/selectGoodsQuantity.action",
				{"projectId":obj.attr('value')},
				function(data) {
					if(data==0){
						window.location.href = "<%=basePath%>project/upload.jsp?projectPageId=<%=pageId%>&projectId="+obj.attr('value')+"&projectName="+$('#projectName'+obj.attr('value')).val();
					}else{
						alert("已存在项目采购控制表，请勿重复上传")
					}
				}
			)	
	}
	
// 	function toUpdateForOrder(obj) {
// 		$.post(
<%-- 				"<%=basePath%>projectGroup/selectGroupDate.action", --%>
// 				{"projectId":obj.attr('value')},
// 				function(data) {
// 		    		if(data>0){
// 		    			if(selectProjectGoodsCount(obj)>=1){
// 		    				$.post(
<%-- 		    					"<%=basePath%>project/selectDutyCount.action", --%>
// 		    					{projectId:obj.attr('value')},
// 		    					function(data) {
// 		    						if(data>0){
// 		    							$.post(
<%-- 		    								"<%=basePath%>project/contrastProjectGoods.action", --%>
// 		    									{"projectId":obj.attr('value')},
// 		    									function(data) {
// 		    										if(data==1){
// 		    											alert("已上传的采购申请表材料总量达到项目采购控制表总量，请调整项目采购控制表再上传采购申请表");
// 		    										}else if(data==2){
<%-- 		    											window.location.href = "<%=basePath%>order/upload.jsp?projectPageId=<%=pageId%>&projectId=" + obj.attr('value'); --%>
// 		    									}
// 		    								}
// 		    							)
// 		    						}else{
// 		    							alert("请将该项目在部门管理中绑定后再上传采购表");
// 		    							return false;
// 		    						}
// 		    					}
// 		    				)
// 		    			}else{
// 		    				alert("请先上传项目采购控制表再上传采购表");
// 		    				return false;
// 		    			}
// 		        	}else{
// 		        		alert("当前时间没有分批不能上传采购表!");
// 					}
// 				}
// 			)
// 	}
	
	function selectProjectGoodsCount(obj){
		var num = 0;
		$.ajax({
			dataType : "json",
			type : "post",
			async: false,//同步
			url : "<%=basePath%>project/selectProjectGoodsCount?projectId=" + obj.attr('value'),
			success : function(data) {
				num = data;
			}
		});
		return num;
	}  
	
	function toProjectUpdateResource(obj){
		window.location.href = "<%=basePath%>project/projectUpdateResource.jsp?projectPageId=<%=pageId%>&projectId="+obj.attr('value');
	}
	
	function selectOrder(obj) {
		window.location.href = "<%=basePath%>order/list.jsp?projectPageId=<%=pageId%>&projectId=" + obj.attr('value')+"&pageId="+obj.attr('pageId');
	}
	
	function projectDetail(id) {
		window.location.href = "<%=basePath%>project/detail.jsp?projectPageId=<%=pageId%>&projectId=" + id;
	}
	
	function statistics(obj) {
		window.location.href = "<%=basePath%>project/statistics.jsp?projectId=" + obj.attr('value');
	}
	
	function projectGroup(obj){
		$.post(
				"<%=basePath%>projectOrder/selectUserCode.action",
				{"userId":<%=userId%>,"projectId":obj.attr('value')},
				function(data) {
					if(data==1){
						//是投资人代表
						if(confirm('有审批流程未完成或存在采购表，您是否继续进行分批设置？')){
							window.location.href = "<%=basePath%>projectGroup/projectGroup.jsp?projectPageId=<%=pageId%>&projectId=" + obj.attr('value')+"&projectName="+$('#projectName'+obj.attr('value')).val();	
				 		} else {
				 			return false;
				 		}
					}else if(data ==2){
						$.post(
								"<%=basePath%>sysFlow/selectBatch.action",
								{"projectId":obj.attr('value'),
								 "buyerId":<%=userId%>
								},
								function(data) {
									if(data==0){
										alert("您已申请分批设置，请在首页提醒事项中进行分批设置");
									}else if(data ==1){
										saveLog("<%=companyId%>","<%=userId%>",1,"<%=userName%>申请了对《"+$('#projectName'+obj.attr('value')).val()+"》项目进行分批设置");
										openModal("<%=basePath%>projectGroup/temporaryBatch.jsp?pageId=<%=pageId%>&recordId="+obj.attr('value'));
									}
								}
							)
					}else{
						window.location.href = "<%=basePath%>projectGroup/projectGroup.jsp?projectPageId=<%=pageId%>&projectId=" + obj.attr('value')+"&projectName="+$('#projectName'+obj.attr('value')).val();
					}
				}
			)
	}
	function projectGroupList(obj){
		window.location.href = "<%=basePath%>projectGroup/list.jsp?projectPageId=<%=pageId%>&projectId=" + obj.attr('value')+"&pageId="+obj.attr('pageId')+"&projectName="+$('#projectName'+obj.attr('value')).val();
	}
	
	function edit(obj){
		window.location.href = "<%=basePath%>project/update.jsp?projectPageId=<%=pageId%>&projectId=" + obj.attr('value');
	}
	
	function deleteGoodsAll(obj){
		if(confirm('您确定要删除？')){
			$.post(
				"<%=basePath%>project/deleteGoodsAll.action",
				{"projectId":obj.attr('value')},
				function(data) {
					if(data==1){
						alert("保存成功");
						$('#data-table').bootstrapTable('refresh');
					}else{
						alert("请选择项目负责人后再上传采购表")
					}
				}
			)
		} else {
			return false;
		}
	}
	
	function temporaryAuthority(obj){
		openModal("<%=basePath%>temporaryAuthority.jsp?pageId=<%=pageId%>&recordId="+obj.attr('value'));
	}
	
	function toProjectUpdate(obj) {
		$.ajax({
			dataType : "json",
			type : "post",
			url : "<%=basePath%>project/saveProjectUpdate.action?project="+obj.attr('value'),
			success : function(data) {
				window.location.href = "<%=basePath%>project/projectUpdate.jsp?projectPageId=<%=pageId%>&projectId="+obj.attr('value')+"&projectUpdateId="+data;
			}
		});
	}
	
	function projectGroupDetail(obj) {
		$.post(
			"<%=basePath%>projectGroup/selectGroupQuantity.action",
			{"projectId":obj.attr('value')},
			function(data) {
				if(data==0){
					window.location.href = "<%=basePath%>projectGroup/details.jsp?projectPageId=<%=pageId%>&projectId=" + obj.attr('value');
				}else if(data ==1){
					alert("此项目还未进行分批设置")
				}
			}
		)
	}
	function analysis(obj) {
		window.location.href = "<%=basePath%>project/analysis.jsp?projectId=" + obj.attr('value');
	}
	
	function addProjectOrder(obj){
		if(selectProjectGoodsCount(obj)>=1){
			$.ajax({
				dataType : "json",
				type : "post",
				url : "<%=basePath%>projectGroup/selectGroupDate.action?projectId="+obj.attr('value'),
				success : function(data){
					if(data>0){
						window.location.href = "<%=basePath%>order/selectContract.jsp?projectId="+obj.attr('value')+"&projectName="+$('#projectName'+obj.attr('value')).val()+"&projectPageId="+<%=pageId%>;
   					}else{
		        		alert("当前时间没有分批不能创建采购申请表!");
					}
	        	}
			});
		}else{
			alert("请先上传项目采购控制表再上传采购表");
 		}
	}
</script>
</head>
<body id="listBody">
	<div align="center">
		<h1>项目列表</h1>
	</div>
	<div align="right" id="buttons<%=pageId%>"></div> 
	<table id="data-table"></table>
</body>
</html>