package com.qrhf.service;

import java.util.Map;

import com.qrhf.pojo.ApplyExpiryDate;

public interface ApplyExpiryDateService {
	
	public int addApplyExpiryDate(ApplyExpiryDate applyExpiryDate);
	
	public Map<String, Object> findApplyExpiryDate(Map<String, Object> param);
	
	public int updateApplyExpiryDate(int id,int processUserId);
	
	public int applyExpiryDateNo(int id,String reason,int processUserId);
	
	public int deleteApplyExpiryDate(int id);
}
