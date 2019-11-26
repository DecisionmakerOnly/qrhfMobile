package com.qrhf.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.qrhf.pojo.Region;

public interface RegionMapper {
	public List<Region> getRegion(@Param(value="pid")String pid);
}
