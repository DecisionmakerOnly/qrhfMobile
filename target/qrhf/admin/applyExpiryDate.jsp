<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.SysAdmin"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	SysAdmin admin = (SysAdmin)request.getSession().getAttribute("admin");
	Integer adminId=admin.getId();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="zh-CN">
<head>
<base href="<%=basePath%>">
<title>申请延期</title>
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
<script src="<%=basePath%>common/plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">

	function zsy(){
		var yScroll = (window.parent.document.documentElement.scrollHeight >window.parent.document.documentElement.clientHeight) ? window.parent.document.documentElement.scrollHeight : window.parent.document.documentElement.clientHeight; 
		return yScroll;
	}
	$(function() {
		var h=zsy();
		$("#data-table").bootstrapTable('destroy'); 
		$('#data-table').bootstrapTable({
	    	url: '<%=basePath%>applyExpiryDate/findApplyExpiryDate.action',
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
					field : 'userName',
					title : '申请人',
					valign : 'middle',
				    events: window.operateEvents,
				    align: "center",
					sortable : true
				},
				{
					field : 'companyName',
					title : '申请企业',
					valign : 'middle',
				    events: window.operateEvents,
				    align: "center",
					sortable : true
				},
				{
					field : 'reason',
					title : '原因',
					valign : 'middle',
				    events: window.operateEvents,
				    align: "center",
					sortable : true
				},
				{
					field : 'createDate',
					title : '申请时间',
					valign : 'middle',
					align: "center",
					sortable : true,
				    events: window.operateEvents,
				  //获取日期列的值进行转换
				    formatter: function (value, row, index) {
				        return changeDateFormat(value);
				    }
				},
				{
					field : 'status',
					title : '状态',
					valign : 'middle',
					align: "center",
					formatter:function(value,row,index){ 
				          if (row.status ==0) {
				        	  return "申请中";
				          }
					} 
				},
				{
		            field: 'operate',
		            title: '操作',
		            align: 'center',
		            valign: 'middle',
		           formatter: operateFormatter,
		        }
			],
			formatNoMatches: function(){
			    return "还没有申请延期企业";
			 }
        })
        
		function operateFormatter(value, row, index) {
		 return ['<a role="button" onclick="openPassDlg('+row.id+','+row.companyId+','+row.userId+')">同意</a>&nbsp;&nbsp;&nbsp;',
				 '<a role="button" onclick="openPassDlgNo('+row.id+')">退回</a>&nbsp;&nbsp;&nbsp;'    	 
		 		].join(''); 
		}
		
		//转换日期格式(时间戳转换为datetime格式)
		function changeDateFormat(cellval) {
		    var dateVal = cellval + "";
		    if (cellval != null) {
		        var date = new Date(parseInt(dateVal.replace("/Date(", "").replace(")/", ""), 10));
		        var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
		        var currentDate = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
		        var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
		        var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
		        var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
		        return date.getFullYear() + "-" + month + "-" + currentDate + " " + hours + ":" + minutes + ":" + seconds;
		    }
		}
		
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
	
	function openPassDlg(id,companyId,userId){
		var id =$("#id").val(id);
		var companyId=$("#companyId").val(companyId);
		var userId=$("#userId").val(userId);
		findUserExpiryDate();
		$("#passDlg").modal('show');
	}
	function findUserExpiryDate(){
		var userId =$("#userId").val();
		$.ajax({
			dataType : "json",
			type : "post",
			url : "<%=basePath%>user/findUserExpiryDate.action?userId="+userId,
			success : function(data) {
				var html ='<input role="button" style="width: 100%; height: 50px; " type="text" class="form-control input-sm Wdate" style="width:10%;" name="expiryDate" id="expiryDate" placeholder="选择时间" onClick="WdatePicker()" value="'+data[0].userExpiryDate+'" readonly/>';
				$("#userExpiryDate").html(html+$("#userExpiryDate").html());
			}
		});
	}
	function closeDlgs() {
		$("#passDlg").modal('hide');
		$("#passDlgNo").modal('hide');
	}
	function openPassDlgNo(id){
		var id =$("#id").val(id);
		$("#passDlgNo").modal('show');
	}
	
	function saveApplyExpiryDate(){
		var id=$("#id").val();
		var companyId=$("#companyId").val();
		var expiryDate = String($("#expiryDate").val());
		if(expiryDate == null || expiryDate == ""){
			alert("请选择时间！");
			return;
		}
		$.ajax({
            type: "POST",//方法类型
            dataType: "text",//预期服务器返回的数据类型
            url: "<%=basePath%>user/updateUserExpiryDate.action",
            data: $('#applyExpiryDateUpdate').serialize(),
            async: false,
            success: function (data) {
            	if(data ==1){
                	$.post(
            				"<%=basePath%>applyExpiryDate/updateApplyExpiryDate.action",
            				{"id":id,"processUserId" :<%=adminId%>},
            				function(data) {
            				}
            			)
            		alert("延期成功！");
            		location.reload();
            	}else{
            		alert("操作失败");
            	}
            	
           	
            }
		});
	}
	
	function applyExpiryDateNo(){
		var id=$("#id").val();
		var reason= $("#reason").val();
		if(reason == null || reason == ""){
			alert("请输入退回原因！");
			return;
		}
    	$.post(
				"<%=basePath%>applyExpiryDate/applyExpiryDateNo.action",
				{"id":id,"reason":reason,"processUserId" :<%=adminId%>},
				function(data) {
					if(data==1){
						alert("退回成功！");
						location.reload();
					}else{
						alert("操作失败！");
					}
					
				}
			)
		
	}
