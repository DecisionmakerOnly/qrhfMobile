<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)request.getSession().getAttribute("user");
	Integer userId=null;
	String userName=null;
	String loginName=null;
	Integer companyId=null;
	String companyName=null;
	Integer sysRoleId=null;
	if(user != null){
		userId = user.getId();
		companyId=user.getCompanyId();
		userName=user.getUserName();
		loginName=user.getLoginName();
		companyName=user.getCompanyName();
		sysRoleId=user.getSysRoleId();
	}
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
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
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
.menubox3{
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
	text-align: center;
}
a.hover-red{
	color:black;
	text-decoration:none;
	font-size:14px;
}
.navbarMin{
	width:100%;
	height:52px;
	overflow: hidden;
	position: absolute;
	z-index:99;
}

.navbarMax{
	width:100%;
	height:350px;
	overflow: hidden;
	position: absolute;
	z-index:99;
}

.div-bj{
	background:url("<%=basePath%>/common/images/beijing.png") no-repeat 0px 0px;
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
    top: 15%; 
    left: 30%; 
  	width: 800px; 
    height: 500px; 
     padding: 20px; 
    z-index:1002; 
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
		$("#navbar").mouseout(function(){
			$(this).removeClass("navbarMax");
		})
		$("#navbar").mouseover(function(){
			$(this).addClass("navbarMax");
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
			jump("we/wethink.jsp");
			menu();
		}
	})
	function jump(url){
		$("#mainFrame").attr('src',"<%=basePath%>"+url);
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
	function toCompare() {
		var userName = isLogin();
		if(userName==""||userName==null){
			login();
		}else{
			location.href="<%=basePath%>a/daohang2.jsp";
		}
	}
	function login() {                                                                                                                                          
		location.href = "<%=basePath%>user/login.jsp"; 
	}
	function register() {
		window.location.href = "<%=basePath%>user/register.jsp";
	}
	function menu() {
		var userName = isLogin();
		if(userName==""||userName==null){
			if(<%=companyName%>==null){
				$("#dl").css('display','none'); 
				$("#wdl").css('display','block'); 
			}
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
			$("#welcom").html("欢迎您："+userName+'<b class="caret"></b>');
			$("#fx").css('display','block'); 
			$("#menubox").css('display','block'); 
			$("#dl").css('display','block'); 
			$("#wdl").css('display','none'); 
			findLeftNavSysResource();
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
						}
					}
				)
		}
	}
	//随机
	function ReturnRandom(){
		return Math.floor(Math.random()*3);
	}
	function closeImg(){
		document.getElementById('light').style.display='none';
		document.getElementById('fade').style.display='none';
		document.getElementById('light2').style.display='none';
		document.getElementById('fade2').style.display='none';
	}
	//左侧导航
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
// 	退出
	function quit(){
		if(confirm('您确定要退出登录吗？')){
      		location.href = "<%=basePath%>user/clearSession"; 
		} else {
			return false;
		}
	}
