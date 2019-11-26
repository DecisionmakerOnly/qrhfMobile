package com.qrhf.service;

import java.util.List;

import com.qrhf.pojo.ProjectUpdate;

public interface ProjectUpdateService {
	
	public int saveProjectUpdate(ProjectUpdate projectUpdate);
	
	public int updateProjectUpdate(ProjectUpdate projectUpdate);
	
	public ProjectUpdate findProjectUpdateById(int projectUpdateId);
	
	public List<ProjectUpdate> findProjectUpdateBatches(Integer projectId,Integer updateType);
	
	public int updateAll(int projectUpdateId);
}
