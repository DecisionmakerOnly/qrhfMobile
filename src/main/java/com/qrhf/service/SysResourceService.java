package com.qrhf.service;

import java.util.List;

import com.qrhf.pojo.SysResource;
import com.qrhf.pojo.TemporaryAuthority;
import com.qrhf.vo.Node;
import com.qrhf.vo.TemporaryAuthorityVO;

public interface SysResourceService {
	
	public List<SysResource> findButtons(int userId,int pageId);
	
	public int temporaryAuthority(TemporaryAuthority temporaryAuthority);
	
	public List<SysResource> findTemporaryAuthorityList(int userId,int pageId);
	
	public int deleteTemporaryAuthority(int userId,int sysResourceId);
	
	public List<TemporaryAuthorityVO> findTemporaryAuthorityVOList(int companyId);
	
	public int updateTemporaryAuthority(int taId,int num);
	
	public List<SysResource> findLeftNavSysResource(int sysRoleId);
	
	public List<Integer> sysResourceSelected(int sysRoleId);
//	public List<Node>sysResourceSelected(int sysRoleId);
}
