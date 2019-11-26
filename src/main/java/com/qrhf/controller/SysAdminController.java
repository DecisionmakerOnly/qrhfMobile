package com.qrhf.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.qrhf.pojo.SysAdmin;
import com.qrhf.service.SysAdminService;

@Controller
@RequestMapping("/admin")
public class SysAdminController {
	@Autowired
	private SysAdminService sysAdminService;
	
	@RequestMapping("/login")
	public @ResponseBody Map<String,Object> login(HttpSession session,HttpServletRequest request,SysAdmin sysAdmin) throws IOException {
		Map<String,Object> map = new HashMap<String, Object>();
		Integer i=null;
		SysAdmin admin=sysAdminService.loginByAdminName(sysAdmin.getLoginName());
		if (admin != null){
			if (sysAdmin.getPassword().equals(admin.getPassword()) ) {
				i=0;// 登录成功
				map.put("id", admin.getId());
				request.getSession().setAttribute("admin", admin);
			}else {
				i = 1;// 密码不正确
			}
			
		}else {
			i = 2;// 用户不存在
		}
		map.put("i", i);
		return map;
	}
	@RequestMapping("clearSession")
	public ModelAndView clearSession(HttpServletRequest req,HttpSession session) {
		ModelAndView mav = new ModelAndView("admin/login");
		System.out.println(req.getSession().getAttribute("admin"));
		session.removeAttribute("admin");
//		req.getSession().invalidate();
		return mav;
	}
	/**
	 * 修改用户密码
	 * 
	 * @param SysAdmin
	 * @return
	 */
	@RequestMapping("/uPass")
	@ResponseBody
	public Integer uPass(SysAdmin sysAdmin) {
		Integer id = sysAdminService.upPass(sysAdmin);
		return id;
	}
}
