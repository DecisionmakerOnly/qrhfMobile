package com.qrhf.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.qrhf.dao.GoodsMapper;
import com.qrhf.dao.ProjectGoodsBakMapper;
import com.qrhf.dao.ProjectGoodsMapper;
import com.qrhf.dao.ProjectGroupGoodsMapper;
import com.qrhf.dao.ProjectGroupMapper;
import com.qrhf.dao.ProjectMapper;
import com.qrhf.dao.ProjectOrderGoodsMapper;
import com.qrhf.dao.ProjectOrderMapper;
import com.qrhf.dao.ProjectUpdateGoodsMapper;
import com.qrhf.dao.ProjectUpdateMapper;
import com.qrhf.dao.ProjectUpdateResourceMapper;
import com.qrhf.pojo.Project;
import com.qrhf.pojo.ProjectGoods;
import com.qrhf.pojo.ProjectStatistics;
import com.qrhf.pojo.ProjectUpdateResource;
import com.qrhf.pojo.SysFlow;
import com.qrhf.vo.Node;

@Service
public class ProjectServiceImpl implements ProjectService {

	@Autowired
	private ProjectMapper projectMapper;
	@Autowired
	private ProjectOrderMapper orderMapper;
	@Autowired
	private ProjectOrderGoodsMapper pogMapper;
	@Autowired
	private ProjectGoodsMapper pgMapper;
	@Autowired
	private ProjectUpdateResourceMapper purMapper;
	@Autowired
	private ProjectGroupMapper projectGroupMapper;
	@Autowired
	private ProjectGroupGoodsMapper pggMapper;
	@Autowired
	private GoodsMapper goodsMapper;
	@Autowired
	private ProjectGoodsBakMapper projectGoodsBakMapper;
	@Autowired
	private ProjectUpdateMapper projectUpdateMapper;
	@Autowired
	private ProjectUpdateGoodsMapper projectUpdateGoodsMapper;	
	@Override
	public int insert(Project project) {
		Project pro=projectMapper.checkProjectName(project.getCompanyId(),project.getId()==null?0:project.getId(),project.getName());
		if(pro==null) {
			projectMapper.insert(project);
			return 1;
		}else {
			return 2;
		}
	}
	@Override
	public List<ProjectStatistics> statistics(int projectId) {
		return projectMapper.statistics(projectId);
	}

	@Override
	public Map<String, Object> findList(Map<String, Object> param) {
		Map<String,Object> result = new HashMap<String,Object>();
		Map<String,Object> sizeMap = new HashMap<String,Object>();
		sizeMap.put("userId",param.get("userId"));
		sizeMap.put("companyId",param.get("companyId"));
		sizeMap.put("departmentId",param.get("departmentId"));
		int total=projectMapper.findList(sizeMap).size();
		List<Project> rows=projectMapper.findList(param);
		result.put("total",total);
		result.put("rows",rows);
		return result;
	}

	@Override
	public void del(int projectId) {
//		contractMapper.contractDel(projectId);
		pogMapper.ProjectOrderGoodsDel(projectId);
		pgMapper.projectGoodsDel(projectId);
		orderMapper.projectOrderDel(projectId);
		projectGroupMapper.projectGroupDel(projectId);
		pggMapper.projectGroupGoodsDel(projectId);
		purMapper.projectUpdateResourceDel(projectId);
		projectMapper.del(projectId);
//		goodsMapper.deleteGoodsProjectId(projectId);
		projectGoodsBakMapper.deleteProjectGoodsBakProjectId(projectId);
		projectUpdateMapper.deletePuProjectId(projectId);
		projectUpdateGoodsMapper.delectPugProjectId(projectId);	
	}

	@Override
	public Integer updateByPrimaryKey(Project project) {
		return projectMapper.updateByPrimaryKey(project);
	}

	@Override
	public Project selectProject(int projectId) {
		return projectMapper.selectProject(projectId);
	}

	@Override
	public Project selectDuty(Integer id) {
		return projectMapper.selectDuty(id);
	}

	@Override
	public int updateProjectUpdateResourceAll(List<ProjectUpdateResource> purList) {
		try {
			List<ProjectUpdateResource> list = new ArrayList<ProjectUpdateResource>();
			for(int i=0;i<purList.size();i++){
				ProjectUpdateResource pur= purList.get(i);
				if(pur.getIsUpdatePrice()==null){
					pur.setIsUpdatePrice(0);
				}
				if(pur.getIsUpdateAmount()==null){
					pur.setIsUpdateAmount(0);
				}
				list.add(pur);
			}
			projectMapper.updateProjectUpdateResourceAll(list);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
	}

	@Override
	public int updateProjectGoodsAll(List<ProjectGoods> pgList) {
		try {
//			List<ProjectGoods> list = new ArrayList<ProjectGoods>();
//			for(int i=0;i<pgList.size();i++){
//				ProjectGoods pg = pgList.get(i);
//				if(pg.getPrice()!=null || pg.getAmount()!=null){
//					list.add(pg);
//				}
//			}
			projectMapper.updateProjectGoodsAll(pgList);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public int deleteGoodsAll(int projectId) {
		try {
			goodsMapper.deleteGoodsProjectId(projectId);
			projectMapper.deleteGoodsAll(projectId);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
	}
	@Override
	public Integer contrastProjectGoods(Integer projectId) {
		return projectMapper.contrastProjectGoods(projectId);
	}
	@Override
	public List<Project> selectStaff(SysFlow sf) {
		return projectMapper.selectStaff(sf);
	}
	@Override
	public List<Node> getCheckBox(int departmentId,int companyId) {
		return projectMapper.getWholeCheckBox(departmentId,companyId);
	}

	@Override
	public List<Node> selectDutyUser(int projectId) {
		return projectMapper.selectDutyUser(projectId);
	}
	
	@Override
	public int selectDutyCount(int projectId) {
		return projectMapper.selectDutyCount(projectId);
	}
	
	@Override
	public boolean saveDepartmentProject(int departmentId, int[] departmentProject,int companyId) {
		boolean flag=false;
		int sum = 0;
		List <Project> dpList=projectMapper.queryDepartmentProject(departmentId);
		if(dpList !=null && dpList.size() > 0) {
			Integer x=projectMapper.updateProjectDepartmentId(companyId);
			if(x > 0) {
				for(Integer i : departmentProject) {
					Integer j=projectMapper.updateProjectDepartment(departmentId, i);
					sum +=j;
				}
				if(sum == departmentProject.length) {
					flag = true;
				}
			}
		}else {
			for(Integer i : departmentProject) {
				Integer j = projectMapper.updateProjectDepartment(departmentId, i);
				sum += j;
			}
			if(sum == departmentProject.length) {
				flag = true;
			}
		}
		
		return flag;
	}

	@Override
	public int selectProjectQuantity(int companyId) {
		return projectMapper.selectProjectQuantity(companyId);
	}
	
	@Override
	public Integer updateDepartmentId(int projectId, int departmentId) {
		return projectMapper.updateDepartmentId(projectId, departmentId);
	}
	@Override
	public Integer getCompanyUpdateDepartmentId(int companyId, int departmentId) {
		return projectMapper.getCompanyUpdateDepartmentId(companyId, departmentId);
	}
	@Override
	public Project selectByProjectPrimaryKey(Integer projectId) {
		return projectMapper.selectByProjectPrimaryKey(projectId);
	}
}
