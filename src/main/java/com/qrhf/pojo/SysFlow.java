package com.qrhf.pojo;

import java.util.Date;

public class SysFlow {

	private Integer id;
	
	private Integer projectId; //项目ID
	
	private Integer projectOrderId; //采购ID
	 
	private Integer projectUpdateId; //修改ID
	
	private Integer projectGroupId; //分批ID
	
	private Integer companyId; //企业ID
	
	private Integer buyerId;	//采购者id
	
	private String buyerName; //采购人姓名
		
	private Integer managerId; //处理人ID
	
	private String title; //标题
	
	private Integer type; //审批类型 1为采购表上传申请, 2为修改项目采购控制表申请, 3:采购员删除全部未通过的采购表后对项目经理的通知
	
	private Integer status;		//订单审批状态
	
	private String rejectReason;	//订单未通过原因
	
	private Date createDate; //
	
	private Date processDate;	//处理时间
	
	private String name;
	
	private Integer userId;
	
	private String userName;
	
	private String projectName;
	
	private Integer num;
	
	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Integer getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}

	public Integer getProjectGroupId() {
		return projectGroupId;
	}

	public void setProjectGroupId(Integer projectGroupId) {
		this.projectGroupId = projectGroupId;
	}

	public String getBuyerName() {
		return buyerName;
	}

	public void setBuyerName(String buyerName) {
		this.buyerName = buyerName;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getProjectId() {
		return projectId;
	}

	public void setProjectId(Integer projectId) {
		this.projectId = projectId;
	}

	public Integer getProjectOrderId() {
		return projectOrderId;
	}

	public void setProjectOrderId(Integer projectOrderId) {
		this.projectOrderId = projectOrderId;
	}

	public Integer getProjectUpdateId() {
		return projectUpdateId;
	}

	public void setProjectUpdateId(Integer projectUpdateId) {
		this.projectUpdateId = projectUpdateId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getRejectReason() {
		return rejectReason;
	}

	public void setRejectReason(String rejectReason) {
		this.rejectReason = rejectReason;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getBuyerId() {
		return buyerId;
	}

	public void setBuyerId(Integer buyerId) {
		this.buyerId = buyerId;
	}

	public Integer getManagerId() {
		return managerId;
	}

	public void setManagerId(Integer managerId) {
		this.managerId = managerId;
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

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}
	
}
