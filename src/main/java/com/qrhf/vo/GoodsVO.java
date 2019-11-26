package com.qrhf.vo;

public class GoodsVO {
	
	private int id;
	
	private int goodsId;
	
	private int projectId;
	
	private int projectGroupId;
	
	private int projectOrderId;
	
	private int projectUpdateId;
	
	private String projectName;
	
	private String asName;
	
	private String name;
	
	private String code;
	
	private String type;
	
	private String unit;
	
	private Double price;
	
	private Double amount;
	
	private Double total;
	
	private Double sAmount;//剩余量

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(int goodsId) {
		this.goodsId = goodsId;
	}

	public int getProjectId() {
		return projectId;
	}

	public void setProjectId(int projectId) {
		this.projectId = projectId;
	}

	public int getProjectGroupId() {
		return projectGroupId;
	}

	public void setProjectGroupId(int projectGroupId) {
		this.projectGroupId = projectGroupId;
	}

	public int getProjectOrderId() {
		return projectOrderId;
	}

	public void setProjectOrderId(int projectOrderId) {
		this.projectOrderId = projectOrderId;
	}

	public int getProjectUpdateId() {
		return projectUpdateId;
	}

	public void setProjectUpdateId(int projectUpdateId) {
		this.projectUpdateId = projectUpdateId;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getAsName() {
		return asName;
	}

	public void setAsName(String asName) {
		this.asName = asName;
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

	public Double getsAmount() {
		return sAmount;
	}

	public void setsAmount(Double sAmount) {
		this.sAmount = sAmount;
	}

}
