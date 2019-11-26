package com.qrhf.pojo;

import java.util.Date;

public class ProjectGroupGoods {
	
	private Integer id;

	private Integer projectId;

	private Integer goodsId;
	
	private Integer projectGroupId;

	private String projectName;

	private String projectOrderName;

	private String name;

	private String code;
	
	private String type;

	private String unit;

	private Double price;

	private Double amount;

	private Double amount2;

	private Double total;

	private Date createDate;
	
	private Integer status;
	
	private String amounts;
	
	private String asName;
	
	private Double projectGoodsAmount;
	
	private Double pogAmount;
	
	private Double surplusAmount;
	
	public Double getSurplusAmount() {
		return surplusAmount;
	}

	public void setSurplusAmount(Double surplusAmount) {
		this.surplusAmount = surplusAmount;
	}

	public Double getPogAmount() {
		return pogAmount;
	}

	public void setPogAmount(Double pogAmount) {
		this.pogAmount = pogAmount;
	}

	public Double getProjectGoodsAmount() {
		return projectGoodsAmount;
	}

	public void setProjectGoodsAmount(Double projectGoodsAmount) {
		this.projectGoodsAmount = projectGoodsAmount;
	}

	public String getAsName() {
		return asName;
	}

	public void setAsName(String asName) {
		this.asName = asName;
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

	public Integer getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(Integer goodsId) {
		this.goodsId = goodsId;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	/**
	 * @return the amount
	 */
	public Double getAmount() {
		return amount;
	}

	/**
	 * @param amount
	 *            the amount to set
	 */
	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public Double getTotal() {
		return total;
	}

	public void setTotal(Double total) {
		this.total = total;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getProjectOrderName() {
		return projectOrderName;
	}

	public void setProjectOrderName(String projectOrderName) {
		this.projectOrderName = projectOrderName;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getProjectGroupId() {
		return projectGroupId;
	}

	public void setProjectGroupId(Integer projectGroupId) {
		this.projectGroupId = projectGroupId;
	}

	public String getAmounts() {
		return amounts;
	}

	public void setAmounts(String amounts) {
		this.amounts = amounts;
	}

	public Double getAmount2() {
		return amount2;
	}

	public void setAmount2(Double amount2) {
		this.amount2 = amount2;
	}
}