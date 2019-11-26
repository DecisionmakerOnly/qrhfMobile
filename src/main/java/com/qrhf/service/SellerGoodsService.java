package com.qrhf.service;

import java.util.List;
import java.util.Map;

import com.qrhf.pojo.SellerGoods;

public interface SellerGoodsService {
	
	public Map<String,Object> findList(Map<String,Object> param);

	public Integer addGoods(SellerGoods sellerGoods);

	public Integer delGoods(Integer id);

	public SellerGoods toUpdate(Integer id);

	public void update(SellerGoods sellerGoods);

	public List<SellerGoods> goodView(Map<String, Object> param);
	
}
