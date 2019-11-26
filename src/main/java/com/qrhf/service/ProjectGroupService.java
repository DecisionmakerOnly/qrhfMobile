package com.qrhf.service;

import java.util.List;
import java.util.Map;

import com.qrhf.pojo.ProjectGroup;
import com.qrhf.pojo.ProjectGroupGoods;
import com.qrhf.pojo.ProjectUpdateResource;
import com.qrhf.vo.ProjectGroupVO;

public interface ProjectGroupService {
	
	public List<ProjectGroupVO> projectGroup(int projectId);
	
	public int save(ProjectGroup projectGroup);
	
	public List<ProjectGroupGoods> detail(int projectGroupId);
	
	public List<ProjectGroupGoods> details(int projectId);
	
	public Map<String,Object> findList(Map<String,Object> param);

	public void saveProjectGroupGoods(List<ProjectGroupGoods> list,int projectId,int projectGroupId);
	
	public int checkDate(ProjectGroup projectGroup);
	
	public List<ProjectUpdateResource> findProjectUpdateResourceList(Map<String,Object> param);
	
	public int del(int projectGroupId);
	
	public int checkFindProjectGroup(int projectId);
	
	public List<ProjectGroup> findProjectGroupDetailsNav(int projectId);
	
	public int selectGroupQuantity(int projectId);
	
	public List<ProjectGroupVO> projectGroupById(int projectGroupId,int projectId);
	
	public List<ProjectGroup> findProjectGroupIdDetailsNav(int projectGroupId);
	
	public void updateProjectGroupGoods(List<ProjectGroupGoods> list);
	
	public int delBatchGoods(int projectGroupId);
	
	public int findProjectGroupId(int projectGroupId);
	
	public int findProjectOrderGroupId(int projectGroupId);
	
	public int checkUpdateDate(ProjectGroup projectGroup);
	
	public int updateGroupDate(int projectGroupId,String startDate,String endDate);
	
	public int selectProjectGroupDate(int projectGroupId);
	
	public int delProjectGroupDate(int projectGroupId);
	
	public int selectGroupDate(int projectId);
	
	public int selectSmallCurrentGroup(int projectId);
}
