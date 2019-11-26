package com.qrhf.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.SellerMapper;
import com.qrhf.pojo.Seller;

@Service("sellerService")
public class SellerServiceImpl implements SellerService {
	
	@Autowired
	private SellerMapper sellerMapper;

	@Override
	public Map<String, Object> findList(Map<String, Object> param) {
		Map<String,Object> result = new HashMap<String,Object>();
		int total=sellerMapper.findList(null).size();
		List<Seller> rows=sellerMapper.findList(param);
		result.put("total",total);
		result.put("rows",rows);
		return result;
	}

	@Override
	public Integer addSeller(Seller seller) {
		return sellerMapper.addSeller(seller);
	}

	@Override
	public Seller compreSeller(Integer userId) {
		return sellerMapper.compreSeller(userId);
	}

	@Override
	public Integer updateSeller(Seller seller) {
		return sellerMapper.updateSeller(seller);
	}

	@Override
	public List<Seller> sellerList(Map<String, Object> param) {
		return sellerMapper.sellerList(param);
	}

	@Override
	public Seller checkName(String name) {
		
		return sellerMapper.checkName(name);
	}

	@Override
	public Seller checkContact(String contact) {
		
		return sellerMapper.checkContact(contact);
	}


}
