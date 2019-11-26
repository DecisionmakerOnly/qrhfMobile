package com.qrhf.dao;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.qrhf.pojo.Company;
import com.qrhf.pojo.User;
import com.qrhf.vo.Node;

public interface UserMapper {

	public List<User> findList(Map<String, Object> param);

	public Integer addUser(User user);
	
	public Integer deleteUserById(Integer id);
	
	public User getUserById(Integer id);
	
	public Integer updateUser(User user);

	public User loginByUserName(String loginName);
	
	public Integer upPass(User user);
	
	public User checkEmail(@Param("id")int id,@Param("chare")String chare,@Param("loginType")String loginType);
	
	public User checkPhone(String phone);
	
	public User getByEmail(String email);
	
	public Integer updatePassword(User user);
	
	public Integer addOrdinaryUser(User user);
	
	public Integer deleteCompanyId(Integer companyId);
	
	public Integer addStaff(User user);
	
	User loginByUser(User user);
	
	public User checkLoginName(String loginName);
	
	public Integer deleteUserByDepartmentId(@Param("departmentIds")String departmentIds);
	
	public Integer updateUserDepartment(@Param("userId")int userId,@Param("departmentId")int departmentId);
	
	public	List<User> findDutyUser(@Param("companyId")Integer companyId);

	public User selectPasswrod(Integer id);

	public int selectResource(Integer userId);

	public List<Integer> selectInvestorsId(Integer companyId);

	public List<User> selectManager(User user);

	public List<User> selectBuyer(User user);
	
	public int getUserRoleId(int userId);
	 
	public List<Node> findUserTree(int companyId);
	
//	public Integer updateUserSysRole(@Param("userId")int userId,@Param("companyId")int companyId);
	
	public Integer deleteUserSysRole(@Param("userId")int userId,@Param("companyId")int companyId);
	
	public Integer getUserIdUpdate(@Param("userId")int userId,@Param("companyId")int companyId);
	
	public List<User> findAllUserForCompany(int companyId);
	
	public User getUserPushTimes(int userId);
	
	public Integer updateUserAnimation(int userId);
	
	public void addUserTimeLength(String paymentOrderId);
	
	public List<User> userExpirationDate(Map<String, Object> param);
	
	public List<User> companyInformation(Map<String, Object> param);
	
	public int updateUserExpiryDate(@Param("companyId")int companyId,@Param("expiryDate")String expiryDate);
	
	public int selectUserExpiryDate(int userId);
	
	public List<User> findUserExpiryDate(int userId);
	
	public List<User> findUserExpires();
	
	public List<User> selectUser(int companyId);
}