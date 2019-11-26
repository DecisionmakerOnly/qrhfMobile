package com.qrhf.dao;

import com.qrhf.pojo.SysAdmin;

public interface SysAdminMapper {
	public SysAdmin loginByAdminName(String loginName);
	public Integer upPass(SysAdmin sysAdmin);
}
