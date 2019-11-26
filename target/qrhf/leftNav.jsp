<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.qrhf.pojo.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)request.getSession().getAttribute("user");
	Integer userId = user.getId();
	String loginName=user.getLoginName();
	String companyName=user.getCompanyName();
	Integer companyId=user.getCompanyId();
	String pageId = request.getParameter("pageId");
	Integer sysRoleId = user.getSysRoleId();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- Bootstrap 不支持 IE 古老的兼容模式。为了让 IE 浏览器运行最新的渲染模式下，建议将此 <meta> 标签加入到你的页面中 -->
<meta name="renderer" content="webkit">
<!-- 将下面的 <meta> 标签加入到页面中，可以让部分国产浏览器默认采用高速模式渲染页面 -->
<link href='<%=basePath%>common/css/bootstrap.css' rel='stylesheet'>
<link href='<%=basePath%>common/css/bootstrap-table.css' rel='stylesheet'>
<link href="<%=basePath%>common/css/sidenav.min.css" type="text/css" rel="stylesheet" >
<link href="<%=basePath%>common/css/googleapis.css" type="text/css" rel="stylesheet" >
<link href='<%=basePath%>common/css/bootstrap-treeview.css' rel='stylesheet'>
<script type='text/javascript' src='<%=basePath%>common/js/base.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/respond.min.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/jquery-3.2.1.min.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/bootstrap.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/bootstrap-table.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/bootstrap-table-zh-CN.js'></script>
<script type='text/javascript' src='<%=basePath%>common/js/bootstrap-treeview.js'></script>
<script type='text/javascript' src="<%=basePath%>common/js/sidenav.min.js"></script>
<style type="text/css">
.toggle {
	display: block;
	height: 30px;
	line-height: 30px;
	text-align: center;
	width: 70px;
}
.div-a {
	float: left;
	width: 2%;
}
.div-b {
	float: right;
	width: 97%;
}
.fixed{
    position:fixed;
    top:580px;
  	left:22px;
  	bottom:0px;
    width:200px; 
    height:45px; 
    }
