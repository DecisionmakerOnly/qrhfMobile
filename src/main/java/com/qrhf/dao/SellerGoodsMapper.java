package com.qrhf.dao;

import java.util.List;
import java.util.Map;

import com.qrhf.pojo.SellerGoods;

public interface SellerGoodsMapper {

	public List<SellerGoods> findList(Map<String,Object> param);
	
	public Integer addGoods(SellerGoods sellerGoods);

	public Integer delGoods(Integer id);

	public SellerGoods toUpdate(Integer id);

	public void update(SellerGoods sellerGoods);

	public List<SellerGoods> goodView(Map<String, Object> param);
}
