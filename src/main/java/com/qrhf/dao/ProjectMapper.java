package com.qrhf.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.qrhf.pojo.Project;
import com.qrhf.pojo.ProjectGoods;
import com.qrhf.pojo.ProjectStatistics;
import com.qrhf.pojo.ProjectUpdateResource;
import com.qrhf.pojo.SysFlow;
import com.qrhf.vo.Node;

public interface ProjectMapper {
	
	public List<Project> findList(Map<String,Object> param);

    public int insert(Project project);

    public List<ProjectStatistics> statistics(int projectId);
    
    public void del(int projectId);
    
    public Integer updateByPrimaryKey(Project project);

	public Project selectProject(int projectId);

	public Project selectDuty(Integer projectId);
	
	public int updateProjectUpdateResourceAll(@Param("purList")List<ProjectUpdateResource> purList);
	
	public int updateProjectGoodsAll(@Param("pgList")List<ProjectGoods> pgList);
	
	public void deleteGoodsAll(int projectId);
	
	public Project checkProjectName (@Param("companyId")Integer companyId,@Param("id")Integer id, @Param("name")String name);
	
	public Integer contrastProjectGoods(Integer projectId);

	public List<Project> selectStaff(SysFlow sf);

	public List<Node> getWholeCheckBox(@Param("departmentId")int departmentId,@Param("companyId")int companyId);
	
	public List<Project> queryDepartmentProject(int departmentId);
	
	public int updateProjectDepartment(@Param("departmentId") int departmentId,@Param("departmentProject")int departmentProject);
	
	public List<String> returnCheckBox(int departmentId);
	
	public int updateProjectDepartmentId(int companyId);
	
	public int selectProjectQuantity(int companyId);

	public int selectDutyCount(int projectId);
	
	public List<Node> selectDutyUser(int projectId);

	public List<ProjectStatistics> statistics(Map<String, Object> param);
	
	public Integer updateDepartmentId(@Param("projectId")int projectId,@Param("departmentId")int departmentId);
	
	public Integer getCompanyUpdateDepartmentId(@Param("companyId")int companyId,@Param("departmentId")int departmentId);
	
	public int deleteDepartmentByDepartmentId(@Param("departmentIds")String departmentIds);

	public Project selectByProjectPrimaryKey(Integer projectId);
	
}