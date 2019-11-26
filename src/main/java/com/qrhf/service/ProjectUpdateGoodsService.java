package com.qrhf.service;

import java.util.List;
import java.util.Map;

import com.qrhf.pojo.ProjectUpdateGoods;
import com.qrhf.vo.ProjectUpdateGoodsVO;

public interface ProjectUpdateGoodsService {
	
	public List<ProjectUpdateGoodsVO> findListForUpdate(int projectId,int projectUpdateId,int sysFlowId);
	
	public int saveOrUpdate(ProjectUpdateGoods projectUpdateGoods);
	
	public int updateAll(int projectUpdateId);
	
	public ProjectUpdateGoodsVO findProjectUpdateGoodsById(int projectUpdateGoodsId);
	
	public int projectUpdateGoodsUpdate(ProjectUpdateGoods projectUpdateGoods);
	
	public int projectUpdateGoodsDel(int projectUpdateGoodsId);

	public int selectCount(int projectId, int projectUpdateId);

	public Map<String, Object> findList(Map<String, Object> param);

	public int getEditCount(ProjectUpdateGoods goods);
	
	public Map<String, Object> findSingle(Map<String, Object> param);
	
}
