package com.qrhf.vo;


public class UserVo {
	private Integer id;
	private String email;
	private String phone;
	private String threeName;
	private String sevenName;
	private String threeExpiryDate;
	private String sevenExpiryDate;
	private Integer isPayment;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getThreeName() {
		return threeName;
	}
	public void setThreeName(String threeName) {
		this.threeName = threeName;
	}
	public String getSevenName() {
		return sevenName;
	}
	public void setSevenName(String sevenName) {
		this.sevenName = sevenName;
	}
	public String getThreeExpiryDate() {
		return threeExpiryDate;
	}
	public void setThreeExpiryDate(String threeExpiryDate) {
		this.threeExpiryDate = threeExpiryDate;
	}
	public String getSevenExpiryDate() {
		return sevenExpiryDate;
	}
	public void setSevenExpiryDate(String sevenExpiryDate) {
		this.sevenExpiryDate = sevenExpiryDate;
	}
	public Integer getIsPayment() {
		return isPayment;
	}
	public void setIsPayment(Integer isPayment) {
		this.isPayment = isPayment;
	}
}
