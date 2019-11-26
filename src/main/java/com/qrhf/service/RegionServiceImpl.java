package com.qrhf.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.RegionMapper;
import com.qrhf.pojo.Region;
@Service("regionService")
public class RegionServiceImpl implements RegionService {
	@Autowired
	private RegionMapper regionMapper;
	@Override
	public List<Region> getRegion(String pid) {
		return regionMapper.getRegion(pid);
	}

}
