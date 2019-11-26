package com.qrhf.pojo;

public class ProjectUpdateResource {
	
	private Integer id;
	
	private Integer pgId;

	private Integer projectId;

	private Integer goodsId;
	
	private String name;

	private String code;
	
	private String type;

	private String unit;

	private Double price;

	private Double amount;

	private Double total;
	
	private Integer isUpdatePrice;
	
	private Integer isUpdateAmount;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getPgId() {
		return pgId;
	}

	public void setPgId(Integer pgId) {
		this.pgId = pgId;
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

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
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

	public Double getTotal() {
		return total;
	}

	public void setTotal(Double total) {
		this.total = total;
	}

	public Integer getIsUpdatePrice() {
		return isUpdatePrice;
	}

	public void setIsUpdatePrice(Integer isUpdatePrice) {
		this.isUpdatePrice = isUpdatePrice;
	}

	public Integer getIsUpdateAmount() {
		return isUpdateAmount;
	}

	public void setIsUpdateAmount(Integer isUpdateAmount) {
		this.isUpdateAmount = isUpdateAmount;
	}

}