package com.qrhf.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.ContractMapper;
import com.qrhf.dao.ProjectGoodsMapper;
import com.qrhf.dao.ProjectGroupGoodsMapper;
import com.qrhf.dao.ProjectGroupMapper;
import com.qrhf.dao.ProjectOrderGoodsMapper;
import com.qrhf.dao.ProjectOrderMapper;
import com.qrhf.dao.ProjectUpdateResourceMapper;
import com.qrhf.pojo.Contract;
import com.qrhf.pojo.ProjectGroupGoods;
import com.qrhf.pojo.ProjectOrder;
import com.qrhf.pojo.ProjectOrderGoods;
import com.qrhf.vo.GoodsVO;

@Service
public class ProjectOrderServiceImpl implements ProjectOrderService {

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
	private ContractMapper contractMapper;
	@Override
	public int insert(ProjectOrder projectOrder) {
		return orderMapper.insert(projectOrder);
	}

	@Override
	public Map<String, Object> findList(Map<String, Object> param) {
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> sizeMap = new HashMap<String, Object>();
		sizeMap.put("projectId", param.get("projectId"));
		int total = orderMapper.findList(sizeMap).size();
		List<ProjectOrder> rows = orderMapper.findList(param);
		result.put("total", total);
		result.put("rows", rows);
		return result;
	}

	@Override
	public List<String> selectProjectOrder(Integer projectId) {
		return orderMapper.selectProjectOrder(projectId); 
	}

	@Override
	public void deleteGoodsAll(ProjectOrderGoods ProjectOrderGoods) {
		orderMapper.projectOrderRemove(ProjectOrderGoods.getProjectOrderId());
		orderMapper.deleteGoodsAll(ProjectOrderGoods);	
	}

	@Override
	public Integer selectOrderQuantity(Integer projectId) {
		return orderMapper.selectOrderQuantity(projectId);
	}

	@Override
	public void projectOrderDel(int projectId) {
		contractMapper.contractDel(projectId);
		pogMapper.ProjectOrderGoodsDel(projectId);
		pgMapper.projectGoodsDel(projectId);
		orderMapper.projectOrderDel(projectId);
		projectGroupMapper.projectGroupDel(projectId);
		pggMapper.projectGroupGoodsDel(projectId);
		purMapper.projectUpdateResourceDel(projectId);
	}

	@Override
	public ProjectOrder selectByPrimaryKey(Integer projectOrderId) {
		return orderMapper.selectByPrimaryKey(projectOrderId);
	}

	@Override
	public List<Integer> selectPoId(int projectId) {
		return orderMapper.selectPoId(projectId);
	}

	@Override
	public List<GoodsVO> findProjectGroupGoodsByprojectGroupId(int projectId,int projectGroupId) {
		return orderMapper.findProjectGroupGoodsByprojectGroupId(projectId,projectGroupId);
	}

	@Override
	public List<Contract> selectContractList(int companyId) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("companyId",companyId);
		return contractMapper.findList(param);
	}

	@Override
	public int del(int projectOrderId) {
		try {
			orderMapper.del(projectOrderId);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}

	@Override
	public int findProjectUpdateOrderById(Integer projectId,Integer goodsId) {
		return orderMapper.findProjectUpdateOrderById(projectId,goodsId);
	}

	@Override
	public List<ProjectGroupGoods> findProjectGroupDetail(int projectGroupId) {
		return orderMapper.findProjectGroupDetail(projectGroupId);
	}

}
