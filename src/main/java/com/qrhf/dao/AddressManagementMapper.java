package com.qrhf.dao;

import com.qrhf.pojo.AddressManagement;

public interface AddressManagementMapper {
	
	public AddressManagement findAddressMangement(int companyId);
	
	public void save(AddressManagement addressManagement);

	public void update(AddressManagement addressManagement);
	
}
