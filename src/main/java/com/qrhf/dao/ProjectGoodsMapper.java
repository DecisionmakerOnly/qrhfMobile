package com.qrhf.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.qrhf.pojo.ProjectGoods;
import com.qrhf.pojo.TemporaryProjectGoods;

public interface ProjectGoodsMapper {

	public List<ProjectGoods> findList(Map<String, Object> param);

	int insert(ProjectGoods record);

	List<ProjectGoods> selectAllProjectGoods();

	int insertSelective(ProjectGoods record);

	public void insertAll(List<ProjectGoods> progoodsList);

	ProjectGoods selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(ProjectGoods record);

	int updateByPrimaryKey(ProjectGoods record);

	public List<ProjectGoods> list(int projectId);

	public List<ProjectGoods> all(int projectId);

	public List<ProjectGoods> findMismatch(Map<String, Object> param);

	public Integer selectGoodsQuantity(Integer projectId);

	public void saveProjectUpdateResourceAll(int projectId);

	public ProjectGoods selectProjectGoodsById(int id);

	public int deleteProjectGoodsById(int id);

	public int updateProjectGoods(@Param("tpgList") List<TemporaryProjectGoods> tpgList);

	public void projectGoodsDel(int projectId);

	public int selectProjectGoodsCount(int projectId);

	public void preservation(int projectId);
	
	public List<ProjectGoods> findListNoPagination(Map<String, Object> param);
	
	public ProjectGoods findProjectGoodsById(@Param("projectGoodsId")int projectGoodsId,@Param("projectUpdateId")int projectUpdateId);
	
	public ProjectGoods findProjectGoodsByCode(@Param("projectId")int projectId,@Param("code")String code,@Param("projectUpdateId")int projectUpdateId,@Param("companyId")int companyId);
	
	public int insertProjectGoodsByProjectUpdateGoods(@Param("projectId")int projectId,@Param("projectUpdateId")int projectUpdateId);
	
	public int updateProjectGoodsByProjectUpdateGoods(@Param("projectId")int projectId,@Param("projectUpdateId")int projectUpdateId);
	
	public int deleteProjectGoodsByProjectUpdateGoods(@Param("projectId")int projectId,@Param("projectUpdateId")int projectUpdateId);
	
	public int deleteGoodsByProjectUpdateGoods(@Param("projectId")int projectId,@Param("projectUpdateId")int projectUpdateId,@Param("companyId")int companyId);
	
	public List<ProjectGoods> findProjectGoodsUpdateType(@Param("projectId")int projectId,@Param("projectUpdateId")int projectUpdateId);
	
	public int updateProjectGoodsUpdateType(List<ProjectGoods> list);
	
	
	
	
}