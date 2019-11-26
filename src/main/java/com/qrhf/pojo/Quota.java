package com.qrhf.pojo;

import java.util.Date;

public class Quota {
	private Integer id;
	
	private Integer companyId;
	
	private Integer departmentId;

	private Integer userId;
	// 三级联动Id
	private String linkageId;

	private String linkagePid;

	private String linkageSonId;

	private String name; // 工作描述

	private Integer seniorWorker;// 高级工人数量
	
	private Double seniorWorkerWages; //一位高级工人一天金额
	
	private Integer middleWorker;// 中级工人数量

	private Integer primaryWorker;// 初级工人数量
	
	private Integer primaryWorkerWages; //一位初级工人一天金额
	private Double mechanics;
	private Integer mechanicsWages;
	private Double wages;// 总工资
	private Integer workload; //工程量
	private String workloadUnit;
	private String organicQuota;
	private String unitId;// 单位
	private String unitName;
	private Integer status;

	private String code;

	private Date createDate;

	private Date startDate;
	
	private Date endDate;
	
	private String regionId;
	private String regionPid;
	private String regionSonId;
	private String region;
	
	private Integer isValid;

	private Date isValidDate;

	private String province;

	private String city;

	private String area;
	

	private String linkageName;
	
	private String startDateStr;
	
	private String endDateStr;
	
	private String duration;
	
	private Integer num;
	
	private String unitPrice;
	
	public String getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(String unitPrice) {
		this.unitPrice = unitPrice;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public Double getMechanics() {
		return mechanics;
	}

	public void setMechanics(Double mechanics) {
		this.mechanics = mechanics;
	}

	public Integer getMechanicsWages() {
		return mechanicsWages;
	}

	public void setMechanicsWages(Integer mechanicsWages) {
		this.mechanicsWages = mechanicsWages;
	}

	public String getOrganicQuota() {
		return organicQuota;
	}

	public void setOrganicQuota(String organicQuota) {
		this.organicQuota = organicQuota;
	}

	public String getWorkloadUnit() {
		return workloadUnit;
	}

	public void setWorkloadUnit(String workloadUnit) {
		this.workloadUnit = workloadUnit;
	}

	public Double getSeniorWorkerWages() {
		return seniorWorkerWages;
	}

	public void setSeniorWorkerWages(Double seniorWorkerWages) {
		this.seniorWorkerWages = seniorWorkerWages;
	}

 
	public Integer getPrimaryWorkerWages() {
		return primaryWorkerWages;
	}

	public void setPrimaryWorkerWages(Integer primaryWorkerWages) {
		this.primaryWorkerWages = primaryWorkerWages;
	}

	public Integer getWorkload() {
		return workload;
	}

	public void setWorkload(Integer workload) {
		this.workload = workload;
	}

	public String getRegionId() {
		return regionId;
	}

	public void setRegionId(String regionId) {
		this.regionId = regionId;
	}

	public String getRegionPid() {
		return regionPid;
	}

	public void setRegionPid(String regionPid) {
		this.regionPid = regionPid;
	}

	public String getRegionSonId() {
		return regionSonId;
	}

	public void setRegionSonId(String regionSonId) {
		this.regionSonId = regionSonId;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public String getDuration() {
		return duration;
	}

	public void setDuration(String duration) {
		this.duration = duration;
	}

	public String getStartDateStr() {
		return startDateStr;
	}

	public void setStartDateStr(String startDateStr) {
		this.startDateStr = startDateStr;
	}

	public String getEndDateStr() {
		return endDateStr;
	}

	public void setEndDateStr(String endDateStr) {
		this.endDateStr = endDateStr;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
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

	public String getUnitName() {
		return unitName;
	}

	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	public String getLinkageName() {
		return linkageName;
	}

	public void setLinkageName(String linkageName) {
		this.linkageName = linkageName;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getLinkageId() {
		return linkageId;
	}

	public void setLinkageId(String linkageId) {
		this.linkageId = linkageId;
	}

	public String getLinkagePid() {
		return linkagePid;
	}

	public void setLinkagePid(String linkagePid) {
		this.linkagePid = linkagePid;
	}

	public String getLinkageSonId() {
		return linkageSonId;
	}

	public void setLinkageSonId(String linkageSonId) {
		this.linkageSonId = linkageSonId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getSeniorWorker() {
		return seniorWorker;
	}

	public void setSeniorWorker(Integer seniorWorker) {
		this.seniorWorker = seniorWorker;
	}

	public Integer getMiddleWorker() {
		return middleWorker;
	}

	public void setMiddleWorker(Integer middleWorker) {
		this.middleWorker = middleWorker;
	}

	public Integer getPrimaryWorker() {
		return primaryWorker;
	}

	public void setPrimaryWorker(Integer primaryWorker) {
		this.primaryWorker = primaryWorker;
	}

	public Double getWages() {
		return wages;
	}

	public void setWages(Double wages) {
		this.wages = wages;
	}

	 
	public String getUnitId() {
		return unitId;
	}

	public void setUnitId(String unitId) {
		this.unitId = unitId;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
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

}
