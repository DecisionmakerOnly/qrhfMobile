package com.qrhf.pojo;

import java.util.Date;

public class Linkage {
	private Integer id;
	
	private String name;
	
	private String pid;
	
	private Integer isValid;
	
	private Integer status;
	
	private Date isValidDate;
	
	@Override
	public String toString() {
		return "Linkage [id=" + id + ", name=" + name + ", pid=" + pid + ", isValid=" + isValid + ", status=" + status
				+ ", isValidDate=" + isValidDate + "]";
	}
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public Integer getIsValid() {
		return isValid;
	}

	public void setIsValid(Integer isValid) {
		this.isValid = isValid;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Date getIsValidDate() {
		return isValidDate;
	}

	public void setIsValidDate(Date isValidDate) {
		this.isValidDate = isValidDate;
	}

}
