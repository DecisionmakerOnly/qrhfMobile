<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	User user = (User)request.getSession().getAttribute("user");
	Integer id=user.getId();
	String code = user.getRoleCode();
	String userName=user.getUserName();
	String password=user.getPassword();
	String pageId=""+session.getAttribute("pageId");
	String parentId=""+session.getAttribute("parentId");
	
	
	Date expiryDate = user.getExpiryDate();
	Calendar c = Calendar.getInstance(); 
    c.setTime(expiryDate); 
    c.add(Calendar.DAY_OF_MONTH,+1); 
    Date time = c.getTime();
	
	Boolean flag = new Date().before(time);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>导航</title>
<link href="<%=basePath%>/common/css/bootstrap.css" rel="stylesheet">
<link href="<%=basePath%>/common/css/style2.css" rel="stylesheet" type="text/css" media="all" />
<script src="<%=basePath%>/common/js/jquery-3.2.1.min.js"></script>
<script src="<%=basePath%>/common/js/bootstrap.js"></script>
<script type="text/javascript" src="<%=basePath%>/common/js/bootstrapValidator.js"></script>
<script type='text/javascript' src='<%=basePath%>common/js/base.js'></script>
<style type="text/css">
.navbar .nav>li .dropdown-menu {
	margin: 0;
}

.navbar .nav>li:hover .dropdown-menu {
	display: block;
}
 .modal {
     position: fixed;  
    top: 10%;
    left: 30%;
    width: 800px;
    height: 800px;
     margin: 100px 100 0 0px;/* margin 负值为宽高的一半 */ */
} 
</style>
<script type="text/javascript">
	var pageId= <%=pageId%>;
	var parentId = <%=parentId%>;
	window.onload = function (){//解决iframe在非IE、firefox浏览器下（如edge、chrome浏览器）重复刷新的问题
		var yScroll = (window.parent.document.documentElement.scrollHeight >window.parent.document.documentElement.clientHeight) ? window.parent.document.documentElement.scrollHeight : window.parent.document.documentElement.clientHeight; 
		var iframe = document.createElement('iframe');
		iframe.id="mainFrame";
		iframe.width="100%";
		iframe.height=yScroll -60
		iframe.frameborder="0";
		iframe.scrolling="no";
		iframe.style.border="0px";
		iframe.setAttribute('frameborder', '0', 0);
		iframe.onload = function(){
			iframe.onload = null;
		};
		document.getElementById("col-md-10").appendChild(iframe);
		selectPasswrod();
		findButtons();
		toHomePage();
	}
	function selectPasswrod() {
		$.post(
			"<%=basePath%>/user/selectPasswrod.action?id="+<%=id%>,
			function(data){
				if(data.i==0){
					openModal("<%=basePath%>/user/stafflogin.jsp");
				}
			}
		);
	} 
	
	function toHomePage(){
<%-- 		$("#mainFrame").attr('src',"<%=basePath%>sysMain/homePage.action"); --%>
		$("#mainFrame").attr('src',"<%=basePath%>leftNav.jsp");
	}
	
	function toProjectList() {
		$("#mainFrame").attr('src',"<%=basePath%>/user/projectList.action?id="+<%=id %>);
	}
	function menuBar(str){
		$("#mainFrame").attr('src',str);
	}
	function quit(){
     	if(confirm('您确定要退出登录吗？')){
      		location.href = "<%=basePath%>/user/clearSession"; 
     		 <%-- parent.top.location.href = "<%=basePath%>daohang.jsp";  --%>
		} else {
			return false;
		}
	}
	//打开模态框
	function openPassDlg() {
		$("#passDlg").modal('show');
	}
	//关闭模态框
	function closeDlgs() {
		$("#passDlg").modal('hide');
		$('#oldPass').val("");
		$('#newPass').val("");
		$('#againPass').val("");
		// Modal验证销毁重构，防止第二次打开modal时显示上一次的验证痕迹
		$('#myform').data('bootstrapValidator', null);
		formValidator();
	}
	function feedback(){
		$("#mainFrame").attr('src',"<%=basePath%>feedback/feedback.jsp");
	}
	 //修改密码
    function upPass(){
    	var p=$("#oldPass").val();
    	var n=$("#newPass").val();
    	var ids=$("#id").val();
    	if(p!=n){
    		if($("#myform").data('bootstrapValidator').validate().isValid()){
        		$.ajax({
        			url:'user/uPass.action',
        			dataType:'json',
        			type:'post',
        			data:{
        				id:ids,
        				password:n
        			},
        			success:function(data){
        				if(data>0){
        					alert("密码修改成功，请重新登陆！");
        					location.href = "<%=basePath%>/user/clearSession"; 
        				}else{
        					alert("密码修改失败");
        				}
        			},
        			error:function(){ 
        				alert("请求失败");
        			}
        		});
        	}else{
        		return false;
        	}
    	}else if(p==""||n==""){
    		alert("请输入密码");
    	}
    	else{
    		alert("新密码不能与原密码一样");
    	}
    }
    
    $(function(){
    	formValidator();
    });
    
    function formValidator(){
    	$("#myform").bootstrapValidator({
    		fields:{
    			id:{
    				notEmpty:{
    					message:'不能为空'
    				}
    			},
    			password:{
    				notEmpty:{
    					message:'不能为空'
    				}
    			},
    			oldPass:{
    				validators:{
    					notEmpty:{
    						message:'密码不能为空'
    					},
    					regexp: {
		                        regexp: /^(?![^a-zA-Z]+$)(?!\D+$)/,
		                        message: '密码必须为6-18位字母、数字!'
    					},
    					identical:{
    						field:'password',
    						message:'输入旧密码有误'
    					}
    				}
    			},
    			newPass:{
    				validators:{
    					notEmpty:{
    						messgae:'密码不能为空',
    					},
    					regexp: {
	                        regexp: /^(?![^a-zA-Z]+$)(?!\D+$)/,
	                        message: '密码必须为6-18位字母、数字!'
						},
    				}
    			},
    			againPass:{
    				validators:{
    					notEmpty:{
    						message:'密码不能为空'
    					},
    					identical:{
    						field:"newPass",
    						message:'两次输入密码不一致'
    					}
    				}
    			}
    		}
    	});
    }
    
    function findButtons(){
		$.ajax({
			dataType : "json",
			type : "post",
			url : "<%=basePath%>user/resourceLogin.action?id=<%=id%>&code=<%=code%>",
			success : function(data) {
				initButtons(data);
				if("<%=pageId%>"!=null && "<%=pageId%>"!="null" && "<%=pageId%>"!=undefined && "<%=pageId%>"!="undefined"){
					if($("#pageId<%=pageId%>").val()==undefined &&  $("#pageId<%=pageId%>").val()==null){
						var str = department/tree.jsp+"&parentId="+<%=parentId%>;
						 menuBar(str)
					}					
					var str = $("#pageId<%=pageId%>").val()+"&parentId="+<%=parentId%>;
					menuBar(str)
				}
			}
		});
	}
	function superior(){
		location.href="<%=basePath%>daohang.jsp";
	}
	function initButtons(objList){
		var html = '';
		for(var i=0;i<objList.length;i++){
			if(<%=flag%>){
				html ='<li><a onclick="menuBar(\''+objList[i].method+'?pageId='+objList[i].id+'\')" role="button"><span>'+objList[i].name+'</span></a><ul class="dropdown-menu" id="pid'+objList[i].id+'"></ul><input type="hidden" id="pageId'+objList[i].id+'" value="'+objList[i].method+'?pageId='+objList[i].id+'"/></li>';
			}else{
				html ='<li class="disabled"><a href ="javascript:void(0);" role="button"><span>'+objList[i].name+'</span></a></li>';
			}
			$("#pid"+objList[i].sysResource).html($("#pid"+objList[i].sysResource).html()+html);
		}
		$("ul[id*=pid]").each(function(){
			if($(this).find("li").length<=0){
				$(this).remove();
			}
		})
	}
 </script>
