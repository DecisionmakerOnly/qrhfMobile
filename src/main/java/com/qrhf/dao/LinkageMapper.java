package com.qrhf.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.qrhf.pojo.Linkage;

public interface LinkageMapper {

	public List<Linkage> getLikage(@Param(value = "pid") String pid);

	public List<Linkage> findByLikage();

}
