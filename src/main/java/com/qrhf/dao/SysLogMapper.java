package com.qrhf.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.qrhf.pojo.SysLog;

public interface SysLogMapper {
	
	public void saveLog(SysLog sysLog);
	
	public List<SysLog> findSysLogList(@Param("companyId")int companyId,@Param("roleType")int roleType);
	
}
