package com.qrhf.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.SysResourceMapper;
import com.qrhf.dao.SysRoleMapper;
import com.qrhf.dao.SysRoleResoureMapper;
import com.qrhf.dao.TemporaryAuthorityRangeMapper;
import com.qrhf.pojo.SysRole;
import com.qrhf.pojo.SysRoleResoure;
import com.qrhf.pojo.TemporaryAuthorityRange;
import com.qrhf.tools.Trees;
import com.qrhf.vo.Node;

@Service
public class SysRoleServiceImpl implements SysRoleService {
	@Autowired
	private SysRoleMapper sysRoleMapper;
	@Autowired
	private SysResourceMapper sysResourceMapper;
	@Autowired
	private SysRoleResoureMapper sysRoleResourceMapper;
	@Autowired
	private TemporaryAuthorityRangeMapper temporaryAuthorityRangeMapper;

	@Override
	public Map<String, Object> findList(Map<String, Object> param) {
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> sizeMap = new HashMap<String, Object>();
		sizeMap.put("companyId", param.get("companyId"));
		int total = sysRoleMapper.findList(sizeMap).size();
		List<SysRole> rows = sysRoleMapper.findList(param);
		result.put("total", total);
		result.put("rows", rows);
		return result;
	}

	@Override
	public Integer add(SysRole sysRole) {
		return sysRoleMapper.add(sysRole);
	}

	@Override
	public SysRole getRoleById(Integer id) {
		return sysRoleMapper.getRoleById(id);
	}

	@Override
	public Integer update(SysRole sysRole) {
		return sysRoleMapper.update(sysRole);
	}

	@Override
	public Integer deleteUserRoleById(Integer id) {
		sysRoleResourceMapper.delSysRoleResource(id);
		return sysRoleMapper.deleteUserRoleById(id);
	}

	@Override
	public SysRole roleByRoleName(String companyId, String code) {
		SysRole sysRole = sysRoleMapper.roleByRoleName(companyId, code);
		return sysRole;
	}

	@Override
	public List<SysRole> findListUserRole(SysRole sysRole) {
		return sysRoleMapper.findListUserRole(sysRole);
	}

	@Override
	public List<Node> getRangeViewTree(int sysRole) {
		List<Node> treeList = new ArrayList<Node>();
		List<String> list = temporaryAuthorityRangeMapper.queryRangeBySysRole(sysRole);
		List<Node> nodeList = sysResourceMapper.getParentRangeList();
		for (Node nodeRange : nodeList) {
			for (String s : list) {
				if (nodeRange.getId().equals(s)) {
					Trees t = new Trees();
					t.setChecked(true);
					nodeRange.setState(t);
					;
				}
			}
			treeList.add(nodeRange);
		}
		return treeList;
	}

	@Override
	public List<Node> getViewTree(int sysRole) {
		List<Node> treeList = new ArrayList<Node>();
		List<String> list = sysRoleResourceMapper.queryResourceBySysRole(sysRole);
		List<Node> nodeList = sysResourceMapper.getParentResoureList();
		for (Node node : nodeList) {
			for (String s : list) {
				if (node.getId().equals(s)) {
					Trees t = new Trees();
					t.setChecked(true);
					node.setState(t);
				}
			}
			treeList.add(node);
		}
		return treeList;
	}

	@Override
	public boolean saveRoleRange(int sysRole, int[] sysResoure) {
		boolean flag = false;
		int sum = 0;
		List<TemporaryAuthorityRange> tarList=temporaryAuthorityRangeMapper.queryTemporaryAuthorityRange(sysRole);
		if(tarList != null && tarList.size() > 0) {
			int x =temporaryAuthorityRangeMapper.delTemporaryAuthorityRange(sysRole);
			if(x > 0) {
				for(Integer i : sysResoure) {
					Integer j =temporaryAuthorityRangeMapper.saveTemporaryAuthorityRange(sysRole, i);
					sum +=j;
				}if(sum == sysResoure.length) {
					flag = true;	
				}
			}
		}else {
			for(Integer i : sysResoure) {
				Integer j = temporaryAuthorityRangeMapper.saveTemporaryAuthorityRange(sysRole, i);
				sum += j;
			}if(sum == sysResoure.length) {
				flag = true;
			}
		}
		return flag;
	}

	@Override
	public boolean saveRoleResoure(int sysRole, int[] sysResoure) {
		boolean flag = false;
		int sum = 0;
		List<SysRoleResoure> srrList = sysRoleResourceMapper.querySysRoleResource(sysRole);
		if (srrList != null && srrList.size() > 0) {
			int x = sysRoleResourceMapper.delSysRoleResource(sysRole);
			if (x > 0) {
				for (Integer i : sysResoure) {
					Integer j = sysRoleResourceMapper.saveSysRoleResource(sysRole, i);
					sum += j;
				}
				if (sum == sysResoure.length) {
					flag = true;
				}
			}
		} else {
			for (Integer i : sysResoure) {
				Integer j = sysRoleResourceMapper.saveSysRoleResource(sysRole, i);
				sum += j;
			}
			if (sum == sysResoure.length) {
				flag = true;
			}

		}
		return flag;
	}

	@Override
	public List<SysRole> findMyCompanyRole(Integer companyId) {
		return sysRoleMapper.findMyCompanyRole(companyId);
	}

	@Override
	public String selectInvestorsCode(Integer userId) {
		return sysRoleMapper.selectInvestorsCode(userId);
	}

	@Override
	public int checkRoleCode(int id) {
		return sysRoleMapper.checkRoleCode(id);
	}

	@Override
	public Integer selectName(Integer id) {
		return sysRoleMapper.selectName(id);
	}

	@Override
	public int checkRepeat(SysRole sysRole) {
		return sysRoleMapper.checkRepeat(sysRole);
	}

	@Override
	public int userSysRole(int sysRoleId, int companyId) {
		return sysRoleMapper.userSysRole(sysRoleId, companyId);
	}

	@Override
	public List<SysRole> selectInvestorsCodeAndPay(Integer userId) {
		return sysRoleMapper.selectInvestorsCodeAndPay(userId);
	}

//	@Override
//	public List<Integer> sysResourceDefault(int sysRoleId) {
//		return sysRoleMapper.sysResourceDefault(sysRoleId);
//	}
	@Override
	public List<Node> sysResourceDefault(int sysRoleId) {
		List<Node> treeList = new ArrayList<Node>();
		List<String> list = sysRoleMapper.sysResourceDefault(sysRoleId);
		List<Node> nodeList = sysResourceMapper.getParentResoureList();
		for (Node node : nodeList) {
			for (String s : list) {
				if (node.getId().equals(s)) {
					Trees t = new Trees();
					t.setChecked(true);
					node.setState(t);
				}
			}
			treeList.add(node);
		}
		return treeList;
	}
}
