package com.qrhf.service;

import java.util.List;
import java.util.Map;

import com.qrhf.pojo.ProjectGoods;
import com.qrhf.pojo.ProjectOrderGoods;
import com.qrhf.pojo.TemporaryProjectGoods;

public interface TemporaryProjectGoodService {

	int addTemporaryProjectGoods(ProjectGoods pg);

	TemporaryProjectGoods selectTemporaryProjectGoodsByPGId(int id);

	int updateTemporaryProjectGoods(TemporaryProjectGoods temporaryprojectGoods);

	int selectProjectGoodsByGoodsId(int id);

	TemporaryProjectGoods selectTemporaryProjectGoodsById(int tpgId);

	Map<String, Object> findList(Map<String, Object> param);

	int updateStatus(int id);

	int merge(int projectOrderId);

	List<TemporaryProjectGoods> selectByPoId(int projectOrderId);

	void addProjectOrderGoods(ProjectOrderGoods projectOrderGoods);

	int deleteByProjectOrderId(int projectOrderId);

	int selectZero(int projectOrderId);

	int selectCountPoId(int projectOrderId);

}
