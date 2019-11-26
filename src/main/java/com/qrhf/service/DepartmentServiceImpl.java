package com.qrhf.service;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.DepartmentMapper;
import com.qrhf.dao.ProjectMapper;
import com.qrhf.dao.UserMapper;
import com.qrhf.pojo.Department;
import com.qrhf.vo.Node;

@Service
public class DepartmentServiceImpl implements DepartmentService{

	@Autowired
	private DepartmentMapper departmentMapper;
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private ProjectMapper projectMapper;
	
	@Override
	public Map<String, Object> findList(Map<String, Object> param) {
		Map<String,Object> result = new HashMap<String,Object>();
		Map<String,Object> totalList = new HashMap<String,Object>();
		totalList.put("parentId",param.get("parentId"));
		totalList.put("companyId",param.get("companyId"));
		int total=departmentMapper.findList(totalList).size();
		List<Department> rows=departmentMapper.findList(param);
		result.put("total",total);
		result.put("rows",rows);
		return result;
	}

	@Override
	public List<Node> tree(int companyId) {
		return departmentMapper.tree(companyId);
	}

	@Override
	public Integer del(Integer id) {
		try {
			String ids = departmentMapper.findDelDepartmentIds(id);
			ids = ids.replace("$,", "");
			userMapper.deleteUserByDepartmentId(ids);
			projectMapper.deleteDepartmentByDepartmentId(ids);
			departmentMapper.del(ids);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
		
	}

	@Override
	public Department getById(Integer id) {
		return departmentMapper.getById(id);
	}

	/*@Override
	public Integer saveOrUpdate(Department department) {
		if(department.getId()!=null && department.getId()!=0){
			departmentMapper.update(department);
		}else{
			departmentMapper.add(department);
		}
		return department.getId();
	}*/
	@Override
	public Integer saveOrUpdate(Department department) {
		Department dep = departmentMapper.checkCode(department.getCompanyId(),department.getId()==null?0:department.getId(),department.getCode());
		if(dep==null) {
			if(department.getId()!=null && department.getId()!=0){
				departmentMapper.update(department);
			}else{
				departmentMapper.add(department);
			}
			return 1;
		}else {
			return -1;
		}
	}

	@Override
	public List<Department> selectDepartment(int companyId) {
		return departmentMapper.selectDepartment(companyId);
	}

	@Override
	public int updateDepartmentOrderBy(List<Department> list) {
		try {
			departmentMapper.updateDepartmentOrderBy(list);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}


	/*@Override
	public int checkCode(String code,String companyId,String name) {
		return departmentMapper.checkCode(code,companyId,name).size();
	}*/

}
