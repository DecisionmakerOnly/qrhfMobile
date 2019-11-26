package com.qrhf.service;

import java.util.List;

import com.qrhf.pojo.Role;

public interface RoleService {

	public Role selectRoleId(String code);

	public List<Role> roleList();

	public int checkRole(Role role);
}
