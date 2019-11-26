package com.qrhf.service;

import java.util.List;
import java.util.Map;

import com.qrhf.pojo.Project;
import com.qrhf.pojo.ProjectGoods;
import com.qrhf.pojo.ProjectOrder;
import com.qrhf.pojo.ProjectStatistics;
import com.qrhf.pojo.ProjectUpdateResource;
import com.qrhf.pojo.SysFlow;
import com.qrhf.vo.Node;

public interface ProjectService {

	public Map<String, Object> findList(Map<String, Object> param);

	public int insert(Project project);

	public List<ProjectStatistics> statistics(int projectId);

	public void del(int projectId);
	
	public Integer updateByPrimaryKey(Project project);

	public Project selectProject(int projectId);

	public Project selectDuty(Integer id);

	public int updateProjectUpdateResourceAll(List<ProjectUpdateResource> purList);

	public int updateProjectGoodsAll(List<ProjectGoods> pgList);

	public int deleteGoodsAll(int projectId);
	
	public Integer contrastProjectGoods(Integer projectId);

	public List<Project> selectStaff(SysFlow sf);

	public List<Node> getCheckBox(int departmentId,int compantId);
	
	public boolean saveDepartmentProject(int departmentId ,int[] departmentProject,int companyId);
	
	public int selectProjectQuantity(int companyId);
	
	public int selectDutyCount(int projectId);
	
	public List<Node> selectDutyUser(int projectId);

	public Integer updateDepartmentId(int projectId,int departmentId);
	
	public Integer getCompanyUpdateDepartmentId(int companyId,int departmentId);
	
	public Project selectByProjectPrimaryKey(Integer projectId);
}
