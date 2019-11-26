<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)request.getSession().getAttribute("user");
	Integer companyId = user.getCompanyId();
	String departmentId = request.getParameter("departmentId");
	departmentId = departmentId==null?"-1":departmentId;
	String id = request.getParameter("id");
	id = id==null||id.equals("undefined")?"":id;
	String pageId = request.getParameter("pageId");
	session.setAttribute("pageId", Integer.valueOf(pageId)-1);
	session.setAttribute("parentId", departmentId);
	String divDisplay=request.getParameter("divDisplay");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加编辑员工模态框</title>
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
<script type='text/javascript' src='<%=basePath%>common/js/bootstrap-treeview.js'></script></head>
<script type="text/javascript">
$(function() {
	initUserRole();
	if($("#id").val()!="" && $("#id").val()!=undefined && $("#id").val()!="undefined"){
		findUserById($("#id").val());
		$("#add").css('display','none'); 
		$("#modify").css('display','block');
	}else{
		$("#modify").css('display','none'); 
		$("#add").css('display','block');
	}
	if(<%=divDisplay%>==1){
		$("#div1").css({"display":"none"});
		$("#div3").css({"display":"none"});
		$("#div2").css({"display":"block"});
		}else if(<%=divDisplay%>==2){
		$("#div2").css({"display":"none"});
		$("#div3").css({"display":"none"});
		$("#div1").css({"display":"block"});
	}else if(<%=divDisplay%>==null){
		$("#div1").css({"display":"none"});
		$("#div2").css({"display":"none"});
		$("#div3").css({"display":"block"});
	}
})
 function add() {
	var isValid = 0;
	var userName =  $("#userName").val();
	var chare =  $("#chare").val();
	var roleId =  $("#sysRoleId").val();
// 	var loginType= $("#loginType").val();
// 	if(loginType==null){
// 		alert("选择:手机号/邮箱");
// 		return;	
// 	}
	if(userName!=null&&userName!=""){
		isValid = 1;
	}else{
		alert("请填写员工姓名");
		isValid = 2;
		return;
	}
	if(roleId!=null&&roleId!="" ||<%=divDisplay%>==1){
		isValid = 1;
	}else{
		alert("请选择员工职务");
		isValid = 2;
		return;
	}
	var myregEmail = /^([\.a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/;
	var myregPhone=/^[1][3,4,5,7,8][0-9]{9}$/;
	 if(myregPhone.test(chare)){
		 var loginType= $("#loginType").val(1);
		 if(chare!=null&&chare!=""){
				isValid = 1;
			}else{
				alert("请填写员工手机号");
				isValid = 2;
				return;
			}
			if(isValid == 1){
				$.post(
						"<%=basePath%>user/add.action",
						$("#person").serialize(),
						function (person) {
							if(person==1){	//判断id是否有值，有值的话就是修改 为空就是添加
								if($("#id").val()==null || $("#id").val()=="" || $("#id").val()==undefined || $("#id").val()=="undefined"){
									alert("添加成功！邀请链接已发至手机号，请点击手机短信内链接登录");
									sendPhone();
								}else{
									alert("操作成功")																																	
								}
								window.location.href="<%=basePath%>main.jsp";
							}else if(person==-1){
								alert("手机号重复！");
							}else{
								alert("添加失败！")
								return;
							}
						}
					)
				} 
	}else if(myregEmail.test(chare)){
		 var loginType= $("#loginType").val(2);
		if(chare!=null&&chare!=""){
			isValid = 1;
		}else{
			alert("请填写员工邮箱");
			isValid = 2;
			return;
		}
		if(isValid == 1){
			$.post(
					"<%=basePath%>user/add.action",
					$("#person").serialize(),
					function (person) {
						if(person==1){	//判断id是否有值，有值的话就是修改 为空就是添加
							if($("#id").val()==null || $("#id").val()=="" || $("#id").val()==undefined || $("#id").val()=="undefined"){
								alert("添加成功！邀请链接已发至新用户邮箱，请点击邮箱内链接登录");
								sendMail();
							}else{
								alert("操作成功")
							}
							window.location.href="<%=basePath%>main.jsp";
						}else if(person==-1){
							alert("邮箱重复！");
						}else{
							alert("添加失败！")
							return;
						}
					}
				)
			}
	}else if(!myregEmail.test(chare) || !myregPhone.test(chare)){
			alert("×请输入有效的手机号/邮箱！");
			return false;
		}
	
	}
	
	function sendMail(){
		$.post(
			"<%=basePath%>user/newUserSendEmail.action",
			{"chare":$("#chare").val()}
		)
	}
	function sendPhone(){
		$.post(
			"<%=basePath%>user/sendPhone.action",
			{"chare":$("#chare").val(),
			"companyId":<%=companyId%>}
		)
	}
	function initUserRole(){
		$.ajax({
			dataType : "json",
			type : "post",
			async: false,//同步
			url : "<%=basePath%>sysRole/findMyCompanyRole.action?companyId="+<%=companyId%>,
			success : function(data) {
				var html = '';
				for(var i=0;i<data.length;i++){
					html +='<option value="'+data[i].id+'">'+data[i].name+'</option>'
				}
				$("#sysRoleId").append(html);
			}
		});
	}
	function findUserById(id){
		$.ajax({
			dataType : "json",
			type : "post",
			url : "<%=basePath%>user/findUserById.action?id="+id,
			success : function(data) {
				initUser(data);
			}
		});
	}
	
	function initUser(obj){
		$("#companyId").val(obj.companyId);
		$("#departmentId").val(obj.departmentId);
		$("#userName").val(obj.userName);
		$("#loginType").val(obj.loginType);
		$("#sysRoleId").val(obj.sysRoleId);
		if(obj.email !=null){
			$("#loginType").val(2);
		}else{
			$("#loginType").val(1);
		}
		if(obj.phone !=null){
			$("#chare").val(obj.phone);
		}else {
			$("#chare").val(obj.email);
		}
	}
	//关闭模态框
	function closeDlg(){
		closeModal();
	};
</script>
<body>
	<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header"  style="display: none" id="add">
					<h4 class="modal-title" id="myModalLabel">添加员工</h4>
					<div class="alert alert-danger alert-dismissable" >
						<button type="button" class="close" data-dismiss="alert"
							aria-hidden="true">
							&times;
						</button>
						<p>人员注册说明：</p>
						<p>一、资金层:投资人是企业资本的提供者。注册数，股东人数。</p>
						<p>二、企业管理层:投资人代表；公司成本主管；公司财务主管，注册人数3个。</p>
						<p>三、工程项目管理层：项目经理；材料员，注册人数为：项目数*2</p>
						<p>具体人员说明：</p>
						<p>投资人：即股东，投资人行使监督权，监督公司管理层把自己的投资管好用好，保证资金安全，并产生较大收益。建议按照公司章程添加投资人。</p>
					  	<p>投资人代表：投资人代表是代表投资人利益的是对企业进行管理的，是企业管理的核心，需要注册。</p>
					  	<p>成本控制人：是对投资人代表负责，直接控制企业成本的，需要注册。</p>
					  	<p>财务主管：智能审批完成是付款的必要条件，财务主管需要注册。</p>
					 	<p>项目经理：是每个工程项目的负责人，完成项目实施者，需要注册。</p>
					  	<p>材料员：是项目部材料供应的负责人，是工程项目实际采购的负责人之一，需要注册。</p>
					</div>
				</div>
				<div class="modal-header"  style="display: none" id="modify">
					<h4 class="modal-title" id="myModalLabel">编辑员工</h4>
				</div>
				<div class="container">
					<form class="form-horizontal" id="person" method="post">
						<input type="hidden" name="companyId" id="companyId" value="<%=companyId%>" />
	        			<input type="hidden" name="departmentId" id="departmentId" value="<%=departmentId%>" />
	        			<input type="hidden" name="id" id="id" value="<%=id%>">
						<div class="form-group">
							<label class="col-md-2 control-label">员工姓名：</label>
							<div class="col-md-3 ">
								<input type="text" class="form-control" name="userName" id="userName" placeholder="员工姓名" autocomplete="off">
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 control-label">手机号/邮箱：</label>
							<div class="col-md-3 ">
								<input type="hidden" id="loginType" name="loginType">
								<input type="text" class="form-control" name="chare" id="chare" autocomplete="off">
							</div>
						</div>
						<div id="div3">
						<div class="form-group">
							<label class="col-md-2 control-label">职务：</label>
							<div class="col-md-3 ">
								<select class="form-control" name="sysRoleId" id="sysRoleId">
		            				<option value="">==请选择==</option>
		          				</select>
							</div>
						</div>
						</div>
						<div id="div1">
						<div class="form-group">
							<label class="col-md-2 control-label">职务：</label>
							<div class="col-md-3 ">
								<select class="form-control" name="sysRoleId" id="sysRoleId">
		            				<option value="">==请选择==</option>
		          				</select>
							</div>
						</div>
						</div>
						<div id="div2">
						<div class="form-group">
							<label class="col-md-2 control-label">职务：</label>
							<div class="col-md-3 ">
								<select style="background-color: #EEEEEE;" disabled="disabled" class="form-control" name="sysRoleId" id="sysRoleId">
		          					<option value="">投资人代表</option>
		          				</select>
							</div>
						</div>
						</div>
						<div class="modal-footer col-md-6">
							<button type="button" class="btn btn-default" onclick="closeDlg()">关闭</button>
							<button type="button" onclick="add()" class="btn btn-primary">保存</button>
						</div>
					</form>
				</div>
			</div>
		</div>
</body>
</html>