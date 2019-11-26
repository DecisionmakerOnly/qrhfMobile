<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.SysAdmin"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	SysAdmin admin = (SysAdmin)request.getSession().getAttribute("admin");
	String loginName=null;
	String userName=null;
	Integer id=null;
	String password=null;
	if(admin != null){
		loginName=admin.getLoginName();
		userName=admin.getUserName();
		id=admin.getId();
		password=admin.getPassword();
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>管理员</title>
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
$(function () { 
	if(<%=loginName%> ==null){
		location.href="<%=basePath%>admin/login.jsp";
	}
	});
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
		paymentOrder();
	}
	function paymentOrder(){
		$("#mainFrame").attr('src',"<%=basePath%>admin/paymentOrder.jsp");
	}
	function sharePage(){
		$("#mainFrame").attr('src',"<%=basePath%>admin/sharePage.jsp");
	}
	function promotionRecord(){
		$("#mainFrame").attr('src',"<%=basePath%>admin/promotionRecord.jsp");
	}
	function feedback(){
		$("#mainFrame").attr('src',"<%=basePath%>admin/feedback.jsp");	
	}
	function userExpirationDate(){
		$("#mainFrame").attr('src',"<%=basePath%>admin/userExpirationDate.jsp");	
	}
	function companyInformation(){
		$("#mainFrame").attr('src',"<%=basePath%>admin/companyInformation.jsp");	
	}
	function applyExpiryDate(){
		$("#mainFrame").attr('src',"<%=basePath%>admin/applyExpiryDate.jsp");	
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
    	location.href="<%=basePath%>admin/clearSession";
    }
//     function notice(){
<%--     	$("#mainFrame").attr('src',"<%=basePath%>admin/notice.jsp");	 --%>
//     }
</script>
<body>
<nav class="navbar navbar-inverse" role="navigation">
	<div class="container-fluid">
    <div class="navbar-header">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;	
    </div>
    <div>
        <ul class="nav navbar-nav">
            <li class="active">
            	<a href="javascript:void(0);" onclick="paymentOrder();" class="dropdown" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">订单管理</a>
            </li>
            <li class="active">
            	<a href="javascript:void(0);" onclick="sharePage();" class="dropdown" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">推广管理</a>
            </li>
            <li class="active">
            	<a href="javascript:void(0);" onclick="promotionRecord();" class="dropdown" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">提现管理</a>
            </li>
            <li class="active">
            	<a href="javascript:void(0);" onclick="feedback();" class="dropdown" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">意见管理</a>
            </li>
            <li class="active">
            <a href="javascript:void(0);" onclick="userExpirationDate();" class="dropdown" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">用户到期日期</a>
            </li>
            <li class="active">
            <a href="javascript:void(0);" onclick="companyInformation();" class="dropdown" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">企业信息</a>
            </li>
            <li class="active">
            	<a href="javascript:void(0);" onclick="applyExpiryDate();" class="dropdown" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">企业延期</a>
            </li>   
<!--             <li class="active"> -->
<!--             	<a href="javascript:void(0);" onclick="notice();" class="dropdown" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">系统公告</a> -->
<!--             </li>    -->
            <li class="active dropdown">
                <a  href="javascript:exit(0)" role="button" id="welcom" class="dropdown-toggle" data-toggle="dropdown">欢迎您：<%=userName%> <b class="caret"></b></a>
                <ul class="dropdown-menu">
                    <li><a href="javascript:void(0);" onclick="openPassDlg()">修改密码</a></li>
                    <li><a href="javascript:void(0);" onclick="quit()" >退出登录</a></li>
                </ul>
            </li>
        </ul>
    </div>
	</div>
</nav>
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
</body>
</html>