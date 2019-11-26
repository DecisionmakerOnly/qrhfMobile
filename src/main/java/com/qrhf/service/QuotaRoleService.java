package com.qrhf.service;

import com.qrhf.pojo.QuotaRole;

public interface QuotaRoleService {
	public Integer insertQuotaRole(QuotaRole quotaRole);
	public QuotaRole getQuotaRoleQuotaId(Integer companyId,Integer quotaId);
	public Integer del(Integer id);
}
