package com.qrhf.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.RefundMapper;
import com.qrhf.pojo.Refund;

@Service
public class RefundServiceImpl implements RefundService{

	@Autowired
	private RefundMapper refundMapper;
	
	@Override
	public Map<String, Object> findList(Map<String, Object> param) {
		Map<String,Object> result =new HashMap<String ,Object>();
		Map<String,Object> sizeMap =new HashMap<String,Object>();
		sizeMap.put("userId",param.get("userId"));
		int total=refundMapper.findList(sizeMap).size();
		List<Refund> rows=refundMapper.findList(param);
		result.put("total",total);
		result.put("rows",rows);
		return result;
	}

	
	@Override
	public Map<String, Object> selectAll(Map<String, Object> param) {
		Map<String,Object> result =new HashMap<String ,Object>();
		Map<String,Object> sizeMap =new HashMap<String,Object>();
		int total=refundMapper.selectAll(sizeMap).size();
		List<Refund> rows=refundMapper.selectAll(param);
		result.put("total",total);
		result.put("rows",rows);
		return result;
	}

	
	@Override
	public int updateStatus(Refund refund) {
		return refundMapper.updateStatus(refund);
	}

}
