package com.qrhf.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.LinkageMapper;
import com.qrhf.pojo.Linkage;
@Service("linkageService")
public class LinkageServiceImpl implements LinkageService {
	@Autowired
	private LinkageMapper linkageMapper;

//	@Override
//	public List<Map<String, Object>> getLikage(String pid) {
//		return linkageMapper.getLikage(pid);
//	}

	@Override
	public List<Linkage> getLikage(String pid) {
		return linkageMapper.getLikage(pid);
	}

	@Override
	public List<Linkage> findByLikage() {
		return linkageMapper.findByLikage();
	}

}
