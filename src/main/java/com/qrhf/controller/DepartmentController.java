package com.qrhf.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.qrhf.pojo.Department;
import com.qrhf.service.DepartmentService;
import com.qrhf.tools.TreeviewUtil;

import net.sf.json.JSONArray;

@Controller
@RequestMapping("/department")
public class DepartmentController {

	@Autowired
	private DepartmentService departmentService;
	
	@ResponseBody
	@RequestMapping("/updateDepartmentOrderBy")
	public String updateDepartmentOrderBy(@RequestParam("jsondata")String jsondata) {
		List<Department> list = new ArrayList<>();
		List<Map<String, Object>>mapListJson  = (List)JSONArray.fromObject(jsondata);
		for(int i=0;i<mapListJson.size();i++){
			Department departmentList=new Department();
			departmentList.setId(mapListJson.get(i).get("id").hashCode());   
			departmentList.setSort(i);
			list.add(departmentList);
		}
		departmentService.updateDepartmentOrderBy(list);
		return "1";
	}
	@RequestMapping("/findList")
	public @ResponseBody Object list(int pageSize, int pageNumber, int companyId, int parentId) {
		Map<String, Object> param = new HashMap<String, Object>();
		int a = (pageNumber - 1) * pageSize;
		int b = pageSize;
		param.put("a", a);
		param.put("b", b);
		param.put("companyId", companyId);
		param.put("parentId", parentId);
		return departmentService.findList(param);
	}

	@RequestMapping("/tree")
	public @ResponseBody Object tree(int companyId) {
		return TreeviewUtil.conversionDataFromList(departmentService.tree(companyId));
	}

	@RequestMapping("saveOrUpdate")
	public @ResponseBody Integer saveOrUpdate(Department department) {
		Integer dep = departmentService.saveOrUpdate(department);
		return dep;
	}

	@RequestMapping("/del")
	public @ResponseBody Integer del(Integer id) {
		return departmentService.del(id);
	}

	@RequestMapping("findDepartmentById")
	public @ResponseBody Object findDepartmentById(int id) {
		return departmentService.getById(id);
	}
	
	@RequestMapping("selectDepartment")
	@ResponseBody 
	public List<Department> selectDepartment(int companyId) {
		List<Department> list = departmentService.selectDepartment(companyId);
		return list;
	}
	
	

	/*@RequestMapping("checkCode")
	public void checkCode(HttpServletRequest request, HttpServletResponse response) throws IOException {
		PrintWriter out =response.getWriter();
		String code =request.getParameter("code");
		String companyId = request.getParameter("companyId");
		String name=request.getParameter("name");
		int i = departmentService.checkCode(code,companyId,name);
		out.println(i);
	}*/

}
