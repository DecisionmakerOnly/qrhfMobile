<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
	Integer companyId=user.getCompanyId();
	String userName=user.getUserName();
	
	String projectId = request.getParameter("projectId");
	String contractId = request.getParameter("contractId");
	String projectPageId = request.getParameter("projectPageId");
	String projectName = new String(request.getParameter("projectName").getBytes("iso8859-1"),"utf-8"); 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>材料订单页面</title>
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
<script type='text/javascript' src="<%=basePath%>common/plugin/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	var flag = false;
	function initNav(){
		$.ajax({
			dataType : "json",
			type : "post",
			url : "<%=basePath%>projectGroup/findProjectGroupDetailsNav.action?projectId=<%=projectId%>",
			success : function(data) {
// 				var html = "<li class='active' href='jacascript::void(0);'><a data-toggle='tab' onclick='refreshTable("+data[0].id+","+new Date(Date.parse(data[0].startDate)).getTime()+","+new Date(Date.parse(data[0].endDate)).getTime()+")'>"+data[0].startDate+"至"+data[0].endDate+"</a></li>";
				var html = "";
				for(var i=0;i<data.length;i++){
					var curTime = new Date().getTime();
					if(curTime>=new Date(Date.parse(data[i].startDate)).getTime() && curTime<=new Date(Date.parse(data[i].endDate)).getTime()+24*60*60*1000-1){
						html += "<li class='active' href='jacascript::void(0);'><a data-toggle='tab' onclick='refreshTable("+data[i].id+","+new Date(Date.parse(data[i].startDate)).getTime()+","+new Date(Date.parse(data[i].endDate)).getTime()+")'>"+data[i].startDate+"至"+data[i].endDate+"</a></li>";
						$("#projectGroupId").val(data[i].id);
						flag = true;
					}else{
						html += "<li href='jacascript::void(0);'><a data-toggle='tab' onclick='refreshTable("+data[i].id+","+new Date(Date.parse(data[i].startDate)).getTime()+","+new Date(Date.parse(data[i].endDate)).getTime()+")'>"+data[i].startDate+"至"+data[i].endDate+"</a></li>";
					}
				}
				html+='<li style="float: right;"><button class="btn" onClick="toProjectList()">返回项目列表</button></li>';
				html+='<li style="float: right;padding-right:20px;"><button class="btn btn-primary" onClick="save()">保存</button></li>';
				$("#projectGroupList").html(html);
				findProjectGroupGoodsListById();
			}
		});
	}
	
	function refreshTable(projectGroupId,startDate,endDate){
		var curTime = new Date().getTime();
      	if(curTime>=startDate && curTime<=endDate){
      		flag = true;
      	}else{
      		flag = false;
      	}
		$("#projectGroupId").val(projectGroupId);
		$('#data-table').bootstrapTable("refresh",{silent: false});
	}
	
	function findProjectGroupGoodsListById(){
		var tableHeight = $(window).height()-$("#title").height()-50;
		$('#data-table').bootstrapTable({
			url: '<%=basePath%>projectOrder/findProjectGroup.action',
 			method: 'post',
 			contentType: "application/x-www-form-urlencoded",
 			/* queryParamsType的默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort  设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber */
             queryParamsType:'', 
             queryParams: function queryParams(params) {  
 				var param = {  
					projectGroupId:$("#projectGroupId").val()
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
 					title : '系统商品名称'
 				},
 				{
 					field : 'asName',
 					title : '项目采购控制表商品名称'
 				},
 				{
 					field : 'code',
 					title : '商品编码'
 				},
 				{
 					field : 'type',
 					title : '规格'
 				},
 				{
 					field : 'unit',
 					title : '单位',
 					align: "center"
 				},
 				{
 					field : 'price',
 					title : '控制单价',
 					align: "center"
 				},
 				{
	                field: 'operate',
	                title: '采购单价',
	                align: 'center',
	                formatter: function (value, row, index) {
	                	if(flag){
	                		return [
								'<input style="width:100px" type="text" name="projectOrderGoodss['+index+'].price" id="price'+index+'" autocomplete="off" maxPrice="'+row.price+'" value="">'
							].join('');
	                	}else{
	                		return "-";
	                	}
 					}  
	            },
//  				{
//  					field : 'amount',
//  					title : '控制数量',
//  					align: "center"
//  				},
//  				{
//  					field : 'amount2',
//  					title : '已采购数量',
//  					align: "center"
//  				},
 				{
	                field: 'operate',
	                title: '采购数量',
	                align: 'center',
	                formatter: function (value, row, index) {
	                	if(flag){
	                		return [
								'<input style="width:100px" type="text" name="projectOrderGoodss['+index+'].amount" id="amount'+index+'" autocomplete="off" maxAmount="'+(row.amount - row.amount2).toFixed(3)+'" value="">',
								'<input type="hidden" name="projectOrderGoodss['+index+'].goodsId" id="goodsId'+index+'" value="'+row.goodsId+'">',
								'<input type="hidden" name="projectOrderGoodss['+index+'].asName" id="asName'+index+'" value="'+row.asName+'">'
							].join('');
	                	}else{
	                		return "-";
	                	}
 					}  
	            },
 				{
 					title : '剩余数量',
 					align: "center",
 					formatter: function (value, row, index) {
 						return (row.amount - row.amount2).toFixed(3);    //返回每条的序号： 每页条数 * （当前页 - 1 ）+ 序号
 					}  
 				}
 			]
		})
	}
	
	function  save() {
		var flag = true;
		var num = 0;
		var amountId = "";
		var priceId = "";
		$("input[name*='amount']").each(function(){
			var $this = $(this);
			if(parseFloat($this.val())>parseFloat($this.attr('maxAmount'))){
				flag = false;
				amountId += parseInt($this.attr("id").substr(6))+1+",";
			}
			if($this.val()>0){
				num++;
			}
			if($this.val() == "" || $this.val() == null){
				$this.val(0);
			}
		})
		$("input[name*='price']").each(function(){
			var $this = $(this);
			if(parseFloat($this.val())>parseFloat($this.attr('maxPrice'))){
				flag = false;
				priceId += parseInt($this.attr("id").substr(5))+1+",";
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
			var html = "检测到至少有一个商品的采购单价大于控制单价或采购数量大于剩余数量\n";
			if(amountId.length>0)html+="数量超过为：第"+amountId.substr(0,amountId.length-1)+"项\n";
			if(priceId.length>0)html+="价格超过为：第"+priceId.substr(0,priceId.length-1)+"项\n";
			alert(html);
		}
	}
	
	$(function(){
		initNav();
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
	
</script>
</head>
<body height="95%">
	<div id="title">
		<div align="center">
			<h1>创建采购表</h1>
		</div>
		<div align="right">
			<ul class="nav nav-tabs" id="projectGroupList"></ul>
			<input type="hidden" id="projectGroupId">
		</div>
	</div>
	<form id="form" method="post" action="">
		<div class="form-inline" align="right" style="margin-right:185px;" >
			<input type="hidden" name="userId" id="userId" value="<%=userId%>">
			<input type="hidden" name="projectId" id="projectId" value="<%=projectId%>">
			<input type="hidden" name="contractId" id="contractId" value="<%=contractId%>">
			<input type="hidden" name="name" id="name" value="<%=projectName%>">
		</div>
		<table id="data-table"></table>
	</form>
</body>
</html>