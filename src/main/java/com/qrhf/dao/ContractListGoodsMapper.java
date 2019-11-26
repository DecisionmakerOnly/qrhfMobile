package com.qrhf.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.qrhf.pojo.ContractListGoods;
import com.qrhf.vo.ContractListGoodsVO;

public interface ContractListGoodsMapper {
	
public List<ContractListGoods> findList(Map<String,Object> param);
	
	public List<ContractListGoodsVO> findProjectOrder(int projectOrderId);
	
	public int saves(@Param("contractListId")int contractListId,@Param("projectOrderId")int projectOrderId);
	
	public List<ContractListGoods> findContractListGoodsList(int contractId);
	
	public void contractListGoodsDel(Integer projectOrderId);
	
	public void delContractListGoodsId(int conractListId);
	
	public void delContractListGoodsByIds(String ids);
	
	public List<ContractListGoodsVO> findGoodsByContractId(int contrctId);
	
	public List<ContractListGoodsVO> findGoodsByProjectId(@Param("contractId")int contractId,@Param("projectId")int projectId);
	
	public List<ContractListGoodsVO> findGoodsByProjectOrderId(int projectOrderId);
	
}
