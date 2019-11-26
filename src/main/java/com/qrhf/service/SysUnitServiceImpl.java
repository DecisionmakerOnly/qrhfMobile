package com.qrhf.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.SysUnitMapper;
import com.qrhf.pojo.SysUnit;
@Service
public class SysUnitServiceImpl implements SysUnitService {
	@Autowired
	private SysUnitMapper sysUnitMapper;
	@Override
	public List<SysUnit> findByUnit() {
		return sysUnitMapper.findByUnit();
	}

}
