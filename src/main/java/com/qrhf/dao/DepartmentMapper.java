package com.qrhf.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.qrhf.pojo.Department;
import com.qrhf.vo.Node;

public interface DepartmentMapper {

	public List<Department> findList(Map<String,Object> param);
	
	public List<Node> tree(int companyId);
	
	public Integer add(Department department);
	
	public Integer del(@Param("ids")String ids);
	
	public Department getById(Integer id);
	
	public Integer update(Department department);

	public Department checkCode(@Param("companyId")Integer companyId,@Param("id")Integer id, @Param("code")String code);

	public List<Department> selectDepartment(int companyId);
	
	public void updateDepartmentOrderBy(List<Department> list);
	
	public String findDelDepartmentIds(int departmentId);
}
