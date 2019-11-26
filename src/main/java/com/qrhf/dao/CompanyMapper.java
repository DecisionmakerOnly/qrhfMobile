package com.qrhf.dao;

import java.util.List;
import java.util.Map;

import com.qrhf.pojo.Company;

public interface CompanyMapper {
	
	public List<Company> findList(Company record);

	public Company getById(Integer id);

	public Integer update(Company company);

	public Integer addCompany(Company company);
	
	public Company loginByCompanyName(String name);
	
	public Integer deleteCompanyById(Integer companyId);
	
	public List<Company> findShareCode(Map <String ,Object> param);

	public Company checkCode(String code);

	public Company getCompanyByUserId(Integer userId);
}