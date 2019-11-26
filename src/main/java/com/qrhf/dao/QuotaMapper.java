package com.qrhf.dao;

import java.util.List;
import java.util.Map;

import com.qrhf.pojo.Quota;
import com.qrhf.pojo.QuotaStatistics;

public interface QuotaMapper {

	public List<QuotaStatistics> quotaAll();
	public void  saveQuota(Quota quota);
	public List<Quota> findList(Map<String ,Object> param);
	public List<Quota> findAll(Map<String,Object> param);
	public void updateQuota(Quota quota);
	public Integer del(Integer id);
	public Quota getQuotaById(Integer id);
	public List<Quota> getListQuotaId(Integer id);
	public Integer updateById(Integer id);
}
