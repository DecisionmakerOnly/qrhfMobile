package com.qrhf.service;

import com.qrhf.dao.ProjectUpdateGoodsMapper;
import com.qrhf.pojo.ProjectUpdateGoods;
import com.qrhf.vo.ProjectUpdateGoodsVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ProjectUpdateGoodsServiceImpl implements ProjectUpdateGoodsService {
	
	@Autowired
	private ProjectUpdateGoodsMapper projectUpdateGoodsMapper;

	@Override
	public int saveOrUpdate(ProjectUpdateGoods projectUpdateGoods) {
		try {
			ProjectUpdateGoods pug = projectUpdateGoodsMapper.findProjectUpdateGoodsByIds(projectUpdateGoods.getProject(),projectUpdateGoods.getProjectUpdate(),projectUpdateGoods.getGoods());
			if(pug == null){
				projectUpdateGoodsMapper.save(projectUpdateGoods);
			}else{

				if(pug.getEditAmount()>projectUpdateGoods.getEditAmount()){
					if(projectUpdateGoods.getEditStatus()==1){
						projectUpdateGoods.setEditAmount(projectUpdateGoods.getEditAmount()+pug.getEditAmount());
					}else if(projectUpdateGoods.getEditStatus()==2){
						projectUpdateGoods.setEditAmount(pug.getEditAmount()-projectUpdateGoods.getEditAmount());
					}
					projectUpdateGoods.setEditStatus(1);
				}else{
					if(projectUpdateGoods.getEditStatus()==1){
						projectUpdateGoods.setEditAmount(projectUpdateGoods.getEditAmount()+pug.getEditAmount());
						projectUpdateGoods.setEditStatus(1);
					}else if(projectUpdateGoods.getEditStatus()==2){
						double result = projectUpdateGoods.getEditAmount() - pug.getEditAmount();
						projectUpdateGoods.setEditAmount(result);
						projectUpdateGoods.setEditStatus(2);
						if (result == 0) {
							projectUpdateGoodsMapper.deleteById(pug.getId());
						}
					}
				}
				projectUpdateGoodsMapper.update(projectUpdateGoods);
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public List<ProjectUpdateGoodsVO> findListForUpdate(int projectId,int projectUpdateId,int sysFlowId) {
		return projectUpdateGoodsMapper.findListForUpdate(projectId,projectUpdateId,sysFlowId);
	}

	@Override
	public int updateAll(int projectUpdateId) {
		return projectUpdateGoodsMapper.updateAll(projectUpdateId);
	}

	@Override
	public ProjectUpdateGoodsVO findProjectUpdateGoodsById(int projectUpdateGoodsId) {
		return projectUpdateGoodsMapper.findProjectUpdateGoodsById(projectUpdateGoodsId);
	}

	@Override
	public int projectUpdateGoodsUpdate(ProjectUpdateGoods projectUpdateGoods) {
		return projectUpdateGoodsMapper.projectUpdateGoodsUpdate(projectUpdateGoods);
	}

	@Override
	public int projectUpdateGoodsDel(int projectUpdateGoodsId) {
		return projectUpdateGoodsMapper.projectUpdateGoodsDel(projectUpdateGoodsId);
	}

	@Override
	public int selectCount(int projectId, int projectUpdateId) {
		return projectUpdateGoodsMapper.selectCount(projectId,projectUpdateId);
	}

	@Override
	public Map<String, Object> findList(Map<String, Object> param) {
		Map<String,Object> result = new HashMap<String,Object>();
		Map<String,Object> sizeMap = new HashMap<String,Object>();
		sizeMap.put("projectId",param.get("projectId"));
		sizeMap.put("isValid",param.get("isValid"));
		sizeMap.put("updateType",param.get("updateType"));
		sizeMap.put("searchName",param.get("searchName"));
		int total=projectUpdateGoodsMapper.findList(sizeMap).size();
		List<ProjectUpdateGoods> rows=projectUpdateGoodsMapper.findList(param);
		result.put("total",total);
		result.put("rows",rows);
		return result;
	}

	@Override
	public int getEditCount(ProjectUpdateGoods goods) {
		return projectUpdateGoodsMapper.getEditCount(goods);
	}

	@Override
	public Map<String, Object> findSingle(Map<String, Object> param) {
		Map<String,Object> result = new HashMap<String,Object>();
		Map<String,Object> sizeMap = new HashMap<String,Object>();
		sizeMap.put("projectId",param.get("projectId"));
		sizeMap.put("goodsId",param.get("goodsId"));
		int total=projectUpdateGoodsMapper.findSingle(sizeMap).size();
		List<ProjectUpdateGoods> rows=projectUpdateGoodsMapper.findSingle(param);
		result.put("total",total);
		result.put("rows",rows);
		return result;
	}

}
