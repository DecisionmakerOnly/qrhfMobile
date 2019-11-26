package com.qrhf.pojo;

import java.util.Date;

public class Department {
	
	private Integer id;
	private Integer companyId;
	private Integer departmentId;
	private String name;
	private String code;
	private int isValid;
	private Date isValidDate;
	private Integer status;
	private Integer isProject;
	private Integer sort;
	public Integer getSort() {
		return sort;
	}
	public void setSort(Integer sort) {
		this.sort = sort;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getCompanyId() {
		return companyId;
	}
	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
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
	public Integer getDepartmentId() {
		return departmentId;
	}
	public void setDepartmentId(Integer departmentId) {
		this.departmentId = departmentId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getIsProject() {
		return isProject;
	}
	public void setIsProject(Integer isProject) {
		this.isProject = isProject;
	}
	
}