</script>
</head>
<body style="overflow: hidden;">
	<div class="containerbody">
		<div style="width:100%;height:5%;">
			<nav class="div-bj navbar navbar-inverse navbarMin navbarMax" role="navigation" id="navbar">
			    <div class="container-fluid">
				    <div class="navbar-header">
				        <a class="navbar-brand" href="javascript:void(0);">zdcigo</a>
				    </div>
				    <div>
				        <ul class="nav navbar-nav">
				            <li><a href="javascript:void(0);" onclick="jump('we/wethink.jsp')">我们</a></li>
				            <li class="dropdown">
				            	<a href="#" class="dropdown-toggle" data-toggle="dropdown">产品<b class="caret"></b></a>
				            	<ul class="dropdown-menu">
				                    <li><a href="javascript:void(0);" onclick="toCompare()">智能审批</a></li>
				                    <li><a href="javascript:void(0);" onclick="return alert('此功能正在开发！')">智能······</a></li>
				                </ul>
				            </li>
				            <li class="dropdown">
				                <a href="#" class="dropdown-toggle" data-toggle="dropdown">技术支持<b class="caret"></b></a>
				                <ul class="dropdown-menu">
				                    <li><a href="javascript:void(0);" onclick="jump('we/chat.jsp')">在线服务</a></li>
				                    <li><a href="javascript:void(0);" onclick="jump('we/problem.jsp')">常见问题</a></li>
				                    <li><a href="javascript:void(0);" onclick="jump('file/aaa.pdf')">使用说明</a></li>
				                </ul>
				            </li>
				            <li class="dropdown">
				            	<a href="#" class="dropdown-toggle" data-toggle="dropdown" id="logins">登录/注册<b class="caret"></b></a>
				            	<ul class="dropdown-menu">
				                    <li><a href="javascript:void(0);" onclick="login();">登录</a></li>
				                    <li><a href="javascript:void(0);" onclick="register();">注册</a></li>
				                </ul>
				            </li>
				            <li class="dropdown">
				            	<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" id="welcom" style="display: none"><b class="caret"></b></a>
				            	<ul class="dropdown-menu">
				                    <li><a href="javascript:void(0);" onclick="jump('feedback/feedback.jsp')">意见反馈</a></li>
				                    <li><a href="javascript:void(0);" onclick="quit()">退出登录</a></li>
				                </ul>
				            </li>
				        </ul>
				    </div>
				    <div>
				    	<div style="position: absolute;margin:0 auto;left:100px;top:140px;color: red;font-size: 16px">
				    		<p>建筑施工过程中材料采购价格和数量的动态控制，一直是建筑行业老板们最费心的事！</p>
				    		<p>现在我们用人工智能的方式控制这个过程，希望给使用这个系统的老板们带来轻松和更多的利润。</p>
				    	</div>
				    	<div>
				    		<img style="position: absolute;margin:0 auto;left:900px;top:45px;height:200px;width:300px;" src="<%=basePath%>common/images/toutu.png"/>
				    	</div>
				    </div>
			    </div>
			</nav>
		</div>
		
	    <div class="menubox menuboxmin" id="menubox" >
			<div class='leftNav'>
				<ul id="leftNav">
					<li id="dl"><a href='javascript:;' title=''><span class='glyphicon glyphicon-th'></span><%=companyName%></a></li>
					<li id="wdl" style="display: none;"><a href='javascript:;' title=''><span class='glyphicon glyphicon-th'></span>未登录</a></li>
				</ul>
			</div>
		</div>
		
		<div id="light" class="white_content">
			<div>
				<img style="width:90%;" src="<%=basePath%>common/images/1.gif"/>
				<a style="color: red;text-decoration:none;font-size:40px; margin-left:40px; position: absolute; " href = "javascript:void(0)" onclick = "document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'">×</a>
			</div> 
		</div> 
		<div id="fade" class="black_overlay"></div>
		<div id="light2" class="white_content">
			<div >
				<img style="width:80%;" src="<%=basePath%>common/images/2.gif"/>
				<a style="color: red;text-decoration:none;font-size:40px;margin-left: 80px; position: absolute; " href = "javascript:void(0)" onclick = "document.getElementById('light2').style.display='none';document.getElementById('fade2').style.display='none'">×</a>
			</div> 
		</div> 
	    <div id="fade2" class="black_overlay"></div>
		
		<div class="menubox2">
			<div style="width:100%;float:left;padding:0;overflow:auto;margin-top: -8px;" id="col-md-10"></div>
		
		<div class="menubox3" >
			<span>
				<p></p>
				<a class="hover-red" href="javascript:exit(0)"  onclick="jump('we/priceStandard.jsp')">计费说明</a>
				&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;京ICP备17060188号&emsp;|&emsp;©2019 北京千瑞恒福科贸有限公司版权所有&emsp;
			</span>
		</div>
		</div>
	</div>
</body>
</html>
