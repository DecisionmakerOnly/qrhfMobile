package com.qrhf.pojo;

import java.util.Date;

public class Feedback {
	private Integer id;
	
	private Integer companyId;
	
	private Integer userId;
	
	private String userName;
	
	private String companyName;
	
	private String sysResourceName;
	
	private String  opinion;
	
	private Date createDate;
	
	private Integer isValid;
	
	private Date isValidDate;
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getCompanyId() {
		return companyId;
	}
	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getOpinion() {
		return opinion;
	}
	public void setOpinion(String opinion) {
		this.opinion = opinion;
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
	public String getSysResourceName() {
		return sysResourceName;
	}
	public void setSysResourceName(String sysResourceName) {
		this.sysResourceName = sysResourceName;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
}
