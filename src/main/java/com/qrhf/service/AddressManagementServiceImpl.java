package com.qrhf.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.AddressManagementMapper;
import com.qrhf.pojo.AddressManagement;

@Service
public class AddressManagementServiceImpl implements AddressManagementService {

	@Autowired
	private AddressManagementMapper addressManagementMapper;
	

	@Override
	public AddressManagement findAddressManagement(int companyId) {
		return addressManagementMapper.findAddressMangement(companyId);
	}
	
	@Override
	public int save(int id,AddressManagement addressManagement) {
		try {
			if(id != 0){
				addressManagement.setId(id);
				addressManagementMapper.update(addressManagement);
			}else{
				addressManagementMapper.save(addressManagement);
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
	}

}
