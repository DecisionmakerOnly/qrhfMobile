<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta charset="UTF-8">
  <title>在线客服</title>
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="format-detection" content="telephone=no">
  <meta name="renderer" content="webkit">
  <meta http-equiv="Cache-Control" content="no-siteapp"/>
<link rel="stylesheet" href="<%=basePath%>/common/css/amazeui.min.css"/>
<link href="<%=basePath%>/common/css/kefu.css" rel="stylesheet" type="text/css" media="all" />
<link href="<%=basePath%>/common/css/umeditor.css" type="text/css" rel="stylesheet">
<link href="<%=basePath%>/common/css/daohang.css" rel="stylesheet" type="text/css" media="all" />
<link href="<%=basePath%>/common/css/bootstrap.css" rel="stylesheet" type="text/css" media="all">
<link href="<%=basePath%>/common/css/style2.css" rel="stylesheet" type="text/css" media="all" />
<script src="<%=basePath%>common/js/jquery.min.js"></script>
<script src="<%=basePath%>common/js/amazeui.min.js"></script>
<script src="<%=basePath%>/common/js/jquery-3.2.1.min.js"></script>
<script src="<%=basePath%>/common/js/bootstrap.js"></script>
<!-- UM相关资源 -->
<script type="text/javascript" charset="utf-8" src="<%=basePath%>common/js/umeditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=basePath%>common/js/umeditor.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/zh-cn.js"></script>
<script type="text/javascript">
function zsy() {
	var yScroll = (window.parent.document.documentElement.scrollHeight > window.parent.document.documentElement.clientHeight) ? window.parent.document.documentElement.scrollHeight : window.parent.document.documentElement.clientHeight;
	return yScroll;
}
$(function() {
	var h = zsy();
// 	$("#listBody").height(h - 100);
	//取到窗口的高度 
	var winH = $(window).height();
	//取到页面的高度 
	var bodyH = $(document).height();
	if (bodyH > winH) {
		window.parent.document.getElementById("mainFrame").height = bodyH;
	} else {
		window.parent.document.getElementById("mainFrame").height = winH;
	}
})
$(function(){
	//实例化编辑器
    var um = UM.getEditor('myEditor',{
    	initialContent:"请输入聊天信息...",
    	autoHeightEnabled:false,
    	toolbar:[
            'source | undo redo | bold italic underline strikethrough | superscript subscript | forecolor backcolor | removeformat |',
            'insertorderedlist insertunorderedlist | selectall cleardoc paragraph | fontfamily fontsize' ,
            '| justifyleft justifycenter justifyright justifyjustify |',
            'link unlink | emotion image video  | map'
        ]
    });
    var nickname = "1";
	var socket = new WebSocket("");
    //接收服务器的消息
    socket.onmessage=function(ev){
    	var obj = eval(   '('+ev.data+')'   );
    	addMessage(obj);
    }
    $("#send").click(function(){
    	if (!um.hasContents()) {  // 判断消息输入框是否为空
            // 消息输入框获取焦点
            um.focus();
            // 添加抖动效果
            $('.edui-container').addClass('am-animation-shake');
            setTimeout("$('.edui-container').removeClass('am-animation-shake')", 1000);
        } else {
        	//获取输入框的内容
        	var txt = um.getContent();
        	//构建一个标准格式的JSON对象
        	var obj = JSON.stringify({
	    		nickname:nickname,
	    		content:txt
	    	});
            // 发送消息
            socket.send(obj);
            // 清空消息输入框
            um.setContent('');
            // 消息输入框获取焦点
            um.focus();
        }
    
    });
});

