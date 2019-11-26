package com.qrhf.service;

import com.qrhf.pojo.AddressManagement;

public interface AddressManagementService {
	
	public AddressManagement findAddressManagement(int companyId);
	
	public int save(int id,AddressManagement addressManagement);

}
