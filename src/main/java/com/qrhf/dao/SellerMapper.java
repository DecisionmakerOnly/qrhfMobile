package com.qrhf.dao;

import java.util.List;
import java.util.Map;

import com.qrhf.pojo.Seller;

public interface SellerMapper {

	public List<Seller> findList(Map<String,Object> param);
	
	public Integer addSeller(Seller seller);
	
	public Seller compreSeller(Integer userId);
	
	public Integer updateSeller(Seller seller);

	public List<Seller> sellerList(Map<String, Object> param);

	public Seller checkName(String name);

	public Seller checkContact(String contact);
}
