package com.qrhf.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.ContractListGoodsMapper;
import com.qrhf.dao.ContractListMapper;
import com.qrhf.pojo.ContractList;

@Service
public class ContractListServiceImpl implements ContractListService {
	
	@Autowired
	private ContractListMapper contractListMapper;
	@Autowired
	private ContractListGoodsMapper contractListGoodsMapper;

	@Override
	public int save(ContractList contractList) {
		try {
			contractListMapper.save(contractList);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
	}

	@Override
	public int delContractListId(int contractListId) {
		try {
			contractListGoodsMapper.delContractListGoodsId(contractListId);
			contractListMapper.delContractListId(contractListId);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
}
