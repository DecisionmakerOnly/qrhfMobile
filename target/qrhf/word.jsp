<%@ page language="java" import="java.util.*,com.zhuozhengsoft.pageoffice.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	String url = request.getParameter("url");
	String filePath = basePath+"/file/upload/contract/"+url;
	PageOfficeCtrl poCtrl=new PageOfficeCtrl(request);
	//设置服务器页面
	poCtrl.setServerPage(request.getContextPath()+"/poserver.zz");
	poCtrl.addCustomToolButton("保存", "Save()", 1);
	poCtrl.addCustomToolButton("打印", "PrintFile()", 6);
	poCtrl.addCustomToolButton("全屏/还原", "IsFullScreen()", 4);
	poCtrl.addCustomToolButton("关闭", "CloseFile()", 21);
	//设置保存页面
	poCtrl.setSaveFilePage("saveFile.jsp?url="+url);
	//打开Word文档
	poCtrl.webOpen(filePath,OpenModeType.docNormalEdit,"张佚名");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
<title>word</title>
<script type="text/javascript" src="<%=basePath%>common/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="pageoffice.js"  id="po_js_main"></script>
<script type="text/javascript">
	function Save() {
		document.getElementById("PageOfficeCtrl1").WebSave();
	}
	function PrintFile(){
		document.getElementById("PageOfficeCtrl1").ShowDialog(4); 
	}
	function IsFullScreen(){
		document.getElementById("PageOfficeCtrl1").FullScreen = !document.getElementById("PageOfficeCtrl1").FullScreen;
	}
	function CloseFile(){
		POBrowser.closeWindow(); 
	}
	$(function(){
		document.getElementById("PageOfficeCtrl1").FullScreen=true;
	});
</script>
</head>
<body>
	<div style="position:absolute;left:5px;top:66px;width:1175px; height:670px;">
		<%=poCtrl.getHtmlCode("PageOfficeCtrl1")%>
	</div>
</body>
</html>
