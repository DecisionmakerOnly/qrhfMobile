<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	User user = (User)request.getSession().getAttribute("user");
	Integer id=user.getId();
	String userName=user.getUserName();
	String password=user.getPassword();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>智能绩效</title>
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
	window.onload = function (){//解决iframe在非IE、firefox浏览器下（如edge、chrome浏览器）重复刷新的问题
		var iframe = document.createElement('iframe');
		iframe.id="mainFrame";
		iframe.width="100%";
		iframe.frameborder="0";
		iframe.scrolling="no";
		iframe.style.border="0px";
		iframe.setAttribute('frameborder', '0', 0);
		iframe.onload = function(){
			iframe.onload = null;
		};
		document.getElementById("col-md-10").appendChild(iframe);
		home();
	}
	function home(){
		$("#mainFrame").attr('src',"<%=basePath%>performance/home.jsp");
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
	 //修改密码
    function upPass(){
    	var p=$("#oldPass").val();
    	var n=$("#newPass").val();
    	var ids=$("#id").val();
    	if(p!=n){
    		if($("#myform").data('bootstrapValidator').validate().isValid()){
        		$.ajax({
        			url:'admin/uPass.action',
        			dataType:'json',
        			type:'post',
        			data:{
        				id:ids,
        				password:n
        			},
        			success:function(data){
        				if(data>0){
        					alert("密码修改成功，请重新登陆！");
        					location.href="<%=basePath%>admin/login.jsp";
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
    function quit(){
    	if(confirm('您确定要退出登录吗？')){
      		location.href = "<%=basePath%>/user/clearSession"; 
		} else {
			return false;
		}
    }
  	function superior(){
    	location.href="<%=basePath%>daohang.jsp";
    }
</script>
<body>
<div style="height:100%;width:100%">
		<div id="daohang" class="header">
		<div class="container">
			<div>
				<nav class="navbar navbar-default">
				<div class="container-fluid">
					<div class="collapse navbar-collapse"
						id="bs-example-navbar-collapse-1">
						<ul class="nav navbar-nav cl-effect-16">
							<li class="dropdown" style="margin: 0px 10px">
								<a href="javascript:void(0);" onclick="" class="dropdown" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">首页</a>
							</li>
							<li class="dropdown" style="margin: 0px 10px">
								<a href="javascript:void(0);"  class="dropdown" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">正在开发，敬请期待</a>
							</li>
							<li class="dropdown" style="margin: 0px 10px">
								<a href="javascript:void(0);"  class="dropdown" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">正在开发，敬请期待</a>
							</li>
						<ul class="nav navbar-nav navbar-right">
							<li class="dropdown" style="margin: 0px 20px">
								<a href="javascript:exit(0)" role="button" id="welcom" style="">欢迎您：<%=userName%></a>
								<ul class="dropdown-menu">
									<li>
										<a onclick="openPassDlg()" role="button" ><i class="fa fa-sign-out"></i> <span class="nav-label">修改密码</span> </a>
									</li>
									<li>
										<a onclick="quit()" role="button" ><i class="fa fa-sign-out"></i> <span class="nav-label">退出登录</span> </a>
									</li>
								</ul>
							</li>
							<li class="dropdown" style="margin: 0px 20px"><a onclick="superior()" role="button"><i class="fa fa-sign-out"></i> <span class="nav-label">返回主页</span> </a></li>
						</ul>
						</ul>
					</div>
				</div>
				</nav>
			</div>
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
							<input type="hidden" id="password" value="<%=password%>"name="password"> 
							<input type="hidden" id="id"value="<%=id%>" name="id">
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
<div style="width:100%;float:left;padding:0;overflow:auto;margin-top: -8px;" id="col-md-10"></div>
</div>
</body>
</html>