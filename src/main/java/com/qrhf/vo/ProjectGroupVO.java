package com.qrhf.vo;

import java.sql.Timestamp;
import java.util.Date;

public class ProjectGroupVO {
	private Integer id;
	
	private Integer projectId;
	
	private Integer goodsId;

	private Integer companyId;

	private Integer departmentId;

	private Integer userId;

	private String userName;

	private Integer jurisdiction;
	
	private String asName;

	private String name;
	
	private String code;
	
	private String type;
	
	private String unit;

	private String budgetAmount;
	
	private Double price;

	private Double amount;

	private String percentage;

	private Date createdate;

	private Integer isValid;

	private Date isValidDate;

	private String company;
	
	private String startDate;
	
	private String endDate;
	
	private Integer projectGroupId;
	
	private String smallAmount;
	
	public String getSmallAmount() {
		return smallAmount;
	}

	public void setSmallAmount(String smallAmount) {
		this.smallAmount = smallAmount;
	}

	public Integer getProjectGroupId() {
		return projectGroupId;
	}

	public void setProjectGroupId(Integer projectGroupId) {
		this.projectGroupId = projectGroupId;
	}

	public Integer getProjectId() {
		return projectId;
	}

	public void setProjectId(Integer projectId) {
		this.projectId = projectId;
	}

	public Integer getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(Integer goodsId) {
		this.goodsId = goodsId;
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

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
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

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getAsName() {
		return asName;
	}

	public void setAsName(String asName) {
		this.asName = asName;
	}
}