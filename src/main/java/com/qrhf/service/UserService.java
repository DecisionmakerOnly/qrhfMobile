package com.qrhf.service;

import java.util.List;
import java.util.Map;

import com.qrhf.pojo.SysResource;
import com.qrhf.pojo.User;
import com.qrhf.vo.Node;

public interface UserService {

	public Map<String, Object> findList(Map<String, Object> param);

	public Integer addUser(User user);

	public Integer deleteUserById(Integer id);

	public User getUserById(Integer id);

	public Integer updateUser(User user);

	public User loginByUserName(String loginName);

	public User getUserInfoByLoginName(String loginName);

	public Integer upPass(User user);

	public User checkEmail(int id,String chare,String loginType);
	
	public User checkPhone(String phone);
	
	public User getByEmail(String email);

	public Integer updatePassword(User user);

	public List<SysResource> getResoureByUserId(int id,String code);
	
//	public List<SysResource> findResource1(int id,int pageId);

	public List<SysResource> getResoureStatusByUserId(int id, int pageId);

	public String newLoginName();

	public Integer addStaff(User user);

	public Integer addOrdinaryUser(User user);
	
	public Integer updateUserDepartment(int userId,int departmentId);
	
	public	List<User> findDutyUser(Integer companyId);

	public User selectPasswrod(Integer id);

	public int selectResource(Integer userId);

	public List<Integer> selectInvestorsId(Integer companyId);

	public List<User> selectManager(User user);

	public List<User> selectBuyer(User user);
	
	public int getUserRoleId(int userId);
	
	public List<Node> findUserTree(int companyId);
	
	public Integer updateUserSysRole(int userId,int companyId);
	
	public Integer getUserIdUpdate(int userId,int companyId);
	
	public User getUserPushTimes(int userId);
	
	public Map<String, Object> findAllUserForCompany(int companyId);
	
	public Integer updateUserAnimation(int userId);
	
	public Map<String, Object> userExpirationDate(Map<String, Object> param);
	
	public Map<String, Object> companyInformation(Map<String, Object> param);
	
	public int updateUserExpiryDate(int companyId,String expiryDate);
	
	public int selectUserExpiryDate(int userId);
	
	public List<User> findUserExpiryDate(int userId);
	
	public List<User> findUserExpires();
	
	public List<User> selectUser(int companyId);
}
