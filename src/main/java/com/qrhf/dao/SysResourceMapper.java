package com.qrhf.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.qrhf.pojo.SysResource;
import com.qrhf.pojo.TemporaryAuthority;
import com.qrhf.vo.Node;
import com.qrhf.vo.TemporaryAuthorityVO;

public interface SysResourceMapper {
	/**
	 * 查询所有启用父级菜单
	 * @return
	 */
	public List<Node> getParentResoureList();
	/**
	 *  查询一次权限范围所有启用父级菜单
	 * @return
	 */
	public List<Node>getParentRangeList();
	/**
	 * 查询父级菜单下的所有启用子菜单
	 * @param sysResource
	 * @return
	 */
	public List<SysResource> queryChildByResource(int sysResource);
	/**
	 * 根据用户id查找父级菜单
	 * @param id 登陆用户的id
	 * @return 
	 */
	public List<SysResource> getParenResourceByUserId(int id);
	
	public List<SysResource> getParenResourceForBoss();
	/**
	 * 根据父级菜单id查找对应的子级菜单id
	 * @param id
	 * @param sysResource
	 * @return
	 */
	public List<SysResource> getChildResourceBySysResource(@Param("id")int id,@Param("sysResource")int sysResource);
//	按钮权限
	/**
	 * 根据用户id 获取按钮菜单状态
	 * @param id
	 * @return
	 */
	public List<SysResource> getResourceStatusByUserId(@Param("id")int id,@Param("pageId")int pageId);
	
	public List<SysResource> findButtons(@Param("roleCode")String roleCode,@Param("userId")int userId,@Param("pageId")int pageId);
	
	public List<SysResource> findButtonsForBoss(@Param("pageId")int pageId);

	public void temporaryAuthority(TemporaryAuthority temporaryAuthority);
	
	public List<SysResource> findTemporaryAuthorityList(@Param("userId")int userId,@Param("pageId")int pageId);
	
	public void deleteTemporaryAuthority(@Param("userId")int userId,@Param("sysResourceId")int sysResourceId);
	
	public List<TemporaryAuthorityVO> findTemporaryAuthorityVOList(int companyId);
	
	public void updateTemporaryAuthority(@Param("taId")int taId,@Param("num")int num);
	
	public List<SysResource> findLeftNavSysResource(int sysRoleId);
	
	public List<Integer> sysResourceSelected(int sysRoleId);
	
//	public List<String> sysResourceSelected(int sysRoleId);
}