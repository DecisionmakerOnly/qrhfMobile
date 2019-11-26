package com.qrhf.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.ContractListGoodsMapper;
import com.qrhf.pojo.ContractListGoods;
import com.qrhf.vo.ContractListGoodsVO;

@Service("contractListGoodsService")
public class ContractListGoodsServiceImpl implements ContractListGoodsService {
	
	@Autowired
	private ContractListGoodsMapper contractListGoodsMapper;

	@Override
	public Map<String, Object> findList(Map<String, Object> param) {
		Map<String,Object> result = new HashMap<String,Object>();
		Map<String,Object> sizeMap = new HashMap<String,Object>();
		sizeMap.put("contractId",param.get("contractId"));
		sizeMap.put("projectId",0);
		sizeMap.put("contractListId",0);
		int total=contractListGoodsMapper.findList(sizeMap).size();
		List<ContractListGoods> rows=contractListGoodsMapper.findList(param);
		result.put("total",total);
		result.put("rows",rows);
		return result;
	}

	@Override
	public List<ContractListGoodsVO> findProjectOrder(int projectOrderId) {
		return contractListGoodsMapper.findProjectOrder(projectOrderId);
	}

	@Override
	public int saves(List<Map<String, Object>> mapListJson) {
		return 0;
//		return contractListGoodsMapper.saves(mapListJson);
	}

	@Override
	public List<ContractListGoods> findContractListGoodsList(int contractId) {
		return contractListGoodsMapper.findContractListGoodsList(contractId);
	}

	@Override
	public int delContractListGoodsByIds(String ids) {
		try {
			contractListGoodsMapper.delContractListGoodsByIds(ids);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public List<ContractListGoodsVO> findGoods(int contractId,int projectId,int projectOrderId) {
		try {
			List<ContractListGoodsVO> list = new ArrayList<ContractListGoodsVO>();
			if(projectId == 0){
				list = contractListGoodsMapper.findGoodsByContractId(contractId);
			}else if(projectOrderId == 0){
				list = contractListGoodsMapper.findGoodsByProjectId(contractId,projectId);
			}else{
				list = contractListGoodsMapper.findGoodsByProjectOrderId(projectOrderId);
			}
			return list;
		} catch (Exception e) {
			return null;
		}
	}

}
