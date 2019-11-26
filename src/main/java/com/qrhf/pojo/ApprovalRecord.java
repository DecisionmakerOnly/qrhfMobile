package com.qrhf.pojo;

public class ApprovalRecord {

	private Integer id;
	
	private Integer taId;
	
	private Integer userId;
	
	private String userName;
	
	private String taText;
	
	private String opinion;

	private Integer status;
	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getId() {
		return id;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getTaId() {
		return taId;
	}

	public void setTaId(Integer taId) {
		this.taId = taId;
	}

	public String getTaText() {
		return taText;
	}

	public void setTaText(String taText) {
		this.taText = taText;
	}

	public String getOpinion() {
		return opinion;
	}

	public void setOpinion(String opinion) {
		this.opinion = opinion;
	}

	@Override
	public String toString() {
		return "ApprovalRecord [id=" + id + ", taId=" + taId + ", userId=" + userId + ", taText=" + taText
				+ ", opinion=" + opinion + ", status=" + status + "]";
	}
	
	
}