//人名nickname，时间date，是否自己isSelf，内容content
function addMessage(msg){
	var box = $("#msgtmp").clone(); 	//复制一份模板，取名为box
	box.show();							//设置box状态为显示
	box.appendTo("#chatContent");		//把box追加到聊天面板中
	box.find('[ff="nickname"]').html(msg.isSelf? msg.nickname+"(me)" :msg.nickname); //在box中设置昵称
	box.find('[ff="msgdate"]').html(msg.date); 		//在box中设置时间
	box.find('[ff="content"]').html(msg.content); 	//在box中设置内容
	box.addClass(msg.isSelf? 'am-comment-flip':'');	//右侧显示
	box.addClass(msg.isSelf? 'am-comment-warning':'am-comment-success');//颜色
	box.css((msg.isSelf? 'margin-left':'margin-right'),"20%");//外边距
	$("#ChatBox div:eq(0)").scrollTop(999999); 	//滚动条移动至最底部
}
</script>
</head>
<body style="width: 100%;">
<div id="kefu1" style="top: 80px;font-family: 'Noto Serif CJK SC', 'Noto Serif CJK', 'Source Han Serif SC', ‘Source Han Serif’, source-han-serif-sc, serif;">
		<div class="cs_close">
			<a href="javascript:;" onClick="kefu1.style.display = 'none'"><span>关闭</span>
			</a>
		</div>
		<div class="cs_tel"></div>
		<div class="cs_tel_ct">
			<span class="cs_tel_num">13120261521</span> 工作日(周一至周五)<br />上午:9:00-12:00<br/>
			下午:13:00-18:00<br />
		</div>
<!-- 		<div class="cs_tel_ct"> -->
<!-- 			工作日:上午8:00-12:00<br /> -->
<!-- 			工作日:下午13:30-17:30<br /> -->
<!-- 		</div> -->
		<div class="cs_spr"></div>
		<div class="cs_online"></div>
		<div class="cs_online_ct">
			<div class="cs_online_qq">												
				<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=2643408178&site=qq&menu=yes">
					<img border="0" src="http://wpa.qq.com/pa?p=2:3473180881:41" alt="QQ客服1" title="QQ客服1">
				</a>
			</div>
			<div class="cs_online_qq">
				<a target="_blank"
					href="http://wpa.qq.com/msgrd?v=3&uin=3473180881&site=qq&menu=yes"><img
					border="0" src="http://wpa.qq.com/pa?p=2:727091913:41"
					alt="QQ客服2" title="QQ客服2">
				</a>
			</div>
		</div>
		<div class="cs_qcode">
			<a href="javascript:void(0)" target="_blank"><img src="<%=basePath%>/common/images/wxkf.jpg" width="120" height="120" title="用手机微信扫一扫" />
			</a>
		</div>
		<span class="cs_tel_ct">&nbsp;扫描二维码加微信好友咨询</span>
</div>
<header class="am-topbar am-topbar-fixed-top">
	  <div class="am-container" style="font-family: 'Noto Serif CJK SC', 'Noto Serif CJK', 'Source Han Serif SC', ‘Source Han Serif’, source-han-serif-sc, serif;"> 
	    <h1 class="am-topbar-brand">
	      <a href="#">欢迎咨询</a>
	    </h1>
	    <div class="am-collapse am-topbar-collapse" id="collapse-head">
		    </div>
	  </div>
	</header>
	<div id="main"  >
		<!-- 聊天内容展示区域 -->
	<div id="ChatBox" class="am-g am-g-fixed" style="height:280px;border:1px solid #999;overflow-y:scroll;font-family: 'Noto Serif CJK SC', 'Noto Serif CJK', 'Source Han Serif SC', ‘Source Han Serif’, source-han-serif-sc, serif;">
	  <div class="am-u-lg-12" >
		<ul id="chatContent" class="am-comments-list am-comments-list-flip">
			<li id="msgtmp" class="am-comment" style="display:none;">
			    <a href="">
			        <img class="am-comment-avatar" src="<%=basePath%>common/assets/images/other.jpg" alt=""/>
			    </a>
			    <div class="am-comment-main" >
			        <header class="am-comment-hd">
			            <div class="am-comment-meta">
			              <a ff="nickname" href="#link-to-user" class="am-comment-author">某人</a>
			              <time ff="msgdate" datetime="" title="">2014-7-12 15:30</time>
			            </div>
			        </header>
			     <div ff="content" class="am-comment-bd"><textarea id="textarea" placeholder="请输入聊天内容，按Ctrl+Enter发送"></textarea></div>
			    </div>
			</li>
		</ul>
	  </div>
	</div>
	<!-- 聊天内容发送区域 -->
	<div id="EditBox" class="am-g am-g-fixed" style="font-family: 'Noto Serif CJK SC', 'Noto Serif CJK', 'Source Han Serif SC', ‘Source Han Serif’, source-han-serif-sc, serif;">
		<!--style给定宽度可以影响编辑器的最终宽度-->
		<script type="text/plain" id="myEditor" style="width:100%;height:120px;"></script>
		<button id="send" type="button" class="am-btn am-btn-primary am-btn-block">发送</button>
	</div>
</div>
</body>
</html>
