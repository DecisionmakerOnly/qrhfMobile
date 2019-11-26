package com.qrhf.service;

import com.qrhf.pojo.SysAdmin;

public interface SysAdminService {
	
	public SysAdmin loginByAdminName(String loginName);
	
	public Integer upPass(SysAdmin sysAdmin);
}
