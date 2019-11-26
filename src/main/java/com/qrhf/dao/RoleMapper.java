package com.qrhf.dao;

import java.util.List;

import com.qrhf.pojo.Role;

public interface RoleMapper {

	public Role selectRoleId(String code);

	public List<Role> roleList();

//	public String selectInvestorsCode(Integer userId);
	
	public int checkRole(Role role);
}
