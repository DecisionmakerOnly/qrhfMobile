package com.qrhf.pojo;

import java.sql.Timestamp;
import java.util.Date;

public class Project {
	private Integer id;

	private Integer companyId;

	private Integer departmentId;

	private Integer userId;
	
	private Integer uId;
	
	private Integer dutyUser;
	
	private String buyerId;
	
	private String userName;
	
	private String dutyUserName;

	private Integer jurisdiction;

	private String name;

	private String budgetAmount;

	private String consumptionAmount;

	private String percentage;

	private Date createdate;

	private Integer isValid;

	private Date isValidDate;

	private String company;
	
	private Integer province;
	private Integer city;
	private Integer area;
	
	private Double contractPrice;
	private Double manpowerPrice;
	private Double materialPrice;
	private Double machinePrice;
	private String sumAmount;
	
	public String getSumAmount() {
		return sumAmount;
	}

	public void setSumAmount(String sumAmount) {
		this.sumAmount = sumAmount;
	}

	public Integer getProvince() {
		return province;
	}

	public void setProvince(Integer province) {
		this.province = province;
	}

	public Integer getCity() {
		return city;
	}

	public void setCity(Integer city) {
		this.city = city;
	}

	public Integer getArea() {
		return area;
	}

	public void setArea(Integer area) {
		this.area = area;
	}

	public Double getContractPrice() {
		return contractPrice;
	}

	public void setContractPrice(Double contractPrice) {
		this.contractPrice = contractPrice;
	}

	public Double getManpowerPrice() {
		return manpowerPrice;
	}

	public void setManpowerPrice(Double manpowerPrice) {
		this.manpowerPrice = manpowerPrice;
	}

	public Double getMaterialPrice() {
		return materialPrice;
	}

	public void setMaterialPrice(Double materialPrice) {
		this.materialPrice = materialPrice;
	}

	public Double getMachinePrice() {
		return machinePrice;
	}

	public void setMachinePrice(Double machinePrice) {
		this.machinePrice = machinePrice;
	}

	public String getBuyerId() {
		return buyerId;
	}

	public void setBuyerId(String buyerId) {
		this.buyerId = buyerId;
	}

	public Integer getuId() {
		return uId;
	}

	public void setuId(Integer uId) {
		this.uId = uId;
	}

	public String getDutyUserName() {
		return dutyUserName;
	}

	public void setDutyUserName(String dutyUserName) {
		this.dutyUserName = dutyUserName;
	}

	public Integer getDutyUser() {
		return dutyUser;
	}

	public void setDutyUser(Integer dutyUser) {
		this.dutyUser = dutyUser;
	}

	public Integer getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}

	public Integer getDepartmentId() {
		return departmentId;
	}

	
	public void setDepartmentId(Integer departmentId) {
		this.departmentId = departmentId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name == null ? null : name.trim();
	}

	public String getBudgetAmount() {
		return budgetAmount;
	}

	public void setBudgetAmount(String budgetAmount) {
		this.budgetAmount = budgetAmount;
	}

	public String getConsumptionAmount() {
		return consumptionAmount;
	}

	public void setConsumptionAmount(String consumptionAmount) {
		this.consumptionAmount = consumptionAmount;
	}

	public String getPercentage() {
		return percentage;
	}

  
	public Date getCreatedate() {
		return createdate;
	}
 
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}

	public void setPercentage(String percentage) {
		this.percentage = percentage;
	}

	public void setCreatedate(Timestamp createdate) {
		this.createdate = createdate;
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

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company == null ? null : company.trim();
	}

	public Integer getJurisdiction() {
		return jurisdiction;
	}

	public void setJurisdiction(Integer jurisdiction) {
		this.jurisdiction = jurisdiction;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
}