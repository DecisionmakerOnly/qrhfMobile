package com.qrhf.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.config.SystemAttributes;
import com.qrhf.dao.SysResourceMapper;
import com.qrhf.dao.SysRoleMapper;
import com.qrhf.dao.UserMapper;
import com.qrhf.pojo.SysResource;
import com.qrhf.pojo.User;
import com.qrhf.vo.Node;

@Service("userService")
public class UserServiceImpl implements UserService {
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private SysResourceMapper sysResourceMapper;
	@Autowired
	private SysRoleMapper sysRoleMapper;

	@Override
	public Map<String, Object> findList(Map<String, Object> param) {
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> sizeMap = new HashMap<String, Object>();
		sizeMap.put("companyId", param.get("companyId"));
		sizeMap.put("departmentId", param.get("departmentId"));
		int total = userMapper.findList(sizeMap).size();
		List<User> rows = userMapper.findList(param);
		result.put("total", total);
		result.put("rows", rows);
		return result;
	}

	@Override
	public Integer addUser(User user) {
		return userMapper.addUser(user);
	}

	@Override
	public Integer deleteUserById(Integer id) {
		return userMapper.deleteUserById(id);
	}

	@Override
	public User getUserById(Integer id) {
		return userMapper.getUserById(id);
	}

	@Override
	public Integer updateUser(User user) {
		return userMapper.updateUser(user);
	}

	@Override
	public User loginByUserName(String loginName) {
		User user = userMapper.loginByUserName(loginName);
		return user;
	}	

	@Override
	public Integer updatePassword(User user) {
		return userMapper.updatePassword(user);
	}

	@Override
	public User getByEmail(String email) {
		return userMapper.getByEmail(email);
	}

	@Override
	public User checkEmail(int id,String chare,String loginType) {
		User user = userMapper.checkEmail(id,chare,loginType);
		return user;
	}

	/**
	 * 根据ID查询此用户的菜单
	 */
	@Override
	public List<SysResource> getResoureByUserId(int id,String code) {
		if(null!=code && SystemAttributes.SYS_ROLE_TZRDB.equals(code)){
			return sysResourceMapper.getParenResourceForBoss();
		}else{
			return sysResourceMapper.getParenResourceByUserId(id);
		}
	}

	@Override
	public List<SysResource> getResoureStatusByUserId(int id,int pageId) {
		List<SysResource> sList = sysResourceMapper.getResourceStatusByUserId(id,pageId);
		return sList;
	}

	@Override
	public User getUserInfoByLoginName(String loginName) {
		return userMapper.loginByUserName(loginName);
	}

	@Override
	public Integer upPass(User user) {
		return userMapper.upPass(user);
	}

	@Override
	public String newLoginName() {
		String loginName = (int) ((Math.random() * 9 + 1) * 100000000) + "";
		User user = userMapper.checkLoginName(loginName);
		if (user != null) {
			newLoginName();
		}
		return loginName;
	}

	@Override
	public Integer addStaff(User user) {
		return userMapper.addStaff(user);
	}

	@Override
	public Integer addOrdinaryUser(User user) {
		return userMapper.addOrdinaryUser(user);
	}

//	@Override
//	public List<SysResource> findResource1(int id, int pageId) {
//		return sysResourceMapper.findButtons(null, id, pageId);
//	}

	@Override
	public Integer updateUserDepartment(int userId, int departmentId) {
		return userMapper.updateUserDepartment(userId, departmentId);
	}

	@Override
	public List<User> findDutyUser(Integer companyId) {
		List <User> user=userMapper.findDutyUser(companyId);
		return user;
	}

	@Override
	public User selectPasswrod(Integer id) {
		return userMapper.selectPasswrod(id);
	}

	@Override
	public User checkPhone(String phone) {
		User user=userMapper.checkPhone(phone);
		return user;
	}

	@Override
	public int selectResource(Integer userId) {
		return userMapper.selectResource(userId);
	}

	@Override
	public List<Integer> selectInvestorsId(Integer companyId) {
		return userMapper.selectInvestorsId(companyId);
	}

	@Override
	public List<User> selectManager(User user) {
		return userMapper.selectManager(user);
	}

	@Override
	public List<User> selectBuyer(User user) {
		return userMapper.selectBuyer(user);
	}

	@Override
	public int getUserRoleId(int userId) {
		return userMapper.getUserRoleId(userId);
	}

	@Override
	public List<Node> findUserTree(int companyId) {
		return userMapper.findUserTree(companyId);
	}

	@Override
	public Integer updateUserSysRole(int userId, int companyId) {
		int id=sysRoleMapper.getSysRoleCompanyId(companyId);
		return userMapper.deleteUserSysRole(id, companyId);
	}

	@Override
	public Integer getUserIdUpdate(int userId, int companyId) {
		return userMapper.getUserIdUpdate(userId, companyId);
	}

	@Override
	public User getUserPushTimes(int userId) {
		User user=userMapper.getUserPushTimes(userId);
		return user;
	}

	@Override
	public Map<String, Object> findAllUserForCompany(int companyId) {
		List<User> rows = userMapper.findAllUserForCompany(companyId);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("rows", rows);
		return result;
	}

	@Override
	public Integer updateUserAnimation(int userId) {
		return userMapper.updateUserAnimation(userId);
	}

	@Override
	public Map<String, Object> userExpirationDate(Map<String, Object> param) {
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> sizeMap = new HashMap<String, Object>();
		sizeMap.put("companyName",param.get("companyName"));
		int total = userMapper.userExpirationDate(sizeMap).size();
		List<User> rows = userMapper.userExpirationDate(param);
		result.put("total", total);
		result.put("rows", rows);
		return result;
	}
	@Override
	public Map<String, Object> companyInformation(Map<String, Object> param) {
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> sizeMap = new HashMap<String, Object>();
		sizeMap.put("companyName",param.get("companyName"));
		int total = userMapper.companyInformation(sizeMap).size();
		List<User> rows = userMapper.companyInformation(param);
		result.put("total", total);
		result.put("rows", rows);
		return result;
	}

	@Override
	public int updateUserExpiryDate(int companyId,String expiryDate) {
		try {
			userMapper.updateUserExpiryDate(companyId,expiryDate);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public int selectUserExpiryDate(int userId) {
		return userMapper.selectUserExpiryDate(userId);
	}

	@Override
	public List<User> findUserExpiryDate(int userId) {
		return userMapper.findUserExpiryDate(userId);
	}

	@Override
	public List<User> findUserExpires() {
		return userMapper.findUserExpires();
	}

	@Override
	public List<User> selectUser(int companyId) {
		return userMapper.selectUser(companyId);
	}
}
