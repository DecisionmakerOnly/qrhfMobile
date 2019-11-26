package com.qrhf.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.qrhf.pojo.TemporaryAuthorityRange;

public interface TemporaryAuthorityRangeMapper {
	/**
	 * 根据角色id查询此角色拥有的一次性菜单权限
	 * @param sysRole
	 * @return
	 */
	public List<String> queryRangeBySysRole(int sysRole);
	/**
	 * 添加角色菜单表
	 * @param sysRole
	 * @param sysResource
	 * @return
	 */
	public int saveTemporaryAuthorityRange(@Param("sysRole") int sysRole,@Param("sysResource")int sysResource);
	/**
	 * 删除角色菜单表
	 * @param sysRole
	 * @return
	 */
	public int delTemporaryAuthorityRange(int sysRole);
	/**
	 * 根据角色id查询
	 * @param sysRole
	 * @return
	 */
	public List<TemporaryAuthorityRange> queryTemporaryAuthorityRange(int sysRole);

}
