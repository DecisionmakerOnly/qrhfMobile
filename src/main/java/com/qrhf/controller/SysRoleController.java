package com.qrhf.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.qrhf.pojo.SysRole;
import com.qrhf.service.SysRoleService;
import com.qrhf.tools.TreeviewUtil;

@Controller
@RequestMapping("/sysRole")
public class SysRoleController {

	@Autowired
	private SysRoleService sysRoleService;
	
	@RequestMapping("findList")
	public @ResponseBody Object list(int pageSize, int pageNumber,int companyId) {
		Map<String, Object> param = new HashMap<String, Object>();
		int a = (pageNumber - 1) * pageSize;
		int b = pageSize;
		param.put("a", a);
		param.put("b", b);
		param.put("companyId", companyId);
		return sysRoleService.findList(param);
	}
	
	@RequestMapping("findMyCompanyRole")
	public @ResponseBody Object findMyCompanyRole(int companyId){
		List<SysRole> list = sysRoleService.findMyCompanyRole(companyId);
		return list;
	}

	@RequestMapping("/add")
	public @ResponseBody Integer add(SysRole role) {
		Integer person = sysRoleService.add(role);
		return person;
	}

	@RequestMapping("/getRoleById")
	public ModelAndView getRoleById(Integer id) {
		ModelAndView mav = new ModelAndView();
		SysRole sysRole = sysRoleService.getRoleById(id);
		mav.addObject("sysRole", sysRole);
		mav.setViewName("/role/edit");
		return mav;
	}

	@RequestMapping("/updateRole")
	@ResponseBody
	public Integer updateRole(SysRole sysRole) {
		Integer id = sysRoleService.update(sysRole);
		return id;
	}

	@RequestMapping("/deleteUserRoleById")
	public @ResponseBody Object deleteUserRoleById(int id) {
		return sysRoleService.deleteUserRoleById(id);
	}

	@RequestMapping("checkCode")
	public void checkCode(HttpServletRequest request,HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();
		String code = request.getParameter("code");
		String companyId = request.getParameter("companyId");
		SysRole sysRole = sysRoleService.roleByRoleName(companyId,code);
		if (sysRole != null) {
			out.println(1);
		} else {
			out.println(2);
		}
	}
	
	@RequestMapping("checkRepeat")
	@ResponseBody
	public int checkRepeat(SysRole sysRole) throws IOException {
		int sr = sysRoleService.checkRepeat(sysRole);
		if(sr == 1) {
			return 1;
		}else {
			return 2;
		}
	}

	/**
	 * 查找菜单	
	 * @param sysRole
	 * @return
	 */
	@RequestMapping("/viewTree")
	public @ResponseBody Object getRoleTree(@RequestParam("sysRole") int sysRole) {
		return TreeviewUtil.conversionDataFromList(sysRoleService.getViewTree(sysRole));
		
	}
	@RequestMapping("/getRangeViewTree")
	public @ResponseBody Object getRangeRoleTree(@RequestParam("sysRole") int sysRole) {
		return TreeviewUtil.conversionDataFromList(sysRoleService.getRangeViewTree(sysRole));
		
	}
	@ResponseBody
	@RequestMapping("/saveRoleResoure")
	public boolean saveRoleResoure(@RequestParam("sysRole") int sysRole, @RequestParam("sysResoure") int[] sysResoure) {
		boolean flag = false;
		flag = sysRoleService.saveRoleResoure(sysRole, sysResoure);
		return flag;
	}
	@ResponseBody
	@RequestMapping("/saveRoleRange")
	public boolean saveRoleRange(@RequestParam("sysRole") int sysRole, @RequestParam("sysResoure") int[] sysResoure) {
		boolean flag =false;
		flag =sysRoleService.saveRoleRange(sysRole, sysResoure);
		return flag;
	}
	
	@RequestMapping("checkRoleCode")
	@ResponseBody
	public int checkRoleCode(int id) {
		return sysRoleService.checkRoleCode(id);
	}
	@RequestMapping("selectName")
	@ResponseBody
	public int selecName(Integer id) {
		Integer role=sysRoleService.selectName(id); 
		if(role>0) {
			return 1;
		}else {
			return 0;
		}
		
	}
	@RequestMapping("userSysRole")
	@ResponseBody
	public int userSysRole(int sysRoleId,int companyId) {
		int number =sysRoleService.userSysRole(sysRoleId,companyId);
		if(number > 0) {
			return 1;
		}else {
			return 2;
		}
		
	}
	@RequestMapping("selectInvestorsCodeAndPay")
	@ResponseBody
	public Object selectInvestorsCodeAndPay(int userId) {
		List<SysRole> list =sysRoleService.selectInvestorsCodeAndPay(userId);
		return list;
	}
	
//	@RequestMapping("sysResourceDefault")
//	public @ResponseBody Object sysResourceDefault(int sysRoleId){
//		return sysRoleService.sysResourceDefault(sysRoleId);
//	}
	@RequestMapping("/sysResourceDefault")
	public @ResponseBody Object sysResourceDefault(@RequestParam("sysRoleId") int sysRoleId) {
		return TreeviewUtil.conversionDataFromList(sysRoleService.sysResourceDefault(sysRoleId));
		
	}
}