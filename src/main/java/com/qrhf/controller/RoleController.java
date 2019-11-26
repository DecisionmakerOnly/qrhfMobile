package com.qrhf.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.qrhf.pojo.Role;
import com.qrhf.service.RoleService;

@Controller
@RequestMapping("role")
public class RoleController {

	@Autowired
	private RoleService roleService;
	
	@RequestMapping("add")
	@ResponseBody
	public ModelAndView add(int pageId) {
		ModelAndView mav = new ModelAndView("role/add");
		List<Role> roleList = roleService.roleList();
		mav.addObject("pageId", pageId);
		mav.addObject("roleList", roleList);
		return mav;
	}
	
	@RequestMapping("checkRole")
	@ResponseBody
	public int checkRole(Role role) {
		int count = roleService.checkRole(role);
		return count;
	}
}
