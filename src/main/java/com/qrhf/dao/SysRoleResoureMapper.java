package com.qrhf.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.qrhf.pojo.SysRoleResoure;
public interface SysRoleResoureMapper {
	/**
	 * 根据角色id查询此角色拥有的菜单权限
	 * @param sysRole
	 * @return
	 */
	public List<String> queryResourceBySysRole(int sysRole);
	/**
	 * 添加角色菜单表
	 * @param sysRole
	 * @param sysResource
	 * @return
	 */
	public int saveSysRoleResource(@Param("sysRole") int sysRole,@Param("sysResource")int sysResource);
	/**
	 * 删除角色菜单表
	 * @param sysRole
	 * @return
	 */
	public int delSysRoleResource(int sysRole);
	/**
	 * 根据角色id查询
	 * @param sysRole
	 * @return
	 */
	public List<SysRoleResoure> querySysRoleResource(int sysRole);
	
	public void initTopResource(int sysRoleId);
}