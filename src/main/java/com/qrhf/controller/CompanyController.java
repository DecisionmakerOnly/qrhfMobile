package com.qrhf.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qrhf.pojo.Company;
import com.qrhf.service.CompanyService;

@Controller
@RequestMapping("/company")
public class CompanyController {
	
	@Resource
	private CompanyService companyService;
	
	/**
	 * 企业/组织是否存在
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("checkLoginname")
	public void checkLoginname(HttpServletRequest request,HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();
		String name = request.getParameter("name");
		Company company = companyService.loginByCompanyName(name);
		if (company != null) {
			out.println(1);
		} else {
			out.println(2);
		}
	}
	
	@RequestMapping("del")
	public @ResponseBody Integer deleteCompanyById(Integer companyId) {
		companyService.deleteCompanyById(companyId);
		return 1;
		
	}
	@RequestMapping("findShareCode")
	public @ResponseBody Object list(HttpServletRequest request, int pageSize, int pageNumber) {
		Map<String, Object> param = new HashMap<String, Object>();
		int a = (pageNumber - 1) * pageSize;
		int b = pageSize;
		param.put("a", a);
		param.put("b", b);
		return companyService.findShareCode(param);
	}
}	