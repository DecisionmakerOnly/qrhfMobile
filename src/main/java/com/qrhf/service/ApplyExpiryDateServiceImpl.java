package com.qrhf.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.ApplyExpiryDateMapper;
import com.qrhf.pojo.ApplyExpiryDate;
@Service
public class ApplyExpiryDateServiceImpl implements ApplyExpiryDateService {
	@Autowired
	private ApplyExpiryDateMapper applyExpiryDateMapper;
	
	@Override
	public int addApplyExpiryDate(ApplyExpiryDate applyExpiryDate) {
		try {
			applyExpiryDateMapper.addApplyExpiryDate(applyExpiryDate);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public Map<String, Object> findApplyExpiryDate(Map<String, Object> param) {
		Map<String,Object> result =new HashMap<String,Object>();
		Map<String,Object> sizeMap =new HashMap<String,Object>();
		int total=applyExpiryDateMapper.findApplyExpiryDate(sizeMap).size();
		List<ApplyExpiryDate> rows=applyExpiryDateMapper.findApplyExpiryDate(param);
		result.put("total",total);
		result.put("rows",rows);
		return result;
	}

	@Override
	public int updateApplyExpiryDate(int id,int processUserId) {
		return applyExpiryDateMapper.updateApplyExpiryDate(id,processUserId);
	}

	@Override
	public int applyExpiryDateNo(int id, String reason,int processUserId) {
		try {
			applyExpiryDateMapper.applyExpiryDateNo(id,reason,processUserId);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public int deleteApplyExpiryDate(int id) {
		try {
			applyExpiryDateMapper.deleteApplyExpiryDate(id);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

}
