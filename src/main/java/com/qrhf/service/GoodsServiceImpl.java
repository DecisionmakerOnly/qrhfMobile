package com.qrhf.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.GoodsMapper;
import com.qrhf.pojo.Goods;
import com.qrhf.pojo.Project;
import com.qrhf.pojo.ProjectGoods;
import com.qrhf.vo.Node;

@Service("goodsService")
public class GoodsServiceImpl implements GoodsService {
	@Autowired
	private GoodsMapper goodsMapper;

	@Override
	public void insertAll(List<Goods> list) {
		List<Goods> goodsList = new ArrayList<>();
		for (Goods goods : list) {
			int i = goodsMapper.selectByNameAndCode(goods);
			if (i < 1)
				goodsList.add(goods);
		}
		if (goodsList.size() > 0)
			goodsMapper.insertAll(goodsList);
	}

	@Override
	public Map<String, Object> findList(Map<String, Object> param) {
		Map<String, Object> result = new HashMap<String, Object>();
		int total = goodsMapper.findList(null).size();
		List<Goods> rows = goodsMapper.findList(param);
		result.put("total", total);
		result.put("rows", rows);
		return result;
	}

	@Override
	public List<Node> findGoodsTypeTreeList() {
		return goodsMapper.findGoodsTypeTreeList();
	}

	@Override
	public Goods getGoodsById(Integer id) {
		return goodsMapper.getGoodsById(id);
	}


	@Override
	public void queryCode(Set<Goods> goodSet, List<ProjectGoods> pgList, int companyId) {
		Set<Goods> goods = goodsMapper.queryCodes(pgList, companyId);
		goodSet.removeAll(goods);
		if(goodSet.size()>0)
		goodsMapper.insertGoods(goodSet);
	}

	@Override
	public int insert(Goods goods) {
		return goodsMapper.insert(goods);
	}

	@Override
	public Map<String, Object> findSystemGoods(Map<String, Object> param) {
		Map<String,Object> result = new HashMap<String,Object>();
		Map<String,Object> sizeMap = new HashMap<String,Object>();
		sizeMap.put("projectId",param.get("projectId"));
		sizeMap.put("searchName",param.get("searchName"));
		sizeMap.put("searchCode",param.get("searchCode"));
		int total=goodsMapper.findSystemGoods(sizeMap).size();
		List<Goods> rows=goodsMapper.findSystemGoods(param);
		result.put("total",total);
		result.put("rows",rows);
		return result;
	}

	@Override
	public Map<String, Object> findCompanyCustomGoods(Map<String, Object> param) {
		Map<String,Object> result = new HashMap<String,Object>();
		Map<String,Object> sizeMap = new HashMap<String,Object>();
		sizeMap.put("companyId",param.get("companyId"));
		sizeMap.put("projectId",param.get("projectId"));
		sizeMap.put("searchName",param.get("searchName"));
		sizeMap.put("searchCode",param.get("searchCode"));
		int total=goodsMapper.findCompanyCustomGoods(sizeMap).size();
		List<Goods> rows=goodsMapper.findCompanyCustomGoods(param);
		result.put("total",total);
		result.put("rows",rows);
		return result;
	}

	@Override
	public int addCompanyCustomGoods(Goods goods) {
		try {
			goodsMapper.addCompanyCustomGoods(goods);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}


/*	@Override
	public void queryCode(List<ProjectGoods> pgList, int projectId) {
		List<ProjectGoods> goods = goodsMapper.queryCode(pgList, projectId);
		List<ProjectGoods> list = new ArrayList<>();
		list.addAll(pgList);
		for (int i = 0; i < goods.size(); i++) {
			for (int j =  list.size()-1; j >=0; j--) {
				if(goods.get(i).getCode().equals(list.get(j).getCode())) {
					list.remove(j);
				}
			}
		}
		if(list.size()>0)
		goodsMapper.addGoods(list);
	}*/

}
