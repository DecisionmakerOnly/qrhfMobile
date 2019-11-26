package com.qrhf.service;

import java.util.List;
import java.util.Map;

import com.qrhf.pojo.ProjectGoods;

public interface ProjectGoodsService {

	public Map<String, Object> findList(Map<String, Object> param);

	List<ProjectGoods> insertSelective(ProjectGoods record);

	public int insertAll(List<ProjectGoods> pgList, int projectId,int companyId);

	public List<ProjectGoods> list(int projectId);

	public List<ProjectGoods> all(int projectId);

	public Map<String, Object> findMismatch(Map<String, Object> param);

	public Integer selectGoodsQuantity(Integer projectId);

	public ProjectGoods selectProjectGoodsById(int id);

	public int updateProjectGoods(ProjectGoods projectGoods);

	public int deleteProjectGoodsById(int id);

	public int updateTemporaryProjectGoods(int projectId);

	public void projectGoodsDel(int projectId);

	public int selectProjectGoodsCount(int projectId);
	
	public int preservation(int projectId);
	
	public List<ProjectGoods> findListNoPagination(Map<String,Object> param);
	
	public ProjectGoods findProjectGoodsById(int projectGoodsId,int projectUpdateId);
	
	public ProjectGoods findProjectGoodsByCode(int projectId,String code,int projectUpdateId,int companyId);
	
	public int updateProjectGoodsByProjectUpdateGoods(int projectId,int projectUpdateId,int companyId);
	public int selectProjectUpdateGroup(int projectId,int projectUpdateId);
	public int updateNotProjectGroup(int projectId,int projectUpdateId);
	
}
