package com.qrhf.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.qrhf.pojo.SysUnit;
@Repository
public interface SysUnitMapper {
	public List<SysUnit> findByUnit();
}
