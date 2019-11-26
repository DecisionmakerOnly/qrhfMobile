package com.qrhf.service;

import java.util.List;
import java.util.Map;

import com.qrhf.pojo.Contract;
import com.qrhf.pojo.ProjectGroupGoods;
import com.qrhf.pojo.ProjectOrder;
import com.qrhf.pojo.ProjectOrderGoods;
import com.qrhf.vo.GoodsVO;

public interface ProjectOrderService {

	public int insert(ProjectOrder projectOrder);

	public Map<String,Object> findList(Map<String,Object> param);
	
	public List<String> selectProjectOrder(Integer projectId);
	
	public void deleteGoodsAll(ProjectOrderGoods ProjectOrderGoods);
	
	public Integer selectOrderQuantity(Integer projectId);
	
	public void projectOrderDel(int projectId);
	
	 ProjectOrder selectByPrimaryKey(Integer projectOrderId);

	public List<Integer> selectPoId(int projectId);
	
	public List<GoodsVO> findProjectGroupGoodsByprojectGroupId(int projectId,int projectGroupId);
	
	public List<Contract> selectContractList(int companyId);
	
	public int del(int projectOrderId);
	
	public int findProjectUpdateOrderById(Integer projectId,Integer goodsId);
	
	public List<ProjectGroupGoods> findProjectGroupDetail(int projectGroupId);

}
