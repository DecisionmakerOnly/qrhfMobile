<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>首页</title>
<meta name="viewport" content="width=device-width; initial-scale=1.4; minimum-scale=1.0; maximum-scale=2.0"/>
<meta name="viewport" content="width=device-width, initial-scale=1" /> 
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=2.0"/>
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

	$(function(){
		var h=zsy();
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
	
	$(function() {
		bossSelect();
	})
	function bossSelect() {
		if($("#isBoss").val()==1){
			$("#shotTable").css('display','block'); 
		}
	}
	
	function toPending(sysFlowId,projectId,projectOrderId,rejectReason,title,name) {
		window.location.href = "<%=basePath%>order/pending.jsp?sysFlowId="+sysFlowId+"&projectId="+projectId+"&projectOrderId="+projectOrderId+"&rejectReason="+rejectReason+"&title="+title+"&name="+name;
	}
	
	function toCorrectTemporaryAuthority(id,text){
		openModal("<%=basePath%>correctTemporaryAuthority.jsp?taId="+id+"&taText="+text.replace(" ",""));
	}
	
	function toApprovalResult(id,text){
		openModal("<%=basePath%>approvalResult.jsp?id="+id+"&taText="+text);
	}
	
	function toApprovalRecord(id,text,opinion,userName){
		openModal("<%=basePath%>approvalRecord.jsp?id="+id+"&taText="+text+"&opinion="+opinion+"&userName="+userName);
	}
	function toTemporaryBatch(id,title,userName,projectName){
		openModal("<%=basePath%>projectGroup/correctTemporaryBatch.jsp?taId="+id+"&title="+title.replace(" ","")+"&applicantName="+userName+"&projectName="+projectName);
	}
	function contrastSKB(sysFlowId,projectId,projectUpdateId,rejectReason) {
		window.location.href = "<%=basePath%>project/contrastSKB.jsp?sysFlowId="+sysFlowId+"&projectId="+projectId+"&projectUpdateId="+projectUpdateId+"&rejectReason="+rejectReason;
	}
	function contrastSKBConsultation(sysFlowId,projectId,projectUpdateId,rejectReason) {
		window.location.href = "<%=basePath%>project/contrastSKBConsultation.jsp?sysFlowId="+sysFlowId+"&projectId="+projectId+"&projectUpdateId="+projectUpdateId+"&rejectReason="+rejectReason;
	}
	
	function edit(sysFlowId,projectOrderId,projectId,name) {
		window.location.href ="<%=basePath%>order/edit.jsp?sysFlowId="+sysFlowId+"&projectOrderId="+projectOrderId+"&projectId="+projectId+"&name="+name;
	}
	
	function compareAgain(sysFlowId,projectOrderId,projectId,name) {
		window.location.href ="<%=basePath%>order/compareAgain.jsp?sysFlowId="+sysFlowId+"&projectOrderId="+projectOrderId+"&projectId="+projectId+"&name="+name;
	}
	function deleteNotice(id) {
		$.post(
			"<%=basePath%>sysFlow/deleteNotice",	
			{id:id},
			function (data) {
				if(data==1){
					location.reload();
				}
			}		
		)
	}
	function deleteNoticeExpire(id){
		$.post(
				"<%=basePath%>sysFlow/deleteNotice",	
				{id:id},
				function (data) {
					if(data==1){
						window.location.href ="<%=basePath%>payment/selectUser.jsp";
						// location.reload();
					}
				}		
			)
			
	}
	function deleteApplyExpiryDate(id){
		$.post(
				"<%=basePath%>applyExpiryDate/deleteApplyExpiryDate",	
				{id:id},
				function (data) {
					if(data==1){
						location.reload();
					}
				}		
			)
	}
	function toPreview(sysFlowId,projectOrderId,projectId,title) {
		window.location.href ="<%=basePath%>order/preview.jsp?sysFlowId="+sysFlowId+"&projectOrderId="+projectOrderId+"&projectPageId="+2+"&projectId="+projectId+"&projectOrderName="+title;
	}
	function projectGroup(projectId,projectName,id){
		window.location.href ="<%=basePath%>projectGroup/projectGroup.jsp?sysFlowId="+id+"&projectPageId="+2+"&projectId="+projectId+"&projectName="+projectName;
	}
	
	function showTable(checkbox) {
/* 		if ( checkbox.checked == true){
		}
 */			location.href="<%=basePath%>sysMain/homePage?showTables="+1;
	}
	
	function consultation(id,projectId,projectUpdateId){
		window.location.href ="<%=basePath%>project/consultation.jsp?consultationId="+id+"&projectId="+projectId+"&projectUpdateId="+projectUpdateId;
	}
	
</script>
</head>
<body id="listBody" style="padding-top: 5px;">
	<div class="panel panel-default" style="float:left;margin-left:20px;height:45%;width:96%;font-size: 36px;">
	    <div class="panel-heading" style="height:15%;font-size: 36px;" >
	       	待办事项
	       	<div  style="float: right;display: none;" id="shotTable">
		       	<input type="button" onclick="showTable()" value="显示所有未审批采购表">
<!-- 		       	<input type="checkbox" onclick="showTable(this)">显示所有未审批采购表 -->
	       	</div>
	    </div>
	    <div class="panel-body" id="approval" style="overflow-y:auto;height:85%;" >
	       	<c:forEach items="${list}" var="list">
				<c:if test="${list.status==0 }">
					<a href="javascript:toPending('${list.id}','${list.projectId}','${list.projectOrderId}','${list.rejectReason}','${list.title}','${list.name}')">${list.title}需要审批，申请时间：<fmt:formatDate value="${list.createDate }" pattern="yyyy-MM-dd HH:mm:ss" /></a><br>
				</c:if>
				<c:if test="${list.status==-1 }">
					<a href="javascript:toPending('${list.id}','${list.projectId}','${list.projectOrderId}','${list.rejectReason}','${list.title}','${list.name}')">${list.title}于<fmt:formatDate value="${list.processDate }" pattern="yyyy-MM-dd HH:mm:ss" />被退回，原因：${list.rejectReason}</a><br>
				</c:if>
			</c:forEach>
			
	       	<c:forEach items="${allTables}" var="list">
	       		<c:if test="${list.status==0 }">
					<a style="color: red;" href="javascript:toPending('${list.id}','${list.projectId}','${list.projectOrderId}','${list.rejectReason}','${list.title}','${list.name}')">${list.title}需要审批，申请时间：<fmt:formatDate value="${list.createDate }" pattern="yyyy-MM-dd HH:mm:ss" /></a><br>
				</c:if>
				<c:if test="${list.status==2 }">
					<a style="color: red;" href="javascript:compareAgain('${list.id}','${list.projectOrderId}','${list.projectId}','${list.name}')">${list.title}：数据已修改，提交时间：<fmt:formatDate value="${list.processDate }" pattern="yyyy-MM-dd HH:mm:ss" /></a><br>
				</c:if>
			</c:forEach>
			
			<c:forEach items="${projectList}" var="list">
				<c:if test="${list.status==0 }">
					<c:if test="${list.num>0 }">
						<a href="javascript:contrastSKBConsultation('${list.id}','${list.projectId}','${list.projectUpdateId}','${list.rejectReason}')">${list.name }修改了《${list.title}》项目项目采购控制表,修改时间：<fmt:formatDate value="${list.createDate }" pattern="yyyy-MM-dd HH:mm:ss" /></a><br>
					</c:if>
					<c:if test="${list.num==0 }">
						<a href="javascript:contrastSKB('${list.id}','${list.projectId}','${list.projectUpdateId}','${list.rejectReason}')">${list.name }修改了《${list.title}》项目项目采购控制表,修改时间：<fmt:formatDate value="${list.createDate }" pattern="yyyy-MM-dd HH:mm:ss" /></a><br>
					</c:if>
				</c:if>
				<c:if test="${list.status==-1 }">
					<a href="javascript:contrastSKB('${list.id}','${list.projectId}','${list.projectUpdateId}','${list.rejectReason}')">对《${list.title}》项目项目采购控制表的修改未通过</a><br>
				</c:if>
			</c:forEach>
			
			<c:forEach items="${projectOrderList}" var="list">
				<a href="javascript:edit('${list.id}','${list.projectOrderId}','${list.projectId}','${list.name}')">${list.name}：未通过项目采购控制表审批，审批时间：<fmt:formatDate value="${list.processDate }" pattern="yyyy-MM-dd HH:mm:ss" /></a><br>
			</c:forEach>
			<c:forEach items="${againProjectOrderList}" var="list">
				<a href="javascript:compareAgain('${list.id}','${list.projectOrderId}','${list.projectId}','${list.name}')">${list.title}：数据已修改</a><br>
			</c:forEach>
			<c:forEach items="${taVOList}" var="list">
				<a href="javascript:toCorrectTemporaryAuthority('${list.id}','${list.userName}申请《${list.pageName}》${list.sysResourceName}功能。原因：${list.remark}')">${list.userName}正在申请《${list.pageName}》${list.sysResourceName}功能</a><br>
			</c:forEach>
			<c:forEach items="${approvalList}" var="list">
				<a href="javascript:toApprovalResult('${list.id}','${list.taText}')">${list.taText}</a><br>
			</c:forEach>
			<c:forEach items="${recordList}" var="list">
				<a href="javascript:toApprovalRecord('${list.id}','${list.taText}','${list.opinion}','${list.userName}')">投资人${list.userName}对一次性权限审批的建议</a><br>
			</c:forEach>
			<c:forEach items="${unconfirmedList}" var="list">
				<a href="javascript:toPreview('${list.id}','${list.projectOrderId}','${list.projectId}','${list.title}')">${list.title}未进行确认操作</a><br>
			</c:forEach>
			<c:forEach items="${sfList}" var="list">
				<a href="javascript:toTemporaryBatch('${list.id}','${list.userName}正在对${list.projectName }申请分批设置。原因：${list.title}','${list.userName}')">${list.userName}正在对《${list.projectName }》项目申请分批设置功能，申请时间：<fmt:formatDate value="${list.createDate }" pattern="yyyy-MM-dd HH:mm:ss" /></a><br>
			</c:forEach>
			<c:forEach items="${temporaryBatchList}" var="list">
				<a href="javascript:projectGroup('${list.projectId}','${list.projectName}','${list.id}')">投资人代表同意对《${list.projectName}》项目进行分批设置请求</a><br>
			</c:forEach>
			<c:forEach items="${consultationList}" var="list">
				<a href="javascript:consultation('${list.id}','${list.projectId}','${list.projectUpdateId}')">会商</a><br>
			</c:forEach>
	    </div>
	</div>
	<div class="panel panel-default" style="float:left;margin-left:20px;height:45%;width:96%;font-size:36px;" >
	    <div class="panel-heading" style="height:15%;font-size: 36px;" >
				提醒事项
	    </div>
	    <div class="panel-body" style="overflow-y:auto;height:85%;font-size: 36px;" >
			<c:forEach items="${uploadNoticeList}" var="list">
				<fmt:formatDate value="${list.createDate }" pattern="yyyy-MM-dd HH:mm:ss" />《${list.title}》项目项目采购控制表上传
				<a style="float: right" href="javascript:deleteNotice('${list.id}')">未读</a><br>
			</c:forEach>
			<c:forEach items="${expiryDateList}" var="list">
				距离到期时间还有${list.title}天
				<a style="float: right" href="javascript:deleteNoticeExpire('${list.id}')">未读</a><br>
			</c:forEach>
			<c:forEach items="${delTemporaryBatchList}" var="list">
				投资人代表于<fmt:formatDate value="${list.processDate }" pattern="yyyy-MM-dd HH:mm:ss" />退回了对《${list.projectName}》项目进行分批设置请求
				<a style="float: right" href="javascript:deleteNotice('${list.id}')">未读</a><br>
			</c:forEach>
	    	<c:forEach items="${deleteNoticeList}" var="list">
				${list.title}未通过审批,已被采购员${list.name }删除，操作时间：<fmt:formatDate value="${list.createDate }" pattern="yyyy-MM-dd HH:mm:ss" />
				<a style="float: right" href="javascript:deleteNotice('${list.id}')">未读</a><br>
			</c:forEach>
			<c:forEach items="${aedList}" var="list">
				管理员拒绝了${list.companyName}的延期申请，原因：${list.reason }
				<a style="float: right" href="javascript:deleteApplyExpiryDate('${list.id}')">未读</a><br>
			</c:forEach>
			
	    </div>
	</div>
	<div class="panel panel-default" style="float:left;margin-left:20px;height:50%;width:96%;font-size: 36px;">
	    <div class="panel-heading" style="height:15%;font-size: 36px;" >
			监督事项
	    </div>
	    <div class="panel-body" style="overflow-y:auto;height:85%;font-size: 36px;" >
			<c:forEach items="${sysLogList}" var="list">
				<table style="width:100%;font-size: 28px;">
					<tr style="width:100%;">
						<td style="width:55%;">${list.title}</td>
						<td style="width:25%;"><c:if test="${list.rejectReason != null && list.rejectReason !=''}">原因：${list.rejectReason}</c:if></td>
						<td style="width:20%;"><fmt:formatDate value="${list.createDate}" pattern="yyyy-MM-dd" /></td>
					</tr>
				</table>
				<hr>
			</c:forEach>
	    </div>
	</div>
	<div style="float:left;margin-left:20px;height:2%;width:96%;font-size: 36px;">
	</div>
	<input type="hidden" value="${isBoss }" id="isBoss">
</body>
</html>
