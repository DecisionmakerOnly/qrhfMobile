package com.qrhf.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.SysAdminMapper;
import com.qrhf.pojo.SysAdmin;
@Service("sysAdminService")
public class SysAdminServiceImpl implements SysAdminService {
	@Autowired
	private SysAdminMapper sysAdminMapper;
	
	@Override
	public SysAdmin loginByAdminName(String loginName) {
		SysAdmin sysAdmin =sysAdminMapper.loginByAdminName(loginName);
		return sysAdmin;
	}

	@Override
	public Integer upPass(SysAdmin sysAdmin) {
		return sysAdminMapper.upPass(sysAdmin);
	}

}