</script>
</head>
<body id="listBody">
	<div align="center">
		<h1>企业延期</h1>
	</div>
	<table id="data-table"></table>
	<div class="form-horizontal" style="overflow: auto;">
		<!-- 模态框（Modal） -->
		<!-- -->
		<div  style="font-family: 'Noto Serif CJK SC', 'Noto Serif CJK', 'Source Han Serif SC', ‘Source Han Serif’, source-han-serif-sc, serif;" id="passDlg" class="modal fade"  tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<form id="applyExpiryDateUpdate" method="post">
					<input type="hidden" id="id" name="id"/>
					<input type="hidden" id="companyId" name="companyId"/>
					<input type="hidden" id="userId" name="userId"/>
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
							<h4 class="modal-title" id="myModalLabel">延期时间</h4>
						</div>
						<div class="modal-body">
					        <div class="form-group">
					            <label for="firstname" class="col-sm-3 control-label">选择到期时间</label>
					            <div class="col-sm-8" id="userExpiryDate">
					            </div>
					        </div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" onclick="closeDlgs()">取消</button>
							<button type="button" onclick="saveApplyExpiryDate()" class="btn btn-primary">保存</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<!-- 模态框（Modal） -->
		<!-- 修改 -->
		<div  style="font-family: 'Noto Serif CJK SC', 'Noto Serif CJK', 'Source Han Serif SC', ‘Source Han Serif’, source-han-serif-sc, serif;" id="passDlgNo" class="modal fade"  tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<form id="applyExpiryDateUpdateNo" method="post">
					<input type="hidden" id="id" name="id"/>
					<input type="hidden" id="companyId" name="companyId"/>
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
							<h4 class="modal-title" id="myModalLabel">退回原因</h4>
						</div>
					<div class="container">
						<div class="form-group">
							&nbsp;<textarea rows="5%" cols="78%" id="reason" ></textarea>
						</div>
						<div class="modal-footer col-md-6">
							<button type="button" class="btn btn-default" onclick="closeDlgs()">取消</button>
							<button type="button" onclick="applyExpiryDateNo()" class="btn btn-primary">确定</button>
						</div>
					</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>