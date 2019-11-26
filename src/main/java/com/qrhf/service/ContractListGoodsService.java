package com.qrhf.service;

import java.util.List;
import java.util.Map;

import com.qrhf.pojo.ContractListGoods;
import com.qrhf.vo.ContractListGoodsVO;

public interface ContractListGoodsService {

	public Map<String, Object> findList(Map<String, Object> param);

	public List<ContractListGoodsVO> findProjectOrder(int projectOrderId);

	public int saves(List<Map<String, Object>> mapListJson);
	
	public List<ContractListGoods> findContractListGoodsList(int contractId);
	
	public int delContractListGoodsByIds(String ids);
	
	public List<ContractListGoodsVO> findGoods(int contractId,int projectId,int projectOrderId);
	
}
