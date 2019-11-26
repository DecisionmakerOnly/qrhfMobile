package com.qrhf.service;

import java.util.List;
import java.util.Map;

import com.qrhf.pojo.Company;

public interface CompanyService {
	
	public List<Company> findList(Company record);

	public Company getById(Integer id);

	public Integer update(Company company);

	public Integer addCompany(Company company);

	public Company loginByCompanyName(String name);
	
	public Integer deleteCompanyById(Integer companyId);

	public Map<String, Object> findShareCode(Map<String, Object> param);
	
	public String newCode();

	public Company getCompanyByUserId(Integer userId);
}
