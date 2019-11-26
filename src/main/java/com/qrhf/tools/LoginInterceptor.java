package com.qrhf.tools;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoginInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("------LoginInterceptor-------");
		 
		// 获取请求的URL
		String url = request.getRequestURI();
		System.out.println(url);
		System.out.println(url.indexOf("daohang"));
		// URL:login.jsp是公开的;这个demo是除了login.jsp是可以公开访问的，其它的URL都进行拦截控制
		// 注意：一些静态文件不能拦截，否则会死循环，知道内存耗尽
		if (url.indexOf("daohang") >= 0) {
			return true;
		}
		// 获取Session
		HttpSession session = request.getSession();
		String userName = (String) session.getAttribute("userName");
 
		if (userName != null) {
			return true;
		}
		// 不符合条件的，跳转到登录界面
		// request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
		response.sendRedirect("/daohang");
		return false;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		
	}
	
}
