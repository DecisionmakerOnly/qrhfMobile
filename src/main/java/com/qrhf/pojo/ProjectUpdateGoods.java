package com.qrhf.pojo;

import java.util.Date;

public class ProjectUpdateGoods {
	
	private int id;

	private int project;
	
	private int projectUpdate;
	
	private int goods;
	
	private String asName;
	
	private Double price;
	
	private Double amount;
	
	private Double total;
	
	private int status;
	
	private int editCount;
	
	private int editStatus;
	
	private Double editAmount;
	
	private Double projectGoodsAmount;
	
	private Date createDate;
	
	private int isValid;
	
	private Date isValidDate;
	
	private String code;
	
	private String unit;

	private String type;
	
	private Integer updateType;
	
	private Integer goodsId;
	
	private Integer projectId;
	
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

	public Integer getUpdateType() {
		return updateType;
	}

	public void setUpdateType(Integer updateType) {
		this.updateType = updateType;
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

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getEditCount() {
		return editCount;
	}

	public void setEditCount(int editCount) {
		this.editCount = editCount;
	}

	public Double getProjectGoodsAmount() {
		return projectGoodsAmount;
	}

	public void setProjectGoodsAmount(Double projectGoodsAmount) {
		this.projectGoodsAmount = projectGoodsAmount;
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

	public int getGoods() {
		return goods;
	}

	public void setGoods(int goods) {
		this.goods = goods;
	}

	public String getAsName() {
		return asName;
	}

	public void setAsName(String asName) {
		this.asName = asName;
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
	
}