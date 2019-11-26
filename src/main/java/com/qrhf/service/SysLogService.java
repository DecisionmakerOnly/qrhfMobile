package com.qrhf.service;

import java.util.List;

import com.qrhf.pojo.SysLog;

public interface SysLogService {
	
	public int saveLog(SysLog sysLog);
	
	public List<SysLog> findList(int companyId,int userId);

}
