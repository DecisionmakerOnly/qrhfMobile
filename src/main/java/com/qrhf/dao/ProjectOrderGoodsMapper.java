package com.qrhf.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.qrhf.pojo.ProjectOrder;
import com.qrhf.pojo.ProjectOrderGoods;
import com.qrhf.pojo.TemporaryProjectGoods;

public interface ProjectOrderGoodsMapper {

	public List<ProjectOrderGoods> findList(Map<String, Object> param);

	int insert(ProjectOrderGoods record);

	int insertSelective(ProjectOrderGoods record);

	ProjectOrderGoods selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(ProjectOrderGoods record);

	int updateByPrimaryKey(ProjectOrderGoods record);

	public void insertAll(List<ProjectOrderGoods> list);

	public int updatePriceStatus(Map<String, Object> map);

	public int updateAmountStatus(Map<String, Object> map);

	public int updatePriceStatusForProjectGroup(Map<String, Object> map);

	public int updateAmountStatusForProjectGroup(Map<String, Object> map);

	public List<ProjectOrderGoods> list(int projectOrderId);
	
	public List<ProjectOrderGoods> projectOrdeExport(Map<String, Object> param);
	
	public List<ProjectOrder> selectOrder(int projectId);

	public List<ProjectOrderGoods> statistics(Map<String, Object> param);

	public void remove(ProjectOrder projectOrder);

	public Integer findProjectGroupId(int projectId);

	public List<ProjectOrderGoods> orderDetail(Map<String, Object> sizeMap);

	public List<ProjectOrderGoods> mismatch(Map<String, Object> param);
	
	public void ProjectOrderGoodsDel(int projectId);
	
	public void ProjectOrderGoodsDelete(int projectOrderId);
	
	public List<ProjectOrderGoods> notPass(Map<String, Object> sizeMap);

	public ProjectOrderGoods getById(int projectOrderGoodsId);

	public int deletePOG(int projectOrderGoodsId);

//	public void batchEditStatus(@Param("pogIds") List<Integer> pogIds);

	public void updateStatus(Map<String, Object> map);

	public void batchUpdateStatus(@Param("pogMap") Map<Integer, Integer> pogMap);

	public int deleteProjectOrder(int projectOrderId);

	public int selectProjectOrderGoodsCount(int projectId);

	public void updateIsModify(List<ProjectOrderGoods> pogs);

	public int delpog(int projectOrderId);

	public List<ProjectOrderGoods> edit(Map<String, Object> param);

	public int deleteAll(Map<String, Integer> param);

	public int updateById(TemporaryProjectGoods temporaryProjectGoods);

	public int deleteById(Integer projectGoodsId);

	public List<ProjectOrderGoods> orderBack(Map<String, Object> sizeMap);

//	public List<ProjectOrderGoods> pogList(Map<String, Object> param);

	public ProjectOrderGoods selectById(int projectOrderGoodsId);

	public List<ProjectOrderGoods> modifiedData(Map<String, Object> param);

	public int selectNotPass(Integer projectOrderId);
	
	public int deleteProjectOrderAll(int projectOrderId);

	public int updateStatusNotExist(Map<String, Object> map);

	public int selectPogExtra(int projectOrderId);

	public int selectStatus(int id);

	public int deletePogExtra(int projectOrderId);

	public int deleteProUseless(int projectOrderId);

	public List<ProjectOrderGoods> detail(Map<String, Object> param);

//	public List<ProjectOrderGoods> findLatestData(Map<String, Object> param);
	public int selectDelPass(Integer projectOrderId);
	public int havePassedDel(Integer projectOrderId);

	List<Double> midAndAvg(ProjectOrderGoods goods);
}