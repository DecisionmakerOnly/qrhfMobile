package com.qrhf.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qrhf.pojo.SysResource;
import com.qrhf.pojo.TemporaryAuthority;
import com.qrhf.pojo.User;
import com.qrhf.service.SysResourceService;
import com.qrhf.tools.TreeviewUtil;

@Controller
@RequestMapping("sysResource")
public class SysResourceController {

	@Autowired
	private SysResourceService sysResourceService;
	
	
	@RequestMapping("findButtons")
	public @ResponseBody Object findButtons(int userId,int pageId){
		return sysResourceService.findButtons(userId, pageId);
	}
	
	@RequestMapping("temporaryAuthority")
	public @ResponseBody Object temporaryAuthority(TemporaryAuthority temporaryAuthority){
		return sysResourceService.temporaryAuthority(temporaryAuthority);
	}
	
	@RequestMapping("findTemporaryAuthorityList")
	public @ResponseBody Object findTemporaryAuthorityList(int userId,int pageId){
		return sysResourceService.findTemporaryAuthorityList(userId, pageId);
	}
	
	@RequestMapping("deleteTemporaryAuthority")
	public @ResponseBody Object deleteTemporaryAuthority(HttpServletRequest request,int sysResourceId){
		User user = (User) request.getSession().getAttribute("user");
		return sysResourceService.deleteTemporaryAuthority(user.getId(),sysResourceId);
	}
	
	@RequestMapping("updateTemporaryAuthority")
	public @ResponseBody Object updateTemporaryAuthority(int taId,int num){
		return sysResourceService.updateTemporaryAuthority(taId, num);
	}
	
	@RequestMapping("findLeftNavSysResource")
	public @ResponseBody List<SysResource> findLeftNavSysResource(int sysRoleId){
		return sysResourceService.findLeftNavSysResource(sysRoleId);
	}
	@RequestMapping("sysResourceSelected")
	public @ResponseBody Object sysResourceSelected(int sysRoleId){
		return sysResourceService.sysResourceSelected(sysRoleId);
	}
//	@RequestMapping("sysResourceSelected")
//	public @ResponseBody Object sysResourceSelected(@RequestParam("sysRoleId") int sysRoleId) {
//		return TreeviewUtil.conversionDataFromList(sysResourceService.sysResourceSelected(sysRoleId));
//	}
}
