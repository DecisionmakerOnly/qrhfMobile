<%@ page language="java" import="java.util.*,com.zhuozhengsoft.pageoffice.*" pageEncoding="utf-8"%>
<%
	String url = request.getParameter("url");
	FileSaver fs=new FileSaver(request,response);
	fs.saveToFile(request.getSession().getServletContext().getRealPath("/file/upload/contract")+"/"+url);
	fs.close();
%>

