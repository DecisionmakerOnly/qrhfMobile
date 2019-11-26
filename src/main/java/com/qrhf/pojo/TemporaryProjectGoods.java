package com.qrhf.pojo;
/**
 * 临时ProjectGoods 
 * 作用：把已上传项目采购控制表中的修改项暂时放到此表 并提交 如通过 用此表的数据覆盖原ProjectGoods表对应的数据 
 *
 */
public class TemporaryProjectGoods {
	
	private Integer id;
	
	private Integer projectId;
	
	private Integer projectGoodsId;
	
	private Integer projectOrderId;
	
	private Integer projectOrderGoodsId;
	
	private Integer goodsId;
	
	private Double price;
	
	private Double amount;
	
	private Double total;
	
	private Integer status;
	
	private String name;
	
	private String asName;
	
	private String code;
	
	private String unit;

	private String type;

	private Integer sfStatus;
	
	
	public String getAsName() {
		return asName;
	}

	public void setAsName(String asName) {
		this.asName = asName;
	}

	public Integer getSfStatus() {
		return sfStatus;
	}

	public void setSfStatus(Integer sfStatus) {
		this.sfStatus = sfStatus;
	}

	public Integer getProjectOrderId() {
		return projectOrderId;
	}

	public void setProjectOrderId(Integer projectOrderId) {
		this.projectOrderId = projectOrderId;
	}

	public Integer getProjectOrderGoodsId() {
		return projectOrderGoodsId;
	}

	public void setProjectOrderGoodsId(Integer projectOrderGoodsId) {
		this.projectOrderGoodsId = projectOrderGoodsId;
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

	public Integer getProjectGoodsId() {
		return projectGoodsId;
	}

	public void setProjectGoodsId(Integer projectGoodsId) {
		this.projectGoodsId = projectGoodsId;
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

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
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

	@Override
	public String toString() {
		return "TemporaryProjectGoods [id=" + id + ", projectId=" + projectId + ", projectGoodsId=" + projectGoodsId
				+ ", goodsId=" + goodsId + ", price=" + price + ", amount=" + amount + ", total=" + total + ", status="
				+ status + ", name=" + name + ", code=" + code + ", unit=" + unit + ", type=" + type + "]";
	}

	
	
	
}
