package com.qrhf.dao;

import java.util.List;
import java.util.Map;

import com.qrhf.pojo.Refund;

public interface RefundMapper {

	int add(Refund refund);

	public List<Refund> findList(Map <String ,Object> param);

	int updateStatus(Refund refund);
	
	public List<Refund> selectAll(Map<String, Object> param);


}
