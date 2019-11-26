package com.qrhf.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.SysLogMapper;
import com.qrhf.dao.SysRoleMapper;
import com.qrhf.pojo.SysLog;
import com.qrhf.pojo.SysRole;

@Service
public class SysLogServiceImpl implements SysLogService {
	
	@Autowired
	private SysLogMapper sysLogMapper;
	@Autowired
	private SysRoleMapper sysRoleMapper;

	@Override
	public int saveLog(SysLog sysLog) {
		sysLogMapper.saveLog(sysLog);
		return 1;
	}

	@Override
	public List<SysLog> findList(int companyId,int userId) {
		SysRole sysRole = sysRoleMapper.getRoleByUserId(userId);
		if(sysRole.getCode().equals("TZRDB")){
			return sysLogMapper.findSysLogList(companyId,2);
		}else if(sysRole.getCode().equals("TZR")){
			return sysLogMapper.findSysLogList(companyId,3);
		}else{
			return null;
		}
	}

}
