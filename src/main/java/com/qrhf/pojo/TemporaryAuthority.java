package com.qrhf.pojo;

import java.util.Date;

public class TemporaryAuthority {
	
	private int id;
	private int pageId;
	private int sysResourceId;
	private int recordId;
	private int userId;
	private String remark;
	private int status;
	private int isValid;
	private Date isValidDate;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPageId() {
		return pageId;
	}
	public void setPageId(int pageId) {
		this.pageId = pageId;
	}
	public int getSysResourceId() {
		return sysResourceId;
	}
	public void setSysResourceId(int sysResourceId) {
		this.sysResourceId = sysResourceId;
	}
	public int getRecordId() {
		return recordId;
	}
	public void setRecordId(int recordId) {
		this.recordId = recordId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getIsValid() {
		return isValid;
	}
	public void setIsValid(int isValid) {
		this.isValid = isValid;
	}
	public Date getIsValidDate() {
		return isValidDate;
	}
	public void setIsValidDate(Date isValidDate) {
		this.isValidDate = isValidDate;
	}
	
}