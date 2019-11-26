package com.qrhf.pojo;

import java.util.Date;

public class Coupon {
	private Integer id;
	
	private Integer userId;
	
	private Integer companyId;
	
	private Integer promotionId;
	
	private Integer promotionCompanyId;
	
	private Double orderAmount;
	
	private Integer isValid;
	
	private Integer status;
	
	private Date createDate;
	
	private Date isValidDate;
	
	private Date startDate;
	
	private Date endDate;
	
	private String termDate;
	
	private String money;
	
	private String payTaxes; //缴税
	
	private String serviceCharge; //服务费
	
	private String  withdrawable; //可提取
	
	private String withdrawMoney;

	public String getWithdrawMoney() {
		return withdrawMoney;
	}

	public void setWithdrawMoney(String withdrawMoney) {
		this.withdrawMoney = withdrawMoney;
	}

	/**
	 * @return the payTaxes
	 */
	public String getPayTaxes() {
		return payTaxes;
	}

	/**
	 * @param payTaxes the payTaxes to set
	 */
	public void setPayTaxes(String payTaxes) {
		this.payTaxes = payTaxes;
	}

	/**
	 * @return the serviceCharge
	 */
	public String getServiceCharge() {
		return serviceCharge;
	}

	/**
	 * @param serviceCharge the serviceCharge to set
	 */
	public void setServiceCharge(String serviceCharge) {
		this.serviceCharge = serviceCharge;
	}

	/**
	 * @return the withdrawable
	 */
	public String getWithdrawable() {
		return withdrawable;
	}

	/**
	 * @param withdrawable the withdrawable to set
	 */
	public void setWithdrawable(String withdrawable) {
		this.withdrawable = withdrawable;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}

	public Integer getPromotionId() {
		return promotionId;
	}

	public void setPromotionId(Integer promotionId) {
		this.promotionId = promotionId;
	}

	public Integer getPromotionCompanyId() {
		return promotionCompanyId;
	}

	public void setPromotionCompanyId(Integer promotionCompanyId) {
		this.promotionCompanyId = promotionCompanyId;
	}

	public Double getOrderAmount() {
		return orderAmount;
	}

	public void setOrderAmount(Double orderAmount) {
		this.orderAmount = orderAmount;
	}

	public Integer getIsValid() {
		return isValid;
	}

	public void setIsValid(Integer isValid) {
		this.isValid = isValid;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
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

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getTermDate() {
		return termDate;
	}

	public void setTermDate(String termDate) {
		this.termDate = termDate;
	}

	public String getMoney() {
		return money;
	}

	public void setMoney(String money) {
		this.money = money;
	}
}