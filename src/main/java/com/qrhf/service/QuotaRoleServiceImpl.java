package com.qrhf.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.QuotaRoleMapper;
import com.qrhf.pojo.QuotaRole;
@Service
public class QuotaRoleServiceImpl implements QuotaRoleService {
	@Autowired
	private QuotaRoleMapper quotaRoleMapper;
	@Override
	public Integer insertQuotaRole(QuotaRole quotaRole) {
		return quotaRoleMapper.insertQuotaRole(quotaRole);
	}

	@Override
	public QuotaRole getQuotaRoleQuotaId(Integer QuotaId,Integer quotaId) {
		return quotaRoleMapper.getQuotaRoleQuotaId(QuotaId,quotaId);
	}

	@Override
	public Integer del(Integer id) {
		return quotaRoleMapper.del(id);
	}

}
