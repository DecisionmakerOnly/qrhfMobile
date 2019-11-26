package com.qrhf.service;

import java.util.List;
import java.util.Map;

import com.qrhf.pojo.ProjectOrder;
import com.qrhf.pojo.ProjectOrderGoods;
import com.qrhf.pojo.TemporaryProjectGoods;

public interface ProjectOrderGoodsService {

	public List<ProjectOrderGoods> findList(Map<String, Object> param);

	public void insertAll(List<ProjectOrderGoods> orderGoodsList);

	public List<ProjectOrderGoods> list(int projectOrderId);
	
	public List<ProjectOrderGoods> projectOrdeExport(Map<String, Object> param);
	
	public Map<String, Object> statistics(Map<String, Object> param);

	public List<ProjectOrder> selectOrder(int projectId);

	public void remove(ProjectOrder projectOrder);

	public Map<String, Object> orderDetail(Map<String, Object> param);

	public void compareGoods(Map<String, Object> param);

	public Map<String, Object> mismatch(Map<String, Object> param);

//	public Object notPassCGB(Map<String, Object> param);
	public Map<String, Object> notPass(Map<String, Object> param);
	
	public TemporaryProjectGoods getById(int projectOrderGoodsId);

	public int deletePOG(int projectOrderGoodsId);

	public int editProjectOrderGoods(ProjectOrderGoods orderGoods);

//	public void compareCGB(Map<String, Object> param);

	public int deleteProjectOrder(int projectOrderId);

	public void updateIsModify(List<ProjectOrderGoods> pogIds);

	public int delpog(int projectOrderId);

	public Map<String, Object> edit(Map<String, Object> param);

	public int deleteAll(Map<String, Integer> param);

	public Map<String, Object> orderBack(Map<String, Object> param);

	public int selectById(int projectOrderGoodsId);

	public int deleteAll(int projectOrderId);

	public Map<String, Object> modifiedData(Map<String, Object> param);

	public int selectNotPass(Integer projectOrderId);

	public int deleteProjectOrderAll(int projectOrderId);

	public int selectPogExtra(int projectOrderId);

	public int selectStatus(int id);

	public int deleteById(int projectOrderGoodsId);

	public int deletePogExtra(int projectOrderId);

	public int deleteProUseless(int projectOrderId);

	public Map<String, Object> detail(Map<String, Object> param);
	
	public int selectDelPass(Integer projectOrderId);
	
	public int havePassedDel(Integer projectOrderId);
	
}
