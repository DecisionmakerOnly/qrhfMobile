package com.qrhf.pojo;

import java.util.Date;

public class SysRole {
	private Integer id;
	
	private Integer companyId;
	
	private String name;

	private String code;
	
	private Integer status;
	
	private Date createDate;

	private Integer isValid;

	private Date isValidDate;
	
	private Integer sysRole;
	
	private Integer userId;
	
	private String notOrPay;
	
	public String getNotOrPay() {
		return notOrPay;
	}

	public void setNotOrPay(String notOrPay) {
		this.notOrPay = notOrPay;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getSysRole() {
		return sysRole;
	}

	public void setSysRole(Integer sysRole) {
		this.sysRole = sysRole;
	}

	public Integer getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name == null ? null : name.trim();
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code == null ? null : code.trim();
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Integer getIsValid() {
		return isValid;
	}

	public void setIsValid(Integer isValid) {
		this.isValid = isValid;
	}

	public Date getIsValidDate() {
		return isValidDate;
	}

	public void setIsValidDate(Date isValidDate) {
		this.isValidDate = isValidDate;
	}
}