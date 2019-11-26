package com.qrhf.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.CompanyMapper;
import com.qrhf.dao.UserMapper;
import com.qrhf.pojo.Company;

@Service
public class CompanyServiceImpl implements CompanyService {
	
	@Autowired
	private CompanyMapper companyMapper;
	@Autowired
	private UserMapper userMapper;
	
	@Override
	public List<Company> findList(Company record) {
		return companyMapper.findList(record);
	}

	@Override
	public Company getById(Integer id) {
		return companyMapper.getById(id);
	}

	@Override
	public Integer update(Company company) {
		return companyMapper.update(company);
	}

	@Override
	public Integer addCompany(Company company) {
		return companyMapper.addCompany(company);
	}
 
	@Override
	public Company loginByCompanyName(String name) {
		return companyMapper.loginByCompanyName(name);
	}

	@Override
	public Integer deleteCompanyById(Integer companyId) {
		userMapper.deleteCompanyId(companyId);
		return companyMapper.deleteCompanyById(companyId);
	}

	@Override
	public Map<String, Object> findShareCode(Map<String, Object> param) {
		Map<String,Object> result =new HashMap<String ,Object>();
		Map<String,Object> sizeMap =new HashMap<String,Object>();
		int total=companyMapper.findShareCode(sizeMap).size();
		List<Company> rows=companyMapper.findShareCode(param);
		result.put("total",total);
		result.put("rows",rows);
		return result;
	}
	
	@Override
	public String newCode() {
		String code = (int) ((Math.random() * 9 + 1) * 100000) + "";
		Company company = companyMapper.checkCode(code);
		if (company != null) {
			newCode();
		}
		return code;
	}

	@Override
	public Company getCompanyByUserId(Integer userId) {
		return companyMapper.getCompanyByUserId(userId);
	}
}