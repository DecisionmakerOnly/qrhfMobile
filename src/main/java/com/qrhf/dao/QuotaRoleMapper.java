package com.qrhf.dao;

import com.qrhf.pojo.QuotaRole;

public interface QuotaRoleMapper {
	public Integer insertQuotaRole(QuotaRole quotaRole);
	public QuotaRole getQuotaRoleQuotaId(Integer companyId,Integer quotaId);
	public Integer del(Integer id);
}
