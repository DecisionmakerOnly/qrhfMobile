package com.qrhf.pojo;

import java.util.Date;

public class ProjectOrderGoods {
	
	private Integer id;

	private Integer projectOrderId;
	
	private Integer projectOrderGoodsId;

	private Integer projectId;

	private Integer goodsId;
	
	private Integer contractId;

	private String projectName;

	private String projectOrderName;

	private String name;

	private String code;
	
	private String type;

	private String unit;

	private Double price;

	private Double amount;

	private Double total;

	private Date createDate;
	
	private Integer status;
	
	private Integer sfStatus;
	
	private String asName;
	
	private Integer isModify;
	
	//↓临时表字段
	private Integer tpgId;
	
	private Double tPrice;

	private Double tAmount;

	private Double tTotal;
	
	private Integer tStatus;
	
	private Double pgPrice;
	
	
	public Double getPgPrice() {
		return pgPrice;
	}
	public void setPgPrice(Double pgPrice) {
		this.pgPrice = pgPrice;
	}
	public Integer gettStatus() {
		return tStatus;
	}
	public void settStatus(Integer tStatus) {
		this.tStatus = tStatus;
	}
	public Integer getTpgId() {
		return tpgId;
	}
	public void setTpgId(Integer tpgId) {
		this.tpgId = tpgId;
	}
	public Double gettPrice() {
		return tPrice;
	}
	public void settPrice(Double tPrice) {
		this.tPrice = tPrice;
	}
	public Double gettAmount() {
		return tAmount;
	}
	public void settAmount(Double tAmount) {
		this.tAmount = tAmount;
	}
	public Double gettTotal() {
		return tTotal;
	}
	public void settTotal(Double tTotal) {
		this.tTotal = tTotal;
	}
	
	public Integer getProjectOrderGoodsId() {
		return projectOrderGoodsId;
	}
	public void setProjectOrderGoodsId(Integer projectOrderGoodsId) {
		this.projectOrderGoodsId = projectOrderGoodsId;
	}
	public Integer getIsModify() {
		return isModify;
	}
	public void setIsModify(Integer isModify) {
		this.isModify = isModify;
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

	public Integer getPeojectOrderId() {
		return projectOrderId;
	}

	public void setProjectOrderId(Integer projectOrderId) {
		this.projectOrderId = projectOrderId;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Integer getProjectOrderId() {
		return projectOrderId;
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

	public Integer getSfStatus() {
		return sfStatus;
	}

	public void setSfStatus(Integer sfStatus) {
		this.sfStatus = sfStatus;
	}
	public Integer getContractId() {
		return contractId;
	}
	public void setContractId(Integer contractId) {
		this.contractId = contractId;
	}
	@Override
	public String toString() {
		return "ProjectOrderGoods [id=" + id + ", goodsId=" + goodsId + ", name=" + name + ", price=" + price
				+ ", amount=" + amount + "]";
	}

	
}