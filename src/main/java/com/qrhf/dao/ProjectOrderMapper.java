package com.qrhf.dao;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.qrhf.pojo.ProjectGroupGoods;
import com.qrhf.pojo.ProjectOrder;
import com.qrhf.pojo.ProjectOrderGoods;
import com.qrhf.vo.GoodsVO;

public interface ProjectOrderMapper {
	
    public int insert(ProjectOrder order);

    int insertSelective(ProjectOrder record);

    ProjectOrder selectByPrimaryKey(Integer projectOrderId);
    
    int updateByPrimaryKeySelective(ProjectOrder record);

    int updateByPrimaryKey(ProjectOrder record);
    
    public List<ProjectOrder> findList(Map<String,Object> param);
    
    public List<String> selectProjectOrder(Integer projectId);
    
    public void deleteGoodsAll(ProjectOrderGoods ProjectOrderGoods);

    public Integer selectOrderQuantity(Integer projectId);
    
    public void projectOrderDel(int projectId);
    
    public void projectOrderRemove(int projectOrderId);

	public List<Integer> selectPoId(int projectId);
	
	public List<GoodsVO> findProjectGroupGoodsByprojectGroupId(@Param("projectId")int projectId,@Param("projectGroupId")int projectGroupId);
	
	public void del(int projectOrderId);
	
	public ProjectOrder getProjectOrderById(int projectOrderId);
	
	public int findProjectUpdateOrderById(@Param("projectId")Integer projectId,@Param("goodsId")Integer goodsId);
	
	public List<ProjectGroupGoods> findProjectGroupDetail(int projectId);

}