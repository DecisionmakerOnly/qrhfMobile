package com.qrhf.pojo;

public class QuotaStatistics {
	private Long id;
	private String name;
	private String linkageId;
	private String linkageCount;
	private String primaryWorker;
	private String seniorWorker;
	private String seniorWorkerWages;
	private String primaryWorkerWages;
	private String wages;
	private String mechanics;
	private String workload;
	
	public String getWorkload() {
		return workload;
	}

	public void setWorkload(String workload) {
		this.workload = workload;
	}

	public String getMechanics() {
		return mechanics;
	}

	public void setMechanics(String mechanics) {
		this.mechanics = mechanics;
	}

	public String getSeniorWorkerWages() {
		return seniorWorkerWages;
	}

	public void setSeniorWorkerWages(String seniorWorkerWages) {
		this.seniorWorkerWages = seniorWorkerWages;
	}

	public String getPrimaryWorkerWages() {
		return primaryWorkerWages;
	}

	public void setPrimaryWorkerWages(String primaryWorkerWages) {
		this.primaryWorkerWages = primaryWorkerWages;
	}

	public String getWages() {
		return wages;
	}

	public void setWages(String wages) {
		this.wages = wages;
	}

	public String getPrimaryWorker() {
		return primaryWorker;
	}

	public void setPrimaryWorker(String primaryWorker) {
		this.primaryWorker = primaryWorker;
	}

	public String getSeniorWorker() {
		return seniorWorker;
	}

	public void setSeniorWorker(String seniorWorker) {
		this.seniorWorker = seniorWorker;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLinkageId() {
		return linkageId;
	}

	public void setLinkageId(String linkageId) {
		this.linkageId = linkageId;
	}

	public String getLinkageCount() {
		return linkageCount;
	}

	public void setLinkageCount(String linkageCount) {
		this.linkageCount = linkageCount;
	}

}
