<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)request.getSession().getAttribute("user");
	Integer id=user.getId();
	String userName=user.getUserName();
	String loginName=user.getUserName();
	String password=user.getPassword();
	String pageId=""+session.getAttribute("pageId");
	String parentId=""+session.getAttribute("parentId");
	String companyName=user.getCompanyName();
	Integer sysRoleId = user.getSysRoleId();
	
	
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
<title>zdcigo</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link type="text/css"  rel="stylesheet" href="<%=basePath%>common/css/leftNav.css">
<link type="text/css"  rel="stylesheet" href="<%=basePath%>common/css/bootstrap.css">
<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
<script type='text/javascript' src='<%=basePath%>common/js/base.js'></script>
<script type="text/javascript" src="<%=basePath%>/common/js/bootstrapValidator.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script><style type="text/css">
.containerbody{
	margin: 0;
	padding:0;
	width:100%;
	height:100%;
	overflow: hidden;
}
.containerbody .menubox{
	padding:0;
	width:200px;
	min-width:200px;
	height:93%;
	position: absolute; 
	top:14px;
	left:0;
	z-index:98;
}
.containerbody .menuboxmin{
	width:40px;
	min-width:40px;
}
.containerbody .menuboxmin .leftNav ul li{
  	height:40px;
  	overflow: hidden;
}
.containerbody .menubox2{
	padding:0;
	width:97%;
	min-width:200px;
	height:93%;
	position: absolute; 
	top:52px;
	left:41px;
	z-index:2;
	overflow: auto;
}
.navbarMin{
	width:100%;
	height:52px;
	z-index:99;
}
.div-bj{
	background:url("<%=basePath%>/common/images/beijing.png") no-repeat 0px 0px;
}
</style>
<script type="text/javascript">
	$(function(){
		$("#menubox").mouseover(function(){
			$(this).removeClass("menuboxmin");
		})
		$("#menubox").mouseout(function(){
			$(this).addClass("menuboxmin");
		})
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
			jump("sysMain/homePage.action");
			findButtons();
			findLeftNavSysResource();
			selectPasswrod();
		}
	})
	function menuBar(str){
		$("#mainFrame").attr('src',str);
	}
	function findButtons(){
		$.ajax({
			dataType : "json",
			type : "post",
			url : "<%=basePath%>user/resourceLogin.action?id="+<%=id%>,
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
	function initButtons(objList){
		var html = '';
		for(var i=0;i<objList.length;i++){
			if(<%=flag%>){
				html ='<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" onclick="menuBar(\''+objList[i].method+'?pageId='+objList[i].id+'\')" role="button"><span>'+objList[i].name+'</span></a><ul class="dropdown-menu" id="pid'+objList[i].id+'"></ul><input type="hidden" id="pageId'+objList[i].id+'" value="'+objList[i].method+'?pageId='+objList[i].id+'"/></li>';
			}else{
				html ='<li class="dropdown"><a href ="javascript:void(0);" role="button"><span>'+objList[i].name+'</span></a></li>';
			}
			$("#pid"+objList[i].sysResource).html($("#pid"+objList[i].sysResource).html()+html);
		}
		$("ul[id*=pid]").each(function(){
			if($(this).find("li").length<=0){
				$(this).remove();
			}
		})
	}
	function findLeftNavSysResource(){
		$.ajax({
			dataType : "json",
			type : "post",
			async : false,
			url : "/sysResource/findLeftNavSysResource.action?sysRoleId=<%=sysRoleId%>",
			success : function(data) {
				initLeftNav(data);
			}
		});
	}
	function initLeftNav(data){
		var html = '';
		for(var i=0;i<data.length;i++){
			html += '<li>';
			html += '<a href="javascript:;" onclick="jump(\''+data[i].method+'\')"> ';
			html += '<span class="glyphicon glyphicon-chevron-down">&nbsp;</span>';
			html += ''+data[i].name+'';
			html += '</a>';
			html += '</li>';
		}
		html +='<div class="fixed">';
		html +='<div align="center">';
		html +='<a style="text-decoration:none; color: white;" href="javascript:void(0);" onclick="qq();" >';
		html +='<img src="<%=basePath%>common/images/qq.png" width="40" height="40" title="分享到QQ，分享就有收获😀" alt="分享到QQ，分享就有收获😀"/>';
		html +='</a>';
		html +='&nbsp;&nbsp;&nbsp;&nbsp;';
		html +='<a style="text-decoration:none; color: white;" href="javascript:void(0);" onclick="weixin();" >';
		html +='<img src="<%=basePath%>common/images/wx.png" width="40" height="40" title="分享到微信，分享就有收获😀" alt="分享到微信，分享就有收获😀"/>';
		html +='</a>';
		html +='&nbsp;&nbsp;&nbsp;&nbsp;';
		html +='<a style="text-decoration:none; color: white;" href="javascript:void(0);" onclick="sinaWeiBo();" >';
		html +='<img src="<%=basePath%>common/images/wb.png" width="40" height="40" title="分享到微博，分享就有收获😀" alt="分享到微博，分享就有收获😀"/>';
		html +='</a>';
		html +='</div>';
		html +='</div>';
		$("#leftNav").html($("#leftNav").html()+html);
	}
	function jump(url){
		if(url != undefined ){
			$("#mainFrame").attr('src',"<%=basePath%>"+url);
		}else {
			if(confirm('您确定要退出登录吗？')){
	      		location.href = "<%=basePath%>/user/clearSession"; 
			} else {
				return false;
			}
		}
	}
	function quit(){
     	if(confirm('您确定要退出登录吗？')){
      		location.href = "<%=basePath%>/user/clearSession"; 
		} else {
			return false;
		}
	}
	//新用户登陆添加密码
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
	//修改密码
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
	function superior(){
		location.href="<%=basePath%>a/daohang.jsp";
	}
   //分享
   function qq(title,url,pic){
	    var p = {
	        url: 'http://www.zdcigo.com/user/register.jsp?shareCode=<%=loginName%>',/*获取URL，可加上来自分享到QQ标识，方便统计*/
	        title : '好消息！好消息！！人工智能系统替您控制材料的采购和使用，太神奇了！快用吧！！',/*分享标题(可选)*/
	        desc:'',
	        summary : title,/*分享描述(可选)*/
	        pics : pic,/*分享图片(可选)*/
	        flash : '', /*视频地址(可选)*/
	        //commonClient : true, /*客户端嵌入标志*/
	        site: '北京'/*分享来源 (可选) ，如：QQ分享*/
	    };
	    var s = [];
	    for (var i in p) {
	        s.push(i + '=' + encodeURIComponent(p[i] || ''));
	    }
	    var target_url = "http://connect.qq.com/widget/shareqq/iframe_index.html?" + s.join('&') ;
	    window.open(target_url, 'qq','height=520, width=720');
	}
   function sinaWeiBo(title,url,pic){
	        var param = {
		             url:'http://www.zdcigo.com/user/register.jsp?shareCode=<%=loginName%>',
		            type:'3',
		            count:'1', /** 是否显示分享数，1显示(可选)*/
		            appkey:'北京', /** 您申请的应用appkey,显示分享来源(可选)*/
		            title:'好消息！好消息！！人工智能系统替您控制材料的采购和使用，太神奇了！快用吧！！', /** 分享的文字内容(可选，默认为所在页面的title)*/
		            rnd:new Date().valueOf()
	       	 }
	        var temp = [];
	        for( var p in param ){
	            temp.push(p + '=' +encodeURIComponent( param[p ] || '' ) )
	        }
	        var target_url = "http://service.weibo.com/share/share.php?"+temp.join('&');
	        window.open(target_url, 'sinaweibo', 'height=430, width=400');
	}
	function weixin(){
       var target_url ="http://qr.liantu.com/api.php?text=http://www.zdcigo.com/user/register.jsp?shareCode=<%=loginName%>";
       window.open('<%=basePath%>weixin.jsp','sinaweixin','height=630, width=900');
	}
</script>
</head>
<body style="overflow: hidden;">
	<div class="containerbody">
		<div style="width:100%;height:5%;">
			<nav class="div-bj navbar navbar-inverse navbarMin navbarMax" role="navigation" id="navbar">
			    <div class="container-fluid">
				    <div class="navbar-header">
				        <a class="navbar-brand" href="javascript:;">zdcigo</a>
				    </div>
				    <div>
				    	<ul class="nav navbar-nav" id="pid-1"></ul>
				        <ul class="nav navbar-nav">
				            <li class="dropdown">
				            	<a href="#" class="dropdown-toggle" data-toggle="dropdown">欢迎您：<%=userName%><b class="caret"></b></a>
				            	<ul class="dropdown-menu">
				                    <li><a onclick="jump('feedback/feedback.jsp')" role="button" href="javascript:;">意见反馈</a></li>
				                    <li><a onclick="openPassDlg();" role="button" href="javascript:;">修改密码</a></li>
				                    <li><a onclick="jump();" role="button" href="javascript:;">退出登录</a></li>
				                </ul>
				            </li>
				            <li><a href="javascript:;" onclick="superior();" role="button">返回主页</a></li>
				        </ul>
				    </div>
			    </div>
			</nav>
		</div>
	
        <div class="menubox menuboxmin" id="menubox">
			<div class='leftNav'>
				<ul id="leftNav">
					<li><a href='javascript:;' title=''><span class='glyphicon glyphicon-th'></span><%=companyName%></a></li>
				</ul>
			</div>
		</div>
		
		<div class="menubox2">
			<div style="width:100%;float:left;padding:0;overflow:auto;margin-top: -8px;" id="col-md-10"></div>
		</div>
    </div>
    
<!-- 模态框（Modal） -->
<!-- 修改密码 -->
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
</body>
</html>
