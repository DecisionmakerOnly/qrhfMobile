package com.qrhf.vo;

import java.util.Date;

public class ProjectUpdateGoodsVO {
	
	private int id;
	
	private int project;
	
	private int projectUpdate;
	
	private int goodsId;
	
	private String asName;
	
	private String name;
	
	private String code;
	
	private String type;
	
	private String unit;
	
	private Double price;
	
	private Double defaultPrice;
	
	private Double amount;
	
	private Double defaultAmount;
	
	private Double total;
	
	private int status;
	
	private Date createDate;
	
	private int isValid;
	
	private Date isValidDate;
	
	private String ideas;

	private int editStatus;

	private Double editAmount;

	private Double pgAmount;

	public Double getPgAmount() {
		return pgAmount;
	}

	public void setPgAmount(Double pgAmount) {
		this.pgAmount = pgAmount;
	}

	public int getEditStatus() {
		return editStatus;
	}

	public void setEditStatus(int editStatus) {
		this.editStatus = editStatus;
	}

	public Double getEditAmount() {
		return editAmount;
	}

	public void setEditAmount(Double editAmount) {
		this.editAmount = editAmount;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getProject() {
		return project;
	}

	public void setProject(int project) {
		this.project = project;
	}

	public int getProjectUpdate() {
		return projectUpdate;
	}

	public void setProjectUpdate(int projectUpdate) {
		this.projectUpdate = projectUpdate;
	}

	public int getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(int goodsId) {
		this.goodsId = goodsId;
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

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public int getIsValid() {
		return isValid;
	}

	public void setIsValid(int isValid) {
		this.isValid = isValid;
	}

	public Date getIsValidDate() {
		return isValidDate;
	}

	public void setIsValidDate(Date isValidDate) {
		this.isValidDate = isValidDate;
	}

	public String getIdeas() {
		return ideas;
	}

	public void setIdeas(String ideas) {
		this.ideas = ideas;
	}

	public Double getDefaultPrice() {
		return defaultPrice;
	}

	public void setDefaultPrice(Double defaultPrice) {
		this.defaultPrice = defaultPrice;
	}

	public Double getDefaultAmount() {
		return defaultAmount;
	}

	public void setDefaultAmount(Double defaultAmount) {
		this.defaultAmount = defaultAmount;
	}
	
}
