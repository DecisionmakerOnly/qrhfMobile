package com.qrhf.dao;

import com.qrhf.pojo.ProjectUpdateGoods;
import com.qrhf.vo.ProjectUpdateGoodsVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface ProjectUpdateGoodsMapper {
	
	public ProjectUpdateGoodsVO findProjectUpdateGoodsById(int projectUpdateGoodsId);
	
	public ProjectUpdateGoods findProjectUpdateGoodsByIds(@Param("projectId")int projectId,@Param("projectUpdateId")int projectUpdateId,@Param("goodsId")int goodsId);
	
	public List<ProjectUpdateGoodsVO> findListForUpdate(@Param("projectId")int projectId,@Param("projectUpdateId")int projectUpdateId,@Param("sysFlowId")int sysFlowId);
	
	public int save(ProjectUpdateGoods projectUpdateGoods);
	
	public int update(ProjectUpdateGoods projectUpdateGoods);
	
	public int updateAll(int projectUpdateId);
	
	public int projectUpdateGoodsUpdate(ProjectUpdateGoods projectUpdateGoods);
	
	public int projectUpdateGoodsDel(int projectUpdateGoodsId);

	public int selectCount(@Param("projectId")int projectId,@Param("projectUpdateId")int projectUpdateId);

	public List<ProjectUpdateGoods> findList(Map<String, Object> param);

	public int getEditCount(ProjectUpdateGoods goods);
	
	public List<ProjectUpdateGoods> findSingle(Map<String, Object> param);
	
	public void delectPugProjectId(int projectId);

	void deleteById(int id);
}
