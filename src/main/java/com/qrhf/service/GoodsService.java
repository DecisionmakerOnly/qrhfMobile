package com.qrhf.service;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.qrhf.pojo.Goods;
import com.qrhf.pojo.ProjectGoods;
import com.qrhf.vo.Node;

public interface GoodsService {
	
	public int insert(Goods goods);
	
	public void insertAll(List<Goods> goodsList);
	
	public Map<String,Object> findList(Map<String,Object> param);
	
	public List<Node> findGoodsTypeTreeList();
	
	public Goods getGoodsById(Integer id);
	
//	public void queryCode(List<ProjectGoods> pgList, int projectId);

	public void queryCode(Set<Goods> goodSet, List<ProjectGoods> pgList, int companyId);
	
	public Map<String, Object> findSystemGoods(Map<String,Object> param);
	
	public Map<String, Object> findCompanyCustomGoods(Map<String,Object> param);
	
	public int addCompanyCustomGoods(Goods goods);

}
