package com.qrhf.pojo;

import java.util.Date;

public class Consultation {

	private int id;
	
	private int sysFlowId;
	
	private int userId;
	
	private int projectId;
	
	private int projectUpdateId;
	
	private String title;
	
	private int status;
	
	private Date create_date;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getSysFlowId() {
		return sysFlowId;
	}

	public void setSysFlowId(int sysFlowId) {
		this.sysFlowId = sysFlowId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getProjectId() {
		return projectId;
	}

	public void setProjectId(int projectId) {
		this.projectId = projectId;
	}

	public int getProjectUpdateId() {
		return projectUpdateId;
	}

	public void setProjectUpdateId(int projectUpdateId) {
		this.projectUpdateId = projectUpdateId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Date getCreate_date() {
		return create_date;
	}

	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}
	
}
