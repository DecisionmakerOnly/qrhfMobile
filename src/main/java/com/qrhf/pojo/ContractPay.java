package com.qrhf.pojo;

import java.util.Date;

public class ContractPay {
	
	private int id;
	
	private int contractId;
	
	private int userId;
	
	private Double price;
	
	private Date createDate;
	
	private String payDate;
	
	private Date dPayDate;
	
	public Date getdPayDate() {
		return dPayDate;
	}

	public void setdPayDate(Date dPayDate) {
		this.dPayDate = dPayDate;
	}

	public String getPayDate() {
		return payDate;
	}

	public void setPayDate(String payDate) {
		this.payDate = payDate;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getContractId() {
		return contractId;
	}

	public void setContractId(int contractId) {
		this.contractId = contractId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
	

}
