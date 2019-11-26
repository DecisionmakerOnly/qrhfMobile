package com.qrhf.pojo;

import java.util.Date;

public class ApplyExpiryDate {
	private int id;
	private int companyId; //企业ID
	private int userId; //申请人ID
	private int processUserId;//处理人ID 
	private String reason;//申请原因
	private int status;//状态 0申请 1同意 -1拒绝 2 已读
	private Date createDate;//申请时间
	private Date processDate;//处理时间
	private int type;//类型   已读1 未读-1
	
	private String companyName;
	private String userName;
	
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getCompanyId() {
		return companyId;
	}
	public void setCompanyId(int companyId) {
		this.companyId = companyId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getProcessUserId() {
		return processUserId;
	}
	public void setProcessUserId(int processUserId) {
		this.processUserId = processUserId;
	}
	
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public Date getProcessDate() {
		return processDate;
	}
	public void setProcessDate(Date processDate) {
		this.processDate = processDate;
	}
}