.fixedHome{
    position:fixed;
    top:430px;
  	left:8px;
  	bottom:0px;
    width:65px; 
    height:160px; 
    }
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	function zsy() {
		var yScroll = (window.parent.document.documentElement.scrollHeight > window.parent.document.documentElement.clientHeight) ? window.parent.document.documentElement.scrollHeight : window.parent.document.documentElement.clientHeight;
		return yScroll;
	}

	$(function() {
		var yScroll = (window.parent.document.documentElement.scrollHeight > window.parent.document.documentElement.clientHeight) ? window.parent.document.documentElement.scrollHeight : window.parent.document.documentElement.clientHeight;
		var xScroll = document.body.clientWidth - 50; //90 两边都有空出
		findLeftNavSysResource();
		$("#fra").height(yScroll);
		$("#fra").width(xScroll);
		$(".sidenav li").on("click", function() {
			var address = $(this).attr("data-src");
			$("iframe").attr("src", address);
			if (address != null && address != "") { //address的值为空就是一级下拉菜单 除此之外点击后关闭
				$("nav").attr("class", "sidenav");
				$(".sidenav-overlay").css('display', 'none');
			}
		});
	});
	function qq(title,url,pic){
	    var p = {
	        url: 'http://www.zdcigo.com/user/register.jsp?shareCode=<%=loginName%>',/*获取URL，可加上来自分享到QQ标识，方便统计*/
	        title : '智能软件控制建筑材料的价格和数量，让您更轻松！',/*分享标题(可选)*/
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
	function weixin(){
	        var target_url ="http://qr.liantu.com/api.php?text=http://www.zdcigo.com/user/register.jsp?shareCode=<%=loginName%>";
	        window.open('<%=basePath%>weixin.jsp','sinaweixin','height=630, width=900');
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
		html += '<div style="text-align:center;" class="sidenav-brand">';
		html += '<%=companyName%>';
		html += '</div>';
		for(var i=0;i<data.length;i++){
			html += '<ul class="sidenav-menu">';
			html += '<li data-src="'+data[i].method+'">';
			html += '<a href="javascript:;" data-sidenav-dropdown-toggle class="active"> ';
			html += '<span class="sidenav-link-icon"><i class="material-icons">store</i></span>';
			html += '<span class="sidenav-link-title">'+data[i].name+'</span>';
			html += '</a>';
			html += '</li>';
			html += '</ul>';
		}
			$.post(
				"<%=basePath%>sysRole/selectInvestorsCodeAndPay",	
				{userId:<%=userId%>},
				function (data) {
					for(var i=0;i<data.length;i++){	
						if(data[i].code == "TZRDB" && data[i].notOrPay == "0"){
							$("#applyDelay").css('display','block'); 
						}if(data[i].code == "TZRDB"){
							$("#applyDelay2").css('display','block'); 
						}
					}
				}		
			) 
			$("#leftNav").html(html+$("#leftNav").html());
	}
	function applyExpiryDate(){
	  	$.post(
				"<%=basePath%>user/selectUserExpiryDate",	
				{userId:<%=userId%>},
				function (data) {
					if(data == -1){
						openModal("<%=basePath%>applyExpiryDate.jsp?pageId=<%=pageId%>&companyId="+<%=companyId%>);
					}else {
						if(data==0){
							var expiryDate=data+1;
							alert("试用时间还有"+expiryDate+"天，试用到期后再申请延期。");
								location.reload()
						}else{
							alert("试用时间还有"+data+"天，试用到期后再申请延期。");
								location.reload()
						}
						
					}
				}		
			) 
		
	}
	function delCompany(){
		if (confirm("是否想解散本组织或单位？")) {
			$.post(
					"<%=basePath%>company/del?companyId="+<%=companyId%> ,	
					function(person){
						if(person==1){
							alert("解散成功！")
							parent.top.location.href = "<%=basePath%>/user/clearSession";
						}else{
							alert("解散失败！")
							return;
						}
					}
				)
		}
	}
</script>
</head>
<body>
	<div id="leftnav" >
		<nav class="sidenav" data-sidenav data-sidenav-toggle="#sidenav-toggle" id="leftNav">
					<ul class="sidenav-menu" id="applyDelay" style="display:none;">
						<li data-src="">
							<a href="javascript:;" onclick="applyExpiryDate();" data-sidenav-dropdown-toggle class="active">
								<span class="sidenav-link-icon"> <i class="material-icons">store</i></span>
								<span class="sidenav-link-title">试用延期申请</span>
							</a>
						</li>
					</ul>
					<ul class="sidenav-menu" id="applyDelay2" style="display:none;">
						<li data-src="">
							<a href="javascript:;" onclick="delCompany();" data-sidenav-dropdown-toggle class="active">
								<span class="sidenav-link-icon"> <i class="material-icons">store</i></span>
								<span class="sidenav-link-title">解散组织</span>
							</a>
						</li>
					</ul>
<!-- 			<ul class="sidenav-menu"> -->
<!-- 				<li> -->
<!-- 					<a href="javascript:;" data-sidenav-dropdown-toggle class="active">  -->
<!-- 						<span class="sidenav-link-icon"><i class="material-icons">store</i></span>  -->
<!-- 						<span class="sidenav-link-title">订单</span> -->
<!-- 						<span class="sidenav-dropdown-icon show" data-sidenav-dropdown-icon><i class="material-icons">arrow_drop_down</i></span>  -->
<!-- 						<span class="sidenav-dropdown-icon" data-sidenav-dropdown-icon><i class="material-icons">arrow_drop_up</i></span> -->
<!-- 					</a> -->
<!-- 					<ul class="sidenav-dropdown" data-sidenav-dropdown> -->
<!-- 						<li data-src="project/list.jsp"><a href="javascript:;">查看订单</a></li> -->
<!-- 					</ul> -->
<!-- 				</li> -->
<!-- 			</ul> -->
<!-- 			<ul class="sidenav-menu"> -->
<!-- 				<li data-src="payment/list.jsp"> -->
<!-- 					<a href="javascript:;" data-sidenav-dropdown-toggle class="active">  -->
<!-- 						<span class="sidenav-link-icon"> <i class="material-icons">store</i></span> -->
<!-- 						<span class="sidenav-link-title">订单</span> -->
<!-- 					</a> -->
<!-- 				</li> -->
<!-- 			</ul> -->
<!-- 			<ul class="sidenav-menu"> -->
<!-- 				<li data-src="user/shareCode.jsp"> -->
<!-- 					<a href="javascript:;" data-sidenav-dropdown-toggle class="active">  -->
<!-- 						<span class="sidenav-link-icon"> <i class="material-icons">store</i></span> -->
<!-- 						<span class="sidenav-link-title">代金券</span> -->
<!-- 					</a> -->
<!-- 				</li> -->
<!-- 			</ul> -->
<!-- 			<ul class="sidenav-menu"> -->
<!-- 				<li data-src="refund/list.jsp"> -->
<!-- 					<a href="javascript:;" data-sidenav-dropdown-toggle class="active">  -->
<!-- 						<span class="sidenav-link-icon"> <i class="material-icons">store</i></span> -->
<!-- 						<span class="sidenav-link-title">提现记录</span> -->
<!-- 					</a> -->
<!-- 				</li> -->
<!-- 			</ul> -->
<!-- 				<ul class="sidenav-menu"> -->
<!-- 				<li data-src="invoice/list.jsp"> -->
<!-- 					<a href="javascript:;" data-sidenav-dropdown-toggle class="active">  -->
<!-- 						<span class="sidenav-link-icon"> <i class="material-icons">store</i></span> -->
<!-- 						<span class="sidenav-link-title">发票管理</span> -->
<!-- 					</a> -->
<!-- 				</li> -->
<!-- 			</ul> -->
<!-- 			<ul class="sidenav-menu"> -->
<!-- 				<li data-src="refund/selectAll.jsp"> -->
<!-- 					<a href="javascript:;" data-sidenav-dropdown-toggle class="active">  -->
<!-- 						<span class="sidenav-link-icon"> <i class="material-icons">list</i></span> -->
<!-- 						<span class="sidenav-link-title">所有提现记录</span> -->
<!-- 					</a> -->
<!-- 				</li> -->
<!-- 			</ul> -->
			<div class="fixed">
				<div align="center">
					<a style="text-decoration:none; color: white;" href="javascript:void(0);" onclick="qq();" ><img src="<%=basePath%>common/images/qq.png" width="40" height="40" title="分享到QQ，分享就有收获😀" alt="分享到QQ，分享就有收获😀"/></a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a style="text-decoration:none; color: white;" href="javascript:void(0);" onclick="sinaWeiBo();" ><img src="<%=basePath%>common/images/wb.png" width="40" height="40" title="分享到微博，分享就有收获😀" alt="分享到微博，分享就有收获😀"/></a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a style="text-decoration:none; color: white;" href="javascript:void(0);" onclick="weixin();" ><img src="<%=basePath%>common/images/wx.png" width="40" height="40" title="分享到微信，分享就有收获😀" alt="分享到微信，分享就有收获😀"/></a>
				</div>
			</div>
		</nav>
		
	</div>
	<div class="div-a" style="padding-top: 25px">
		<a href="javascript:;" class="toggle" id="sidenav-toggle"> <i
			class="material-icons">menu</i>
		</a>
	</div>
	<div class="fixedHome">
		<div align="center">
			<a style="text-decoration:none; color: white;" href="javascript:void(0);" onclick="qq();" ><img src="<%=basePath%>common/images/qq.png" width="40" height="40" title="分享到QQ，分享就有收获😀" alt="分享到QQ，分享就有收获😀"/></a><br/><span></span><br/>
			<a style="text-decoration:none; color: white;" href="javascript:void(0);" onclick="sinaWeiBo();" ><img src="<%=basePath%>common/images/wb.png" width="40" height="40" title="分享到微博，分享就有收获😀" alt="分享到微博，分享就有收获😀"/></a><br/><span></span><br/>
			<a style="text-decoration:none; color: white;" href="javascript:void(0);" onclick="weixin();" ><img src="<%=basePath%>common/images/wx.png" width="40" height="40" title="分享到微信，分享就有收获😀" alt="分享到微信，分享就有收获😀"/></a><br/>
		</div>
	</div>
	<script>$('[data-sidenav]').sidenav();</script>
	<div class="div-b">
		<iframe src="sysMain/homePage.action" frameborder="0" style="float: left" id="fra"></iframe>
	</div>
</body>
</html>