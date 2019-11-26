package com.qrhf.dao;

import java.util.List;
import java.util.Map;

import com.qrhf.pojo.ProjectGoods;
import com.qrhf.pojo.ProjectOrderGoods;
import com.qrhf.pojo.TemporaryProjectGoods;

public interface TemporaryProjectGoodMapper {

	int addTemporaryProjectGoods(ProjectGoods pg);

	TemporaryProjectGoods selectTemporaryProjectGoodsByPGId(int id);

	int updateTemporaryProjectGoods(TemporaryProjectGoods temporaryprojectGoods);

	int selectProjectGoodsByGoodsId(int id);

	TemporaryProjectGoods selectTemporaryProjectGoodsById(int tpgId);

	List<TemporaryProjectGoods> findList(Map<String, Object> param);

	List<TemporaryProjectGoods> selectProjectGoodsByProjectId(int projectId);

	int deleteByProjectId(int projectId);

	int updateStatus(int id);

	int selectCountPogId(Integer id);

	int addProjectOrderGoods(ProjectOrderGoods pog);

	TemporaryProjectGoods selectByPogId(Integer id);

	List<TemporaryProjectGoods> selectByPoId(int projectOrderId);

	int deleteByProjectOrderId(Integer projectOrderId);

	int updateStatusByPogId(int projectOrderGoodsId);

	List<TemporaryProjectGoods> selectByProjectOrderId(int projectOrderId);

	int deleteAll(int projectOrderId);

	int selectZero(int projectOrderId);

	int selectCountPoId(int projectOrderId);

}
