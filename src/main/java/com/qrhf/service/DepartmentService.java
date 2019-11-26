package com.qrhf.service;

import java.util.List;
import java.util.Map;
import com.qrhf.pojo.Department;
import com.qrhf.vo.Node;

public interface DepartmentService {
	
	public Map<String,Object> findList(Map<String,Object> param);
	
	public List<Node> tree(int companyId);
	
	public Integer saveOrUpdate(Department department);
	
	public Integer del(Integer id);
	
	public Department getById(Integer id);

	public List<Department> selectDepartment(int companyId);
	public int updateDepartmentOrderBy(List<Department> list);

}
