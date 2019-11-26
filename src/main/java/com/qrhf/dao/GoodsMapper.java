package com.qrhf.dao;

import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.ibatis.annotations.Param;

import com.qrhf.pojo.Goods;
import com.qrhf.pojo.ProjectGoods;
import com.qrhf.vo.Node;

public interface GoodsMapper {

	public List<Goods> selectAllGoods();

	public void insertAll(List<Goods> goodsList);

	public int selectByNameAndCode(Goods goods);

	public List<Goods> findList(Map<String, Object> param);

	public List<Node> findGoodsTypeTreeList();

	public Goods getGoodsById(Integer id);

/*	public List<ProjectGoods> queryCode(@Param(value = "list") List<ProjectGoods> pgList,
			@Param(value = "projectId") int projectId);*/
	
	public Set<Goods> queryCodes(@Param(value = "list") List<ProjectGoods> pgList,
			@Param(value = "companyId") int companyId);

//	public void addGoods(List<ProjectGoods> pgList);

	public void deleteGoodsProjectId(int companyId);

	public void insertGoods(@Param("set")Set<Goods> goodSet);
	
	public int insert(Goods goods);
	
	public List<Goods> findSystemGoods(Map<String,Object> param);
	
	public List<Goods> findCompanyCustomGoods(Map<String,Object> param);
	
	public void addCompanyCustomGoods(Goods goods);

}