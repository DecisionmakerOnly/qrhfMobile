package com.qrhf.dao;

import com.qrhf.pojo.ContractList;

public interface ContractListMapper {

	public int save(ContractList contractList);
	
	public void contractListDel(int projectOrderId);
	
	public void delContractListId(int contratListId);
}
