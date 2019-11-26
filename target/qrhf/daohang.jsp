<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)request.getSession().getAttribute("user");
	String loginIdentification = request.getParameter("loginIdentification");
	Integer userId=null;
	String userName=null;
	String loginName=null;
	Integer companyId=null;
	if(user != null){
		userId = user.getId();
		companyId=user.getCompanyId();
		userName=user.getUserName();
		loginName=user.getLoginName();
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>导航栏</title>
<link href="<%=basePath%>/common/css/kefu.css" rel="stylesheet" type="text/css" media="all" />
<link href="<%=basePath%>/common/css/daohang.css" rel="stylesheet" type="text/css" media="all" />
<link href="<%=basePath%>/common/css/bootstrap.css" rel="stylesheet" type="text/css" media="all">
<link href="<%=basePath%>/common/css/style2.css" rel="stylesheet" type="text/css" media="all" />
<script src="<%=basePath%>/common/js/jquery-3.2.1.min.js"></script>
<script src="<%=basePath%>/common/js/bootstrap.js"></script>
<style type="text/css">
.img_close{
	position: absolute;
	right: 100px; 
	top: 5px; 
	background: url("../images/img.gif-v=1.gif")
}
.img_tel{
	position: absolute;
	left:0.6px;
  	top:0.6px;
}
.black_overlay{ 
    display: none; 
    top: 0%; 
    left: 0%; 
    width: 100%; 
    height: 1400px; 
    background-color:transparent; 
    z-index:1001; 
    -moz-opacity: 0.8; 
    opacity:.80; 
    filter: alpha(opacity=80); 
    position: absolute; 
} 
.white_content {
    display: none; 
    position: absolute; 
    top: 5%; 
    left: 25%; 
  	width: 1000px;  
    height: 900px; 
    padding: 20px; 
    z-index:1002; 
} 
.fixedHome{
    position:fixed;
    top:160px;
  	left:8px;
  	bottom:0px;
    width:65px; 
    height:160px; 
    }
.fixed{
	margin-top:990px;
	width:100%;
	height:50px;
 	border-top:1px solid #F0F0F0; 
	text-align: center;
	font-size:12px;
	line-height: 28px;
	color:black;
	position: absolute; 
	} 
.fixed span{
	display:inline-block;
 	margin-top:10px;
}
a.hover-red{
	color:black;
	text-decoration:none;
	font-size:14px;
	}
/* a.hover-red:hover{ */
/* 	color:red; */
/* 	} */
</style>
<script type="text/javascript">
$(function(){
	try{
		    if (/Android|webOS|iPhone|iPod|BlackBerry/i.test(navigator.userAgent)) {
			    window.location.href="http://47.95.236.175:8082/";
		    }else{
		    }
		}catch(e){
		}
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
		toWeThink();
		menu();
	}
	function toWeThink() {
		$("#mainFrame").attr('src',"<%=basePath%>we/wethink.jsp");
	}
	
	$(function(){
		$("#col-md-10").height($(window).height()-$("#daohang").height());
	})
	function toWeNeed() {
		$("#mainFrame").attr('src',"<%=basePath%>we/weneed.jsp");
	}
	function toProduct() {
		$("#mainFrame").attr('src',"<%=basePath%>we/product.jsp");
	}
	function toOurClient() {
		$("#mainFrame").attr('src',"<%=basePath%>we/ourclient.jsp");
	}
	function toProduct() {
		$("#mainFrame").attr('src',"<%=basePath%>we/product.jsp");
	}
	function toProblem(){
		$("#mainFrame").attr('src',"<%=basePath%>we/problem.jsp");
	}
	function toChat(){
		$("#mainFrame").attr('src',"<%=basePath%>we/chat.jsp");		
	}
	function toChargeDetail(){
		$("#mainFrame").attr('src',"<%=basePath%>charge/detail.jsp");		
	}
	function priceStandard(){
		$("#mainFrame").attr('src',"<%=basePath%>we/priceStandard.jsp");		
	}
	function register() {
		window.location.href = "<%=basePath%>user/register.jsp";
	}
	function feedback(){
		$("#mainFrame").attr('src',"<%=basePath%>feedback/feedback.jsp");
	}
	function isLogin(){
		var userName = "";
		$.ajax({
			type : "post",
			async: false,//同步
			url : "<%=basePath%>user/isLogin",
			success : function(data) {
				userName = data;
			}
		});
		return userName;
	}
	
	function toCompare(ceshi) {
		var userName = isLogin();
		if(ceshi =="sp"){
			if(userName==""||userName==null){
				$.post("<%=basePath%>user/isLogin")	
				login();
			}else{
				location.href="<%=basePath%>main.jsp";
			}
		}else{
			if(userName==""||userName==null){
				login();
			}else{
				location.href="<%=basePath%>performance/daohang.jsp";
			}
		}
		
	}
	function ReturnRandom(){
		return Math.floor(Math.random()*3);
	}
	function menu() {
		var userName = isLogin();
		if(userName==""||userName==null){
			var random=ReturnRandom();
			if(random ==1 ||random ==0){
				setTimeout("closeImg()",4000);
				document.getElementById('light').style.display='block';
				document.getElementById('fade').style.display='block';
			}else if(random ==2){
				setTimeout("closeImg()",4000);
				document.getElementById('light2').style.display='block';
				document.getElementById('fade2').style.display='block';
			}
			return false;
		}else{
			$("#logins").css('display','none'); 
			$("#welcom").css('display','block'); 
			$("#welcom").html("欢迎您："+userName);
			$("#fx").css('display','block'); 
			$.post(
					"<%=basePath%>user/userAnimation.action",
					{"userId" : <%=userId%>},
					function(data){
						if(data==1){
							var random=ReturnRandom();
							if(random ==1 ||random ==0){
								// 1000 毫秒= 1 秒
								setTimeout("closeImg()",4000);
								document.getElementById('light2').style.display='block';
								document.getElementById('fade2').style.display='block';
							}else if(random ==2){
								setTimeout("closeImg()",4000);
								document.getElementById('light').style.display='block';
								document.getElementById('fade').style.display='block';
							}
						}else if(data==2){
							setTimeout("closeImg()",4000);
							document.getElementById('light2').style.display='block';
							document.getElementById('fade2').style.display='block';
						}else if(data==3){
							setTimeout("closeImg()",4);
						}
					}
				)
		}
	}
	function closeImg(){
		document.getElementById('light').style.display='none';
		document.getElementById('fade').style.display='none';
		document.getElementById('light2').style.display='none';
		document.getElementById('fade2').style.display='none';
		$("#passDlgNo").modal('show');		
	}
	function closeDlgs(){
		$("#passDlgNo").modal('hide');
	}
	function test() {
		alert("此功能正在开发,敬请期待...");
	}
	function login() {
		$.post("<%=basePath%>user/isLogin")
		location.href = "<%=basePath%>user/login.jsp"; 
	}
	function daohang(){
		location.href="<%=basePath%>";
	}
	function quit(){
		if(confirm('您确定要退出登录吗？')){
      		location.href = "<%=basePath%>/user/clearSession"; 
		} else {
			return false;
		}
	}
	function qq(title,url,pic){
		var p = {
	        url: 'http://www.zdcigo.com/user/register.jsp?shareCode=<%=loginName%>',/*获取URL，可加上来自分享到QQ标识，方便统计*/
	          	title:  '智能软件控制建筑材料的价格和数量，让您更轻松！',
	       	summary: '',
	       	desc:'',
	        pics : pic,/*分享图片(可选)*/
	        flash : '', /*视频地址(可选)*/
	        commonClient : true, /*客户端嵌入标志*/
	        site: ''/*分享来源 (可选) ，如：QQ分享*/
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
	            title:'智能软件控制建筑材料的价格和数量，让您更轻松！', /** 分享的文字内容(可选，默认为所在页面的title)*/
	            rnd:new Date().valueOf()
       	 }
        var temp = [];
        for( var p in param ){
            temp.push(p + '=' +encodeURIComponent( param[p ] || '' ) )
        }
        var target_url = "http://service.weibo.com/share/share.php?"+temp.join('&');
        window.open(target_url, 'sinaweibo', 'height=430, width=400');
	}
	function weixin(title,url,pic){
        var target_url ="http://qr.liantu.com/api.php?text=http://www.zdcigo.com/user/register.jsp?shareCode=<%=loginName%>";
        window.open('<%=basePath%>weixin.jsp','sinaweixin','height=630, width=900');
	}
</script>
<body>
	<div class="div-bj" >
		<img style="position: absolute;margin:0 auto;left:800px;top:45px;height:400px;width:680px;" src="<%=basePath%>common/images/toutu.png"/>
        <div class="fixedHome" id="fx" style="display: none">
			<div align="center">
				<a style="text-decoration:none; color: white;" href="javascript:void(0);" onclick="qq();" ><img src="<%=basePath%>common/images/qq.png" width="40" height="40" title="分享到QQ，分享就有收获😀" alt="分享到QQ，分享就有收获😀"/></a><br/><span></span><br/>
				<a style="text-decoration:none; color: white;" href="javascript:void(0);" onclick="sinaWeiBo();" ><img src="<%=basePath%>common/images/wb.png" width="40" height="40" title="分享到微博，分享就有收获😀" alt="分享到微博，分享就有收获😀"/></a><br/><span></span><br/>
				<a style="text-decoration:none; color: white;" href="javascript:void(0);" onclick="weixin();" ><img src="<%=basePath%>common/images/wx.png" width="40" height="40" title="分享到微信，分享就有收获😀" alt="分享到微信，分享就有收获😀"/></a><br/>
			</div>
		</div>
       <div id="light" class="white_content">
			<div class="img_tel">
				<img style="width:90%;" src="<%=basePath%>common/images/1.gif"/>
				<a style="color: red;text-decoration:none;font-size:40px; margin-left:80px; position: absolute; " href = "javascript:void(0)" onclick = "document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'">×</a>
			</div> 
		</div>
		 <div id="fade" class="black_overlay"></div>
		<div id="light2" class="white_content">
			<div class="img_tel">
				<img style="width:80%;" src="<%=basePath%>common/images/2.gif"/>
				<a style="color: red;text-decoration:none;font-size:40px;margin-left: 160px; position: absolute; " href = "javascript:void(0)" onclick = "document.getElementById('light2').style.display='none';document.getElementById('fade2').style.display='none'">×</a>
			</div> 
		</div>  
        <div id="fade2" class="black_overlay"></div>
		<div class="div-1" >
			<div style="color:white;width:600px;height:300px;margin-left:75px;margin-top:110px;">
				<p>建筑工程成本的控制是施工过程中最重要的环节，尤其是材料价格和材料用量的动态控制，直接影响着项目的利润！现在，我们用人工智能的方式自动控制这个过程，为管理者节省大量的时间。在施工过程中，管理层新的决策会时时自动更新系统的控制条件，达到动态控制的目的。</p>
			</div>
		</div>
		<div class="container">
			<div style="width: 100%;">
				<nav class="navbar navbar-default">
				<div class="container-fluid">
					<div class="collapse navbar-collapse"
						id="bs-example-navbar-collapse-1">
						<ul class="nav navbar-nav cl-effect-16">
							<li class="dropdown" style="margin: 0px 40px">
								<a href="error.html" onclick="daohang();" class="dropdown" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">我们</a>
							</li>
							<li class="dropdown" style="margin: 0px 40px">
								<a href="javascript:void(0);"  class="dropdown" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">产品</a>
								<ul class="dropdown-menu">
										<li><a href="javascript:void(0);" onclick="toCompare('sp')">智能审批</a></li>
										<li><a href="javascript:void(0);" onclick="toCompare('jx')">智能绩效</a></li>
										<li><a href="javascript:void(0);" onclick="test()">智能··</a></li>
								</ul>
							</li>
							<li class="dropdown" style="margin: 0px 40px">
								<a href="services.html" class="dropdown" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">技术支持</a>
								<ul class="dropdown-menu">
									<li><a href="# " onclick="toChat();">在线服务</a></li>
									<li><a href="javascript:void(0);" onclick="toProblem();">常见问题</a></li>
									<li><a href="<%=basePath%>file/aaa.pdf" target="_blank">使用说明</a></li>
								</ul>
							</li>
<!-- 							<li class="dropdown" style="margin: 0px 20px"> -->
<!-- 								<a href="services.html" onclick="priceStandard()" class="dropdown" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">计费说明</a> -->
<!-- 							</li> -->
						</ul>
						<ul class="nav navbar-nav">
								<li class="dropdown" style="margin: 0px 175px">
									<a href="services.html" class="dropdown" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" id="logins">登录/注册</a>
									<ul class="dropdown-menu">
										<li><a onclick="login();" style="cursor:pointer;">登录</a></li>
										<li><a onclick="register();"style="cursor:pointer;">注册</a></li>
									</ul>
								</li>
						</ul>
						<ul class="nav navbar-nav">
								<li class="dropdown" style="margin: 0px 165px">
									<a href="javascript:exit(0)" role="button" id="welcom" style="display: none"></a>
									<ul class="dropdown-menu">
										<li>
											<a onclick="feedback()" role="button" ><i class="fa fa-sign-out"></i> <span class="nav-label">意见反馈</span> </a>
											<a onclick="quit()" role="button" ><i class="fa fa-sign-out"></i> <span class="nav-label">退出登录</span> </a>
										</li>
									</ul>
								</li>
						 </ul>
					</div>
				</div>
				</nav>
			</div>
		</div>
	</div>
	<div style="width:100%;float:left;padding:0;overflow:auto;margin-top: -8px;" id="col-md-10">
		<div class="fixed">
		<span>
			<a class="hover-red" href="javascript:exit(0)" style="" onclick="priceStandard()">计费说明</a>
			&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;京ICP备17060188号&emsp;|&emsp;©2019 北京千瑞恒福科贸有限公司版权所有&emsp;
		</span>
	</div>
	
	</div>
<!-- 	<div style="font-family: 'Noto Serif CJK SC', 'Noto Serif CJK', 'Source Han Serif SC', ‘Source Han Serif’, source-han-serif-sc, serif;" id="passDlgNo" class="modal fade"  tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="myModalLabel" aria-hidden="true"> -->
<!-- 		<div class="modal-dialog"> -->
<!-- 			<div class="modal-content"> -->
<!-- 				<div class="modal-header"> -->
<!-- 					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> -->
<!-- 					<h4 class="modal-title" id="myModalLabel">系统公告</h4> -->
<!-- 				</div> -->
<!-- 				<div class="modal-body"> -->
<!-- 					在这里添加系统公告 -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
</body>
</html>