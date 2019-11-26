package com.qrhf.service;

import java.util.List;
import java.util.Map;

import com.qrhf.pojo.SysRole;
import com.qrhf.vo.Node;

public interface SysRoleService {
	public Map<String, Object> findList(Map<String, Object> param);

	/**
	 * 新增角色
	 * 
	 * @param project
	 * @return
	 */
	public Integer add(SysRole sysRole);

	/**
	 * 根据id 查询
	 * 
	 * @param id
	 * @return
	 */
	public SysRole getRoleById(Integer id);

	/**
	 * 修改角色
	 * 
	 * @param role
	 * @return
	 */
	public Integer update(SysRole sysRole);

	/**
	 * 删除
	 * 
	 * @param id
	 * @return
	 */
	public Integer deleteUserRoleById(Integer id);

	/**
	 * 根据code 查询
	 * 
	 * @param userName
	 * @return
	 */
	SysRole roleByRoleName(String companyId,String code);

	public List<SysRole> findListUserRole(SysRole sysRole);

	/**
	 * 查询所有的菜单，并让此角色拥有的菜单选中
	 * 
	 * @param sysRole
	 * @return
	 */
	public List<Node> getViewTree(int sysRole);
	/**
	 * 查询所有权限范围菜单，并让此角色拥有的菜单选中
	 * @param sysRole
	 * @return
	 */
	public List<Node> getRangeViewTree(int sysRole);

	/**
	 * 添加角色菜单表
	 * 
	 * @param sysRole
	 * @param sysResoure
	 * @return
	 */
	public boolean saveRoleResoure(int sysRole, int[] sysResoure);
	/**
	 * 添加一次性角色菜单表
	 * @param sysRole
	 * @param sysResoure
	 * @return
	 */
	public boolean saveRoleRange(int sysRole, int[] sysResoure);
	
	public List<SysRole> findMyCompanyRole(Integer companyId);

	public String selectInvestorsCode(Integer userId);

	public int checkRoleCode(int userId);
	
	public Integer selectName(Integer id);
	
	public int checkRepeat(SysRole sysRole);
	
	public int userSysRole(int sysRoleId,int companyId);
	
	public List<SysRole> selectInvestorsCodeAndPay(Integer userId);
	
//	public List<Integer> sysResourceDefault(int sysRoleId);
	public List<Node> sysResourceDefault(int sysRoleId);

	
}
