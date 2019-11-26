package com.qrhf.pojo;

import java.io.Serializable;
import java.util.Date;

public class User implements Serializable {
	private static final long serialVersionUID = 1L;
	private Integer id;
	private Integer sysRoleId;
	private Integer companyId;
	private Integer departmentId;
	private String roleName;
	private String roleCode;
	private String userName;
	private String loginName;
	private String password;
	private String email;
	private String phone;
	private Integer isValid;
	private Date isValidDate;
	private Date createDate;
	private String name;
	private String userRoleCode;
	private String userRoleName;
	private Integer isFactory;
	private String chare;
	private Integer loginType;
	private String pass;
	private String code;
	private Integer pushTimes;
	private Date ExpiryDate;
	private String shareCode;
	private String companyCode;
	private String companyName;
	private String phoneOrEmail;
	private String userExpiryDate;
	private Integer isPayment;
	private String threeName;
	private String sevenName;
	private String threeExpiryDate;
	private String sevenExpiryDate;
	
	public String getThreeName() {
		return threeName;
	}

	public void setThreeName(String threeName) {
		this.threeName = threeName;
	}

	public String getSevenName() {
		return sevenName;
	}

	public void setSevenName(String sevenName) {
		this.sevenName = sevenName;
	}

	public String getThreeExpiryDate() {
		return threeExpiryDate;
	}

	public void setThreeExpiryDate(String threeExpiryDate) {
		this.threeExpiryDate = threeExpiryDate;
	}

	public String getSevenExpiryDate() {
		return sevenExpiryDate;
	}

	public void setSevenExpiryDate(String sevenExpiryDate) {
		this.sevenExpiryDate = sevenExpiryDate;
	}

	public Integer getIsPayment() {
		return isPayment;
	}

	public void setIsPayment(Integer isPayment) {
		this.isPayment = isPayment;
	}

	public String getUserExpiryDate() {
		return userExpiryDate;
	}

	public void setUserExpiryDate(String userExpiryDate) {
		this.userExpiryDate = userExpiryDate;
	}

	public String getPhoneOrEmail() {
		return phoneOrEmail;
	}

	public void setPhoneOrEmail(String phoneOrEmail) {
		this.phoneOrEmail = phoneOrEmail;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getCompanyCode() {
		return companyCode;
	}

	public void setCompanyCode(String companyCode) {
		this.companyCode = companyCode;
	}

	public String getShareCode() {
		return shareCode;
	}

	public void setShareCode(String shareCode) {
		this.shareCode = shareCode;
	}

	private Integer codeNumber;
	
	
	public Date getExpiryDate() {
		return ExpiryDate;
	}

	public void setExpiryDate(Date expiryDate) {
		ExpiryDate = expiryDate;
	}
	public Integer getCodeNumber() {
		return codeNumber;
	}

	public void setCodeNumber(Integer codeNumber) {
		this.codeNumber = codeNumber;
	}

	public Integer getPushTimes() {
		return pushTimes;
	}

	public void setPushTimes(Integer pushTimes) {
		this.pushTimes = pushTimes;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public Integer getLoginType() {
		return loginType;
	}

	public void setLoginType(Integer loginType) {
		this.loginType = loginType;
	}
	public Integer getIsFactory() {
		return isFactory;
	}

	public void setIsFactory(Integer isFactory) {
		this.isFactory = isFactory;
	}

	public String getChare() {
		return chare;
	}

	public void setChare(String chare) {
		this.chare = chare;
	}

	public Integer getSysRoleId() {
		return sysRoleId;
	}

	public void setSysRoleId(Integer sysRoleId) {
		this.sysRoleId = sysRoleId;
	}

	public String getUserRoleCode() {
		return userRoleCode;
	}

	public void setUserRoleCode(String userRoleCode) {
		this.userRoleCode = userRoleCode;
	}

	public String getUserRoleName() {
		return userRoleName;
	}

	public void setUserRoleName(String userRoleName) {
		this.userRoleName = userRoleName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getIsValidDate() {
		return isValidDate;
	}

	public void setIsValidDate(Date isValidDate) {
		this.isValidDate = isValidDate;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public Integer getIsValid() {
		return isValid;
	}

	public void setIsValid(Integer isValid) {
		this.isValid = isValid;
	}

	public Integer getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}

	public Integer getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(Integer departmentId) {
		this.departmentId = departmentId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone == null ? null : phone.trim();
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getRoleCode() {
		return roleCode;
	}

	public void setRoleCode(String roleCode) {
		this.roleCode = roleCode;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}