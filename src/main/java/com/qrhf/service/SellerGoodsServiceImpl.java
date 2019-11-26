package com.qrhf.service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.SellerGoodsMapper;
import com.qrhf.pojo.SellerGoods;


@Service("sellerGoodsService")
public class SellerGoodsServiceImpl implements SellerGoodsService{

	@Autowired
	private SellerGoodsMapper sellerGoodsMapper;
	
	@Override
	public Map<String, Object> findList(Map<String, Object> param) {
		Map<String,Object> result = new HashMap<String,Object>();
		int total=sellerGoodsMapper.findList(null).size();
		List<SellerGoods> rows=sellerGoodsMapper.findList(param);
		result.put("total",total);
		result.put("rows",rows);
		return result;
	}

	@Override
	public Integer addGoods(SellerGoods sellerGoods) {
		return sellerGoodsMapper.addGoods(sellerGoods);
	}

	@Override
	public Integer delGoods(Integer id) {
		return sellerGoodsMapper.delGoods(id);
	}

	@Override
	public SellerGoods toUpdate(Integer id) {
		return sellerGoodsMapper.toUpdate(id);
	}

	@Override
	public void update(SellerGoods sellerGoods) {
		sellerGoodsMapper.update(sellerGoods);		
	}

	@Override
	public List<SellerGoods> goodView(Map<String, Object> param) {
		return sellerGoodsMapper.goodView(param);
	}

	
	


}