</head>
<body id="listBody">
	<div style="height:100%;width:100%">
		<div id="daohang" class="header">
			<div class="container">
				<nav class="navbar navbar-default">
					<div class="container-fluid">
						<ul class="nav navbar-nav cl-effect-16" id="pid-1"></ul>
						<ul class="nav navbar-nav">
							<li class="dropdown" style="margin: 0px 140px">
								<a href="javascript:exit(0)" role="button">欢迎您：<%=userName %></a>
								<ul class="dropdown-menu">
									<li>
										<a onclick="feedback()" role="button" ><i class="fa fa-sign-out"></i> <span class="nav-label">意见反馈</span> </a>
										<a onclick="openPassDlg()" role="button" ><i class="fa fa-sign-out"></i> <span class="nav-label">修改密码</span> </a>
										<a onclick="quit()" role="button" ><i class="fa fa-sign-out"></i> <span class="nav-label">退出登录</span> </a>
									</li>
								</ul>
							</li>
						 </ul>
						 <ul class="nav navbar-nav">
						 <li class="dropdown" style="margin: 0px -140px"><a onclick="superior()" role="button"><i class="fa fa-sign-out"></i> <span class="nav-label">返回主页</span> </a></li>
						 </ul>
					</div>
				</nav>
			</div>
		</div>
		<!-- 模态框（Modal） -->
		<!-- 修改 -->
		<div id="passDlg" class="modal fade"  tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" id="myModalLabel">修改密码</h4>
					</div>
					<div class="container">
						<form class="form-horizontal" id="myform" method="post">
							<div class="form-group">
								<label class="col-md-2 control-label">旧密码：</label>
								<div class="col-md-3 ">
									<input type="password" id="oldPass" name="oldPass" class="form-control form-control-static" placeholder="请输入原始密码">
									<input type="hidden" id="password" value="<%=password %>"
										name="password"> <input type="hidden" id="id"
										value="<%=id %>" name="id">
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">新密码：</label>
								<div class="col-md-3 ">
									<input type="password" id="newPass" name="newPass"
										class="form-control form-control-static" placeholder="请输入新密码">
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">确认密码：</label>
								<div class="col-md-3">
									<input type="password" id="againPass" name="againPass"
										class="form-control form-control-static" placeholder="请输入新密码">
								</div>
							</div>
							<div class="modal-footer col-md-6">
								<input type="reset" name="reset" style="display: none;" />
								<button type="button" class="btn btn-default"
									onclick="closeDlgs()">关闭</button>
								<button type="button" onclick="upPass()" class="btn btn-primary">修改</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div style="width: 100%;float: left; padding: 0; overflow: auto;" id="col-md-10"></div>
	</div>
</body>
</html>