package com.qrhf.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.qrhf.pojo.ApplyExpiryDate;

public interface ApplyExpiryDateMapper {
	
	public void addApplyExpiryDate(ApplyExpiryDate applyExpiryDate);
	
	public List<ApplyExpiryDate> findApplyExpiryDate(Map <String ,Object> param);
	
	public int updateApplyExpiryDate(@Param("id")int id,@Param("processUserId")int processUserId);
	
	public int applyExpiryDateNo(@Param("id")int id,@Param("reason")String reason,@Param("processUserId")int processUserId);
	
	public int deleteApplyExpiryDate(int id);
}
