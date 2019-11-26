package com.qrhf.service;

import java.util.List;

import com.qrhf.pojo.Linkage;

public interface LinkageService {
	public List<Linkage> getLikage(String pid);
//	List<Map<String , Object>> getLikage(String pid);
	public List<Linkage> findByLikage();
}
