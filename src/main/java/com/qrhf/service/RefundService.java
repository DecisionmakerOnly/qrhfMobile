package com.qrhf.service;

import java.util.Map;

import com.qrhf.pojo.Refund;

public interface RefundService {

	public Map<String, Object> findList(Map<String, Object> param);

	public int updateStatus(Refund refund);

	public Map<String, Object> selectAll(Map<String, Object> param);


}
