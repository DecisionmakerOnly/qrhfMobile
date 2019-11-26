package com.qrhf.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.RoleMapper;
import com.qrhf.pojo.Role;

@Service
public class RoleServiceImpl implements RoleService{

	@Autowired
	private RoleMapper roleMapper;
	
	@Override
	public Role selectRoleId(String code) {
		return roleMapper.selectRoleId(code);
	}

	@Override
	public List<Role> roleList() {
		return roleMapper.roleList();
	}

	@Override
	public int checkRole(Role role) {
		return roleMapper.checkRole(role);
	}

}
