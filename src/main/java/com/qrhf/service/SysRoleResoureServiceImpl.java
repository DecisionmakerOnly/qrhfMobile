package com.qrhf.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.SysRoleResoureMapper;

@Service("roleResoureService")
public class SysRoleResoureServiceImpl implements SysRoleResoureService {
	
	@Autowired
	private SysRoleResoureMapper sysRoleResoureMapper;
	
	@Override
	public void initTopResource(int sysRoleId) {
		sysRoleResoureMapper.initTopResource(sysRoleId);
}
	
}
