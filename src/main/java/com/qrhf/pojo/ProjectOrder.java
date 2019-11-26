package com.qrhf.pojo;

import java.util.Date;

public class ProjectOrder {
    private Integer id;
    
    private Integer userId;
    
    private Integer projectId;
    
    private Integer contractId;

    private String name;

    private Date createDate;

    private Integer isValid;

    private Date isValidDate;
    
    private Integer num;
    
    private Integer toNum;
    
    private Integer status;

	public Integer getToNum() {
		return toNum;
	}

	public void setToNum(Integer toNum) {
		this.toNum = toNum;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
    
    public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
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

	public Integer getProjectId() {
		return projectId;
	}

	public void setProjectId(Integer projectId) {
		this.projectId = projectId;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}
	
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getContractId() {
		return contractId;
	}

	public void setContractId(Integer contractId) {
		this.contractId = contractId;
	}
}