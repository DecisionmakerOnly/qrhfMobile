package com.qrhf.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.ProjectGroupMapper;
import com.qrhf.pojo.ProjectGroup;
import com.qrhf.pojo.ProjectGroupGoods;
import com.qrhf.pojo.ProjectUpdateResource;
import com.qrhf.pojo.ProjectOrder;
import com.qrhf.vo.ProjectGroupVO;

@Service
public class ProjectGroupServiceImpl implements ProjectGroupService {

	@Autowired
	private ProjectGroupMapper projectGroupMapper;

	@Override
	public List<ProjectGroupVO> projectGroup(int projectId) {
		return projectGroupMapper.projectGroup(projectId);
	}

	@Override
	public Map<String, Object> findList(Map<String, Object> param) {
		Map<String,Object> result = new HashMap<String,Object>();
		Map<String,Object> sizeMap = new HashMap<String,Object>();
		sizeMap.put("projectId",param.get("projectId"));
		int total=projectGroupMapper.findList(sizeMap).size();
		List<ProjectOrder> rows=projectGroupMapper.findList(param);
		result.put("total",total);
		result.put("rows",rows);
		return result;
	}
	
	@Override
	public int save(ProjectGroup projectGroup) {
		return projectGroupMapper.save(projectGroup);
	}

	@Override
	public void saveProjectGroupGoods(List<ProjectGroupGoods> list,int projectId,int projectGroupId) {
		projectGroupMapper.saveProjectGroupGoods(list,projectId,projectGroupId);
		projectGroupMapper.saveProjectGroupGoodsAttr(projectId,projectGroupId);
	}

	@Override
	public List<ProjectGroupGoods> detail(int projectGroupId) {
		return projectGroupMapper.detail(projectGroupId);
	}

	@Override
	public int checkDate(ProjectGroup projectGroup) {
		return projectGroupMapper.checkDate(projectGroup).size();
	}

	@Override
	public List<ProjectUpdateResource> findProjectUpdateResourceList(Map<String, Object> param) {
		return projectGroupMapper.findProjectUpdateResourceList(param);
	}

	@Override
	public int del(int projectGroupId) {
		try {
			projectGroupMapper.del(projectGroupId);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
		
	}

	@Override
	public int checkFindProjectGroup(int projectId) {
		return projectGroupMapper.checkFindProjectGroup(projectId);
	}

	@Override
	public List<ProjectGroupGoods> details(int projectId) {
		return projectGroupMapper.details(projectId);
	}

	@Override
	public List<ProjectGroup> findProjectGroupDetailsNav(int projectId) {
		return projectGroupMapper.findProjectGroupDetailsNav(projectId);
	}

	@Override
	public int selectGroupQuantity(int projectId) {
		return projectGroupMapper.selectGroupQuantity(projectId);
	}
	@Override
	public List<ProjectGroupVO> projectGroupById(int projectGroupId,int projectId) {
		return projectGroupMapper.projectGroupById(projectGroupId,projectId);
	}
	@Override
	public List<ProjectGroup> findProjectGroupIdDetailsNav(int projectGroupId) {
		return projectGroupMapper.findProjectGroupIdDetailsNav(projectGroupId);
	}
	@Override
	public void updateProjectGroupGoods(List<ProjectGroupGoods> list) {
		projectGroupMapper.updateProjectGroupGoods(list);	
	}

	@Override
	public int delBatchGoods(int projectGroupId) {
		try {
			projectGroupMapper.delBatchGoods(projectGroupId);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public int findProjectGroupId(int projectGroupId) {
		return projectGroupMapper.findProjectGroupId(projectGroupId);
	}

	@Override
	public int findProjectOrderGroupId(int projectGroupId) {
		return projectGroupMapper.findProjectOrderGroupId(projectGroupId);
	}

	@Override
	public int checkUpdateDate(ProjectGroup projectGroup) {
		return projectGroupMapper.checkUpdateDate(projectGroup).size();
	}

	@Override
	public int updateGroupDate(int projectGroupId, String startDate, String endDate) {
		try {
			projectGroupMapper.updateGroupDate(projectGroupId,startDate,endDate);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public int selectProjectGroupDate(int projectGroupId) {
		return projectGroupMapper.selectProjectGroupDate(projectGroupId);
	}

	@Override
	public int delProjectGroupDate(int projectGroupId) {
		return projectGroupMapper.delProjectGroupDate(projectGroupId);
	}

	@Override
	public int selectGroupDate(int projectId) {
		try {
			return projectGroupMapper.selectGroupDate(projectId);
		} catch (Exception e) {
			System.out.println("当前时间内没有分批");
			return 0;
		}
		
	}
	@Override
	public int selectSmallCurrentGroup(int projectId) {
		return projectGroupMapper.selectSmallCurrentGroup(projectId);
	}
}