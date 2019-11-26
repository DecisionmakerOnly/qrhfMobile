package com.qrhf.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.config.SystemAttributes;
import com.qrhf.dao.SysResourceMapper;
import com.qrhf.dao.SysRoleMapper;
import com.qrhf.pojo.SysResource;
import com.qrhf.pojo.SysRole;
import com.qrhf.pojo.TemporaryAuthority;
import com.qrhf.tools.Trees;
import com.qrhf.vo.Node;
import com.qrhf.vo.TemporaryAuthorityVO;

@Service
public class SysResourceServiceImpl implements SysResourceService {

	@Autowired
	private SysResourceMapper sysResourceMapper;
	@Autowired
	private SysRoleMapper sysRoleMapper;
	@Override
	public List<SysResource> findButtons(int userId, int pageId) {
		String code =sysRoleMapper.getUserIdRole(userId).getCode();
		if(null!=code && SystemAttributes.SYS_ROLE_TZRDB.equals(code)){
			return sysResourceMapper.findButtonsForBoss(pageId);
		}else{
			return sysResourceMapper.findButtons(code,userId, pageId);
		}
	}

	@Override
	public int temporaryAuthority(TemporaryAuthority temporaryAuthority) {
		try {
			sysResourceMapper.temporaryAuthority(temporaryAuthority);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public List<SysResource> findTemporaryAuthorityList(int userId, int pageId) {
		return sysResourceMapper.findTemporaryAuthorityList(userId, pageId);
	}

	@Override
	public int deleteTemporaryAuthority(int userId,int sysResourceId) {
		try {
			sysResourceMapper.deleteTemporaryAuthority(userId,sysResourceId);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
	}

	@Override
	public List<TemporaryAuthorityVO> findTemporaryAuthorityVOList(int companyId) {
		return sysResourceMapper.findTemporaryAuthorityVOList(companyId);
	}

	@Override
	public int updateTemporaryAuthority(int taId, int num) {
		try {
			sysResourceMapper.updateTemporaryAuthority(taId, num);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
	}

	@Override
	public List<SysResource> findLeftNavSysResource(int sysRoleId) {
		return sysResourceMapper.findLeftNavSysResource(sysRoleId);
	}

//	@Override
//	public List<Node> sysResourceSelected(int sysRoleId) {
//		List<Node> treeList = new ArrayList<Node>();
//		List<String> list = sysResourceMapper.sysResourceSelected(sysRoleId);
//		List<Node> nodeList = sysResourceMapper.getParentResoureList();
//		for (Node node : nodeList) {
//			for (String s : list) {
//				if (node.getId().equals(s)) {
//					Trees t = new Trees();
//					t.setChecked(true);
//					node.setState(t);
//				}
//			}
//			treeList.add(node);
//		}
//		return treeList;
//	}
	@Override
	public List<Integer> sysResourceSelected(int sysRoleId) {
		return sysResourceMapper.sysResourceSelected(sysRoleId);
	}

}
