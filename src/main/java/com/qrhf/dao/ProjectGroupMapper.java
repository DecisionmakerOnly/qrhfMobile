package com.qrhf.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.qrhf.pojo.ProjectGroup;
import com.qrhf.pojo.ProjectGroupGoods;
import com.qrhf.pojo.ProjectUpdateResource;
import com.qrhf.pojo.ProjectOrder;
import com.qrhf.vo.ProjectGroupVO;

public interface ProjectGroupMapper {

	public List<ProjectGroupVO> projectGroup(int projectId);

	public int save(ProjectGroup projectGroup);

	public List<ProjectGroupGoods> detail(int projectId);

	public List<ProjectGroupGoods> details(int projectId);

	public List<ProjectOrder> findList(Map<String, Object> param);

	public void saveProjectGroupGoods(@Param("list")List<ProjectGroupGoods> list,@Param("projectId")int projectId,@Param("projectGroupId")int projectGroupId);
	
	public void saveProjectGroupGoodsAttr(@Param("projectId")int projectId,@Param("projectGroupId")int projectGroupId);
	
	public List<ProjectGroup> checkDate(ProjectGroup projectGroup);

	public List<ProjectUpdateResource> findProjectUpdateResourceList(Map<String, Object> param);

	public int del(int projectGroupId);

	public int checkFindProjectGroup(int projectId);

	public void projectGroupDel(int projectId);
	
	public List<ProjectGroup> findProjectGroupDetailsNav(int projectId);
	
	public int selectGroupQuantity(int projectId);
	
	public List<ProjectGroupVO> projectGroupById(@Param("projectGroupId")int projectGroupId,@Param("projectId")int projectId);
	
	public List<ProjectGroup> findProjectGroupIdDetailsNav(int projectGroupId);
	
	public void updateProjectGroupGoods(List<ProjectGroupGoods> list);

	public int delBatchGoods(int projectGroupId);
	
	public int findProjectGroupId(int projectGroupId);
	
	public int findProjectOrderGroupId(int projectGroupId);
	
	public List<ProjectGroup> checkUpdateDate(ProjectGroup projectGroup);
	
	public int updateGroupDate(@Param("projectGroupId")int projectGroupId,@Param("startDate")String startDate,@Param("endDate")String endDate);
	
	public int selectProjectGroupDate(int projectGroupId);
	
	public int delProjectGroupDate(int projectGroupId);
	
	public int selectGroupDate(int projectId);
	
	public int insertProjectGroupByProjectUpdateGoods(@Param("projectId")int projectId,@Param("projectUpdateId")int projectUpdateId);
	
	public int selectSmallCurrentGroup(int projectId);
}