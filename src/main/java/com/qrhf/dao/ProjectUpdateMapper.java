package com.qrhf.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.qrhf.pojo.ProjectUpdate;

public interface ProjectUpdateMapper {
	
	public int saveProjectUpdate(ProjectUpdate projectUpdate);
	
	public int updateProjectUpdate(ProjectUpdate projectUpdate);
	
	public ProjectUpdate findProjectUpdateByCode(String code);
	
	public ProjectUpdate findProjectUpdateById(int projectUpdateId);
	
	public List<ProjectUpdate> findProjectUpdateBatches(@Param("projectId")Integer projectId,@Param("updateType")Integer updateType);

	public void deletePuProjectId(int projectId);
	
	public int updateAll(int projectUpdateId);
}
