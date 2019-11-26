package com.qrhf.dao;

import java.util.List;

import com.qrhf.pojo.ProjectGoods;

public interface ProjectGoodsBakMapper {
	
	public void insertAll(List<ProjectGoods> progoodsList);
	
	public void deleteProjectGoodsBakProjectId(int projectId);

}
