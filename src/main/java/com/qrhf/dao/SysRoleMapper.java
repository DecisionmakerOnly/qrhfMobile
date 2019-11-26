package com.qrhf.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.qrhf.pojo.SysRole;
@Repository
public interface SysRoleMapper {
	/**
	 * 分页，查看所有角色
	 * @param param
	 * @return
	 */
	public List<SysRole> findList(Map<String, Object> param);
	/**
	 * 新增角色
	 * @param project
	 * @return
	 */
	public Integer add(SysRole sysRole);
	/**
	 * 根据id 查询
	 * @param id
	 * @return
	 */
	public SysRole getRoleById(Integer id);
	
	public SysRole getUserIdRole(Integer userId);
	/**
	 * 根据用户ID查询角色信息
	 * @param id
	 * @return
	 */
	public SysRole getRoleByUserId(Integer id);
	/**
	 * 修改角色
	 * @param role
	 * @return
	 */
	public Integer update(SysRole sysRole);
	/**
	 * 删除
	 * @param id
	 * @return
	 */
	public Integer deleteUserRoleById(Integer id);
	/**
	 * 根据code 查询
	 * @param userName
	 * @return
	 */
	SysRole roleByRoleName(@Param("companyId")String companyId,@Param("code")String code);
	/**
	 * 查询所有
	 * @param sysRole
	 * @return
	 */
	public List<SysRole> findListUserRole(SysRole sysRole);
	
	public List<SysRole> findMyCompanyRole(Integer companyId);
	
	public String selectInvestorsCode(Integer userId);
	
	public int checkRoleCode(int id);
	
	public int checkRepeat(SysRole sysRole);
	
	public Integer selectName(Integer id);
	
	public SysRole getUserCode(int companyId);
	
	public int userSysRole(@Param("sysRoleId")int sysRoleId,@Param("companyId")int companyId);

	public int getSysRoleCompanyId(int companyId);
	
	public List<SysRole> selectInvestorsCodeAndPay(Integer userId);
	
//	public List<Integer> sysResourceDefault(int sysRoleId);

	public List<String> sysResourceDefault(int sysRoleId);
	
}