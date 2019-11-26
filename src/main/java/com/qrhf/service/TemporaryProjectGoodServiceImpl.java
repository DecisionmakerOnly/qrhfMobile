package com.qrhf.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.ProjectGoodsMapper;
import com.qrhf.dao.ProjectOrderGoodsMapper;
import com.qrhf.dao.TemporaryProjectGoodMapper;
import com.qrhf.pojo.ProjectGoods;
import com.qrhf.pojo.ProjectOrderGoods;
import com.qrhf.pojo.TemporaryProjectGoods;
@Service
public class TemporaryProjectGoodServiceImpl implements TemporaryProjectGoodService{

	@Autowired
	private TemporaryProjectGoodMapper mapper;
	@Autowired
	private ProjectGoodsMapper projectGoodsMapper;
	@Autowired
	private ProjectOrderGoodsMapper projectOrderGoodsMapper;
	
	@Override
	public int addTemporaryProjectGoods(ProjectGoods pg) {
		return mapper.addTemporaryProjectGoods(pg);
	}

	@Override
	public TemporaryProjectGoods selectTemporaryProjectGoodsByPGId(int id) {
		int goodsId = mapper.selectProjectGoodsByGoodsId(id);
		TemporaryProjectGoods tpg = new TemporaryProjectGoods();
		if(goodsId==0) {
			ProjectGoods pg = projectGoodsMapper.selectProjectGoodsById(id);
			pg.setStatus(-1);
			int t = mapper.addTemporaryProjectGoods(pg);
			if(t==1) {
				tpg = mapper.selectTemporaryProjectGoodsByPGId(id);
			}
		}else {
			tpg = mapper.selectTemporaryProjectGoodsByPGId(id);
		}
		return tpg;
	}

	@Override
	public int updateTemporaryProjectGoods(TemporaryProjectGoods temporaryprojectGoods) {
		int tpgId = temporaryprojectGoods.getId();
		TemporaryProjectGoods tpgs = mapper.selectTemporaryProjectGoodsById(tpgId);
		
		if(tpgs.getStatus()==1) {		//价格未通过
			if(!(temporaryprojectGoods.getAmount().equals(tpgs.getAmount()))) {
				temporaryprojectGoods.setStatus(3);
			}
		}else if(tpgs.getStatus()==2) {		//数量未通过
			if(!(temporaryprojectGoods.getPrice().equals(tpgs.getPrice()))) {
				temporaryprojectGoods.setStatus(3);
			}
		}
		
		return mapper.updateTemporaryProjectGoods(temporaryprojectGoods);
	}
	
	@Override
	public int selectProjectGoodsByGoodsId(int id) {
		return mapper.selectProjectGoodsByGoodsId(id);
	}

	@Override
	public TemporaryProjectGoods selectTemporaryProjectGoodsById(int tpgId) {
		return mapper.selectTemporaryProjectGoodsById(tpgId);
	}

	@Override
	public Map<String, Object> findList(Map<String, Object> param) {
		Map<String,Object> result = new HashMap<String,Object>();
		Map<String,Object> sizeMap = new HashMap<String,Object>();
		sizeMap.put("projectId",param.get("projectId"));
		int total=mapper.findList(sizeMap).size();
		List<TemporaryProjectGoods> rows=mapper.findList(param);
		result.put("total",total);
		result.put("rows",rows);
		return result;
	}
	

	@Override
	public int updateStatus(int id) {
		return mapper.updateStatus(id);
	}

	@Override
	public int merge(int projectOrderId) {
		//查询临时表的数据
		List<TemporaryProjectGoods> tpgList = mapper.selectByPoId(projectOrderId);
		int j = 0;
		for (int i = 0; i < tpgList.size(); i++) {
			if(tpgList.get(i).getStatus()!=0) {	
				//如果临时表数据状态不为0(非删除项) 用临时表数据覆盖对应订单商品表数据 status=-1 and is_modify=1
				j = projectOrderGoodsMapper.updateById(tpgList.get(i));
			}else {
				//如果临时表数据状态为0(非删除项) 直接删除对应订单商品表数据
				j = projectOrderGoodsMapper.deleteById(tpgList.get(i).getProjectOrderGoodsId());
			}
		}
		//改完订单商品表数据后删除对应临时表数据
		//mapper.deleteByProjectOrderId(tpgList.get(0).getProjectOrderId());
		return j;
	}

	@Override
	public List<TemporaryProjectGoods> selectByPoId(int projectOrderId) {
		return mapper.selectByPoId(projectOrderId);
	}

	@Override
	public void addProjectOrderGoods(ProjectOrderGoods projectOrderGoods) {
		mapper.addProjectOrderGoods(projectOrderGoods);		
	}

	@Override
	public int deleteByProjectOrderId(int projectOrderId) {
		return mapper.deleteByProjectOrderId(projectOrderId);
	}

	@Override
	public int selectZero(int projectOrderId) {
		return mapper.selectZero(projectOrderId);
	}

	@Override
	public int selectCountPoId(int projectOrderId) {
		return mapper.selectCountPoId(projectOrderId);
	}

}
