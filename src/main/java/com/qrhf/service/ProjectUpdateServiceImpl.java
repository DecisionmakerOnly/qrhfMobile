package com.qrhf.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.ProjectUpdateMapper;
import com.qrhf.pojo.ProjectUpdate;

@Service
public class ProjectUpdateServiceImpl implements ProjectUpdateService {

	@Autowired
	private ProjectUpdateMapper projectUpdateMapper;
	
	@Override
	public int saveProjectUpdate(ProjectUpdate projectUpdate) {
		projectUpdateMapper.saveProjectUpdate(projectUpdate);
		return projectUpdate.getId();
	}

	@Override
	public int updateProjectUpdate(ProjectUpdate projectUpdate) {
		ProjectUpdate pu = projectUpdateMapper.findProjectUpdateByCode(projectUpdate.getCodeTitle()+projectUpdate.getCode());
		if(pu == null)
		return projectUpdateMapper.updateProjectUpdate(projectUpdate);
		return 0;
	}

	@Override
	public ProjectUpdate findProjectUpdateById(int projectUpdateId) {
		return projectUpdateMapper.findProjectUpdateById(projectUpdateId);
	}
	@Override
	public List<ProjectUpdate> findProjectUpdateBatches(Integer projectId,Integer updateType) {
		return projectUpdateMapper.findProjectUpdateBatches(projectId,updateType);
	}

	@Override
	public int updateAll(int projectUpdateId) {
		return projectUpdateMapper.updateAll(projectUpdateId);
	}
}
