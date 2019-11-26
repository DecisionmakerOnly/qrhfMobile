package com.qrhf.pojo;

public class ProjectGoods {
	private Integer id;

	private Integer projectId;

	private Integer goodsId;
	
	private Integer projectUpdateGoodsId;

	private String projectName;

	private String name;
	
	private String code;
	
	private String unit;

	private String type;

	private Double price;

	private Double amount;

	private Double total;
	
	private Integer status;
	
	private String asName;
	
	private Integer projectGroupId;
	
	//↓临时表字段
	
	private Integer tpgId;
	
	private Double tPrice;

	private Double tAmount;

	private Double tTotal;
	
	private String updateType;
	
	private int updateType2;
	
	private int projectUpdate;
	
	private int companyId;
	
	public int getCompanyId() {
		return companyId;
	}
	public void setCompanyId(int companyId) {
		this.companyId = companyId;
	}
	public int getProjectUpdate() {
		return projectUpdate;
	}
	public void setProjectUpdate(int projectUpdate) {
		this.projectUpdate = projectUpdate;
	}
	public Integer getProjectGroupId() {
		return projectGroupId;
	}
	public void setProjectGroupId(Integer projectGroupId) {
		this.projectGroupId = projectGroupId;
	}
	public Integer getProjectUpdateGoodsId() {
		return projectUpdateGoodsId;
	}
	public void setProjectUpdateGoodsId(Integer projectUpdateGoodsId) {
		this.projectUpdateGoodsId = projectUpdateGoodsId;
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
	public String getAsName() {
		return asName;
	}
	public void setAsName(String asName) {
		this.asName = asName;
	}
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
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

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
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
	
	public String getUpdateType() {
		return updateType;
	}
	public void setUpdateType(String updateType) {
		this.updateType = updateType;
	}
	public int getUpdateType2() {
		return updateType2;
	}
	public void setUpdateType2(int updateType2) {
		this.updateType2 = updateType2;
	}
	@Override
	public String toString() {
		return "ProjectGoods [id=" + id + ", projectId=" + projectId + ", goodsId=" + goodsId + ", projectName="
				+ projectName + ", name=" + name + ", code=" + code + ", unit=" + unit + ", type=" + type + ", price="
				+ price + ", amount=" + amount + ", total=" + total + ", status=" + status + "]";
	}
}