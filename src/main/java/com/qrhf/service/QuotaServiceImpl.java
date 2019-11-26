package com.qrhf.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.QuotaMapper;
import com.qrhf.dao.QuotaRoleMapper;
import com.qrhf.pojo.Quota;
import com.qrhf.pojo.QuotaStatistics;
@Service("quotaService")
public class QuotaServiceImpl implements QuotaService {
	
	@Autowired
	private QuotaMapper quotaMapper;
	@Autowired
	private QuotaRoleMapper quotaRoleMapper;
	
	@Override
	public List<QuotaStatistics> quotaAll() {
		return quotaMapper.quotaAll();
	}

	@Override
	public void saveQuota(Quota quota) {
		quotaMapper.saveQuota(quota);
	}
	
	@Override
	public Map<String, Object> findAll(Map<String, Object> param) {
		Map<String ,Object>result =new HashMap<String,Object>();
		int total=quotaMapper.findAll(null).size();
		List<Quota> rows=quotaMapper.findAll(param);
		result.put("total", total);
		result.put("rows", rows);
		return result;
	}
	@Override
	public Map<String, Object> findList(Map<String, Object> param) {
		Map<String,Object> result =new HashMap<String ,Object>();
		Map<String,Object> sizeMap=new HashMap<String,Object>();
		sizeMap.put("companyId", param.get("companyId"));
		int total=quotaMapper.findList(sizeMap).size();
		List<Quota> rows=quotaMapper.findList(param);
		result.put("total", total);
		result.put("rows", rows);
		return result;
	}


	@Override
	public void updateQuota(Quota quota) {
		quotaMapper.updateQuota(quota);
	}

	@Override
	public Integer del(Integer id) {
		quotaRoleMapper.del(id);
		return quotaMapper.del(id);
	}

	@Override
	public Quota getQuotaById(Integer id) {
		return quotaMapper.getQuotaById(id);
	}

	@Override
	public List<Quota> getListQuotaId(Integer id) {
		return quotaMapper.getListQuotaId(id);
	}

	@Override
	public Integer updateById(Integer id) {
		return quotaMapper.updateById(id);
	}
}
