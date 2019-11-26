package com.qrhf.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.qrhf.pojo.ProjectGoods;
import com.qrhf.pojo.ProjectGroupGoods;

public interface ProjectGroupGoodsMapper {
	public void projectGroupGoodsDel(int projectId);
//	public void insertProjectGroupGoods(List<ProjectGroupGoods> list);
	public int updateProjectGroupGoodsUpdate(List<ProjectGroupGoods> list);
	public List<ProjectGroupGoods> findProjectGroupUpdateAmount(@Param("projectId")int projectId,@Param("projectUpdateId")int projectUpdateId);
	public List<ProjectGroupGoods> findProjectGroupUpdateAmountAndPrice(@Param("projectId")int projectId,@Param("projectUpdateId")int projectUpdateId);
//	public List<ProjectGroupGoods> selectProjectGroupSurplusAmount(@Param("projectId")int projectId,@Param("projectUpdateId")int projectUpdateId);
}
